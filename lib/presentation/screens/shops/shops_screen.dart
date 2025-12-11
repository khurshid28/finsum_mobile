import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import 'shop_detail_screen.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  final List<Map<String, dynamic>> _shops = [
    {
      'id': '1',
      'name': 'Artel',
      'category': 'Maishiy texnika',
      'image': 'assets/images/placeholder.png',
      'address': 'Yunusobod tumani, Amir Temur shoh ko\'chasi 107A',
      'phone': '+998 71 202 00 00',
      'workTime': '09:00 - 20:00',
      'isOpen': true,
      'rating': 4.8,
      'productsCount': 245,
    },
    {
      'id': '2',
      'name': 'Samsung',
      'category': 'Elektronika',
      'image': 'assets/images/placeholder.png',
      'address': 'Chilonzor tumani, Bunyodkor ko\'chasi 51',
      'phone': '+998 71 200 01 00',
      'workTime': '10:00 - 21:00',
      'isOpen': true,
      'rating': 4.9,
      'productsCount': 320,
    },
    {
      'id': '3',
      'name': 'Texnomart',
      'category': 'Maishiy texnika',
      'image': 'assets/images/placeholder.png',
      'address': 'Sergeli tumani, Yangi Sergeli ko\'chasi 12',
      'phone': '+998 71 200 55 00',
      'workTime': '09:00 - 22:00',
      'isOpen': false,
      'rating': 4.7,
      'productsCount': 580,
    },
  ];

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
            const Text('Do\'konlar'),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/svg/search.svg',
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: _shops.length,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: index * 100),
            child: _buildShopCard(_shops[index]),
          );
        },
      ),
    );
  }

  Widget _buildShopCard(Map<String, dynamic> shop) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ShopDetailScreen(shop: shop),
          ),
        );
      },
      child: Container(
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
            // Image and status
            Stack(
              children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Image.asset(
                  shop['image'],
                  height: 180.h,
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
                    color: shop['isOpen'] ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    shop['isOpen'] ? 'Ochiq' : 'Yopiq',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
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
                // Name and rating
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        shop['name'],
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/svg/star.svg',
                      width: 20.w,
                      height: 20.h,
                      colorFilter: ColorFilter.mode(
                        Colors.amber,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      shop['rating'].toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),
                Text(
                  shop['category'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: 12.h),

                // Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/location.svg',
                      width: 18.w,
                      height: 18.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        shop['address'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Phone
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/phone.svg',
                      width: 18.w,
                      height: 18.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      shop['phone'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Work time
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/clock.svg',
                      width: 18.w,
                      height: 18.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      shop['workTime'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Products count
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${shop['productsCount']} ta mahsulot',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
