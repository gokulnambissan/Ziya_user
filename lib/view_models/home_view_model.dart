import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeViewModel extends ChangeNotifier {
  bool checkedIn = false;
  String checkInStatus = 'Please check-in to start your day';
  Color statusColor = Colors.red;
  String? checkOutTimeMessage;
  String? userName;

  final currentUser = FirebaseAuth.instance.currentUser;

  HomeViewModel() {
    fetchUserName();
  }

  String getFormattedTime() {
    return DateFormat.jm().format(DateTime.now());
  }

 
  Future<void> fetchUserName() async {
    try {
      if (currentUser != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get();
        userName = doc.data()?['name'] ?? currentUser!.email;
      } else {
        userName = "Unknown";
      }
    } catch (e) {
      userName = currentUser?.email ?? "Unknown";
    }
    notifyListeners();
  }
}