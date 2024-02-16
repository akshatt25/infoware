import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/bloc/audio_bloc.dart';
import 'package:infoware/helper_class/postion_stream.dart';
import 'package:infoware/helper_class/title_editor.dart';

class PlayScreen extends StatelessWidget {
  String audio_name;

  PlayScreen({super.key, required this.audio_name});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<AudioBloc>().add(LeavingScreen());
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<AudioBloc, AudioState>(
          builder: (context, state) {
            String title = "";
            if (state is AUdioSelected) {
              audio_name = state.audio_name;
              title = TitleEditior.title_editor(audio_name);
            }
            return Container(
                padding: const EdgeInsets.all(20),
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF144771), Color(0xFF071A2C)])),
                child: (state is AUdioSelected)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(2, 4),
                                    blurRadius: 4)
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/chr.jpg",
                                height: 300,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Christmas Song",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          StreamBuilder<PositionData>(
                              stream: state.positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                return ProgressBar(
                                  barHeight: 8,
                                  baseBarColor: Colors.grey[600],
                                  bufferedBarColor: Colors.grey,
                                  progressBarColor: Colors.red,
                                  thumbColor: Colors.red,
                                  timeLabelTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  progress:
                                      positionData?.position ?? Duration.zero,
                                  buffered: positionData?.bufferedPosition ??
                                      Duration.zero,
                                  total:
                                      positionData?.duration ?? Duration.zero,
                                  onSeek: state.seek,
                                );
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<AudioBloc>()
                                      .add(AudioPrev(audio_name: audio_name));
                                },
                                icon: const Icon(Icons.skip_previous_rounded),
                                color: Colors.white,
                                iconSize: 60,
                              ),
                              (state is AUdioSelected && state.play)
                                  ? IconButton(
                                      iconSize: 80,
                                      color: Colors.white,
                                      onPressed: () {
                                        context
                                            .read<AudioBloc>()
                                            .add(AudioPause());
                                      },
                                      icon: const Icon(Icons.pause))
                                  : IconButton(
                                      iconSize: 80,
                                      color: Colors.white,
                                      onPressed: () {
                                        context.read<AudioBloc>().add(
                                            AudioPlay(audio_name: audio_name));
                                      },
                                      icon:
                                          const Icon(Icons.play_arrow_rounded)),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<AudioBloc>()
                                      .add(AudioNext(audio_name: audio_name));
                                },
                                icon: const Icon(Icons.skip_next_rounded),
                                color: Colors.white,
                                iconSize: 60,
                              ),
                            ],
                          ),
                        ],
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.red,
                          )
                        ],
                      ));
          },
        ),
      ),
    );
  }
}
