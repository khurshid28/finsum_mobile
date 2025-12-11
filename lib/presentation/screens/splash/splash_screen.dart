import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/di/injection_container.dart';
import '../../../data/datasources/local/local_data_source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      final localDataSource = getIt<LocalDataSource>();
      final token = localDataSource.getToken();
      
      if (token != null && token.isNotEmpty) {
        context.go(AppRouter.main);
      } else {
        context.go(AppRouter.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 1000),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 150.h,
                    width: 120.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 100.sp,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  'FinSum',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  'Muddat to\'lovga xarid qiling',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              FadeIn(
                delay: const Duration(milliseconds: 1500),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
