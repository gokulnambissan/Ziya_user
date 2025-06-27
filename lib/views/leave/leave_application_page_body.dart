// ignore_for_file: deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/view_models/leave_application_view_model.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import 'package:ziya_user/views/leave/leave_dashboard_page.dart';
import 'package:ziya_user/views/leave/leave_tab_header_page.dart';



class LeaveApplicationPageBody extends StatefulWidget {
  const LeaveApplicationPageBody({super.key});

  @override
  State<LeaveApplicationPageBody> createState() =>
      _LeaveApplicationPageBodyState();
}

class _LeaveApplicationPageBodyState extends State<LeaveApplicationPageBody> {
  final LeaveApplicationViewModel viewModel = LeaveApplicationViewModel();

  String? userName;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      if (currentUser != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get();
        setState(() => userName = doc.data()?['name'] ?? currentUser!.email);
      }
    } catch (e) {
      setState(() => userName = currentUser?.email ?? 'Unknown');
    }
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      );

  Widget _field({required Widget child}) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const TopNavigationBar(),            // ◀︎ Leaves  bar
      body: SafeArea(
        child: Column(
          children: [
            LeaveTabHeaderPage(
              selectedTab: 1,
              onTabSelected: (idx) {
                if (idx == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LeaveDashboardPage()),
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Apply for Leave',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),

                    // Employee Name
                    _label('Employee Name'),
                    _field(
                      child: TextField(
                        enabled: false,
                        controller:
                            TextEditingController(text: userName ?? ''),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Employee ID
                    _label('Employee ID'),
                    _field(
                      child: const TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Employee ID - auto-filled',
                          prefixIcon: Icon(Icons.badge),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // From / To
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label('From Date'),
                              _field(
                                child: GestureDetector(
                                  onTap: () => viewModel.pickDate(
                                      context, true, setState),
                                  child: AbsorbPointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: viewModel.fromDate != null
                                            ? '${viewModel.fromDate!.day}/${viewModel.fromDate!.month}/${viewModel.fromDate!.year}'
                                            : 'From',
                                        prefixIcon:
                                            const Icon(Icons.calendar_today),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Row(
                          children: [
                            Transform.rotate(
                              angle: 3.14,
                              child: const Icon(Icons.play_arrow, size: 16),
                            ),
                            const SizedBox(width: 2),
                            const Icon(Icons.play_arrow, size: 16),
                          ],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label('To Date'),
                              _field(
                                child: GestureDetector(
                                  onTap: () => viewModel.pickDate(
                                      context, false, setState),
                                  child: AbsorbPointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: viewModel.toDate != null
                                            ? '${viewModel.toDate!.day}/${viewModel.toDate!.month}/${viewModel.toDate!.year}'
                                            : 'To',
                                        prefixIcon:
                                            const Icon(Icons.calendar_today),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Leave Type
                    _label('Leave Type'),
                    Row(
                      children: [
                        Expanded(
                          child: _field(
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Leave Type',
                                prefixIcon: Icon(Icons.article_outlined),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _field(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  hintText: 'Choose Type',
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                ),
                                value: viewModel.selectedLeaveType,
                                items:
                                    viewModel.leaveTypes.map((String type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(type,
                                        overflow: TextOverflow.ellipsis),
                                  );
                                }).toList(),
                                onChanged: (newValue) =>
                                    setState(() => viewModel
                                        .selectedLeaveType = newValue!),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Reason
                    _label('Reason'),
                    _field(
                      child: TextField(
                        controller: viewModel.reasonController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: 'Text area',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Attachment
                    _label('Attachment'),
                    GestureDetector(
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles();
                        if (result != null && result.files.isNotEmpty) {
                          setState(() => viewModel.attachmentController.text =
                              result.files.single.name);
                        }
                      },
                      child: _field(
                        child: Row(
                          children: [
                            const Icon(Icons.attach_file, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                viewModel.attachmentController.text.isNotEmpty
                                    ? viewModel.attachmentController.text
                                    : 'Select Attachment (Optional)',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.upload_file, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Submit
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // handle submission here
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
