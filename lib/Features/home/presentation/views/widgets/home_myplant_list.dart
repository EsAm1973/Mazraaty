import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';
import 'package:mazraaty/Features/home/data/models/plant_garden.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_myplant_item.dart';
import 'package:mazraaty/Features/home/presentation/views/widgets/home_plant_empty_state.dart';
import 'package:mazraaty/constants.dart';

class HomeMyPlantList extends StatefulWidget {
  const HomeMyPlantList({
    super.key,
    required this.plant,
    this.onAddNewPlantTap
  });

  final PlantGarden plant;
  final VoidCallback? onAddNewPlantTap;

  @override
  State<HomeMyPlantList> createState() => _HomeMyPlantListState();
}

class _HomeMyPlantListState extends State<HomeMyPlantList> with TickerProviderStateMixin {
  final List<PlantGarden> _allPlants = [];
  List<PlantGarden> _filteredPlants = [];

  late AnimationController _filterAnimationController;
  late Animation<double> _filterAnimation;

  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Indoor', 'Outdoor', 'Herbs', 'Needs Care'];

  // For the shimmer loading effect
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _filterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _filterAnimation = CurvedAnimation(
      parent: _filterAnimationController,
      curve: Curves.easeInOut,
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Create sample plants with more detailed data
    _allPlants.add(widget.plant.copyWith(
      plantType: 'Flower',
      age: '3 months',
      nextWateringDate: DateTime.now().add(const Duration(days: 1)),
      careDifficulty: 'Medium',
      growthStage: 'Mature',
      waterLevel: 0.7,
      sunlightLevel: 0.8,
      location: 'Indoor',
      tags: ['Flowering', 'Fragrant'],
    ));

    _allPlants.add(PlantGarden(
      name: 'Basil',
      imageUrl: 'assets/images/similar2.png',
      status: 'Healthy',
      lastWatered: '2 hours',
      plantType: 'Herb',
      age: '1 month',
      nextWateringDate: DateTime.now().add(const Duration(hours: 12)),
      careDifficulty: 'Easy',
      growthStage: 'Young',
      waterLevel: 0.9,
      sunlightLevel: 0.7,
      location: 'Indoor',
      tags: ['Herb', 'Edible', 'Kitchen'],
    ));

    _allPlants.add(PlantGarden(
      name: 'Mint',
      imageUrl: 'assets/images/similar3.png',
      status: 'Need Water',
      lastWatered: '2 days',
      plantType: 'Herb',
      age: '2 months',
      nextWateringDate: DateTime.now().subtract(const Duration(hours: 6)),
      careDifficulty: 'Easy',
      growthStage: 'Mature',
      waterLevel: 0.2,
      sunlightLevel: 0.6,
      location: 'Outdoor',
      tags: ['Herb', 'Edible', 'Aromatic'],
    ));

    _allPlants.add(PlantGarden(
      name: 'Aloe Vera',
      imageUrl: 'assets/images/similar1.png',
      status: 'Healthy',
      lastWatered: '5 days',
      plantType: 'Succulent',
      age: '6 months',
      nextWateringDate: DateTime.now().add(const Duration(days: 7)),
      careDifficulty: 'Easy',
      growthStage: 'Mature',
      waterLevel: 0.8,
      sunlightLevel: 0.9,
      location: 'Indoor',
      tags: ['Medicinal', 'Low-maintenance'],
    ));

    // Initialize filtered plants
    _filteredPlants = List.from(_allPlants);
  }

  @override
  void dispose() {
    _filterAnimationController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  void _filterPlants(String category) {
    // Start the animation
    _filterAnimationController.forward(from: 0.0);

    setState(() {
      _selectedCategory = category;

      if (category == 'All') {
        _filteredPlants = List.from(_allPlants);
      } else if (category == 'Needs Care') {
        _filteredPlants = _allPlants
            .where((plant) =>
                plant.status.toLowerCase() == 'need water' ||
                plant.status.toLowerCase() == 'need attention')
            .toList();
      } else {
        _filteredPlants = _allPlants
            .where((plant) => plant.location == category ||
                  (plant.tags?.contains(category) ?? false) ||
                  plant.plantType == category)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with title and see all button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Plants',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                // Navigate to all plants view
              },
              icon: const Icon(
                Icons.spa,
                size: 18,
                color: kMainColor,
              ),
              label: Text(
                'See All',
                style: Styles.textStyle15.copyWith(
                  color: kMainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Category selector
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category;

              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _filterPlants(category),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? kMainColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? kMainColor.withAlpha(100)
                                  : Colors.black.withAlpha(10),
                              blurRadius: isSelected ? 8 : 4,
                              spreadRadius: isSelected ? 1 : 0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getCategoryIcon(category),
                              size: 16,
                              color: isSelected ? Colors.white : Colors.grey[700],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              category,
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? Colors.white : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // Plant grid with animation
        AnimatedBuilder(
          animation: _filterAnimation,
          builder: (context, child) {
            return _filteredPlants.isEmpty
                ? const HomePlantEmptyState()
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      // Remove fixed aspect ratio to allow items to size naturally
                      mainAxisExtent: 350, // Use a fixed height instead
                    ),
                    itemCount: _filteredPlants.length,
                    itemBuilder: (context, index) {
                      // Calculate staggered animation delay
                      final staggeredDelay = index * 100;

                      return AnimatedOpacity(
                        opacity: _filterAnimation.value,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: AnimatedSlide(
                          offset: Offset(0, 0.1 * (1.0 - _filterAnimation.value)),
                          duration: Duration(milliseconds: 300 + staggeredDelay),
                          curve: Curves.easeOutQuad,
                          child: HomeMyPlantItem(plant: _filteredPlants[index]),
                        ),
                      );
                    },
                  );
          },
        ),

        const SizedBox(height: 24),

        // Add new plant button with gradient and animation
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.95, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      kMainColor.withAlpha(40),
                      kMainColor.withAlpha(15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: kMainColor.withAlpha(20),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomElevatedButton(
                  text: 'Add New Plant',
                  onPressed: widget.onAddNewPlantTap,
                  icon: Icons.add,
                  backgroundColor: Colors.white,
                  textColor: kMainColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'All':
        return Icons.grid_view_rounded;
      case 'Indoor':
        return Icons.home;
      case 'Outdoor':
        return Icons.landscape;
      case 'Herbs':
        return Icons.eco;
      case 'Needs Care':
        return Icons.healing;
      default:
        return Icons.spa;
    }
  }
}
