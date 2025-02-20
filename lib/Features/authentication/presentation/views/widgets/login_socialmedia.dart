import 'package:flutter/material.dart';

class LoginSocialMedia extends StatelessWidget {
  const LoginSocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
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
          onPressed: () {},
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
          onPressed: () {},
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
