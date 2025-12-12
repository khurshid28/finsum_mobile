import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';

class ScoringScreen extends StatefulWidget {
  const ScoringScreen({super.key});

  @override
  State<ScoringScreen> createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  final int _currentScore = 725;
  final int _maxScore = 850;

  double get _scorePercentage => _currentScore / _maxScore;

  String get _scoreLevel {
    if (_currentScore >= 700) return 'A\'lo';
    if (_currentScore >= 600) return 'Yaxshi';
    if (_currentScore >= 500) return 'O\'rtacha';
    return 'Past';
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
            const Text('Skoring'),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Card
            FadeInDown(
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Sizning skoringiz',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 200.r,
                          height: 200.r,
                          child: CircularProgressIndicator(
                            value: _scorePercentage,
                            strokeWidth: 12.r,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _currentScore.toString(),
                              style: TextStyle(
                                fontSize: 56.sp,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 1,
                              ),
                            ),
                            Text(
                              '/ $_maxScore',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                _scoreLevel,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Kredit olish uchun yaxshi reyting!',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Score Factors
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: Text(
                'Skoringga ta\'sir qiluvchi omillar',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(height: 16.h),

            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _buildFactorCard(
                iconPath: 'assets/icons/svg/check.svg',
                iconColor: AppColors.success,
                title: 'To\'lov tarixi',
                description: 'Barcha to\'lovlar o\'z vaqtida amalga oshirilgan',
                score: 95,
              ),
            ),
            SizedBox(height: 12.h),

            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: _buildFactorCard(
                iconPath: 'assets/icons/svg/wallet.svg',
                iconColor: AppColors.primary,
                title: 'Kredit yuklamasi',
                description: 'Hozirda 2 ta faol kredit mavjud',
                score: 80,
              ),
            ),
            SizedBox(height: 12.h),

            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: _buildFactorCard(
                iconPath: 'assets/icons/svg/history.svg',
                iconColor: AppColors.warning,
                title: 'Kredit tarixi',
                description: '2 yillik to\'lov tarixi',
                score: 70,
              ),
            ),
            SizedBox(height: 12.h),

            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: _buildFactorCard(
                iconPath: 'assets/icons/svg/arrow-up.svg',
                iconColor: AppColors.success,
                title: 'Daromad barqarorligi',
                description: 'Barqaror daromad manbalari',
                score: 85,
              ),
            ),
            SizedBox(height: 24.h),

            // Tips Card
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lightbulb,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Maslahat',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'To\'lovlaringizni o\'z vaqtida amalga oshiring va skoringiz yanada yaxshilanadi!',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactorCard({
    required String iconPath,
    required Color iconColor,
    required String title,
    required String description,
    required int score,
  }) {
    return Container(
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
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                iconColor,
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
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            children: [
              Text(
                '$score%',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: iconColor,
                ),
              ),
              SizedBox(
                width: 40.w,
                child: LinearProgressIndicator(
                  value: score / 100,
                  backgroundColor: iconColor.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
