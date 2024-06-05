import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ScannUrlsWaybackMachine extends StatelessWidget {
  const ScannUrlsWaybackMachine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Urls Wayback Machine'),
      ),
      body: CuerpoWaybackMachine(),
    );
  }
}

class CuerpoWaybackMachine extends StatefulWidget {
  CuerpoWaybackMachine({super.key});

  @override
  State<CuerpoWaybackMachine> createState() => _CuerpoWaybackMachineState();
}

class _CuerpoWaybackMachineState extends State<CuerpoWaybackMachine> {
  final portController = TextEditingController();

  bool isDiscovering = false;

  List<String> urls = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        TextField(
            controller: portController,
            decoration: const InputDecoration(
              labelText: 'url',
              hintText: 'url',
            )),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: isDiscovering ? null : () => urlsWaybackMachine(),
            child: Text(isDiscovering ? 'Discovering...' : 'Discover')),
        const SizedBox(height: 15),
        for (var url in urls) Text(url),
      ]),
    );
  }

  Future urlsWaybackMachine() async {
    String url =
        'https://web.archive.org/cdx/search/cdx?url=*.${portController.text}/*&output=json&fl=original&collapse=urlkey';
    final response = await Dio().get(url);
    for (var i = 0; i < response.data.length; i++) {
      //Verificamos que la url no sea nula y no se encuentre dentro de urls
      if (response.data[i][0] != null && !urls.contains(response.data[i][0])) {
        print(response.data[i][0]);
        urls.add(response.data[i][0]);
      }
    }
    setState(() {
      urls;
    });
  }
}
