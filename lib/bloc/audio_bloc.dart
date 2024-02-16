import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infoware/helper_class/postion_stream.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

import 'package:rxdart/rxdart.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc() : super(AudioInitial()) {
    int index = 0;
    Stream<Duration> positionStream = Stream.value(Duration.zero);
    Stream<Duration> bufferedPositionStream = Stream.value(Duration.zero);
    Stream<Duration?> durationStream = Stream.value(Duration.zero);
    Stream<PositionData> _positionDataStream =
        Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      positionStream,
      bufferedPositionStream,
      durationStream,
      (a, b, c) => PositionData(a, b, c ?? Duration.zero),
    );
    AudioPlayer audioPlayer = new AudioPlayer();
    List<String> audios = [];
    on<LoadAudioNames>((event, emit) async {
      await AssetManifest.loadFromAssetBundle(rootBundle).then((value) {
        List<String> mylist = value.listAssets();
        for (var element in mylist) {
          if (element.endsWith(".mp3")) {
            audios.add(element);
          }
        }
      });

      emit(AudiosLoaded(audios));
    });
    on<AudioPrev>(
      (event, emit) async {
        audioPlayer.pause();
        audioPlayer.dispose();
        audioPlayer = new AudioPlayer();
        index = audios.indexOf(event.audio_name);
        if (index == 0) {
          index = audios.length - 1;
        } else {
          index = index - 1;
        }
        await audioPlayer.setAsset(audios[index]);
        positionStream = audioPlayer.positionStream;
        bufferedPositionStream = audioPlayer.bufferedPositionStream;
        durationStream = audioPlayer.durationStream;
        _positionDataStream =
            Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          positionStream,
          bufferedPositionStream,
          durationStream,
          (a, b, c) => PositionData(a, b, c ?? Duration.zero),
        );
        emit(AUdioSelected(
            false, _positionDataStream, audioPlayer.seek, audios[index]));
      },
    );

    on<AudioNext>(
      (event, emit) async {
        emit(AudioChanging());
        audioPlayer.pause();

        audioPlayer.dispose();
        audioPlayer = new AudioPlayer();
        index = audios.indexOf(event.audio_name);
        if (index == audios.length - 1) {
          index = 0;
        } else {
          index = index + 1;
        }
        await audioPlayer.setAsset(audios[index]);
        positionStream = audioPlayer.positionStream;
        bufferedPositionStream = audioPlayer.bufferedPositionStream;
        durationStream = audioPlayer.durationStream;
        _positionDataStream =
            Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          positionStream,
          bufferedPositionStream,
          durationStream,
          (a, b, c) => PositionData(a, b, c ?? Duration.zero),
        );

        emit(AUdioSelected(
            false, _positionDataStream, audioPlayer.seek, audios[index]));
      },
    );

    on<AudioSelect>(
      (event, emit) async {
        emit(AudioChanging());
        index = audios.indexOf(event.audio_name);
        audioPlayer = new AudioPlayer();
        await audioPlayer.setAsset(event.audio_name);
        positionStream = audioPlayer.positionStream;
        bufferedPositionStream = audioPlayer.bufferedPositionStream;
        durationStream = audioPlayer.durationStream;
        _positionDataStream =
            Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          positionStream,
          bufferedPositionStream,
          durationStream,
          (a, b, c) => PositionData(a, b, c ?? Duration.zero),
        );

        emit(AUdioSelected(
            false, _positionDataStream, audioPlayer.seek, event.audio_name));
      },
    );

    on<AudioPlay>(
      (event, emit) async {
        audioPlayer.play();
        if (audioPlayer.duration == audioPlayer.position) {
          emit(AUdioSelected(
              false, _positionDataStream, audioPlayer.seek, event.audio_name));
        } else {
          emit(AUdioSelected(
              true, _positionDataStream, audioPlayer.seek, event.audio_name));
        }
      },
    );

    on<AudioPause>(
      (event, emit) async {
        await audioPlayer.pause();
        emit(AUdioSelected(
            false, _positionDataStream, audioPlayer.seek, audios[index]));
      },
    );

    on<LeavingScreen>(
      (event, emit) async {
        await audioPlayer.pause();
        audioPlayer.dispose();
        emit(AudiosLoaded(audios));
      },
    );
  }
}
