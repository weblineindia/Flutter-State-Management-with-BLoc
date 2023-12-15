part of '../user_bloc.dart';

///User states
@immutable
abstract class UserState {}

///Initial state of user
class UserInitial extends UserState {}

///Login state of user
class UserLoading extends UserState {}

///Error state of user
class UserError extends UserState {
  final String errorMessage;

  UserError({required this.errorMessage});
}

///Success state of user
class UserSuccess extends UserState {}
