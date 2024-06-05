import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scannerpuertos/config/menu/menu_item.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Menu Escanner')),
      ),
      body: _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  _HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: MenuItem().menuItem.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(MenuItem().menuItem[index]['title']),
            subtitle: Text(MenuItem().menuItem[index]['subtitle']),
            onTap: () {
              context.push(MenuItem().menuItem[index]['route']);
            },
            leading: Icon(Icons.search),
            trailing: Icon(Icons.arrow_forward),
          );
        });
  }
}
