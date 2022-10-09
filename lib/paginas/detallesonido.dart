import 'package:flutter/material.dart';

class SonidoDeta extends StatefulWidget {
  final String title;
  final String description;
  final String color;
  final String img;
  final String songurl;
  const SonidoDeta(
      {super.key,
      required this.title,
      required this.description,
      required this.color,
      required this.img,
      required this.songurl});

  @override
  State<SonidoDeta> createState() => _SonidoDetaState();
}

class _SonidoDetaState extends State<SonidoDeta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
