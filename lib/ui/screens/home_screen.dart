import 'package:fl_bloc_consumer/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_constant.dart';

///Home screen for user after successful login or registration
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 100),
            const Text('Home Screen'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final preference = await SharedPreferences.getInstance();
                preference.setBool(ApiConstant.isLogin, false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
