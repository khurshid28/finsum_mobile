import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<Map<String, dynamic>> _savedItems = [
    {
      'id': '1',
      'name': 'Samsung Galaxy S24',
      'price': 15000000,
      'monthlyPrice': 1250000,
      'image': 'assets/images/placeholder.png',
      'shop': 'Samsung',
    },
    {
      'id': '2',
      'name': 'iPhone 15 Pro',
      'price': 20000000,
      'monthlyPrice': 1666667,
      'image': 'assets/images/placeholder.png',
      'shop': 'iStore',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saqlanganlar'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _savedItems.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: _savedItems.length,
              itemBuilder: (context, index) {
                return FadeInUp(
                  delay: Duration(milliseconds: index * 100),
                  child: _buildSavedCard(_savedItems[index], index),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/svg/bookmark.svg',
            width: 100.w,
            height: 100.h,
            colorFilter: ColorFilter.mode(
              AppColors.textSecondary.withOpacity(0.5),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Hali hech narsa saqlanmagan',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedCard(Map<String, dynamic> item, int index) {
    return Dismissible(
      key: Key(item['id']),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _savedItems.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saqlanganlardan o\'chirildi')),
        );
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        child: SvgPicture.asset(
          'assets/icons/svg/delete.svg',
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(12.w),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                item['image'],
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item['shop'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        '${_formatPrice(item['price'])} so\'m',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '/ ${_formatPrice(item['monthlyPrice'])} so\'m/oy',
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
            IconButton(
              icon: const Icon(Icons.bookmark, color: AppColors.primary),
              onPressed: () {
                setState(() {
                  _savedItems.removeAt(index);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]} ',
        );
  }
}
