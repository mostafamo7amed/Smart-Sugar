part of 'login_cubit.dart';


abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}

final class LoginError extends LoginState {}

final class LoginFindAdminState extends LoginState {}
final class LoginFindUserState extends LoginState {}
