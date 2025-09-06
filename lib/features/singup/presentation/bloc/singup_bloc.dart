import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'singup_event.dart';
part 'singup_state.dart';

class SingupBloc extends Bloc<SingupEvent, SingupState> {
  SingupBloc() : super(SingupInitial()) {
    on<SingupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
