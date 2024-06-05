import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class ScannerPuertos extends StatefulWidget {
  const ScannerPuertos({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ScannerPuertos> {
  final hostController = TextEditingController();
  final portsController = TextEditingController();
  final resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Port Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: hostController,
              decoration: const InputDecoration(
                labelText: 'Host',
                hintText: 'Ejemplo: 127.0.0.1 o www.paginaweb.es',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: portsController,
              decoration: const InputDecoration(
                labelText: 'Puertos (separados por comas)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                scanPorts();
              },
              child: const Text('Escanear Puertos'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: resultController,
                    readOnly: true,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Resultado del escaneo',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanPorts() async {
    final host = hostController.text.trim();
    final portsString = portsController.text.trim();

    if (host.isEmpty || portsString.isEmpty) {
      setState(() {
        resultController.text = 'Por favor, ingrese un host y puertos.';
      });
      return;
    }

    final ports = portsString
        .split(',')
        .map((port) => int.tryParse(port.trim()))
        .where((port) => port != null)
        .toList();

    if (ports.isEmpty) {
      setState(() {
        resultController.text = 'Por favor, ingrese puertos válidos.';
      });
      return;
    }

    setState(() {
      resultController.text = 'Escaneando puertos en $host...\n';
    });

    for (var port in ports) {
      try {
        var socket = await Socket.connect(host, port!,
            timeout: const Duration(seconds: 5));
        setState(() {
          resultController.text += 'Puerto $port abierto\n';
        });
        await socket.close();
      } catch (e) {
        setState(() {
          resultController.text += 'Puerto $port cerrado\n';
        });
      }
    }

    setState(() {
      resultController.text += 'Escaneo de puertos completado.';
    });
  }
}
