import 'package:flutter/material.dart';
import 'package:flutter_meedu/rx.dart';
import 'package:meedu_player/meedu_player.dart';
import 'package:meedu_player/src/helpers/responsive.dart';

import 'player_button.dart';

class VideoFitButton extends StatelessWidget {
  final Responsive responsive;
  const VideoFitButton({required this.responsive});

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);
    return RxBuilder((__) {
      String iconPath = 'assets/icons/fit.png';
      Widget? customIcon = _.customIcons?.videoFit;

      return PlayerButton(
        size: responsive.ip(_.fullscreen.value ? 5 : 7),
        circle: false,
        backgrounColor: Colors.transparent,
        iconColor: Colors.white,
        iconPath: iconPath,
        customIcon: customIcon ?? Container(),
        onPressed: () {
          _.toggleVideoFit();
        },
      );
    });
  }
}
