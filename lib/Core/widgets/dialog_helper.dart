import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mazraaty/constants.dart';

class DialogHelper {
  static AwesomeDialog? _loadingDialog;

  static void showLoading(BuildContext context) {
    _loadingDialog?.dismiss();
    _loadingDialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...'),
          ],
        ),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
    );
    _loadingDialog?.show();
  }

  static void hideLoading() {
    _loadingDialog?.dismiss();
    _loadingDialog = null;
  }

  static void showSuccess(
    BuildContext context, 
    String title, 
    String description,
    VoidCallback onOkPressed,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: title,
      desc: description,
      btnOkOnPress: onOkPressed,
      btnOkColor: kMainColor,
    ).show();
  }

  static void showError(
    BuildContext context, 
    String title, 
    String description,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: title,
      desc: description,
      btnOkColor: kMainColor,
      btnOkOnPress: () {},
    ).show();
  }
}