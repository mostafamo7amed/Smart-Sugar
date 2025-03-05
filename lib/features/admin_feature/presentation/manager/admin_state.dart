part of 'admin_cubit.dart';

abstract class AdminState {}

final class AdminInitial extends AdminState {}

final class GetAdminLoading extends AdminState {}

final class GetAdminSuccess extends AdminState {}

final class GetAdminError extends AdminState {}

final class PikImageSuccessState extends AdminState {}

final class PikImageErrorState extends AdminState {}

final class AddSugarCenterLoadingState extends AdminState {}

final class AddSugarCenterSuccessState extends AdminState {}

final class AddSugarCenterErrorState extends AdminState {}

final class GetSugarCenterLoadingState extends AdminState {}

final class GetSugarCenterSuccessState extends AdminState {}

final class GetSugarCenterErrorState extends AdminState {}

final class DeleteSugarCenterLoadingState extends AdminState {}

final class DeleteSugarCenterSuccessState extends AdminState {}

final class DeleteSugarCenterErrorState extends AdminState {}

final class AddArticleLoadingState extends AdminState {}

final class AddArticleSuccessState extends AdminState {}

final class AddArticleErrorState extends AdminState {}

final class GetArticlesLoadingState extends AdminState {}

final class GetArticlesSuccessState extends AdminState {}

final class GetArticlesErrorState extends AdminState {}

final class DeleteArticleLoadingState extends AdminState {}

final class DeleteArticleSuccessState extends AdminState {}

final class DeleteArticleErrorState extends AdminState {}

final class AddEmergencyNumberLoadingState extends AdminState {}

final class AddEmergencyNumberSuccessState extends AdminState {}

final class AddEmergencyNumberErrorState extends AdminState {}

final class GetEmergencyNumberLoadingState extends AdminState {}

final class GetEmergencyNumberSuccessState extends AdminState {}

final class GetEmergencyNumberErrorState extends AdminState {}

final class DeleteEmergencyNumberLoadingState extends AdminState {}

final class DeleteEmergencyNumberSuccessState extends AdminState {}

final class DeleteEmergencyNumberErrorState extends AdminState {}

final class RefreshApiLinkLoadingState extends AdminState {}

final class RefreshApiLinkSuccessState extends AdminState {}

final class RefreshApiLinkErrorState extends AdminState {}

final class GetApiLinkLoadingState extends AdminState {}

final class GetApiLinkSuccessState extends AdminState {}

final class GetApiLinkErrorState extends AdminState {}

