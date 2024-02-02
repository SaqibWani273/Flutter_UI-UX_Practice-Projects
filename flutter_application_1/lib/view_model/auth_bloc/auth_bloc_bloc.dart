import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Repository/data_repo.dart';
import 'package:flutter_application_1/constants/custom_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_bloc_event.dart';

part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final DataRepo dataRepo;

  AuthBlocBloc({required this.dataRepo}) : super(UnAuthenticatedState()) {
    on<CheckAuthEvent>(_checkUserStatus);
    on<SignInEvent>(_signIn);
  }
  Future<void> _checkUserStatus(
      CheckAuthEvent event, Emitter<AuthBlocState> emit) async {
    emit(LoadingState());
    final user = FirebaseAuth.instance.currentUser;
    emit(user == null ? UnAuthenticatedState() : AuthenticatedState());
  }

  Future<void> _signIn(SignInEvent event, Emitter<AuthBlocState> emit) async {
    emit(LoadingState());
    try {
      if (event.otp == null) {
        //firebase automatically verifies otp on some devices for those we donot need to send otp
        final isVerficationCompleted =
            await dataRepo.verifyNumberAndSendOtp(number: event.number);
        isVerficationCompleted
            ? emit(AuthenticatedState())
            : emit(OtpSentState());
      } else {
        await dataRepo.verifyOtp(number: event.number, otp: event.otp!);
        emit(AuthenticatedState());
      }
    } on CustomException catch (err) {
      emit(AuthErrorState(errMsg: err.msg));
    } catch (e) {
      emit(AuthErrorState(errMsg: "Something went wrong !"));
    }
  }
}
