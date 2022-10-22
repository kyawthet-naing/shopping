import 'dart:async';

enum PopupStatus { show, hide }

class PopupState {
  PopupStatus overlayStatus;
  PopupState({required this.overlayStatus});
}

class PopupBloc {
  StreamController<PopupState> popupController = StreamController.broadcast();

  Stream<PopupState> popupStream() => popupController.stream;

  disposed() => popupController.close();
}
