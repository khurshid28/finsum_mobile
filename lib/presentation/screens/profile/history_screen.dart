import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _payments = [
    {
      'id': '1',
      'type': 'payment',
      'title': 'Samsung Galaxy A54',
      'shopName': 'Samsung Store',
      'amount': 750000,
      'date': DateTime(2024, 12, 10),
      'status': 'success',
    },
    {
      'id': '2',
      'type': 'payment',
      'title': 'Artel Muzlatgich 350L',
      'shopName': 'Artel',
      'amount': 500000,
      'date': DateTime(2024, 12, 5),
      'status': 'success',
    },
    {
      'id': '3',
      'type': 'payment',
      'title': 'Samsung Galaxy A54',
      'shopName': 'Samsung Store',
      'amount': 750000,
      'date': DateTime(2024, 11, 10),
      'status': 'success',
    },
    {
      'id': '4',
      'type': 'payment',
      'title': 'Artel Muzlatgich 350L',
      'shopName': 'Artel',
      'amount': 500000,
      'date': DateTime(2024, 11, 5),
      'status': 'pending',
    },
  ];

  final List<Map<String, dynamic>> _purchases = [
    {
      'id': '1',
      'type': 'purchase',
      'title': 'Samsung Galaxy A54',
      'shopName': 'Samsung Store',
      'amount': 4500000,
      'date': DateTime(2024, 10, 15),
      'installmentMonths': 6,
    },
    {
      'id': '2',
      'type': 'purchase',
      'title': 'Artel Muzlatgich 350L',
      'shopName': 'Artel',
      'amount': 6000000,
      'date': DateTime(2024, 8, 1),
      'installmentMonths': 12,
    },
    {
      'id': '3',
      'type': 'purchase',
      'title': 'iPhone 13 Pro',
      'shopName': 'iSpace',
      'amount': 12000000,
      'date': DateTime(2023, 12, 20),
      'installmentMonths': 12,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatMoney(int amount) {
    final formatter = NumberFormat('#,###', 'uz_UZ');
    return '${formatter.format(amount)} so\'m';
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy, HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 32.h,
              width: 32.w,
            ),
            SizedBox(width: 8.w),
            const Text('Tarix'),
          ],
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'To\'lovlar'),
            Tab(text: 'Xaridlar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPaymentsList(),
          _buildPurchasesList(),
        ],
      ),
    );
  }

  Widget _buildPaymentsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _payments.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 50),
          child: _buildPaymentCard(_payments[index]),
        );
      },
    );
  }

  Widget _buildPurchasesList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _purchases.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 50),
          child: _buildPurchaseCard(_purchases[index]),
        );
      },
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    final bool isSuccess = payment['status'] == 'success';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: isSuccess
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.warning.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              isSuccess ? 'assets/icons/svg/check.svg' : 'assets/icons/svg/clock.svg',
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                isSuccess ? AppColors.success : AppColors.warning,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment['title'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.store,
                      size: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        payment['shopName'],
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/clock.svg',
                      width: 12.w,
                      height: 12.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _formatDate(payment['date']),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-${_formatMoney(payment['amount'])}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: isSuccess ? AppColors.success : AppColors.warning,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isSuccess
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  isSuccess ? 'To\'landi' : 'Kutilmoqda',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: isSuccess ? AppColors.success : AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseCard(Map<String, dynamic> purchase) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/svg/bag.svg',
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  purchase['title'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/store.svg',
                      width: 14.w,
                      height: 14.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        purchase['shopName'],
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/clock.svg',
                      width: 12.w,
                      height: 12.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _formatDate(purchase['date']),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatMoney(purchase['amount']),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  '${purchase['installmentMonths']} oy',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
