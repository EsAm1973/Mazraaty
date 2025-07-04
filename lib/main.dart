import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/data/database/user_database.dart';
import 'package:mazraaty/Core/data/repository/User%20Repository/user_repo_impl.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/utils/service_locator.dart';
import 'package:mazraaty/constants.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Service Locator (GetIt) registrations
  setup();

  // تحقق من أذونات الكاميرا عند بدء التشغيل
  final cameraStatus = await Permission.camera.status;
  if (!cameraStatus.isGranted) {
    await Permission.camera.request();
  }
  runApp(
    BlocProvider(
      create: (context) => UserCubit(
          userRepository: UserRepositoryImpl(userDatabase: UserDatabase())),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Mazraaty',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: kPrimaryColor,
        textTheme: GoogleFonts.inderTextTheme(ThemeData.light().textTheme),
      ),
    );
  }
}
