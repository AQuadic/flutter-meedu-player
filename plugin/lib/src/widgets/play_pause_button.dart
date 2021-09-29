import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/rx.dart';
import 'package:meedu_player/meedu_player.dart';

import 'player_button.dart';

class PlayPauseButton extends StatelessWidget {
  final double size;
  const PlayPauseButton({this.size = 40});

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);
    return RxBuilder(
      (__) {
        if (_.isBuffering.value) {
          return CupertinoButton(
              child: _.loadingWidget ?? CupertinoActivityIndicator(),
              onPressed: _.pause);
        }

        String iconPath = 'assets/icons/repeat.png';
        Widget? customIcon = _.customIcons.repeat;
        if (_.playerStatus.playing) {
          iconPath = 'assets/icons/pause.png';
          customIcon = _.customIcons.pause;
        } else if (_.playerStatus.paused) {
          iconPath = 'assets/icons/play.png';
          customIcon = _.customIcons.play;
        }
        return PlayerButton(
          backgrounColor: Colors.transparent,
          iconColor: Colors.white,
          onPressed: () {
            if (_.playerStatus.playing) {
              _.pause();
            } else if (_.playerStatus.paused) {
              _.play();
            } else {
              _.play(repeat: true);
            }
          },
          size: size,
          iconPath: iconPath,
          customIcon: customIcon,
        );
      },
    );
  }
}
