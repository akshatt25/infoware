import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSubmitPressed>((event, emit) async {
      final gender = event.gender;
      final country = event.country;
      final state = event.state;
      final city = event.city;

      if (gender == 'none') {
        emit(AuthFailure(error: "Please select your gender"));
        return;
      }
      if (city == 'none') {
        emit(AuthFailure(error: "Please specify your location"));
        return;
      }
      await Future.delayed(Duration(seconds: 1), () {
        emit(AuthSucces(

            // user data passed to DB or API
            ));
      });
    });
  }
}
