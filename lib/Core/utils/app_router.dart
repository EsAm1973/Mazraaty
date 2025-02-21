import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:mazraaty/Features/authentication/presentation/manager/Authentication/authentication_cubit.dart';
import 'package:mazraaty/Features/authentication/presentation/views/login_view.dart';
import 'package:mazraaty/Features/authentication/presentation/views/recover_pass_view.dart';
import 'package:mazraaty/Features/authentication/presentation/views/resetpass_view.dart';
import 'package:mazraaty/Features/authentication/presentation/views/signup_view.dart';
import 'package:mazraaty/Features/authentication/presentation/views/verify_code_view.dart';
import 'package:mazraaty/Features/onboardeing/presentation/views/onboard_view.dart';
import 'package:mazraaty/Features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kSplashView = '/';
  static const String kOnboardingView = '/onboarding_view';
  static const String kLoginView = '/login_view';
  static const String kSignupView = '/signup_view';
  static const String kHomeView = '/home_view';
  static const String kRecoverPassView = '/recoverpass_view';
  static const String kVerifyCodeView = '/verifycode_view';
  static const String kResetPassView = '/resetpass_view';

  static final router = GoRouter(routes: [
    GoRoute(
      path: kSplashView,
      builder: (context, state) => const SplashView(),
    ),
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
      builder: (context, state) => BlocProvider(
        create: (context) => AuthenticationCubit(
            AuthenticationRepoImpl(apiService: ApiService(dio: Dio()))),
        child: const SignupView(),
      ),
    ),
    GoRoute(
      path: kRecoverPassView,
      builder: (context, state) => const RecoverPassView(),
    ),
    GoRoute(
      path: kVerifyCodeView,
      builder: (context, state) => const VerifyCodeView(),
    ),
    GoRoute(
      path: kResetPassView,
      builder: (context, state) => const ResetPassView(),
    ),
  ]);
}
