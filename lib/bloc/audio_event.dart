part of 'audio_bloc.dart';

@immutable
sealed class AudioEvent {}

class LoadAudioNames extends AudioEvent {}

class AudioPlay extends AudioEvent {
  String audio_name;
  AudioPlay({required this.audio_name});
}

class AudioSelect extends AudioEvent {
  String audio_name;
  AudioSelect({required this.audio_name});
}

class AudioPause extends AudioEvent {}

class LeavingScreen extends AudioEvent {}

class AudioNext extends AudioEvent {
  String audio_name;
  AudioNext({required this.audio_name});
}

class AudioPrev extends AudioEvent {
  String audio_name;
  AudioPrev({required this.audio_name});
}
