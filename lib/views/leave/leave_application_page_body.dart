import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/view_models/leave_application_view_model.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 

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

        setState(() {
          userName = doc.data()?['name'] ?? currentUser!.email;
        });
      }
    } catch (e) {
      setState(() {
        userName = currentUser?.email ?? 'Unknown';
      });
    }
  }

  Widget _buildFieldContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const TopNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.black,
                  elevation: 3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Back"),
              ),
              const SizedBox(height: 16),
              const Text("Apply for Leave",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              _buildLabel("Employee Name"),
              _buildFieldContainer(
                child: TextField(
                  enabled: false,
                  controller:
                      TextEditingController(text: userName ?? 'Employee ID - auto-filled'),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                  ),
                ),
              ),
              _buildLabel("Employee ID"),
              _buildFieldContainer(
                child: const TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Employee ID - auto-filled',
                    prefixIcon: Icon(Icons.badge),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("From Date"),
                        _buildFieldContainer(
                          child: GestureDetector(
                            onTap: () =>
                                viewModel.pickDate(context, true, setState),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: viewModel.fromDate != null
                                      ? "${viewModel.fromDate!.day}/${viewModel.fromDate!.month}/${viewModel.fromDate!.year}"
                                      : 'From',
                                  prefixIcon: const Icon(Icons.calendar_today),
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
                        child: Icon(Icons.play_arrow, size: 16),
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
                        _buildLabel("To Date"),
                        _buildFieldContainer(
                          child: GestureDetector(
                            onTap: () =>
                                viewModel.pickDate(context, false, setState),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: viewModel.toDate != null
                                      ? "${viewModel.toDate!.day}/${viewModel.toDate!.month}/${viewModel.toDate!.year}"
                                      : 'To',
                                  prefixIcon: const Icon(Icons.calendar_today),
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
              _buildLabel("Leave Type"),
              Row(
                children: [
                  Expanded(
                    child: _buildFieldContainer(
                      child: const TextField(
                        enabled: true,
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
                    child: _buildFieldContainer(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: const InputDecoration(
                            hintText: 'Choose Type',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          value: viewModel.selectedLeaveType,
                          items: viewModel.leaveTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child:
                                  Text(type, overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              viewModel.selectedLeaveType = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _buildLabel("Reason"),
              _buildFieldContainer(
                child: TextField(
                  controller: viewModel.reasonController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: 'Text area',
                    border: InputBorder.none,
                  ),
                ),
              ),
              _buildLabel("Attachment"),
              _buildFieldContainer(
                child: TextField(
                  controller: viewModel.attachmentController,
                  decoration: const InputDecoration(
                    hintText: 'Attachment (Optional)',
                    prefixIcon: Icon(Icons.attach_file),
                    border: InputBorder.none,
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
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Form submission
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
