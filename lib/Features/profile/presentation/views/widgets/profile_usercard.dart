import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/profile/data/models/profile.dart';
import 'package:mazraaty/Features/profile/presentation/manager/Profile/profile_cubit.dart';
import 'package:mazraaty/constants.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key, required this.profile});
  final Profile profile;

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                GoRouter.of(context).pop();
                // اختيار صورة من المعرض
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  File imageFile = File(pickedFile.path);
                  // الانتقال إلى شاشة تعديل الصورة (CropImageScreen)
                  final File? croppedImage = await GoRouter.of(context)
                      .push<File>(AppRouter.kCropImageView, extra: imageFile);
                  if (croppedImage != null) {
                    // استدعاء الـ Cubit لتحديث صورة البروفايل باستخدام الصورة المعدلة
                    context.read<ProfileCubit>().updateProfileImage(
                          image: croppedImage,
                          token: context.read<UserCubit>().currentUser!.token,
                        );
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Picture'),
              onTap: () async {
                GoRouter.of(context).pop();
                // التقاط صورة بالكاميرا
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  File imageFile = File(pickedFile.path);
                  // الانتقال إلى شاشة تعديل الصورة (CropImageScreen)
                  final File? croppedImage = await GoRouter.of(context)
                      .push<File>(AppRouter.kCropImageView, extra: imageFile);
                  if (croppedImage != null) {
                    // استدعاء الـ Cubit لتحديث صورة البروفايل باستخدام الصورة المعدلة
                    context.read<ProfileCubit>().updateProfileImage(
                          image: croppedImage,
                          token: context.read<UserCubit>().currentUser!.token,
                        );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String baseImageUrl = 'https://c93d-154-238-234-226.ngrok-free.app/';
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            kMainColor.withOpacity(0.40),
            Colors.white24,
            Colors.white,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Picture
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(
                // 'assets/images/avatar.png',
                '$baseImageUrl${profile.image}',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // User Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(profile.userName, style: Styles.textStyle18),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  profile.email,
                  style: Styles.textStyle13.copyWith(color: kMainColor),
                ),
              ],
            ),
          ),

          // More Options
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              size: 35,
            ),
            onPressed: () => _showImageOptions(context),
          ),
        ],
      ),
    );
  }
}
