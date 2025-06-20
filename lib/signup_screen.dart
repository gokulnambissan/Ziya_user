import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/app_strings.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool has8Chars = false;
  bool hasNumber = false;
  bool hasLetter = false;
  bool isPasswordVisible = false;

  void _validatePassword(String password) {
    setState(() {
      has8Chars = password.length >= 8;
      hasNumber = RegExp(r'[0-9]').hasMatch(password);
      hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    });
  }

  Future<void> _signUp() async {
    try {
      final name = _fullNameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'createdAt': Timestamp.now(),
      });

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
    } catch (e) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(AppStrings.error),
          content: Text(e.toString()),
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Image(image: AssetImage('assets/logo.jpg'), height: 100),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    AppStrings.appName,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.blue),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    AppStrings.signUpPrompt,
                    style: TextStyle(color: AppColors.green, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(AppStrings.fullName,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.black)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    hintText: AppStrings.fullName,
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
                ),
                const SizedBox(height: 16),
                const Text(AppStrings.email,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.black)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: AppStrings.email,
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(AppStrings.password,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.black)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !isPasswordVisible,
                  onChanged: _validatePassword,
                  decoration: InputDecoration(
                    hintText: AppStrings.password,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(has8Chars ? Icons.check : Icons.close,
                        color: has8Chars ? AppColors.green : AppColors.red, size: 18),
                    const SizedBox(width: 8),
                    Text(AppStrings.passwordMin,
                        style: TextStyle(
                            color: has8Chars ? AppColors.green : AppColors.red, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(hasNumber ? Icons.check : Icons.close,
                        color: hasNumber ? AppColors.green : AppColors.red, size: 18),
                    const SizedBox(width: 8),
                    Text(AppStrings.passwordNumber,
                        style: TextStyle(
                            color: hasNumber ? AppColors.green : AppColors.red, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(hasLetter ? Icons.check : Icons.close,
                        color: hasLetter ? AppColors.green : AppColors.red, size: 18),
                    const SizedBox(width: 8),
                    Text(AppStrings.passwordLetter,
                        style: TextStyle(
                            color: hasLetter ? AppColors.green : AppColors.red, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 24),
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
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(AppStrings.signUp, style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.haveAccount),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
                      child: const Text(AppStrings.login,
                          style: TextStyle(
                              color: AppColors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
