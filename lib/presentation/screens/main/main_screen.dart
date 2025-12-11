import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../home/home_screen.dart';
import '../shops/shops_screen.dart';
import '../saved/saved_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ShopsScreen(),
    SavedScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/svg/home.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/svg/home.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Asosiy',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/svg/shop.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/svg/shop.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Do\'konlar',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/svg/bookmark.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/svg/bookmark.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Saqlangan',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/svg/chat.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/svg/chat.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/svg/user.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/svg/user.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
