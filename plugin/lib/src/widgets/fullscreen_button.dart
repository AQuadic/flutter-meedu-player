import 'package:flutter/material.dart';
import 'package:flutter_meedu/rx.dart';
import 'package:meedu_player/meedu_player.dart';

import 'player_button.dart';

class FullscreenButton extends StatelessWidget {
  final double size;
  const FullscreenButton({this.size = 30});

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);
    return RxBuilder(
      (__) {
        String iconPath = 'assets/icons/minimize.png';
        Widget? customIcon = _.customIcons.minimize;

        if (!_.fullscreen.value) {
          iconPath = 'assets/icons/fullscreen.png';
          customIcon = _.customIcons.fullscreen;
        }
        return PlayerButton(
          size: size,
          circle: false,
          backgrounColor: Colors.transparent,
          iconColor: Colors.white,
          iconPath: iconPath,
          customIcon: customIcon,
          onPressed: () {
            if (_.fullscreen.value) {
              // exit to fullscreen
              Navigator.pop(context);
            } else {
              _.goToFullscreen(context);
            }
          },
        );
      },
    );
  }
}
