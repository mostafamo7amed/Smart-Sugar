import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_sugar/core/helper_functions/get_snack_bar.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/admin_home_view.dart';

import '../../../../../constants.dart';
import '../../../../home/presentation/view/user_home_root.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

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

  Future<void> findUser(String uid,BuildContext context) async {
    var userData = await FirebaseFirestore.instance.collection(usersCollection).doc(uid).get();
    if(userData.exists){
      if(context.mounted) {
        Navigator.pushNamed(context, UserHomeRoot.routeName);
        emit(LoginFindUserState());
      }
    }else{
      if(context.mounted) {
        Navigator.pushNamed(context, AdminHomeView.routeName);
        emit(LoginFindAdminState());
      }
    }
  }
}
