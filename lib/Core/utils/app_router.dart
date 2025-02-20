import 'package:go_router/go_router.dart';
import 'package:mazraaty/Features/authentication/presentation/views/login_view.dart';
import 'package:mazraaty/Features/authentication/presentation/views/signup_view.dart';
import 'package:mazraaty/Features/onboardeing/presentation/views/onboard_view.dart';
import 'package:mazraaty/Features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  //static const String kSplashView = '/';
  static const String kOnboardingView = '/onboarding_view';
  static const String kLoginView = '/';
  static const String kSignupView = '/signup_view';
  static const String kHomeView = '/home_view';

  static final router = GoRouter(routes: [
    // GoRoute(
    //   path: kSplashView,
    //   builder: (context, state) => const SplashView(),
    // ),
    GoRoute(
      path: kOnboardingView,
      builder: (context, state) => const OnboardScreensView(),
    ),
    GoRoute(
      path: kLoginView,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: kSignupView,
      builder: (context, state) => const SignupView(),
    ),
  ]);
}
