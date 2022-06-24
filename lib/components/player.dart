import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ny_tiona/components/snackabar_read_error.dart';
import 'package:ny_tiona/tools/human.dart';
import 'package:ny_tiona/tools/timer.dart';

enum PlayerReadState { stop, pause, play }

class Player extends StatefulWidget {
  const Player({Key? key, required this.audio}) : super(key: key);

  static const double hidePositionFromBottom = -200;
  static const double showPositionFromBottom = 0;
  final String audio;

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final player = AudioPlayer();
  Duration duration = const Duration();
  Duration readPosition = const Duration();
  PlayerReadState readState = PlayerReadState.stop;
  bool isSlideEditing = false;

  @override
  void initState() {
    player.setAsset(widget.audio).then((musicDuration) {
      duration = musicDuration ?? const Duration();
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackbarReadError());
    });

    player.positionStream
        .where(ThrottleFilter<Duration>(const Duration(seconds: 1)).call)
        .listen((duration) {
      if (!isSlideEditing) {
        setState(() {
          readPosition = duration;
        });
      }
    });

    super.initState();
  }

  void play() {
    player.play();
    setState(() {
      readState = PlayerReadState.play;
    });
  }

  void pause() async {
    try {
      await player.pause();
      setState(() {
        readState = PlayerReadState.pause;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackbarReadError());
    }
  }

  void stop({allowSnackBarError = true}) async {
    try {
      await player.pause();
      await player.seek(Duration.zero);
      setState(() {
        readState = PlayerReadState.stop;
        readPosition = const Duration();
      });
    } catch (e) {
      if (allowSnackBarError) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackbarReadError());
      }
    }
  }

  Future jumpSeconds(double value) async {
    try {
      int nextSeconds = value.toInt() + readPosition.inSeconds;
      if (nextSeconds < 0) {
        nextSeconds = 0;
      } else if (nextSeconds > duration.inSeconds) {
        nextSeconds = duration.inSeconds;
      }
      Duration nextDuration = Duration(seconds: nextSeconds);
      await player.seek(nextDuration);
      setState(() {
        readPosition = nextDuration;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackbarReadError());
    }
  }

  void replay() async {
    await jumpSeconds(-10);
  }

  void forward() async {
    await jumpSeconds(10);
  }

  void onSlideEditStart(double value) {
    setState(() {
      isSlideEditing = true;
    });
  }

  void onSlideEditStop(double value) {
    setState(() {
      isSlideEditing = false;
    });
  }

  void onSlideEditing(double value) async {
    try {
      Duration nextDuration = Duration(seconds: value.toInt());
      await player.seek(nextDuration);
      setState(() {
        readPosition = nextDuration;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackbarReadError());
    }
  }

  @override
  void dispose() async {
    stop(allowSnackBarError: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Audio player'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              replayButton(replay),
              if (readState == PlayerReadState.play) pauseButton(pause),
              if (readState == PlayerReadState.stop ||
                  readState == PlayerReadState.pause)
                playButton(play),
              if (readState == PlayerReadState.play ||
                  readState == PlayerReadState.pause)
                stopButton(stop),
              forwardButton(forward),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(playerTime(readPosition)),
              ),
              Expanded(
                child: Slider(
                  value: readPosition.inSeconds.toDouble(),
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: onSlideEditing,
                  onChangeStart: onSlideEditStart,
                  onChangeEnd: onSlideEditStop,
                ),
              ),
              SizedBox(
                width: 40,
                child: Text(playerTime(duration)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget pauseButton(void Function() action) {
  return IconButton(
    onPressed: action,
    icon: const Icon(Icons.pause),
  );
}

Widget playButton(void Function() action) {
  return IconButton(
    onPressed: action,
    icon: const Icon(Icons.play_circle_outline_outlined),
  );
}

Widget stopButton(void Function() action) {
  return IconButton(
    onPressed: action,
    icon: const Icon(Icons.stop_circle_outlined),
  );
}

Widget replayButton(void Function() action) {
  return IconButton(
    onPressed: action,
    icon: const Icon(Icons.replay_10_outlined),
  );
}

Widget forwardButton(void Function() action) {
  return IconButton(
    onPressed: action,
    icon: const Icon(Icons.forward_10_outlined),
  );
}
