import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/custom_button.dart';

class VerifyScreen extends StatefulWidget {
  final String phone;
  
  const VerifyScreen({super.key, required this.phone});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _codeController = TextEditingController();
  Timer? _timer;
  int _seconds = 120;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() => _seconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
    super.dispose();
  }

  void _handleVerify() {
    if (_codeController.text.length == 6) {
      context.read<AuthBloc>().add(
            VerifyCodeRequested(widget.phone, _codeController.text),
          );
    }
  }

  void _resendCode() {
    setState(() => _seconds = 120);
    _startTimer();
    context.read<AuthBloc>().add(LoginRequested(widget.phone));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tasdiqlash'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
            if (state is VerifyCodeSuccess) {
              context.go(AppRouter.passport);
            } else if (state is VerifyCodeFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
        }
      },
        child: SafeArea(
            child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.h),
                FadeInDown(
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/svg/sms.svg',
                          width: 50.w,
                          height: 50.h,
                          colorFilter: ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'SMS kodni kiriting',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      '${widget.phone} raqamiga yuborilgan\n6 raqamli kodni kiriting',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 48.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12.r),
                        fieldHeight: 60.h,
                        fieldWidth: 50.w,
                        activeFillColor: AppColors.inputBackground,
                        inactiveFillColor: AppColors.inputBackground,
                        selectedFillColor: AppColors.inputBackground,
                        activeColor: AppColors.primary,
                        inactiveColor: AppColors.textHint.withOpacity(0.3),
                        selectedColor: AppColors.primary,
                      ),
                      animationDuration: const Duration(milliseconds: 200),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      onCompleted: (code) => _handleVerify(),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: 24.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Kodni qayta yuborish: ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_seconds == 0) ...[
                    SizedBox(height: 16.h),
                    TextButton(
                      onPressed: _resendCode,
                      child: Text(
                        'Qayta yuborish',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 24.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          text: 'Tasdiqlash',
                          onPressed: _handleVerify,
                          isLoading: state is AuthLoading,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        
      ),
    );
  }
}
