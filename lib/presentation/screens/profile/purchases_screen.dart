import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  final List<Map<String, dynamic>> _purchases = [
    {
      'id': '1',
      'productName': 'Samsung Galaxy A54',
      'shopName': 'Samsung Store',
      'image': 'assets/images/placeholder.png',
      'totalPrice': 4500000,
      'monthlyPayment': 750000,
      'paidMonths': 2,
      'totalMonths': 6,
      'remainingAmount': 3000000,
      'date': DateTime(2024, 10, 15),
      'status': 'active',
    },
    {
      'id': '2',
      'productName': 'Artel Muzlatgich 350L',
      'shopName': 'Artel',
      'image': 'assets/images/placeholder.png',
      'totalPrice': 6000000,
      'monthlyPayment': 500000,
      'paidMonths': 6,
      'totalMonths': 12,
      'remainingAmount': 3000000,
      'date': DateTime(2024, 8, 1),
      'status': 'active',
    },
    {
      'id': '3',
      'productName': 'iPhone 13 Pro',
      'shopName': 'iSpace',
      'image': 'assets/images/placeholder.png',
      'totalPrice': 12000000,
      'monthlyPayment': 1000000,
      'paidMonths': 12,
      'totalMonths': 12,
      'remainingAmount': 0,
      'date': DateTime(2023, 12, 20),
      'status': 'completed',
    },
  ];

  String _formatMoney(int amount) {
    final formatter = NumberFormat('#,###', 'uz_UZ');
    return '${formatter.format(amount)} so\'m';
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
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
            const Text('Xaridlarim'),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/svg/chevron-right.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              AppColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: _purchases.length,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: index * 100),
            child: _buildPurchaseCard(_purchases[index]),
          );
        },
      ),
    );
  }

  Widget _buildPurchaseCard(Map<String, dynamic> purchase) {
    final double progress = purchase['paidMonths'] / purchase['totalMonths'];
    final bool isCompleted = purchase['status'] == 'completed';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Status Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Image.asset(
                  purchase['image'],
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isCompleted ? AppColors.success : AppColors.primary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        isCompleted
                            ? 'assets/icons/svg/check.svg'
                            : 'assets/icons/svg/clock.svg',
                        width: 14.w,
                        height: 14.h,
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        isCompleted ? 'To\'landi' : 'Faol',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  purchase['productName'],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),

                // Shop Name
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/store.svg',
                      width: 16.w,
                      height: 16.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      purchase['shopName'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'To\'lov jarayoni',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${purchase['paidMonths']}/${purchase['totalMonths']} oy',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8.h,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCompleted ? AppColors.success : AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Payment Details
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        'Umumiy narx',
                        _formatMoney(purchase['totalPrice']),
                      ),
                      SizedBox(height: 8.h),
                      _buildDetailRow(
                        'Oylik to\'lov',
                        _formatMoney(purchase['monthlyPayment']),
                      ),
                      if (!isCompleted) ...[
                        SizedBox(height: 8.h),
                        _buildDetailRow(
                          'Qolgan summa',
                          _formatMoney(purchase['remainingAmount']),
                          valueColor: AppColors.error,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // Purchase Date
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Xarid qilingan: ${_formatDate(purchase['date'])}',
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
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
