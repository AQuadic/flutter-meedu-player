import 'package:flutter/material.dart';
import 'package:flutter_meedu/rx.dart';
import 'package:meedu_player/meedu_player.dart';
import 'package:meedu_player/src/helpers/responsive.dart';
import 'package:meedu_player/src/helpers/utils.dart';
import 'package:meedu_player/src/widgets/fullscreen_button.dart';
import 'package:meedu_player/src/widgets/mute_sound_button.dart';
import 'package:meedu_player/src/widgets/pip_button.dart';
import 'package:meedu_player/src/widgets/player_slider.dart';
import 'package:meedu_player/src/widgets/video_fit_button.dart';

class PrimaryBottomControls extends StatelessWidget {
  final Responsive responsive;
  const PrimaryBottomControls({required this.responsive});

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);
    final fontSize = responsive.ip(2.5);
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: fontSize > 17 ? 17 : fontSize,
    );
    return Positioned(
      left: 5,
      right: 0,
      bottom: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // START VIDEO POSITION
          RxBuilder(
            (__) => Text(
              _.duration.value.inMinutes >= 60
                  ? printDurationWithHours(_.position.value)
                  : printDuration(_.position.value),
              style: textStyle,
            ),
          ),
          // END VIDEO POSITION
          SizedBox(width: 10),
          Expanded(
            child: PlayerSlider(),
          ),
          SizedBox(width: 10),
          // START VIDEO DURATION
          RxBuilder(
            (__) => Text(
              _.duration.value.inMinutes >= 60
                  ? printDurationWithHours(_.duration.value)
                  : printDuration(_.duration.value),
              style: textStyle,
            ),
          ),
          // END VIDEO DURATION
          SizedBox(width: 15),
          if (_.bottomRight != null) ...[
            _.bottomRight ?? Container(),
            SizedBox(width: 5)
          ],

          if (_.enabledButtons?.pip ?? false) PipButton(responsive: responsive),

          if (_.enabledButtons?.videoFit ?? false)
            VideoFitButton(responsive: responsive),
          if (_.enabledButtons?.muteAndSound ?? false)
            MuteSoundButton(responsive: responsive),

          if (_.enabledButtons?.fullscreen ?? false)
            FullscreenButton(
              size: responsive.ip(_.fullscreen.value ? 5 : 7),
            )
        ],
      ),
    );
  }
}
