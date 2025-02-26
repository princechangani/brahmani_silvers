import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
   TextEditingController phoneController = TextEditingController();
   TextEditingController pinController = TextEditingController();


  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      try{
        emit(LoginSuccess(isLoginSuccess: login(event.phone, event.pin)));
        await Future.delayed(Duration(milliseconds: 500));
        emit(LoginInitial());

      }catch(e){
        emit(LoginFailure(errorMessage: 'Login Failed'));
        await Future.delayed(Duration(milliseconds: 500));
        emit(LoginInitial());
      }
    });
  }

  bool login(String phone , String pin){
    if("9999999999" == phone && "9999" == pin){
     return true;
    }
    return false;
  }
}
