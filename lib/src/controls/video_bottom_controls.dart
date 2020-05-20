import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../colors.dart';
import '../extras.dart';
import '../meedu_video_player_controller.dart';
import 'video_progress_bar.dart';

class VideoBottomControls extends StatefulWidget {
  final MeeduPlayerController controller;
  const VideoBottomControls({Key key, @required this.controller})
      : super(key: key);
  @override
  _VideoBottomControlsState createState() => _VideoBottomControlsState();
}

class _VideoBottomControlsState extends State<VideoBottomControls> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.status == MeeduPlayerStatus.loading)
      return Container();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            widget.controller.backgroundColor.withOpacity(0.3),
            widget.controller.backgroundColor
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              VideoProgressBar(
                duration: widget.controller.duration.value,
                onSeekTo: (position) {
                  widget.controller.seekTo(position);
                },
                position: widget.controller.position,
                buffered: widget.controller.buffered,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // START TIMER
                  ValueListenableBuilder(
                    valueListenable: widget.controller.position,
                    builder:
                        (BuildContext context, Duration value, Widget child) {
                      return Text(
                        "${printDuration2(value.inSeconds)} / ${printDuration2(widget.controller.duration.value.inSeconds)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                  // END TIMER
                  if (widget.controller.bottomLeftContent != null) ...[
                    SizedBox(
                      width: 5,
                    ),
                    widget.controller.bottomLeftContent
                  ],
                ],
              ),
              Row(
                children: <Widget>[
                  if (widget.controller.bottomRightContent != null) ...[
                    widget.controller.bottomRightContent,
                    SizedBox(
                      width: 5,
                    )
                  ],
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    minSize: 25,
                    child: SvgPicture.asset(
                      widget.controller.isFullScreen
                          ? 'assets/icons/fullscreen-off.svg'
                          : 'assets/icons/fullscreen-on.svg',
                      package: 'meedu_player',
                      width: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (widget.controller.isFullScreen) {
                        widget.controller.fullScreenOff();
                      } else {
                        widget.controller.fullScreenOn(context);
                      }
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}