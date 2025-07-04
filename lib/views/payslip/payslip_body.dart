// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/app_strings.dart';
import 'package:ziya_user/util/payslip_pdf_generator.dart';
import 'package:ziya_user/view_models/payslip_view_model.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import 'package:ziya_user/views/common/inline_search_bar.dart';
import 'package:ziya_user/views/payslip/box_payslip_info.dart';

class PayslipPageBody extends StatefulWidget {
  const PayslipPageBody({super.key});

  @override
  State<PayslipPageBody> createState() => _PayslipPageBodyState();
}

class _PayslipPageBodyState extends State<PayslipPageBody> {
  late PayslipViewModel model;
  bool isSearching = false;
  String searchQuery = '';
  final List<String> searchHistory = [];

  String? userName;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    model = PayslipViewModel();
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

  void _handleSearchSubmit() {
    final query = searchQuery.trim();
    if (query.isEmpty) return;
    setState(() {
      searchHistory.insert(0, query);
      searchQuery = '';
      isSearching = false;
    });
    debugPrint('Search submitted: $query');
  }

  void _toggleSearch(bool enable) {
    setState(() {
      isSearching = enable;
      if (!enable) searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = model.payslip;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: kToolbarHeight,
              child: Stack(
                children: [
                  // === Watermark ===
                  Opacity(
                    opacity: 0.06,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/vector.png',
                        width: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // === Payslip Content ===
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.arrow_back_ios,
                                  size: 12, color: AppColors.black),
                              SizedBox(width: 4),
                              Text(
                                'Pay Slip',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage('assets/vector.png'),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(AppStrings.appName1,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blue)),
                                    Text(AppStrings.subTitle1,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.green)),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(AppStrings.payslipForMonth,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.lightGrey)),
                                Text(p.payPeriod,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),

                        // Employee Summary
                        const Text(AppStrings.empSummary,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PayslipInfo(
                                      AppStrings.empName, userName ?? ''),
                                  PayslipInfo(
                                      AppStrings.designation, p.designation),
                                  PayslipInfo(
                                      AppStrings.employeeId, p.employeeId),
                                  PayslipInfo(AppStrings.dateOfJoining,
                                      p.dateOfJoining),
                                  PayslipInfo(
                                      AppStrings.payPeriod, p.payPeriod),
                                  PayslipInfo(AppStrings.payDate, p.payDate),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.lightGrey),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 0.5,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        color: const Color.fromARGB(
                                            255, 205, 243, 207),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 2,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 62, 151, 65),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "₹ ${p.netPayable.toStringAsFixed(0)}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                              const Text(
                                                AppStrings.empnetPay,
                                                style: TextStyle(
                                                  fontSize: 9,
                                                  color: AppColors.lightGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          final boxWidth =
                                              constraints.constrainWidth();
                                          const dashWidth = 2.0;
                                          const dashHeight = 1.0;
                                          const dashSpacing = 2.0;
                                          final dashCount = (boxWidth /
                                                  (dashWidth + dashSpacing))
                                              .floor();

                                          return Flex(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            direction: Axis.horizontal,
                                            children:
                                                List.generate(dashCount, (_) {
                                              return SizedBox(
                                                width: dashWidth,
                                                height: dashHeight,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.grey),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Wrap(
                                        runSpacing: 6,
                                        spacing: 8,
                                        direction: Axis.horizontal,
                                        children: [
                                          BoxInfo(AppStrings.paidDays, "31"),
                                          BoxInfo(AppStrings.lopDays, "0"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        const Divider(),

                        // === PF and UAN ===
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "${AppStrings.pfAc} Number    :  ",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: p.pfNumber,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: "UAN   :   ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.lightGrey,
                                        ),
                                      ),
                                      TextSpan(
                                        text: p.uan,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // === Earnings & Deductions Table ===
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: const [
                                    Expanded(
                                        flex: 2,
                                        child: Text(AppStrings.earning,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 9))),
                                    Expanded(
                                        child: Text(AppStrings.amount,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 9))),
                                    Expanded(
                                        child: Text(" ${AppStrings.ytd}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 9))),
                                    SizedBox(width: 14),
                                    Expanded(
                                        flex: 2,
                                        child: Text(AppStrings.deduction,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 9))),
                                    Expanded(
                                        child: Text("${AppStrings.amount} ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 9))),
                                    Expanded(
                                        child: Text(" ${AppStrings.ytd}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 9))),
                                  ],
                                ),
                              ),
                              ...List.generate(p.earnings.length, (i) {
                                final eKey = p.earnings.keys.elementAt(i);
                                final eAmt = p.earnings[eKey]!;
                                final eYTD = p.earningsYTD[eKey] ?? 0;

                                final dKey = i < p.deductions.length
                                    ? p.deductions.keys.elementAt(i)
                                    : "";
                                final dAmt = i < p.deductions.length
                                    ? p.deductions[dKey]!
                                    : 0;
                                final dYTD = i < p.deductions.length
                                    ? p.deductionsYTD[dKey] ?? 0
                                    : 0;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Text(eKey,
                                              style: const TextStyle(
                                                  fontSize: 9))),
                                      Expanded(
                                          child: Text(
                                              "₹ ${eAmt.toStringAsFixed(0)}",
                                              style: const TextStyle(
                                                  fontSize: 8))),
                                      Expanded(
                                          child: Text(
                                              "₹ ${eYTD.toStringAsFixed(0)}",
                                              style: const TextStyle(
                                                  fontSize: 8))),
                                      const SizedBox(width: 16),
                                      Expanded(
                                          flex: 2,
                                          child: Text(dKey,
                                              style: const TextStyle(
                                                  fontSize: 8))),
                                      Expanded(
                                          child: Text(
                                              "₹ ${dAmt.toStringAsFixed(0)}",
                                              style: const TextStyle(
                                                  fontSize: 8))),
                                      Expanded(
                                          child: Text(
                                              "₹ ${dYTD.toStringAsFixed(0)}",
                                              style: const TextStyle(
                                                  fontSize: 8))),
                                    ],
                                  ),
                                );
                              }),
                              Container(
                                color: Colors.blue.shade50,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 2,
                                        child: Text(AppStrings.grossEarning,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10))),
                                    Expanded(
                                      child: Text(
                                          "₹ ${p.grossEarnings.toStringAsFixed(0)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ),
                                    const Expanded(child: Text("")),
                                    const SizedBox(width: 16),
                                    const Expanded(
                                        flex: 2,
                                        child: Text(AppStrings.totalDeduction,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10))),
                                    Expanded(
                                        child: Text(
                                            "₹ ${p.totalDeductions.toStringAsFixed(0)}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10))),
                                    const Expanded(child: Text("")),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // === Total Net Pay ===
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(AppStrings.totalNetPayable,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                      Text(AppStrings.gtDeduction,
                                          style: TextStyle(
                                              color: AppColors.lightGrey,
                                              fontSize: 9)),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 205, 243, 207),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "₹ ${p.netPayable.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 6),

                        // === Amount in Words ===
                        Padding(
                          padding: const EdgeInsets.only(left: 90.0),
                          child: Row(
                            children: [
                              const Text(AppStrings.amountInWords,
                                  style: TextStyle(
                                      color: AppColors.lightGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  AppStrings.sal,
                                  style: const TextStyle(
                                      color: AppColors.lightGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                        const Divider(),

                        const Center(
                          child: Text(
                            AppStrings.autoGeneratedTxt,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightGrey),
                          ),
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              await SlipPdfGenerator.generateAndDownload(
                                  model.payslip);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 75, 159, 228),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              AppStrings.downloadPayslip,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(AppStrings.monthlyPayslipHistory,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 12),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              _buildHistoryRow(
                                  AppStrings.month,
                                  AppStrings.netPay,
                                  AppStrings.status,
                                  AppStrings.action,
                                  isHeader: true),
                              ...List.generate(model.payslipHistory.length,
                                  (i) {
                                final payslip = model.payslipHistory[i];
                                final isSelected = payslip.payPeriod ==
                                    model.payslip.payPeriod;
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      model.selectPayslip(payslip);
                                    });
                                  },
                                  child: Container(
                                    decoration: isSelected
                                        ? BoxDecoration(
                                            color:
                                                Colors.blue.withOpacity(0.08),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          )
                                        : null,
                                    child: _buildHistoryRow(
                                      payslip.payPeriod,
                                      "₹${payslip.netPayable.toStringAsFixed(0)}",
                                      "✅Generated",
                                      "[📥 Download]",
                                       onDownload: () async {
                                        await SlipPdfGenerator
                                            .generateAndDownload(payslip);
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Top Navigation/Search
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: isSearching
                  ? InlineSearchBar(
                      query: searchQuery,
                      onQueryChanged: (val) =>
                          setState(() => searchQuery = val),
                      onSubmit: _handleSearchSubmit,
                      onClose: () => _toggleSearch(false),
                    )
                  : TopNavigationBar(
                      searchHint: 'Search payslip...',
                      onSearchTap: () => _toggleSearch(true),
                    ),
            ),

            // Search history
            if (isSearching && searchHistory.isNotEmpty)
              Positioned(
                top: kToolbarHeight,
                left: 0,
                right: 0,
                child: Container(
                  color: AppColors.white,
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Search History',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey),
                        ),
                      ),
                      const Divider(height: 1, color: AppColors.borderColor),
                      Flexible(
                        child: ListView.builder(
                          itemCount: searchHistory.length,
                          itemBuilder: (_, index) {
                            final item = searchHistory[index];
                            return ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              title: Text(item),
                              onTap: () {
                                setState(() {
                                  searchQuery = item;
                                });
                                _handleSearchSubmit();
                              },
                            );
                          },
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

  Widget _buildHistoryRow(
  String month,
  String netPay,
  String status,
  String action, {
  bool isHeader = false,
  Function()? onDownload
}) {
  final textStyle = TextStyle(
    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    fontSize: 10,
    color: AppColors.black,
  );

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(flex: 2, child: Text(month, style: textStyle)),
        Expanded(flex: 2, child: Text(netPay, style: textStyle)),
        Expanded(flex: 2, child: Text(status, style: textStyle)),
        Expanded(
          flex: 2,
          child: GestureDetector(
              onTap: onDownload,
              child: Text(
                action,
                style: TextStyle(
                    fontSize: 10,
                    color: onDownload != null ? AppColors.blue : null,
                    decoration:
                        onDownload != null ? TextDecoration.underline : null),
              ),
            ),
        ),
      ],
    ),
  );
}

}
