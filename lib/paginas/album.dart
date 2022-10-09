import 'package:actividadanimales/paginas/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:actividadanimales/json/sonidos_json.dart';
import 'package:actividadanimales/temas/colores.dart';
import 'package:page_transition/page_transition.dart';
import 'package:audioplayers/audioplayers.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key, this.sonidos}) : super(key: key);
  final dynamic sonidos;

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  bool isPlaying = false;
  bool isPaused = false;
  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco, //color de fondo
      body: cuerpoAlbum(),
    );
  }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
        isPaused = state == PlayerState.paused;
      });
    });
  }

  void dispose() {
    player.dispose();
    super.dispose();
  }

  Widget cuerpoAlbum() {
    var size = MediaQuery.of(context).size;
    List songAlbums = widget.sonidos['songs'];

    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                height: 220,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.sonidos['img']),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.sonidos['title'],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: negro)),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Column(
                    children: List.generate(songAlbums.length, (index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            width: (size.width - 60) * 0.77,
                            child: Text(
                              songAlbums[index]['title'],
                              style: TextStyle(color: negro),
                            ),
                          ),
                          Container(
                            width: (size.width - 60) * 0.23,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: negro,
                                      ),
                                      onPressed: () async {
                                        if (isPlaying) {
                                          await player.pause();
                                        } else if (isPaused) {
                                          await player.resume();
                                        } else {
                                          player.play(AssetSource(
                                              widget.sonidos['song_url']));
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 10, top: 10),
                child: Text(
                  widget.sonidos['description'],
                  style: TextStyle(color: negro),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Acuaticos",
                style: TextStyle(
                    fontSize: 15, color: negro, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: List.generate(acuaticos.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            //cambio de wiget cetral
                            Navigator.push(
                                context,
                                PageTransition(
                                    alignment: Alignment.bottomCenter,
                                    child: AlbumPage(
                                      sonidos: acuaticos[index],
                                    ),
                                    type: PageTransitionType.scale));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(acuaticos[index]['img']),
                                        fit: BoxFit.cover),
                                    color: primario,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                acuaticos[index]['title'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: negro,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: blanco,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
