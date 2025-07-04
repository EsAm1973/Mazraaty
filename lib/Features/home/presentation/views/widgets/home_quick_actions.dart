import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/constants.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plant Care Calendar',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(15),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildUpcomingTask(
                icon: Icons.water_drop,
                color: Colors.blue,
                title: 'Water Rose Plant',
                time: 'Today',
                isOverdue: true,
              ),
              const Divider(),
              _buildUpcomingTask(
                icon: Icons.eco,
                color: Colors.green,
                title: 'Fertilize Mint',
                time: 'Tomorrow',
                isOverdue: false,
              ),
              const Divider(),
              _buildUpcomingTask(
                icon: Icons.wb_sunny_outlined,
                color: Colors.orange,
                title: 'Move Basil to Sunlight',
                time: 'In 2 days',
                isOverdue: false,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All Tasks',
                      style: TextStyle(
                        color: kMainColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingTask({
    required IconData icon,
    required Color color,
    required String title,
    required String time,
    required bool isOverdue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: isOverdue ? Colors.red : Colors.grey[600],
                    fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check_circle_outline,
              color: isOverdue ? Colors.red : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
