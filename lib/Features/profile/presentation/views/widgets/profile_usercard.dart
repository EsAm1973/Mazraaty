import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/profile/data/models/profile.dart';
import 'package:mazraaty/constants.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key, required this.profile});
  final Profile profile;
  @override
  Widget build(BuildContext context) {
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
                profile.image,
                width: 90,
                height: 90,
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
