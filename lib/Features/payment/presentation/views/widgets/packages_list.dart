import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/payment/presentation/manager/Package%20Cubit/cubit/packages_cubit.dart';
import 'package:mazraaty/Features/payment/presentation/views/widgets/subscription_packages.dart';

class PackagesList extends StatelessWidget {
  const PackagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackagesCubit, PackagesState>(
      builder: (context, state) {
        if (state is PackagesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PackagesLoaded) {
          return SubscriptionPackages(packages: state.packages);
        } else if (state is PackagesError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${state.errorMessage}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<PackagesCubit>().getPackages(),
                  child: Text(
                    'Retry',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('Select a package'));
      },
    );
  }
}