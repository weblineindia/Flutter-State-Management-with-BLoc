import 'package:fl_bloc_consumer/core/network/api_constant.dart';
import 'package:fl_bloc_consumer/ui/screens/home_screen.dart';
import 'package:fl_bloc_consumer/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigation();
  }

  ///Method to navigate on next screen after 2 seconds
  ///Checking session to navigate on either Login or Register
  Future<void> _navigation() async {
    final preference = await SharedPreferences.getInstance();
    final screen = (preference.getBool(ApiConstant.isLogin) ?? false) ? const HomeScreen() : const LoginScreen();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => screen));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.desktop_mac_outlined, size: 100),
            Text('Splash Screen'),
          ],
        ),
      ),
    );
  }
}
