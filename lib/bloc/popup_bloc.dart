import 'dart:async';

enum PopupStatus { show, hide }

class PopupState {
  PopupStatus popupStatus;
  PopupState({required this.popupStatus});
}

class PopupBloc {
  StreamController<PopupState> popupController = StreamController.broadcast();

  Stream<PopupState> get popupStream => popupController.stream;

  disposed() => popupController.close();
}
