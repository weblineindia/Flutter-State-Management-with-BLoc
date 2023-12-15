part of '../user_bloc.dart';

///User Events
@immutable
abstract class UserEvent {}

///Event for login user
class UserLoginEvent extends UserEvent {
  final String email;
  final String password;

  UserLoginEvent({
    required this.email,
    required this.password,
  });
}

///Event for register user
class UserRegistrationEvent extends UserEvent {
  final String name;
  final String email;
  final String password;

  UserRegistrationEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

///Event for reset bloc state
class ResetEvent extends UserEvent {}
