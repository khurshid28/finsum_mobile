import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/verify_screen.dart';
import '../../presentation/screens/auth/passport_screen.dart';
import '../../presentation/screens/main/main_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String verify = '/verify';
  static const String passport = '/passport';
  static const String main = '/main';
  static const String home = '/home';
  static const String catalog = '/catalog';
  static const String cart = '/cart';
  static const String profile = '/profile';

  final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: verify,
        builder: (context, state) {
          final phone = state.extra as String?;
          return VerifyScreen(phone: phone ?? '');
        },
      ),
      GoRoute(
        path: passport,
        builder: (context, state) => const PassportScreen(),
      ),
      GoRoute(
        path: main,
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}
