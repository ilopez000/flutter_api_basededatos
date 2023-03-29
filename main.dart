import 'package:flutter/material.dart';
import 'package:ejemplo_conexion_bd/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _idController = TextEditingController();
  Map<String, dynamic> _fetchedData = {};
  bool _isLoading = false;
  final _apiService = ApiService(baseUrl: 'http://localhost:3000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Buscar por ID')),
    body: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    TextField(
    controller: _idController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    labelText: 'ID',
    ),
    ),
    SizedBox(height: 16),
    ElevatedButton(
    onPressed: () async {
    setState(() {
    _isLoading = true;
    });
    try {
    final data =
    await _apiService.fetchDataById(int.parse(_idController.text));
    setState(() {
    _fetchedData = data;
    });
    } catch (e) {
    print(e);
    setState(() {
    _fetchedData = {};
    });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    },
      child: Text('Buscar'),
    ),
      SizedBox(height: 16),
      if (_isLoading)
        CircularProgressIndicator()
      else if (_fetchedData.isNotEmpty)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${_fetchedData["id"]}'),
            Text('Nombre: ${_fetchedData["nombre"]}'),
            Text('Apellido1: ${_fetchedData["apellido1"]}'),
            Text('Apellido2: ${_fetchedData["apellido2"]}'),
          ],
        ),
    ],
    ),
    ),
    );
  }
}