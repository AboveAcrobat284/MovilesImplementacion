// Importamos las librerías necesarias para construir la aplicación
import 'package:flutter/material.dart'; // Para construir la interfaz de usuario
import 'package:url_launcher/url_launcher.dart'; // Para abrir enlaces externos
import 'screens/qr_screen.dart'; // Importamos la pantalla de escaneo de QR
import 'screens/geolocator_screen.dart'; // Importamos la pantalla de geolocalización
import 'screens/micro_screen.dart'; // Importamos la pantalla de grabación de voz
import 'screens/sensorplus_screen.dart'; // Importamos la pantalla de sensores

// Esta es la función principal que se ejecuta al iniciar la aplicación
void main() {
  runApp(const MyApp()); // Llamamos a la clase MyApp para construir la app
}

// Definimos la clase principal de nuestra aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Aquí definimos el diseño y estilo general de la aplicación
    return MaterialApp(
      title: 'Flutter Demo', // Título de la aplicación
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black, // Color de fondo de toda la app
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 24, 24, 24), // Color de fondo de la barra superior
          titleTextStyle: TextStyle(color: Colors.yellowAccent), // Color del texto en la barra superior
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 24, 24, 24), // Color de fondo de la barra de navegación
          selectedItemColor: Colors.yellowAccent, // Color de los íconos seleccionados
          unselectedItemColor: Colors.grey, // Color de los íconos no seleccionados
        ),
      ),
      home: const MyHomePage(), // La pantalla inicial de la app
    );
  }
}

// Definimos la clase para la página principal
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key}); // Constructor

  @override
  _MyHomePageState createState() => _MyHomePageState(); // Creación del estado para esta página
}

// Clase para manejar el estado de MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  // Función para abrir un enlace externo (GitHub en este caso)
  void _openLink() async {
    final githubUri = Uri.parse('https://github.com/AboveAcrobat284/MovilesImplementacion.git'); // URI del enlace
    try {
      // Intenta abrir el enlace en el navegador
      if (!await launchUrl(
        githubUri,
        mode: LaunchMode.externalApplication, // Abre en una aplicación externa
      )) {
        throw 'No se pudo abrir el enlace $githubUri'; // Si falla, lanza un error
      }
    } catch (e) {
      print('No se pudo abrir el enlace: $e'); // Muestra un mensaje de error en la consola
    }
  }

  @override
  Widget build(BuildContext context) {
    // Construimos el diseño de la página principal
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Estudiante'), // Título en la barra superior
      ),
      body: Center(
        // Centramos el contenido de la página
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alineamos al centro
          children: <Widget>[
            // Mostramos el logo del estudiante
            Image.asset(
              'assets/Logo.jpg', // Ruta de la imagen del logo
              width: 100, // Ancho de la imagen
              height: 100, // Altura de la imagen
            ),
            const SizedBox(height: 20), // Espacio entre la imagen y el siguiente texto
            const Text(
              'Carlos Eduardo Gumeta Navarro', // Nombre del estudiante
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyanAccent), // Estilo del texto
            ),
            const SizedBox(height: 5), // Espacio
            const Text('221199', style: TextStyle(color: Colors.yellowAccent)), // Matrícula
            const SizedBox(height: 5), // Espacio
            const Text('9A', style: TextStyle(color: Colors.yellowAccent)), // Grupo
            const SizedBox(height: 5), // Espacio
            const Text('Ingeniería en Software', style: TextStyle(color: Colors.yellowAccent)), // Carrera
            const SizedBox(height: 5), // Espacio
            const Text('Desarrollo de Aplicaciones Móviles', style: TextStyle(color: Colors.yellowAccent)), // Especialidad
            const SizedBox(height: 20), // Espacio
            ElevatedButton(
              onPressed: _openLink, // Al presionar, abre el enlace
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 153, 0), // Color de fondo del botón
              ),
              child: const Text('Abrir GitHub', style: TextStyle(color: Colors.white)), // Texto del botón
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Tipo de barra de navegación
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on), // Ícono de ubicación
            label: 'Geo', // Etiqueta
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code), // Ícono de código QR
            label: 'QR', // Etiqueta
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors), // Ícono de sensores
            label: 'Sensor', // Etiqueta
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic), // Ícono de micrófono
            label: 'Speech', // Etiqueta
          ),
        ],
        onTap: (index) {
          // Maneja el evento de pulsación en los íconos de la barra de navegación
          switch (index) {
            case 0: // Si se pulsa el ícono de Geo
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => GpsScreen()), // Navega a la pantalla de GPS
              );
              break;
            case 1: // Si se pulsa el ícono de QR
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const QrScreen()), // Navega a la pantalla de QR
              );
              break;
            case 2: // Si se pulsa el ícono de Sensor
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SensoresScreen()), // Navega a la pantalla de Sensores
              );
              break;
            case 3: // Si se pulsa el ícono de Speech
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MicroScreen()), // Navega a la pantalla de Microfono
              );
              break;
          }
        },
      ),
    );
  }
}
