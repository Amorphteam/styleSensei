import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_selection_state.dart';

class ImageSelectionCubit extends Cubit<ImageSelectionState> {
  ImageSelectionCubit() : super(ImageSelectionInitial());
}
