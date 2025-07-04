import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mazraaty/Core/data/repository/User%20Repository/user_repo.dart';
import 'package:mazraaty/Core/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final IUserRepository userRepository;

  UserCubit({required this.userRepository}) : super(UserInitial());

  User? get currentUser {
    if (state is UserLoaded) {
      return (state as UserLoaded).user;
    }
    return null;
  }

  Future<void> loadUser() async {
    try {
      emit(UserLoading());
      final user = await userRepository.getUser();
      if (user != null && user.id != 0) {
        // التأكد من وجود user id صالح
        emit(UserLoaded(user));
      } else {
        emit(UserInitial());
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> saveUser(User user) async {
    try {
      await userRepository.saveUser(user);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(UserLoading());
      await userRepository.logoutUser();
      emit(UserInitial());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
