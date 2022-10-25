import 'package:shopping/utils/color_utils.dart';
import 'package:flutter/material.dart';
import '../bloc/popup_bloc.dart';

class PopupListener extends StatefulWidget {
  final Widget child;
  const PopupListener({super.key, required this.child});

  @override
  State<PopupListener> createState() => PopupListenerState();
}

class PopupListenerState extends State<PopupListener>
    with SingleTickerProviderStateMixin {
  static PopupBloc popupBloc = PopupBloc();
  static Widget? childWidget;

  // controller
  static late AnimationController _controller;

  // animation
  late Animation<double> _animation;

  PopupListenerState();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: this,
          value: 0.6,
        );
        _animation = CurvedAnimation(
          parent: _controller,
          curve: Curves.linear,
        );
      },
    );

    super.initState();
  }

  static void show({required Widget child}) {
    childWidget = child;
    popupBloc.popupController.sink.add(
      PopupState(popupStatus: PopupStatus.show),
    );
    _controller.forward();
  }

  static void hide() {
    popupBloc.popupController.sink.add(
      PopupState(popupStatus: PopupStatus.hide),
    );
    _controller.reset();
  }

  @override
  void dispose() {
    ///warning*
    ///alertBloc.disposed();
    ///_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        StreamBuilder<PopupState>(
          stream: popupBloc.popupStream(),
          initialData: PopupState(popupStatus: PopupStatus.hide),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              PopupState state = snapshot.data!;
              return state.popupStatus == PopupStatus.show
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: ColorUtils.blackPoint2,
                      alignment: Alignment.center,
                      child: ScaleTransition(
                        scale: _animation,
                        alignment: Alignment.center,
                        child: childWidget,
                      ),
                    )
                  : const SizedBox();
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
