import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[600],
      ),
      body: Column(
        children: [
          Text('MainScreen', style: TextStyle(color: Colors.white)),
          ElevatedButton(onPressed: () {
            // Navigator.pushNamed(context, '/todo');
            // Navigator.pushNamedAndRemoveUntil(context, '/todo', (route) => false);
            Navigator.pushReplacementNamed(context, '/todo');
          }, child: Text('Перейти далее'))
        ],
      ),
    );
  }
}
