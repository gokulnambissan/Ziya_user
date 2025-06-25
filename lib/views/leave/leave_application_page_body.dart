import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';

class LeaveApplicationPageBody extends StatefulWidget {
  const LeaveApplicationPageBody({super.key});

  @override
  State<LeaveApplicationPageBody> createState() =>
      _LeaveApplicationPageBodyState();
}

class _LeaveApplicationPageBodyState extends State<LeaveApplicationPageBody> {
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController attachmentController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;
  String? selectedLeaveType;

  Future<void> pickDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  void dispose() {
    reasonController.dispose();
    attachmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const TopNavigationBar(),
            Expanded(
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
                        elevation: 1,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Back"),
                    ),
                    const SizedBox(height: 16),
                    const Text("Apply for Leave",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),

                    // Employee Name
                    const Text("Employee Name",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    const TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Employee Name - auto-filled',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Employee ID
                    const Text("Employee ID",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    const TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Employee ID - auto-filled',
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // From - To
                    const Text("Duration",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("From",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => pickDate(context, true),
                                child: AbsorbPointer(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: fromDate != null
                                          ? "${fromDate!.day}/${fromDate!.month}/${fromDate!.year}"
                                          : 'From Date',
                                      prefixIcon:
                                          const Icon(Icons.calendar_today),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("To",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => pickDate(context, false),
                                child: AbsorbPointer(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: toDate != null
                                          ? "${toDate!.day}/${toDate!.month}/${toDate!.year}"
                                          : 'To Date',
                                      prefixIcon:
                                          const Icon(Icons.calendar_today),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Leave Type
                    const Text("Leave Type",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Leave Type',
                              prefixIcon: Icon(Icons.list),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedLeaveType,
                            decoration: const InputDecoration(
                              hintText: 'Choose Type',
                              prefixIcon: Icon(Icons.arrow_drop_down),
                            ),
                            items: ['Sick', 'Casual', 'Earned','Maternity']
                                .map((type) => DropdownMenuItem(
                                    value: type, child: Text(type)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedLeaveType = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Reason
                    const Text("Reason",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: reasonController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Text area',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Attachment
                    const Text("Attachment",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: attachmentController,
                      decoration: const InputDecoration(
                        hintText: 'Attachment (Optional)',
                        prefixIcon: Icon(Icons.attach_file),
                      ),
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue),
                        onPressed: () {
                          // TODO: Handle form submission logic
                        },
                        child: const Text('Submit'),
                      ),
                    )
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
