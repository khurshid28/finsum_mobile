import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/local/local_data_source.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/locale/locale_bloc.dart';
import 'purchases_screen.dart';
import 'history_screen.dart';
import 'cards_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: BlocProvider(
        create: (_) => getIt<UserBloc>()..add(LoadUser()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // Profile Header
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [AppColors.cardShadow],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 70.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 40.sp,
                                  color: Colors.white,
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(4.w),
                                    decoration: const BoxDecoration(
                                      color: AppColors.success,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/svg/check.svg',
                                      width: 12.w,
                                      height: 12.h,
                                      colorFilter: ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.fullName,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    'Tasdiqlangan',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  user.phone,
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
                    SizedBox(height: 24.h),

                    // Menu Items
                    _buildMenuItem(
                      iconPath: 'assets/icons/svg/card.svg',
                      title: 'Kartalarim',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CardsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/icons/svg/bag.svg',
                      title: 'Xaridlarim',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PurchasesScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/icons/svg/history.svg',
                      title: 'Tarix',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistoryScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/icons/svg/info.svg',
                      title: 'Biz haqimizda',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/icons/svg/headset.svg',
                      title: 'Bog\'lanish',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/icons/svg/language.svg',
                      title: 'Til',
                      onTap: () => _showLanguageDialog(context),
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/icons/svg/moon.svg',
                      title: 'Qorong\'u rejim',
                      trailing: BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return Switch(
                            value: state.themeMode == ThemeMode.dark,
                            onChanged: (_) {
                              context.read<ThemeBloc>().add(ToggleTheme());
                            },
                            activeTrackColor: AppColors.primary,
                          );
                        },
                      ),
                      onTap: () {},
                    ),
                    SizedBox(height: 16.h),
                    _buildMenuItem(
                      iconPath: 'assets/icons/svg/logout.svg',
                      title: 'Chiqish',
                      textColor: AppColors.error,
                      onTap: () => _showLogoutDialog(context),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    Widget? trailing,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [AppColors.cardShadow],
      ),
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(
          iconPath,
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            textColor ?? AppColors.textPrimary,
            BlendMode.srcIn,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: textColor ?? AppColors.textPrimary,
          ),
        ),
        trailing: trailing ??
            SvgPicture.asset(
              'assets/icons/svg/chevron-right.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(
                AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tilni tanlang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('O\'zbekcha'),
              onTap: () {
                context
                    .read<LocaleBloc>()
                    .add(ChangeLocale(const Locale('uz', 'UZ')));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Русский'),
              onTap: () {
                context
                    .read<LocaleBloc>()
                    .add(ChangeLocale(const Locale('ru', 'RU')));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('English'),
              onTap: () {
                context
                    .read<LocaleBloc>()
                    .add(ChangeLocale(const Locale('en', 'US')));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chiqish'),
        content: const Text('Haqiqatan ham chiqmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Yo\'q'),
          ),
          TextButton(
            onPressed: () async {
              await getIt<LocalDataSource>().clearAll();
              if (context.mounted) {
                context.go(AppRouter.login);
              }
            },
            child: const Text('Ha'),
          ),
        ],
      ),
    );
  }
}
