import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class HomeWelcomeCard extends StatelessWidget {
  const HomeWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back,',
                  style:
                      Styles.textStyle20.copyWith(fontWeight: FontWeight.w600),
                ),
                const Text(
                  'John Doe',
                  style: Styles.textStyle20,
                ),
              ],
            ),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              size: 30,
            ))
      ],
    );
  }
}
