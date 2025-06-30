import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginViewModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  bool isPasswordVisible = false;

  Future<Map<String, dynamic>> login() async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      FirebaseAuth.instance.setLanguageCode('en');
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        throw Exception("User record not found in Firestore");
      }

      return {'success': true, 'userData': userDoc.data()};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
