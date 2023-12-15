import 'package:fl_bloc_consumer/core/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state/user_state.dart';

part 'event/user_event.dart';

///BLoC class who handles actual business logic
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      ///User registration event
      if (event is UserRegistrationEvent) {
        emit(UserLoading());
        final response =
            await UserRepository().userRegistration(name: event.name, email: event.email, password: event.password);

        response.fold(
          (l) => emit(UserError(errorMessage: l.message)),
          (r) => emit(UserSuccess()),
        );
      }

      ///User login event
      if (event is UserLoginEvent) {
        emit(UserLoading());
        final response = await UserRepository().userLogin(email: event.email, password: event.password);

        response.fold(
          (l) => emit(UserError(errorMessage: l.message)),
          (r) => emit(UserSuccess()),
        );
      }

      ///Resent bloc state event
      if (event is ResetEvent){
        emit(UserInitial());
      }
    });
  }
}
