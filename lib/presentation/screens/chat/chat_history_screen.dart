import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final List<Map<String, dynamic>> _history = [
    {
      'id': '1',
      'shopName': 'Artel',
      'subject': 'Mahsulot haqida savol',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'messageCount': 12,
      'status': 'closed',
    },
    {
      'id': '2',
      'shopName': 'Samsung',
      'subject': 'To\'lov muammosi',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'messageCount': 8,
      'status': 'closed',
    },
    {
      'id': '3',
      'shopName': 'Qo\'llab-quvvatlash',
      'subject': 'Texnik yordam',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'messageCount': 15,
      'status': 'closed',
    },
    {
      'id': '4',
      'shopName': 'Artel',
      'subject': 'Yetkazib berish',
      'date': DateTime.now().subtract(const Duration(days: 14)),
      'messageCount': 6,
      'status': 'closed',
    },
  ];

  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Chat Tarixi'),
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
      body: _history.isEmpty ? _buildEmptyState() : _buildHistoryList(),
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
            'Tarix bo\'sh',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Hali hech qanday chat tarixi yo\'q',
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
      itemCount: _history.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildHistoryItem(_history[index]),
        );
      },
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item['shopName']} - ${item['subject']} chati ochildi'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
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
              Expanded(
                child: Text(
                  item['shopName'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Yopilgan',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            item['subject'],
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
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
                _formatDate(item['date']),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(width: 16.w),
              SvgPicture.asset(
                'assets/icons/svg/chat.svg',
                width: 14.w,
                height: 14.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '${item['messageCount']} ta xabar',
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
    );
  }
}
