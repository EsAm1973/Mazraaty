import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class OrSignWithWidget extends StatelessWidget {
  const OrSignWithWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              thickness: 2,
              height: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Or sign in with',
              style: Styles.textStyle16.copyWith(
                color: const Color(0xff939393),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              thickness: 2,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
