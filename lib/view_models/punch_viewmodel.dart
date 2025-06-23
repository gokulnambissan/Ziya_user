import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class PunchViewModel {
  bool checkedIn = false;
  String checkInStatus = AppStrings.checkInPrompt;
  Color statusColor = AppColors.red;
  String? checkOutTimeMessage;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// Store punch-in mode (e.g., "Work From Home" or "On Site")
  Future<void> punchIn(Function updateUI, String mode) async {
    final now = DateTime.now();
    final userId = _auth.currentUser?.uid;
    final timestamp = now.toIso8601String();

    checkedIn = true;
    checkInStatus = "You're Punched in at ${DateFormat.jm().format(now)}!";
    statusColor = AppColors.green;
    checkOutTimeMessage = null;

    // Save to Firestore
    if (userId != null) {
      await _firestore.collection('attendance').doc(userId).collection('records').add({
        'type': 'in',
        'mode': mode,
        'timestamp': timestamp,
      });
    }

    updateUI();
  }

  /// Punch out and log it
  Future<void> punchOut(Function updateUI) async {
    final now = DateTime.now();
    final userId = _auth.currentUser?.uid;
    final timestamp = now.toIso8601String();

    checkedIn = false;
    checkInStatus = AppStrings.checkInPrompt;
    statusColor = AppColors.red;
    checkOutTimeMessage = "Punched out at ${DateFormat.jm().format(now)}";

    // Save to Firestore
    if (userId != null) {
      await _firestore.collection('attendance').doc(userId).collection('records').add({
        'type': 'out',
        'timestamp': timestamp,
      });
    }

    updateUI();
  }

  /// Retrieve last punch-in mode
  Future<String?> getLastPunchInMode() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return null;

    final snapshot = await _firestore
        .collection('attendance')
        .doc(userId)
        .collection('records')
        .where('type', isEqualTo: 'in')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data()['mode'] as String?;
    }

    return null;
  }
}
