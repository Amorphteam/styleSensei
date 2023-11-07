import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'style_state.dart';

class ImageSelectionCubit extends Cubit<ImageSelectionState> {
  ImageSelectionCubit() : super(ImageSelectionInitial());
}
