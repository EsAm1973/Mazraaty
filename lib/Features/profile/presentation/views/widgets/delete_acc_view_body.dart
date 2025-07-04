import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/profile/presentation/manager/Profile/profile_cubit.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/delete_acc_backbutton.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/delete_acc_button.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/delete_acc_pass_textfeild.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/delete_acc_title.dart';

class DeleteAccountViewBody extends StatelessWidget {
  DeleteAccountViewBody({super.key});
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoading) {
          DialogHelper.showLoading(context);
        } else {
          DialogHelper.hideLoading();
        }

        if (state is ProfileDeleted) {
          DialogHelper.showSuccess(
            context,
            "Success Delete",
            "Your account has been deleted successfully",
            () {
              context.read<UserCubit>().logout();
              GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
            },
          );
        } else if (state is ProfileError) {
          DialogHelper.showError(context, "Error", state.message);
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DeleteAccountBackButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                ),
                const SizedBox(height: 110),
                const DeleteAccountTitle(),
                const SizedBox(height: 30),
                Form(
                  key: formKey,
                  child: DeleteAccPasswordTextFeild(
                    passwordController: passwordController,
                  ),
                ),
                const SizedBox(height: 30),
                DeleteAccountButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.bottomSlide,
                        title: "Confirm Deletion",
                        desc: "Are you sure you want to delete your account?",
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          context.read<ProfileCubit>().deleteAccount(
                                token: context
                                    .read<UserCubit>()
                                    .currentUser!
                                    .token,
                                password: passwordController.text,
                              );
                        },
                      ).show();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
