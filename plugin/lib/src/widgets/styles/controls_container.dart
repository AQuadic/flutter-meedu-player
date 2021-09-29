import 'package:flutter/material.dart';
import 'package:flutter_meedu/rx.dart';
import 'package:meedu_player/src/controller.dart';

class ControlsContainer extends StatelessWidget {
  final Widget child;
  const ControlsContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);
    return Positioned.fill(
      child: RxBuilder(
        (__) => GestureDetector(
          onTap: () => _.controls = !_.showControls.value,
          child: AnimatedOpacity(
            opacity: _.showControls.value ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: _.showControls.value ? Colors.black38 : Colors.transparent,
              child: AbsorbPointer(
                absorbing: !_.showControls.value,
                child: this.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
