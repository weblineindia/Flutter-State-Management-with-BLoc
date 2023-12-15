import 'dart:developer';

import 'package:fl_bloc_consumer/ui/screens/home_screen.dart';
import 'package:fl_bloc_consumer/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../../core/bloc/user_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

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
        appBar: AppBar(title: const Text('Register'), centerTitle: true),
        body: BlocBuilder<UserBloc, UserState>(builder: (BuildContext context, UserState state) {
          if (state is UserLoading) {
            return _body(true);
          } else if (state is UserInitial) {
            return _body(false);
          } else if (state is UserSuccess) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) async {
                context.read<UserBloc>().add(ResetEvent());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            );
            return _body(false);
          } else if (state is UserError) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Toast.show(state.errorMessage, duration: 15),
            );
            log(state.errorMessage);
            return _body(false);
          }
          return const SizedBox();
        }));
  }

  ///Body widget
  Widget _body(bool isLoading) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(hintText: 'Name')),
              const SizedBox(height: 24),
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
                child: const Text('Register'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
        if (isLoading) const Center(child: CircularProgressIndicator(color: Colors.blue)),
      ],
    );
  }

  ///Method to check validation and request authentication
  void _validation() {
    if (_nameController.text.isEmpty) {
      Toast.show("Please enter name");
      return;
    } else if (_emailController.text.isEmpty) {
      Toast.show("Please enter email");
      return;
    } else if (_passwordController.text.isEmpty) {
      Toast.show("Please enter password");
      return;
    } else {
      context.read<UserBloc>().add(
            UserRegistrationEvent(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }
}
