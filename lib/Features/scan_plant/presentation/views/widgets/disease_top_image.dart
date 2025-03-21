import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Features/history/presentation/manager/History/history_cubit.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';

class DiseaseTopImage extends StatelessWidget {
  const DiseaseTopImage({
    super.key,
    required this.image,
    required this.disease, // أضفنا الخاصية هنا
  });

  final Uint8List image;
  final DiseaseDetailsModel disease; // تعريف الخاصية المطلوبة

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        final historyCubit = context.read<HistoryCubit>();
        final userCubit = context.read<UserCubit>();
        final isLoggedIn = userCubit.currentUser != null;
        bool isSaved = false;

        if (isLoggedIn) {
          isSaved = context.select<HistoryCubit, bool>(
            (cubit) => (cubit.state is HistoryLoaded)
                ? (cubit.state as HistoryLoaded).diseases.any((d) =>
                    d.diseaseId == disease.id) // استخدمنا الخاصية الجديدة هنا
                : false,
          );
        }

        return Stack(
          children: [
            Image.memory(
              image,
              width: double.infinity,
              height: 350,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: BlocBuilder<HistoryCubit, HistoryState>(
                  builder: (context, state) {
                    return IconButton(
                      icon: Icon(
                        isSaved
                            ? Icons.download_done // أيقونة عندما يكون محفوظ
                            : FontAwesomeIcons.download,
                        color: isSaved ? Colors.green : Colors.black,
                      ),
                      onPressed: () {
                        if (isLoggedIn) {
                          context
                              .read<HistoryCubit>()
                              .toggleDisease(disease, image);
                        } else {
                          // عرض رسالة للمستخدم لتسجيل الدخول
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('يجب تسجيل الدخول لحفظ التاريخ'),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
