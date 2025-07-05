// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';

import '../../constants/app_colors.dart';
import '../../view_models/leave_application_view_model.dart';
import '../common/inline_search_widget.dart';
import 'leave_dashboard_page.dart';
import 'leave_tab_header_page.dart';

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
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    try {
      if (currentUser != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get();
        setState(() =>
            userName = doc.data()?['name']?.toString() ?? currentUser!.email);
      }
    } catch (_) {
      setState(() => userName = currentUser?.email ?? 'Unknown');
    }
  }

  void _handleSearch(String query) {
    debugPrint('Leave search triggered: $query');
    // TODO: Add your real search logic here if needed
  }

  Widget _label(String t) => Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(t,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)));

  Widget _field({required Widget child}) => Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
      child: child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: kToolbarHeight,
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
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 24),
                          _label('Employee Name'),
                          _field(
                            child: TextField(
                              enabled: false,
                              controller:
                                  TextEditingController(text: userName ?? ''),
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person, size: 18),
                                hintStyle: TextStyle(fontSize: 13),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 14), 
                              ),
                            ),
                          ),
                          _label('Employee ID'),
                          _field(
                            child: const TextField(
                              enabled: false,
                              decoration: const InputDecoration(
                                hintText: 'Employee ID - auto-filled',
                                prefixIcon: Icon(Icons.badge, size: 18),
                                hintStyle: TextStyle(fontSize: 13),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
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
                                            style:
                                                const TextStyle(fontSize: 18),
                                            decoration: InputDecoration(
                                              hintText: viewModel.fromDate !=
                                                      null
                                                  ? '${viewModel.fromDate!.day}/${viewModel.fromDate!.month}/${viewModel.fromDate!.year}'
                                                  : 'From',
                                              prefixIcon: const Icon(
                                                Icons.calendar_today,
                                                size: 16,
                                              
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                                              hintStyle:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                               Padding(
      padding: const EdgeInsets.only(top: 25), // push down
      child: Row(
        children: [
          Transform.rotate(
            angle: 3.14, // left arrow
            child: const Icon(Icons.play_arrow, size: 16),
          ),
          const SizedBox(width: 1),
          const Icon(Icons.play_arrow, size: 16), // right arrow
        ],
      ),
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
                                            style:
                                                const TextStyle(fontSize: 18),
                                            decoration: InputDecoration(
                                              hintText: viewModel.toDate != null
                                                  ? '${viewModel.toDate!.day}/${viewModel.toDate!.month}/${viewModel.toDate!.year}'
                                                  : 'To',
                                              prefixIcon: const Icon(
                                                Icons.calendar_today,
                                                size: 16,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                                              hintStyle:
                                                  const TextStyle(fontSize: 15),
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
                          _label('Leave Type'),
                          _field(
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.article_outlined, size: 16),
                                hintText: 'Choose Type',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 14),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8,vertical: 14),
                              ),
                              isExpanded: true,
                              value: viewModel.selectedLeaveType,
                              style: const TextStyle(fontSize: 12),
                              items: viewModel.leaveTypes
                                  .map((type) => DropdownMenuItem<String>(
                                        value: type,
                                        child: Text(
                                          type,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.black),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (newVal) => setState(
                                  () => viewModel.selectedLeaveType = newVal),
                            ),
                          ),
                          _label('Reason'),
                          _field(
                            child: TextField(
                              style: TextStyle(fontSize: 12),
                              controller: viewModel.reasonController,
                              maxLines: 6,
                              decoration: const InputDecoration(
                                hintText: 'Text area',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _label('Attachment'),
                          GestureDetector(
                            onTap: () async {
                              final result =
                                  await FilePicker.platform.pickFiles();
                              if (result != null && result.files.isNotEmpty) {
                                setState(() => viewModel.attachmentController
                                    .text = result.files.single.name);
                              }
                            },
                            child: _field(
                              child: Row(
                                children: [
                                  const Icon(Icons.attach_file,
                                      color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      viewModel.attachmentController.text
                                              .isNotEmpty
                                          ? viewModel.attachmentController.text
                                          : 'Select Attachment (Optional)',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(Icons.upload_file,
                                      color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                                foregroundColor: AppColors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                // TODO: Submit leave application
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: InlineSearchWidget(
                searchHint: 'Search',
                onSubmitQuery: _handleSearch,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
