import 'package:flutter/material.dart'; // Importamos la biblioteca de Flutter para crear la interfaz de usuario
import 'package:mobile_scanner/mobile_scanner.dart'; // Importamos la biblioteca para escanear códigos QR

// Clase principal para la pantalla de escáner QR
class QrScreen extends StatelessWidget {
  const QrScreen({super.key}); // Constructor de la clase

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Escáner de QR',
          style: TextStyle(color: Colors.yellowAccent), // Establecemos el color del título en amarillo
        ),
        backgroundColor: Color.fromARGB(255, 24, 24, 24), // Color oscuro para el fondo de la AppBar
        iconTheme: IconThemeData(color: Colors.yellowAccent), // Color de la flecha de retroceso en amarillo
      ),
      body: Container(
        color: Colors.black, // Fondo negro para toda la pantalla
        child: MobileScanner( // Widget para escanear códigos QR
          onDetect: (BarcodeCapture capture) { // Método que se llama cuando se detecta un código
            final List<Barcode> barcodes = capture.barcodes; // Obtenemos la lista de códigos detectados
            for (final barcode in barcodes) { // Iteramos sobre cada código detectado
              // Mostramos un SnackBar con el valor del código escaneado
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Código escaneado: ${barcode.rawValue}', // Mostramos el valor del código
                    style: TextStyle(color: Colors.white), // Texto blanco en el SnackBar
                  ),
                  backgroundColor: Colors.blueAccent, // Color del fondo del SnackBar
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
