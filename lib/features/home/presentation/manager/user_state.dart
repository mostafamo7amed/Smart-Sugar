part of 'user_cubit.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

final class GetUserLoadingState extends UserState {}

final class GetUserSuccessState extends UserState {}

final class GetUserErrorState extends UserState {}

final class AddGlucoseReadLoadingState extends UserState {}

final class AddGlucoseReadSuccessState extends UserState {}

final class AddGlucoseReadErrorState extends UserState {}

final class GetSugarReadLoadingState extends UserState {}

final class GetSugarReadSuccessState extends UserState {
  List<SugarReadEntity> sugarReadList;
  GetSugarReadSuccessState(this.sugarReadList);
}

final class GetSugarReadErrorState extends UserState {}

final class GetArticlesLoadingState extends UserState {}

final class GetArticlesSuccessState extends UserState {}

final class GetArticlesErrorState extends UserState {}

final class EvaluateBloodSugarLoadingState extends UserState {}

final class EvaluateBloodSugarSuccessState extends UserState {
  String result;
  EvaluateBloodSugarSuccessState(this.result);
}

final class EvaluateBloodSugarErrorState extends UserState {
  String result;
  EvaluateBloodSugarErrorState(this.result);
}

final class AnalyzeSugarReadLoadingState extends UserState {}

final class AnalyzeSugarReadSuccessState extends UserState {}
final class AnalyzeSugarReadErrorState extends UserState {}

final class GetSugarCenterLoadingState extends UserState {}

final class GetSugarCenterSuccessState extends UserState {}

final class GetSugarCenterErrorState extends UserState {}

final class GetEmergencyNumberLoadingState extends UserState {}

final class GetEmergencyNumberSuccessState extends UserState {}

final class GetEmergencyNumberErrorState extends UserState {}

final class AddSugarCenterToMyListLoadingState extends UserState {}

final class AddSugarCenterToMyListSuccessState extends UserState {}

final class AddSugarCenterToMyListErrorState extends UserState {}

final class GetMySugarCenterLoadingState extends UserState {}

final class GetMySugarCenterSuccessState extends UserState {}

final class GetMySugarCenterErrorState extends UserState {}

final class PikImageSuccessState extends UserState {}

final class PikImageErrorState extends UserState {}

final class EditUserProfileLoadingState extends UserState {}

final class EditUserProfileSuccessState extends UserState {}

final class EditUserProfileErrorState extends UserState {}

final class GetChartDataLoadingState extends UserState {}

final class GetChartDataSuccessState extends UserState {}

final class GetApiLinkLoadingState extends UserState {}

final class GetApiLinkSuccessState extends UserState {}

final class GetApiLinkErrorState extends UserState {}

final class ChatWithAILoadingState extends UserState {}

final class ChatWithAISuccessState extends UserState {}

final class ChatWithAIErrorState extends UserState {}

final class AddMedicationReminderLoadingState extends UserState {}

final class AddMedicationReminderSuccessState extends UserState {}

final class AddMedicationReminderErrorState extends UserState {}

final class GetMedicationRemindersLoadingState extends UserState {}

final class GetMedicationRemindersSuccessState extends UserState {}

final class GetMedicationRemindersErrorState extends UserState {}

final class AddNotificationLoadingState extends UserState {}

final class AddNotificationSuccessState extends UserState {}

final class AddNotificationErrorState extends UserState {}

final class GetNotificationsLoadingState extends UserState {}

final class GetNotificationsSuccessState extends UserState {}

final class GetNotificationsErrorState extends UserState {}

final class UpdateMedicationStatusLoadingState extends UserState {}

final class UpdateMedicationStatusSuccessState extends UserState {}

final class UpdateMedicationStatusErrorState extends UserState {}

final class  RemoveMedicationReminderLoadingState extends UserState {}

final class  RemoveMedicationReminderSuccessState extends UserState {}

final class  RemoveMedicationReminderErrorState extends UserState {}

final class UpdateNotificationStatusLoadingState extends UserState {}

final class UpdateNotificationStatusSuccessState extends UserState {}

final class UpdateNotificationStatusErrorState extends UserState {}
