part of 'audio_bloc.dart';

@immutable
sealed class AudioState {}

final class AudioInitial extends AudioState {}

final class AudiosLoaded extends AudioState {
  List<String> audios;
  AudiosLoaded(this.audios);
}

final class AudioChanging extends AudioState {}

final class AUdioSelected extends AudioState {
  bool play;
  String audio_name;
  Stream<PositionData> positionDataStream;
  dynamic seek;

  AUdioSelected(this.play, this.positionDataStream, this.seek, this.audio_name);
}
