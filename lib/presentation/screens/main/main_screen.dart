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
              icon: _buildNavIcon('assets/icons/svg/home.svg', false),
              activeIcon: _buildNavIcon('assets/icons/svg/home.svg', true),
              label: 'Asosiy',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon('assets/icons/svg/shop.svg', false),
              activeIcon: _buildNavIcon('assets/icons/svg/shop.svg', true),
              label: 'Do\'konlar',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon('assets/icons/svg/bookmark.svg', false),
              activeIcon: _buildNavIcon('assets/icons/svg/bookmark.svg', true),
              label: 'Saqlangan',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon('assets/icons/svg/chat.svg', false),
              activeIcon: _buildNavIcon('assets/icons/svg/chat.svg', true),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon('assets/icons/svg/user.svg', false),
              activeIcon: _buildNavIcon('assets/icons/svg/user.svg', true),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(String iconPath, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(isActive ? 0 : 0),
      child: SvgPicture.asset(
        iconPath,
        width: isActive ? 26.w : 24.w,
        height: isActive ? 26.h : 24.h,
        colorFilter: ColorFilter.mode(
          isActive ? AppColors.primary : AppColors.textSecondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
