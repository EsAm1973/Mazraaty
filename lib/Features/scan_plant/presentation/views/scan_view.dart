import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/scan_view_body.dart';
import 'package:mazraaty/constants.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //  backgroundColor: kScaffoldColor,
      appBar: AppBar(
        //  backgroundColor: kScaffoldColor,
        centerTitle: true,
        title: Text(
          'Scan Plant',
          style: Styles.textStyle26
              .copyWith(fontFamily: kfontFamily, color: kMainColor),
        ),
        leading: BlocBuilder<UserCubit, UserState>(
          buildWhen: (prevState, currState) {
            // قارن النقاط فقط
            if (prevState is UserLoaded && currState is UserLoaded) {
              return prevState.user.points != currState.user.points;
            }
            return currState is UserLoaded;
          },
          builder: (context, state) {
            if (state is UserLoaded) {
              return Text('${state.user.points}');
            }
            return const Text('');
          },
        ),
      ),
      body: const ScanViewBody(),
    ));
  }
}
