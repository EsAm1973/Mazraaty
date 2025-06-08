import 'package:flutter/material.dart';

class LoginSocialMedia extends StatelessWidget {
  final VoidCallback? onGooglePressed;
  final VoidCallback? onFacebookPressed;
  final VoidCallback? onApplePressed;

  const LoginSocialMedia({
    super.key,
    this.onGooglePressed,
    this.onFacebookPressed,
    this.onApplePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onGooglePressed,
          icon: Image.asset(
            'assets/images/google.png',
            width: 35,
            height: 35,
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        IconButton(
          onPressed: onFacebookPressed,
          icon: Image.asset(
            'assets/images/facebook.png',
            width: 35,
            height: 35,
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        IconButton(
          onPressed: onApplePressed,
          icon: Image.asset(
            'assets/images/apple.png',
            width: 35,
            height: 35,
          ),
        )
      ],
    );
  }
}
