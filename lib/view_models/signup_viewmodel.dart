
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpViewModel {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool has8Chars = false;
  bool hasNumber = false;
  bool hasLetter = false;

  void validatePassword(String password) {
    has8Chars = password.length >= 8;
    hasNumber = RegExp(r'[0-9]').hasMatch(password);
    hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
  }

  Future<Map<String, dynamic>> signUp() async {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate the password conditions
    validatePassword(password);
    if (!has8Chars || !hasNumber || !hasLetter) {
      return {
        'success': false,
        // 'message':
        //     'Password must be at least 8 characters long, contain at least one number and one letter.'
      };
    }

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'createdAt': Timestamp.now(),
      });

      return {'success': true};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
