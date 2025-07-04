import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/library_view_body.dart';
import 'package:mazraaty/constants.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0, // Hide the app bar but keep the status bar styling
      ),
      body: const LibraryViewBody(),
    );
  }
}
