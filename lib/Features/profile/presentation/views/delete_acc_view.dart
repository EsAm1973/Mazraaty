import 'package:flutter/material.dart';
import 'package:mazraaty/Features/profile/presentation/views/widgets/delete_acc_view_body.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      body: DeleteAccountViewBody(),
    ));
  }
}