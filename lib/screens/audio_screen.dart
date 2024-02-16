import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/bloc/audio_bloc.dart';
import 'package:infoware/helper_class/title_editor.dart';
import 'package:infoware/screens/play_screen.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(useMaterial3: true),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("A U D I O U S"),
          centerTitle: true,
        ),
        body: BlocBuilder<AudioBloc, AudioState>(
          builder: (context, state) {
            if (state is AudiosLoaded) {
              List audios = state.audios;

              return Container(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: audios.length,
                  itemBuilder: (context, index) {
                    if ("${audios[index]}".endsWith(".mp3")) {
                      return MyListItem(audios[index], context);
                    }
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
          },
        ),
      ),
    );
  }

  Widget MyListItem(String mytitle, BuildContext context) {
    String new_title = TitleEditior.title_editor(mytitle);
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              // color: Color.fromARGB(255, 228, 227, 227),
              offset: Offset(0, 0),
              blurRadius: 2,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
              onTap: () async {
                context.read<AudioBloc>().add(AudioSelect(audio_name: mytitle));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayScreen(
                        audio_name: mytitle,
                      ),
                    ));
              },
              leading: const Icon(Icons.music_note_outlined),
              title: Text(new_title)),
        ),
      ),
    );
  }
}
