import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;  // Para leer archivos desde assets
import 'dart:convert';

import 'package:prueba_2/navigator/drawer.dart';

class SeriesListScreen extends StatefulWidget {
  @override
  _SeriesListScreenState createState() => _SeriesListScreenState();
}

class _SeriesListScreenState extends State<SeriesListScreen> {
  List<dynamic> series = [];
  bool isLoading = true;
  String errorMessage = '';

  // Función para cargar los datos del archivo JSON local
  Future<void> fetchSeries() async {
    try {
      // Leemos el archivo JSON desde los assets
      final String response = await rootBundle.rootBundle.loadString('assets/series.json');

      print('Contenido del archivo JSON: $response');

      // Decodificamos el JSON
      final data = json.decode(response);

      setState(() {
        series = data['series']; // Usamos el campo 'series' del JSON
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        errorMessage = 'Error al cargar el archivo JSON: $e';
        isLoading = false;
      });
      print('Error al cargar el archivo: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSeries();  // Llamamos a la función para cargar las series al inicio
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Series')),
      drawer: MiDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: series.length,
                  itemBuilder: (ctx, index) {
                    var serie = series[index];
                    return ListTile(
                      title: Text(serie['titulo'] ?? 'Sin título'),
                      subtitle: Text(serie['descripcion'] ?? 'Sin descripción'),
                      leading: Image.network(
                        serie['info']['imagen'] ?? 'https://via.placeholder.com/50',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(serie['titulo'] ?? 'Sin título'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  serie['info']['imagen'] ?? 'https://via.placeholder.com/150',
                                ),
                                SizedBox(height: 10),
                                Text(serie['descripcion'] ?? 'Sin descripción'),
                                SizedBox(height: 10),
                                Text('Año: ${serie['anio']}'),
                                Text('Temporadas: ${serie['metadata']['temporadas']}'),
                                Text('Creador: ${serie['metadata']['creador']}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("Cerrar"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
