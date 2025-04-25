import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/constants.dart';

class HomePremiumUpgradeCard extends StatefulWidget {
  const HomePremiumUpgradeCard({super.key, required this.onSubscribeTap});
  final VoidCallback onSubscribeTap;

  @override
  State<HomePremiumUpgradeCard> createState() => _HomePremiumUpgradeCardState();
}

class _HomePremiumUpgradeCardState extends State<HomePremiumUpgradeCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shineAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _shineAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF2E7D32).withAlpha(230), // Dark green
                const Color(0xFF4CAF50).withAlpha(230), // Medium green
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: kMainColor.withAlpha(60),
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Premium',
                    style: Styles.textStyle20.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber.withAlpha(200),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'SPECIAL OFFER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Unlock Premium Features',
                style: Styles.textStyle18.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Get unlimited scans, advanced insights, and priority support',
                style: Styles.textStyle15.copyWith(
                  color: Colors.white.withAlpha(220),
                ),
              ),
              const SizedBox(height: 16),
              // Feature list
              _buildFeatureItem('Unlimited plant scans'),
              _buildFeatureItem('Detailed plant care guides'),
              _buildFeatureItem('Priority customer support'),
              const SizedBox(height: 16),
              // Subscribe button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onSubscribeTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: kMainColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Subscribe Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Shine effect overlay
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _shineAnimation,
            builder: (context, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Transform.translate(
                  offset: Offset(_shineAnimation.value * MediaQuery.of(context).size.width, 0),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.white.withAlpha(0),
                          Colors.white.withAlpha(50),
                          Colors.white.withAlpha(0),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Styles.textStyle15.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
