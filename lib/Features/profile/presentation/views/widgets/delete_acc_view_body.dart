import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
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
          if (state is ProfileDeleted) {
            context.read<UserCubit>().logout();
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
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
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const CircularProgressIndicator();
                      }
                      return DeleteAccountButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<ProfileCubit>().deleteAccount(
                                  token: context
                                      .read<UserCubit>()
                                      .currentUser!
                                      .token,
                                  password: passwordController.text,
                                );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
