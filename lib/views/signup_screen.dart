import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/app_strings.dart';
import 'package:ziya_user/view_models/signup_viewmodel.dart';
import 'package:ziya_user/views/common/auth_background.dart';
import 'package:ziya_user/views/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final viewModel = SignUpViewModel();

  Future<void> _signUp() async {
    final result = await viewModel.signUp();

    if (result['success']) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(AppStrings.success),
          content: const Text(AppStrings.accountCreated),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(AppStrings.error),
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
      resizeToAvoidBottomInset: false, // ✅ Fix: prevent push-up
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const AuthBackground(), // ✅ Only background decoration
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          AppStrings.appName,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          AppStrings.signUpPrompt,
                          style: TextStyle(
                            color: AppColors.green,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        AppStrings.fullName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: viewModel.fullNameController,
                        decoration: const InputDecoration(
                          hintText: AppStrings.fullName,
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your full name' : null,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        AppStrings.email,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: viewModel.emailController,
                        decoration: const InputDecoration(
                          hintText: AppStrings.email,
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Enter email';
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                              .hasMatch(value)) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Mobile Number',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: viewModel.mobileController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: 'Enter 10-digit mobile number',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter mobile number';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Enter valid 10-digit number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        AppStrings.password,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: viewModel.passwordController,
                        obscureText: !viewModel.isPasswordVisible,
                        onChanged: (value) {
                          setState(() {
                            viewModel.validatePassword(value);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(viewModel.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                viewModel.isPasswordVisible =
                                    !viewModel.isPasswordVisible;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            viewModel.has8Chars ? Icons.check : Icons.close,
                            color: viewModel.has8Chars
                                ? AppColors.green
                                : AppColors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppStrings.passwordMin,
                            style: TextStyle(
                              color: viewModel.has8Chars
                                  ? AppColors.green
                                  : AppColors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            viewModel.hasNumber ? Icons.check : Icons.close,
                            color: viewModel.hasNumber
                                ? AppColors.green
                                : AppColors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppStrings.passwordNumber,
                            style: TextStyle(
                              color: viewModel.hasNumber
                                  ? AppColors.green
                                  : AppColors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            viewModel.hasLetter ? Icons.check : Icons.close,
                            color: viewModel.hasLetter
                                ? AppColors.green
                                : AppColors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppStrings.passwordLetter,
                            style: TextStyle(
                              color: viewModel.hasLetter
                                  ? AppColors.green
                                  : AppColors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _signUp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            AppStrings.signUp,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(AppStrings.haveAccount),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                            ),
                            child: const Text(
                              AppStrings.login,
                              style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
