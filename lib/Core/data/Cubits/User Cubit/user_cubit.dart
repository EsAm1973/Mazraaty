import 'package:bloc/bloc.dart';
import 'package:mazraaty/Core/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
}
