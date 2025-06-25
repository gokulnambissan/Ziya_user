import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/view_models/leave_application_view_model.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';

class LeaveApplicationPageBody extends StatefulWidget {
  const LeaveApplicationPageBody({super.key});

  @override
  State<LeaveApplicationPageBody> createState() =>
      _LeaveApplicationPageBodyState();
}

class _LeaveApplicationPageBodyState extends State<LeaveApplicationPageBody> {
  final LeaveApplicationViewModel viewModel = LeaveApplicationViewModel();

  @override
  void dispose() {
    viewModel.disposeControllers();
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
                                onTap: () =>
                                    viewModel.pickDate(context, true, setState),
                                child: AbsorbPointer(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: viewModel.fromDate != null
                                          ? "${viewModel.fromDate!.day}/${viewModel.fromDate!.month}/${viewModel.fromDate!.year}"
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
                        const SizedBox(width: 6),
                        Row(
                          children: const [
                            Icon(Icons.arrow_back_ios_new, size: 16),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("To",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => viewModel.pickDate(
                                    context, false, setState),
                                child: AbsorbPointer(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: viewModel.toDate != null
                                          ? "${viewModel.toDate!.day}/${viewModel.toDate!.month}/${viewModel.toDate!.year}"
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
                    const Text("Leave Type",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            enabled: false,
                            decoration: const InputDecoration(
                              hintText: 'Leave Type',
                              prefixIcon: Icon(Icons.article_outlined),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true, // <== CRUCIAL
                            decoration: const InputDecoration(
                              hintText: 'Choose Type',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text("Reason",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: viewModel.reasonController,
                      maxLines: 3,
                      decoration: const InputDecoration(hintText: 'Text area'),
                    ),
                    const SizedBox(height: 16),
                    const Text("Attachment",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: viewModel.attachmentController,
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
                          backgroundColor: AppColors.blue,
                          foregroundColor: AppColors.white,
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
          ],
        ),
      ),
    );
  }
}
