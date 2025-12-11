import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/theme/app_colors.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUser());
  }

  String _formatMoney(int amount) {
    final formatter = NumberFormat('#,###', 'uz_UZ');
    return '${formatter.format(amount)} so\'m';
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
            const Text('FinSum'),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/svg/notification.svg',
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
      body: BlocProvider(
        create: (_) => getIt<UserBloc>()..add(LoadUser()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return _buildLoadingView();
            } else if (state is UserLoaded) {
              return _buildLoadedView(state);
            } else {
              return _buildErrorView();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          ShimmerWidget(
            height: 180.h,
            width: double.infinity,
            borderRadius: 16.r,
          ),
          SizedBox(height: 24.h),
          ShimmerWidget(
            height: 100.h,
            width: double.infinity,
            borderRadius: 16.r,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedView(UserLoaded state) {
    final user = state.user;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Limit Card
          FadeInDown(
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [AppColors.cardShadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sizning limitingiz',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Mavjud',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    _formatMoney(user.availableLimit),
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        'Jami limit: ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        _formatMoney(user.limit),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_circle_outline),
                        SizedBox(width: 8.w),
                        Text(
                          'Ariza topshirish',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Quick Actions
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: Text(
              'Tez amallar',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    iconPath: 'assets/icons/svg/bag.svg',
                    title: 'Xaridlar',
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildQuickAction(
                    iconPath: 'assets/icons/svg/history.svg',
                    title: 'Tarix',
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    iconPath: 'assets/icons/svg/arrow-up.svg',
                    title: 'Chegirmalar',
                    color: AppColors.accent,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildQuickAction(
                    iconPath: 'assets/icons/svg/info.svg',
                    title: 'Yordam',
                    color: AppColors.info,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required String iconPath,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [AppColors.cardShadow],
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 32.w,
            height: 32.h,
            colorFilter: ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: AppColors.error,
          ),
          SizedBox(height: 16.h),
          Text(
            'Xatolik yuz berdi',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<UserBloc>().add(LoadUser()),
            child: const Text('Qayta urinish'),
          ),
        ],
      ),
    );
  }
}
