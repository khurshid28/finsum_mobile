import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/di/injection_container.dart';
import '../../../data/datasources/local/local_data_source.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class PassportScreen extends StatefulWidget {
  const PassportScreen({super.key});

  @override
  State<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends State<PassportScreen> {
  final _passportController = TextEditingController();
  final _dateController = TextEditingController();

  final _passportMask = MaskTextInputFormatter(
    mask: 'AA #######',
    filter: {'A': RegExp(r'[A-Z]'), '#': RegExp(r'[0-9]')},
  );

  final _dateMask = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _passportController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _handleVerify() {
    final passport = _passportMask.getUnmaskedText();
    if (passport.length == 9 && _dateController.text.length == 10) {
      context.read<AuthBloc>().add(
            VerifyPassportRequested(
              series: passport.substring(0, 2),
              number: passport.substring(2),
              birthDate: _dateController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyID'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is VerifyPassportSuccess) {
            // Save default token
            final localDataSource = getIt<LocalDataSource>();
            await localDataSource.saveToken(
                'default_auth_token_${DateTime.now().millisecondsSinceEpoch}');

            if (mounted) {
              context.go(AppRouter.main);
            }
          } else if (state is VerifyPassportFailure) {
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
                        'assets/icons/svg/card.svg',
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
                    'Pasport ma\'lumotlari',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 48.h),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: CustomTextField(
                    controller: _passportController,
                    hintText: 'AB 1234567',
                    prefixIconPath: 'assets/icons/svg/card.svg',
                    keyboardType: TextInputType.text,
                    inputFormatters: [_passportMask],
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    controller: _dateController,
                    hintText: 'DD.MM.YYYY',
                    prefixIconPath: 'assets/icons/svg/calendar.svg',
                    keyboardType: TextInputType.number,
                    inputFormatters: [_dateMask],
                  ),
                ),
                SizedBox(height: 32.h),
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
