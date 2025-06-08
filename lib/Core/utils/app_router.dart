import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/data/Cubits/Change%20Pass%20Cubit/change_password_cubit.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Core/widgets/custom_nav_bar.dart';
import 'package:mazraaty/Features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:mazraaty/Features/authentication/presentation/manager/Authentication/authentication_cubit.dart';
import 'package:mazraaty/Features/authentication/presentation/views/login_view.dart';
import 'package:mazraaty/Features/authentication/presentation/views/recover_pass_view.dart';
import 'package:mazraaty/Features/authentication/presentation/views/resetpass_view.dart';
import 'package:mazraaty/Features/authentication/presentation/views/signup_view.dart';
import 'package:mazraaty/Features/authentication/presentation/views/verify_code_view.dart';
import 'package:mazraaty/Features/history/data/repos/history_repo_impl.dart';
import 'package:mazraaty/Features/history/presentation/manager/History/history_cubit.dart';
import 'package:mazraaty/Features/history/presentation/views/history_view.dart';
import 'package:mazraaty/Features/home/data/repos/Common%20Disease/common_disease_repo_impl.dart';
import 'package:mazraaty/Features/home/data/repos/weather_repo_impl.dart';
import 'package:mazraaty/Features/home/presentation/manager/Weather%20Cubit/weather_cubit.dart';
import 'package:mazraaty/Features/home/presentation/views/home_view.dart';
import 'package:mazraaty/Features/onboardeing/presentation/views/onboard_view.dart';
import 'package:mazraaty/Features/payment/data/repos/Package%20Repo/package_repo_impl.dart';
import 'package:mazraaty/Features/payment/data/repos/Payment%20Repo/payment_repo_impl.dart';
import 'package:mazraaty/Features/payment/presentation/manager/Package%20Cubit/cubit/packages_cubit.dart';
import 'package:mazraaty/Features/payment/presentation/manager/Paypal%20Cubit/payment_cubit.dart';
import 'package:mazraaty/Features/payment/presentation/views/methods_view.dart';
import 'package:mazraaty/Features/payment/presentation/views/packages_view.dart';
import 'package:mazraaty/Features/plant_library/data/models/plant.dart';
import 'package:mazraaty/Features/plant_library/data/repos/Library%20Repo/library_repo_impl.dart';
import 'package:mazraaty/Features/plant_library/presentation/manager/LibraryCubit/library_cubit.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/ai_chat_view.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/library_view.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/updated_details_view.dart';
import 'package:mazraaty/Features/profile/data/repos/profile_repo_impl.dart';
import 'package:mazraaty/Features/profile/presentation/manager/Profile/profile_cubit.dart';
import 'package:mazraaty/Features/profile/presentation/views/crop_image_view.dart';
import 'package:mazraaty/Features/profile/presentation/views/delete_acc_view.dart';
import 'package:mazraaty/Features/profile/presentation/views/profile_view.dart';
import 'package:mazraaty/Features/scan_plant/data/data_source/api_scan_service.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Disease%20Details%20Repo/disease_details_repo_impl.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Points%20Repo/points_repo_impl.dart';
import 'package:mazraaty/Features/scan_plant/data/repos/Scan%20Repo/scan_repo_impl.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Disease%20Details/disease_details_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Points%20Cubit/cubit/points_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/manager/Scan/scan_cubit.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/disease_view.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/scan_view.dart';
import 'package:mazraaty/Features/payment/presentation/manager/MyFatoorah%20Cubit/myfatoorah_cubit.dart';
import 'package:mazraaty/Features/splash/presentation/views/splash_view.dart';

import '../../Features/home/presentation/manager/Common Disease Cubit/common_disease_cubit.dart';

abstract class AppRouter {
  static const String kSplashView = '/';
  static const String kOnboardingView = '/onboarding_view';
  static const String kLoginView = '/login_view';
  static const String kSignupView = '/signup_view';
  static const String kScanView = '/scan_view';
  static const String kRecoverPassView = '/recoverpass_view';
  static const String kVerifyCodeView = '/verifycode_view';
  static const String kResetPassView = '/resetpass_view';
  static const String kHomeView = '/home_view';
  static const String kLibraryView = '/library_view';
  static const String kProfileView = '/profile_view';
  static const String kNavigationView = '/navigation_view';
  static const String kCropImageView = '/cropimage_view';
  static const String kHistoryView = '/history_view';
  static const String kUpdatedDetailsView = '/updatedetails_view';
  static const String kDeleteAccountView = '/deleteaccount_view';
  static const String kDiseaseView = '/disease_view';
  static const String kPaymentPackgesView = '/paymentpackages_view';
  static const String kPaymentMethodsView = '/paymentmethods_view';
  static const String kAiChatView = '/aichat_view';

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
      builder: (context, state) => BlocProvider(
        create: (context) => AuthenticationCubit(
            AuthenticationRepoImpl(apiService: ApiService(dio: Dio()))),
        child: const LoginView(),
      ),
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
      builder: (context, state) => BlocProvider(
        create: (context) => PasswordCubit(
            authenticationRepo:
                AuthenticationRepoImpl(apiService: ApiService(dio: Dio()))),
        child: const RecoverPassView(),
      ),
    ),
    GoRoute(
      path: kVerifyCodeView,
      builder: (context, state) => BlocProvider(
        create: (context) => PasswordCubit(
            authenticationRepo:
                AuthenticationRepoImpl(apiService: ApiService(dio: Dio()))),
        child: VerifyCodeView(
          email: state.extra as String,
        ),
      ),
    ),
    GoRoute(
      path: kResetPassView,
      builder: (context, state) => BlocProvider(
        create: (context) => PasswordCubit(
            authenticationRepo:
                AuthenticationRepoImpl(apiService: ApiService(dio: Dio()))),
        child: ResetPassView(
          email: (state.extra as Map)['email'],
          token: (state.extra as Map)['token'],
        ),
      ),
    ),
    GoRoute(
      path: kNavigationView,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherCubit(
              WeatherRepositoryImpl(
                Dio(),
                //LocationService(),
              ),
            )..getWeather('Mansoura'),
          ),
          BlocProvider(
            create: (context) => PointsCubit(
                userCubit: context.read<UserCubit>(),
                pointsRepository:
                    PointsRepositoryImpl(apiService: ApiService(dio: Dio()))),
          ),
          BlocProvider(
              create: (context) => DiseaseDetailsCubit(
                  diseaseRepository: DiseaseRepositoryImpl(
                      apiService: ApiService(dio: Dio())))),
          BlocProvider(
            create: (context) => ScanCubit(
                repository:
                    ScanRepositoryImpl(apiScanService: ApiScanService())),
          ),
          BlocProvider(
            create: (context) {
              final userCubit = context.read<UserCubit>();
              final historyCubit = HistoryCubit(
                HistoryRepositoryImpl(apiService: ApiService(dio: Dio())),
                userCubit,
              );

              // Only load history if user is available
              if (userCubit.currentUser != null) {
                historyCubit.loadHistory();
              }

              return historyCubit;
            },
          ),
          BlocProvider(
            create: (context) =>
                LibraryCubit(PlantRepositoryImpl(ApiService(dio: Dio())))
                  ..fetchCategories(),
          ),
          BlocProvider(
              create: (context) {
                final userCubit = context.read<UserCubit>();
                final profileCubit = ProfileCubit(
                    ProfileRepositoryImpl(apiService: ApiService(dio: Dio())));

                // Only fetch profile if user is available
                if (userCubit.currentUser != null) {
                  profileCubit.fetchProfile(token: userCubit.currentUser!.token);
                }

                return profileCubit;
              }),
          BlocProvider(
            create: (context) {
              final userCubit = context.read<UserCubit>();
              final commonDiseaseCubit = CommonDiseaseCubit(
                  CommonDiseaseRepositoryImpl(apiService: ApiService(dio: Dio())),
                  userCubit);

              // Only fetch diseases if user is available
              if (userCubit.currentUser != null) {
                commonDiseaseCubit.fetchCommonDiseases();
              }

              return commonDiseaseCubit;
            },
          ),
        ],
        child: const CustomNavBar(),
      ),
    ),
    GoRoute(
      path: kHomeView,
      builder: (context, state) => const HomeView(),
    ),
    // مؤقتا
    GoRoute(
      path: kScanView,
      builder: (context, state) => const ScanView(),
    ),
    GoRoute(
      path: kLibraryView,
      builder: (context, state) => const LibraryView(),
    ),
    GoRoute(
      path: kUpdatedDetailsView,
      builder: (context, state) => UpdatedDetailsView(
        plant: state.extra as Plant,
      ),
    ),
    GoRoute(
      path: kHistoryView,
      builder: (context, state) => const HistoryView(),
    ),
    GoRoute(
      path: kProfileView,
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: kDiseaseView,
      builder: (context, state) => BlocProvider(
        create: (context) => HistoryCubit(
            HistoryRepositoryImpl(apiService: ApiService(dio: Dio())),
            context.read<UserCubit>()),
        child: DiseaseView(
          details: (state.extra as Map)['details'],
          imageBytes: (state.extra as Map)['imageBytes'],
          imageUrl: (state.extra as Map)['imageUrl'],
          source: (state.extra as Map)['source'] ?? 'scan',
        ),
      ),
    ),
    GoRoute(
      path: kDeleteAccountView,
      builder: (context, state) => BlocProvider(
        create: (context) => ProfileCubit(
            ProfileRepositoryImpl(apiService: ApiService(dio: Dio()))),
        child: const DeleteAccountView(),
      ),
    ),
    GoRoute(
      path: kCropImageView,
      builder: (context, state) => BlocProvider(
        create: (context) => ProfileCubit(
            ProfileRepositoryImpl(apiService: ApiService(dio: Dio()))),
        child: CropImageView(
          imageFile: state.extra as File,
        ),
      ),
    ),
    GoRoute(
      path: kPaymentPackgesView,
      builder: (context, state) => BlocProvider(
        create: (context) => PackagesCubit(
            userCubit: context.read<UserCubit>(),
            packagesRepository:
                PackagesRepositoryImpl(apiService: ApiService(dio: Dio()))),
        child: const PackagesView(),
      ),
    ),
    GoRoute(
      path: kPaymentMethodsView,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PaymentCubit(
                userCubit: context.read<UserCubit>(),
                packagesCubit: PackagesCubit(
                    packagesRepository: PackagesRepositoryImpl(
                        apiService: ApiService(dio: Dio())),
                    userCubit: context.read<UserCubit>()),
                paymentRepository:
                    PaymentRepositoryImpl(apiService: ApiService(dio: Dio()))),
          ),
          BlocProvider(
            create: (context) => PackagesCubit(
                userCubit: context.read<UserCubit>(),
                packagesRepository:
                    PackagesRepositoryImpl(apiService: ApiService(dio: Dio()))),
          ),
          BlocProvider(
            create: (context) => MyFatoorahCubit(
                userCubit: context.read<UserCubit>(),
                packagesCubit: PackagesCubit(
                    packagesRepository: PackagesRepositoryImpl(
                        apiService: ApiService(dio: Dio())),
                    userCubit: context.read<UserCubit>()),
                paymentRepository:
                    PaymentRepositoryImpl(apiService: ApiService(dio: Dio()))),
          ),
        ],
        child: PaymentMethodsView(
          packageId: (state.extra as Map)['packageId'],
          packageName: (state.extra as Map)['packageName'],
          coins: (state.extra as Map)['coins'],
          price: (state.extra as Map)['price'],
          currency: (state.extra as Map)['currency'],
        ),
      ),
    ),
    GoRoute(
      path: kAiChatView,
      builder: (context, state) => AiChatView(
        plantName: state.extra as String,
      ),
    ),
  ]);
}
