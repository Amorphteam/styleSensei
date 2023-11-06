import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'waiting_state.dart';

class WaitingCubit extends Cubit<WaitingState> {
  WaitingCubit() : super(WaitingInitial());
}
