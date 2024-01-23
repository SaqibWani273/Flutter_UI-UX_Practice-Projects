import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_auth_model.dart';
import '../services/firestore.dart';

UserAuthModel userAuthModel = UserAuthModel();

class AuthDataProvider extends StateNotifier<UserAuthModel> {
  AuthDataProvider() : super(userAuthModel);
  Future<void> addUser(UserModel user) async {
    try {
      await FirestoreService().addUserToFirestore(user);
    } catch (e) {
      log("error in adding user to firestore $e");
    }
    state = state.copyWith(user: user);
  }

  Future<void> getUser() async {
    try {
      final user = await FirestoreService().getUser();
      log("user $user");
      state = state.copyWith(user: user);
    } catch (e) {
      log("error in getting user from firestore $e");
    }
  }

  set isLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  set otpSent(bool otpSent) {
    state = state.copyWith(otpSent: otpSent);
  }

  set verficationId(String verficationId) {
    state = state.copyWith(verficationId: verficationId);
  }

  // set otp(String otp) {
  //   state = state.copyWith(otp: otp);
  // }
  set number(String number) {
    state = state.copyWith(phoneNumber: number);
  }
}

final authDataProvider =
    StateNotifierProvider<AuthDataProvider, UserAuthModel>((ref) {
  return AuthDataProvider();
});
