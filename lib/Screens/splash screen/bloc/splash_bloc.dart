import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<InitializeAppEvent>((event, emit) async {
      requestStoragePermission();
      emit(SplashLoading());
      await Future.delayed(
          Duration(seconds: 3));
      emit(SplashCompleted());

    });
  }
  Future<bool> requestStoragePermission() async {
    var status = await Permission.manageExternalStorage.status;

    if (!status.isGranted) {
      status = await Permission.manageExternalStorage.request();
    }

    return status.isGranted;
  }

}
