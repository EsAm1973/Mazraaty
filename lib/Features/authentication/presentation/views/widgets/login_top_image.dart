import 'package:flutter/material.dart';

class LoginTopImage extends StatelessWidget {
  const LoginTopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: Align(
        alignment: Alignment.topRight,
        child: Image(
          image: AssetImage('assets/images/login_photo.png'),
        ),
      ),
    );
  }
}