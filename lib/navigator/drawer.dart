import 'package:flutter/material.dart';
import 'package:prueba_2/screens/comments_screen.dart';
import 'package:prueba_2/screens/series_list_screen.dart';

class MiDrawer extends StatelessWidget {
  const MiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Comentarios", style: TextStyle(color: Colors.deepPurple)),
            tileColor: Colors.blueAccent,
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentsScreen())),
          ),
          ListTile(
            tileColor: Colors.cyanAccent,
            title: Text("Lista de Series"),
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> SeriesListScreen())),
          )
        ],
      ),
    );
  }
}