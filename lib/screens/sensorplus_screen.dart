import 'package:flutter/material.dart'; // Importamos la biblioteca de Flutter para la interfaz de usuario
import 'package:sensors_plus/sensors_plus.dart'; // Importamos la biblioteca para acceder a los sensores del dispositivo
import 'dart:async'; // Importamos para manejar la programación asíncrona

// Clase principal para la pantalla de sensores
class SensoresScreen extends StatefulWidget {
  @override
  _SensoresScreenState createState() => _SensoresScreenState(); // Creamos el estado de la pantalla
}

// Clase que maneja el estado de la pantalla de sensores
class _SensoresScreenState extends State<SensoresScreen> {
  // Variables para almacenar los datos de los sensores
  String _accelerometer = "Acelerómetro: esperando datos..."; // Mensaje inicial
  String _gyroscope = "Giroscopio: esperando datos..."; // Mensaje inicial
  String _magnetometer = "Magnetómetro: esperando datos..."; // Mensaje inicial

  // Umbral y duración para detectar si el teléfono está estático
  final double _threshold = 0.2; // Umbral de sensibilidad
  final int _staticDuration = 200; // Duración en milisegundos para considerar "estático"
  bool _isStatic = false; // Estado del acelerómetro
  DateTime _lastUpdate = DateTime.now(); // Última actualización de tiempo

  // Suscripciones a los eventos de los sensores
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;

  @override
  void initState() {
    super.initState(); // Llamamos al método initState de la clase padre

    // Escucha los datos del acelerómetro
    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        // Comprobamos si el dispositivo ha estado "estático" durante el tiempo suficiente
        if (DateTime.now().difference(_lastUpdate).inMilliseconds >= _staticDuration) {
          _isStatic = event.x.abs() < _threshold && // Verificamos si el movimiento es menor que el umbral
                      event.y.abs() < _threshold &&
                      (event.z - 9.81).abs() < _threshold;

          if (_isStatic) {
            _lastUpdate = DateTime.now(); // Actualizamos la última vez que se detectó "estático"
          }
        }

        // Actualizamos el texto del acelerómetro
        _accelerometer = _isStatic 
            ? 'Acelerómetro: Estático' 
            : 'Acelerómetro: \nX: ${event.x}, Y: ${event.y}, Z: ${event.z}';
      });
    });

    // Escucha los datos del giroscopio
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscope = 'Giroscopio: \nX: ${event.x}, Y: ${event.y}, Z: ${event.z}';
      });
    }, onError: (error) {
      setState(() {
        _gyroscope = 'Giroscopio: Sensor no encontrado'; // Mensaje de error
      });
    });

    // Escucha los datos del magnetómetro
    _magnetometerSubscription = magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometer = 'Magnetómetro: \nX: ${event.x}, Y: ${event.y}, Z: ${event.z}';
      });
    }, onError: (error) {
      setState(() {
        _magnetometer = 'Magnetómetro: Sensor no encontrado'; // Mensaje de error
      });
    });
  }

  @override
  void dispose() {
    // Cancelamos las suscripciones a los eventos de los sensores
    _accelerometerSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    _magnetometerSubscription?.cancel();
    super.dispose(); // Llamamos al dispose de la clase padre
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sensores del dispositivo',
          style: TextStyle(color: Colors.yellowAccent), // Título en amarillo
        ),
        backgroundColor: Color.fromARGB(255, 24, 24, 24), // Fondo oscuro
        iconTheme: IconThemeData(color: Colors.yellowAccent), // Color de la flecha en amarillo
      ),
      body: Container(
        color: Color.fromARGB(255, 0, 0, 0), // Fondo negro
        padding: const EdgeInsets.all(16.0), // Espaciado alrededor del contenido
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alineación del texto a la izquierda
          children: [
            Text(
              _accelerometer, 
              style: TextStyle(fontSize: 18, color: Colors.cyanAccent) // Texto en cian
            ),
            SizedBox(height: 20), // Espacio entre los textos
            Text(
              _gyroscope, 
              style: TextStyle(fontSize: 18, color: Colors.cyanAccent) // Texto en cian
            ),
            SizedBox(height: 20), // Espacio entre los textos
            Text(
              _magnetometer, 
              style: TextStyle(fontSize: 18, color: Colors.cyanAccent) // Texto en cian
            ),
          ],
        ),
      ),
    );
  }
}
