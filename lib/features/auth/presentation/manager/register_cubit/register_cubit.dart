import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/helper_functions/get_snack_bar.dart';
import 'package:smart_sugar/core/services/app_references.dart';
import 'package:smart_sugar/features/auth/domain/entity/user_entity.dart';

import '../../../../../constants.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit getCubit(context) => BlocProvider.of(context);
  late User user;
  void registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(RegisterLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppReference.sharedPreferences.setString(userNameKey, name);
      user = credential.user!;
      emit(RegisterSuccess(user));
    } on FirebaseAuthException catch (e) {
      log('Exception: in FirebaseAuthServices.createUserWithEmailAndPassword ${e.toString()}');
      if (e.code == 'weak-password') {
        getSnackBar('Your password is too weak');
      } else if (e.code == 'email-already-in-use') {
        getSnackBar('This email is already exists');
      } else if (e.code == 'invalid-email') {
        getSnackBar('This email is invalid');
      } else if (e.code == 'network-request-failed') {
        getSnackBar('Please check your internet connection');
      } else {
        getSnackBar('There is an error, please try again');
      }
      emit(RegisterError());
    } catch (e) {
      log('Exception: in FirebaseAuthServices.createUserWithEmailAndPassword ${e.toString()}');
      getSnackBar('There is an error, please try again');
      emit(RegisterError());
    }
  }

  void createUser({
    required String gender,
    required String age,
    required String wight,
    required String diabetesType,
    required String therapyType,
    required String insulinValue,
    required String glucoseLowValue,
    required String glucoseHighValue,
  }) async {
    emit(RegisterCreateUserLoading());
    String userName = AppReference.sharedPreferences.getString(userNameKey)!;
    UserEntity userEntity = UserEntity(
      uid: user.uid,
      name: userName,
      gender: gender,
      email: user.email,
      weight: wight,
      image: '',
      age: age,
      diabetesType: diabetesType,
      therapyType: therapyType,
      insulinValue: insulinValue,
      glucoseLowValue: glucoseLowValue,
      glucoseHighValue: glucoseHighValue,
      fcmToken: '',
    );
    await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(user.uid)
        .set(userEntity.toMap())
        .then((value) => emit(RegisterCreateUserSuccess()))
        .onError((error, stackTrace) => emit(RegisterCreateUserError()));
  }
}
