import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mazraaty/Core/utils/api_service.dart';
import 'package:mazraaty/Features/authentication/data/repos/authentication_repo_impl.dart';
import 'package:mazraaty/Features/history/data/repos/history_repo_impl.dart';
import 'package:mazraaty/Features/payment/data/repos/Package%20Repo/package_repo_impl.dart';
import 'package:mazraaty/Features/payment/data/repos/Payment%20Repo/payment_repo_impl.dart';
import 'package:mazraaty/Features/profile/data/repos/profile_repo_impl.dart';
import 'package:mazraaty/Features/scan_plant/data/data_source/api_scan_service.dart';

final getit = GetIt.instance;

void setup() {
  // Register core dependencies first
  getit.registerSingleton<Dio>(Dio());
  getit.registerSingleton<ApiService>(ApiService(dio: getit<Dio>()));

  // Register ApiScanService (already existed)
  getit.registerSingleton<ApiScanService>(ApiScanService(dio: getit<Dio>()));

  // Register duplicated repository implementations
  getit.registerSingleton<AuthenticationRepoImpl>(
    AuthenticationRepoImpl(apiService: getit<ApiService>())
  );

  getit.registerSingleton<HistoryRepositoryImpl>(
    HistoryRepositoryImpl(apiService: getit<ApiService>())
  );

  getit.registerSingleton<ProfileRepositoryImpl>(
    ProfileRepositoryImpl(apiService: getit<ApiService>())
  );

  getit.registerSingleton<PackagesRepositoryImpl>(
    PackagesRepositoryImpl(apiService: getit<ApiService>())
  );

  getit.registerSingleton<PaymentRepositoryImpl>(
    PaymentRepositoryImpl(apiService: getit<ApiService>())
  );
}