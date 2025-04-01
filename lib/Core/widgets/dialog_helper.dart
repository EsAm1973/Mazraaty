import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/utils/app_router.dart';
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

  static void showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Image.asset(
                      'assets/images/pro_animated.gif',
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Subscription Required',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'To use this feature, you need to subscribe to a premium plan.',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kPaymentPackgesView);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Go Premium',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                  child: Text(
                    'Maybe Later',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
