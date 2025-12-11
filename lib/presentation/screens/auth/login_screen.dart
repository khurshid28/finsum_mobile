import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/locale/locale_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _phoneMask = MaskTextInputFormatter(
    mask: '+998 (##) ###-##-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final phone = '+998${_phoneMask.getUnmaskedText()}';
    if (_phoneMask.getUnmaskedText().length == 9) {
      context.read<AuthBloc>().add(LoginRequested(phone));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go(
                AppRouter.verify,
                extra: '+998${_phoneMask.getUnmaskedText()}',
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),
                // Language selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<LocaleBloc, LocaleState>(
                      builder: (context, state) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildLanguageButton('🇺🇿', 'UZ',
                                  state.locale.languageCode == 'uz'),
                              SizedBox(width: 8.w),
                              _buildLanguageButton('🇷🇺', 'RU',
                                  state.locale.languageCode == 'ru'),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                FadeInDown(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 200.h,
                      width: 200.w,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Icon(
                            Icons.image_not_supported,
                            size: 80.sp,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                FadeInDown(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Xush kelibsiz!',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 12.h),
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    'Telefon raqamingizni kiriting',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 48.h),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    controller: _phoneController,
                    hintText: '+998 (__) ___-__-__',
                    prefixIconPath: 'assets/icons/svg/phone.svg',
                    keyboardType: TextInputType.phone,
                    inputFormatters: [_phoneMask],
                  ),
                ),
                SizedBox(height: 24.h),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Davom etish',
                        onPressed: _handleLogin,
                        isLoading: state is AuthLoading,
                      );
                    },
                  ),
                ),
                const Spacer(),
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: Text(
                    'Davom etish orqali siz shaxsiy ma\'lumotlarni\nqayta ishlashga rozilik bildirasiz',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(String flag, String code, bool isSelected) {
    return GestureDetector(
      onTap: () {
        context
            .read<LocaleBloc>()
            .add(ChangeLocale(Locale(code.toLowerCase())));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 16.sp)),
            SizedBox(width: 4.w),
            Text(
              code,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
