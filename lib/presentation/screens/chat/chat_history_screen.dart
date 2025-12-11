import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';

class ChatHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> myMessages;

  const ChatHistoryScreen({super.key, required this.myMessages});

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Bugun ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Kecha ${DateFormat('HH:mm').format(date)}';
    } else {
      return DateFormat('dd.MM.yyyy HH:mm').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mening Savollarim'),
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
      body: myMessages.isEmpty ? _buildEmptyState() : _buildHistoryList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/svg/history.svg',
            width: 100.w,
            height: 100.h,
            colorFilter: ColorFilter.mode(
              AppColors.textSecondary.withOpacity(0.5),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Hali savol yo\'q',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Qo\'llab-quvvatlashga savol yuboring',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: myMessages.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildHistoryItem(myMessages[index], index + 1),
        );
      },
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> message, int number) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '#$number',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/svg/clock.svg',
                width: 14.w,
                height: 14.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                _formatDate(message['time']),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            message['text'],
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
