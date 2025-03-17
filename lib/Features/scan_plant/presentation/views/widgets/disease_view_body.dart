import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Core/widgets/sticky_headers_delegate.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_scientific_names.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_top_image.dart';

class DiseaseViewBody extends StatelessWidget {
  const DiseaseViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: StickyHeaderDelegate(
            child: const DiseaseTopImage(),
            maxExtent: 300,
            minExtent: 300,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Mint Rust',
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DiseaseScientificNames(
                      diseaseName: 'Mint Rust',
                      scientificName: 'Puccinia menthae',
                      alsoKnownAs: '“Puccinia Rust” , “Rust Disease”',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const DiseaseDescription(
                      description:
                          'Mint Rust is a fungal disease that primarily affects plants in the Mint family (Lamiaceae), such as peppermint (Mentha piperita) and spearmint (Mentha spicata). The disease manifests as small, orange, yellow, or reddish pustules on the undersides of the leaves, which can eventually lead to leaf drop, reduced vigor, and plant death if left untreated.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DiseaseDescription extends StatefulWidget {
  const DiseaseDescription({super.key, required this.description});
  final String description;
  @override
  State<DiseaseDescription> createState() => _DiseaseDescriptionState();
}

class _DiseaseDescriptionState extends State<DiseaseDescription> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Styles.textStyle23
              .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          firstChild: Text(
            widget.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle15,
          ),
          secondChild: Text(
            widget.description,
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isExpanded ? "Read less" : "Read more",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
