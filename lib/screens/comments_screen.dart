import 'package:flutter/material.dart';
import 'package:prueba_2/navigator/drawer.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comentarios')),
      drawer: MiDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Hola Mundo")
          ],
        ),
      ),
    );
  }
}