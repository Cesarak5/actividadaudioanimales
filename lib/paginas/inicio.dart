import 'package:flutter/material.dart';
import 'package:actividadanimales/paginas/principal.dart';

class AnimalesSonidos extends StatelessWidget {
  const AnimalesSonidos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Principal(),
    );
  }
}
