import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Core/widgets/custom_listtile.dart';
import 'package:mazraaty/Core/widgets/custom_switch_listtile.dart';
import 'package:mazraaty/Core/widgets/profile_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_changepass_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_darkmode_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_language_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_payment_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_policy_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_usercard.dart';
import 'package:mazraaty/constants.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Profile',
              style: Styles.textStyle30.copyWith(
                fontFamily: kfontFamily,
                color: kMainColor,
              ),
            ),
          ),
          const SizedBox(
            height: 37,
          ),
          const ProfileUserCard(),
          const SizedBox(
            height: 35,
          ),
          const ProfileListTile(),
          const ProfilePaymentListTile(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          const ProfileChangePassword(),
          const ProfileLanguageListTile(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          const ProfileDarkModeListTile(),
          const ProfilePolicesListTile(),
        ],
      ),
    );
  }
}