import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/helper_functions/get_snack_bar.dart';
import 'package:smart_sugar/core/services/app_references.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/admin_home_view.dart';

import '../../../../../constants.dart';
import '../../../../home/presentation/view/user_home_root.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess(credential.user!));
    } on FirebaseAuthException catch (e) {
      log('Exception: in FirebaseAuthServices.signInWithEmailAndPassword ${e.toString()}');
      if (e.code == 'user-not-found') {
        getSnackBar('User not found');
      } else if (e.code == 'wrong-password') {
        getSnackBar('Wrong email or password');
      } else if (e.code == 'invalid-email') {
        getSnackBar('Invalid email');
      } else if (e.code == 'invalid-credential') {
        getSnackBar('Wrong email or password');
      } else if (e.code == 'network-request-failed') {
        getSnackBar('Please check your internet connection');
      } else {
        getSnackBar('There is an error, please try again');
      }
      emit(LoginError());
    } catch (e) {
      log('Exception: in FirebaseAuthServices.signInWithEmailAndPassword ${e.toString()}');
      getSnackBar('There is an error, please try again');
      emit(LoginError());
    }
  }

  Future<void> findUser(String uid, BuildContext context) async {
    var userData = await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(uid)
        .get();
    if (userData.exists) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, UserHomeRoot.routeName);
        emit(LoginFindUserState());
      }
    } else {
      var adminData = await FirebaseFirestore.instance
          .collection(adminCollection)
          .doc(uid)
          .get();
      if (adminData.exists) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, AdminHomeView.routeName);
          emit(LoginFindAdminState());
        }
      } else {
        if (context.mounted) {
          getSnackBar('User not found');
          emit(LoginError());
        }
      }
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    AppReference.removeData(key: userIdKey);
    AppReference.removeData(key: authKey);
    emit(LoginLogoutState());
  }

  void resetPassword(String email) async {
    emit(LoginResetPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(LoginResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      log('Exception: in FirebaseAuthServices.sendPasswordResetEmail ${e.toString()}');
      if (e.code == 'user-not-found') {
        getSnackBar('User not found');
      } else if (e.code == 'wrong-password') {
        getSnackBar('Wrong email or password');
      } else if (e.code == 'invalid-email') {
        getSnackBar('Invalid email');
      } else if (e.code == 'network-request-failed') {
        getSnackBar('Please check your internet connection');
      }
    } catch (e) {
      log('Exception: in FirebaseAuthServices.sendPasswordResetEmail ${e.toString()}');
      getSnackBar('There is an error, please try again');
      emit(LoginResetPasswordError());
    }
  }
}
