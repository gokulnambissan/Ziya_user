import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/app_strings.dart';
import 'package:ziya_user/view_models/login_viewmodel.dart';
import 'package:ziya_user/views/home/home_screen.dart';
import 'package:ziya_user/views/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = LoginViewModel();

  Future<void> _login() async {
    final result = await viewModel.login();

    if (result['success']) {
      final userData = result['userData'];
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(AppStrings.loginTitle),
          content: Text('${AppStrings.loginWelcome}${userData['name']}!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: const Text(AppStrings.continueBtn),
            ),
          ],
        ),
      );
    } else {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(AppStrings.loginFailed),
          content: Text(result['message']),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.jpg', height: 100),
                const SizedBox(height: 16),
                Text(AppStrings.appName,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.blue)),
                const SizedBox(height: 4),
                Text(AppStrings.tagline,
                    style: TextStyle(fontSize: 16, color: AppColors.green)),
                const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppStrings.email,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: AppStrings.email,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppStrings.password,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: viewModel.passwordController,
                  obscureText: !viewModel.isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: AppStrings.password,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: IconButton(
                      icon: Icon(viewModel.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          viewModel.isPasswordVisible = !viewModel.isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: viewModel.rememberMe,
                          onChanged: (bool? newValue) {
                            setState(() {
                              viewModel.rememberMe = newValue ?? false;
                            });
                          },
                        ),
                        const Text(AppStrings.rememberMe),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(AppStrings.forgetPassword,
                          style: TextStyle(color: AppColors.blue)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(AppStrings.loginBtn, style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.noAccount),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      ),
                      child: const Text(AppStrings.signUp,
                          style: TextStyle(
                              color: AppColors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
