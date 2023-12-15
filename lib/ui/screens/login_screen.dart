import 'package:fl_bloc_consumer/core/bloc/user_bloc.dart';
import 'package:fl_bloc_consumer/ui/screens/home_screen.dart';
import 'package:fl_bloc_consumer/ui/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

///Login Screen for user
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  ///Initial state initialization method
  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.97),
        appBar: AppBar(title: const Text('Login'), centerTitle: true),
        body: BlocBuilder<UserBloc, UserState>(builder: (BuildContext context, UserState state) {
          if (state is UserLoading) {
            return _body(true);
          } else if (state is UserInitial) {
            return _body(false);
          } else if (state is UserSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<UserBloc>().add(ResetEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            });
            return _body(false);
          } else if (state is UserError) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Toast.show(state.errorMessage, duration: 2),
            );
            return _body(false);
          }
          return const SizedBox();
        }));
  }

  ///Body widget
  Widget _body(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextField(controller: _emailController, decoration: const InputDecoration(hintText: 'Email')),
          const SizedBox(height: 24),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {
              _validation();
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
            },
            child: const Text('SignUp'),
          ),
        ],
      ),
    );
  }

  ///Method to check validation and request authentication
  void _validation() {
    if (_emailController.text.isEmpty) {
      Toast.show("Please enter email");
      return;
    } else if (_passwordController.text.isEmpty) {
      Toast.show("Please enter password");
      return;
    } else {
      context.read<UserBloc>().add(
            UserLoginEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }
}
