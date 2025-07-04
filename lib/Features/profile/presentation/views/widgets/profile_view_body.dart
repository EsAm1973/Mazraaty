import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/profile/presentation/manager/Profile/profile_cubit.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_changepass_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_darkmode_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_delete_account_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_language_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_logout_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_payment_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_policy_listtile.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/profile_usercard.dart';
import 'package:mazraaty/constants.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  Future<void> _refreshProfile(BuildContext context) async {
    final userCubit = context.read<UserCubit>();
    final profileCubit = context.read<ProfileCubit>();

    if (userCubit.currentUser != null) {
      await profileCubit.refreshProfile(userCubit.currentUser!.token);
    }
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              title,
              style: Styles.textStyle18.copyWith(
                fontWeight: FontWeight.w600,
                color: kMainColor,
                fontFamily: kfontFamily,
              ),
            ),
          ),
          ...children,
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kMainColor.withOpacity(0.1),
                          kMainColor.withOpacity(0.05),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'Profile',
                      style: Styles.textStyle30.copyWith(
                        fontFamily: kfontFamily,
                        color: kMainColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 3,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kMainColor.withOpacity(0.3),
                          kMainColor,
                          kMainColor.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kScaffoldColor,
              Colors.white.withOpacity(0.8),
              kScaffoldColor,
            ],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () => _refreshProfile(context),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  _buildAnimatedHeader(),
                  const SizedBox(height: 20),

                  // User Profile Card with Animation
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1000),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.8 + (0.2 * value),
                        child: Opacity(
                          opacity: value,
                          child: BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              if (state is ProfileError) {
                                return Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      state.message,
                                      style: Styles.textStyle16
                                          .copyWith(color: Colors.red),
                                    ),
                                  ),
                                );
                              } else if (state is ProfileLoading) {
                                return Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kMainColor),
                                    ),
                                  ),
                                );
                              } else if (state is ProfileLoaded) {
                                return ProfileUserCard(profile: state.profile);
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  // Payment Section
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1200),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: _buildSectionCard(
                            title: 'Purchase Coins',
                            context: context,
                            children: const [
                              ProfilePaymentListTile(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Security Section
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1400),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: _buildSectionCard(
                            title: 'Security & Language',
                            context: context,
                            children: const [
                              ProfileChangePassword(),
                              ProfileLanguageListTile(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Preferences Section
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1600),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: _buildSectionCard(
                            title: 'Preferences',
                            context: context,
                            children: const [
                              ProfileDarkModeListTile(),
                              ProfilePolicesListTile(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Account Management Section
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1800),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: _buildSectionCard(
                            title: 'Account Management',
                            context: context,
                            children: const [
                              ProfileDeleteAccountListTile(),
                              ProfileLogoutListTile(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}
