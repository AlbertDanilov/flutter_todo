import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String _userToDo;
  List todoList = [];

  @override
  void initState() {
    super.initState();

    todoList.addAll(['Buy milk', 'Wash dishes', 'Play footbal']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Список дел'),
        backgroundColor: Colors.deepOrange[600],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: Key(todoList[index]),
              child: Card(
                child: ListTile(
                  title: Text(todoList[index]),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_sweep,
                        color: Colors.deepOrange[600],
                      ),
                      onPressed: () {
                        setState(() {
                          todoList.removeAt(index);
                        });
                      },
                    ),
                ),
              ),
              onDismissed: (direction) {
                // if(direction == DismissDirection.endToStart) {}
                setState(() {
                  todoList.removeAt(index);
                });
              },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange[600],
        onPressed: () {
          showDialog(context: context, builder: (BuildContext buildContext) {
            return AlertDialog(
              title: Text('Добавить элемент'),
              content: TextField(
                onChanged: (String value) {
                    _userToDo = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  setState(() {
                    todoList.add(_userToDo);
                  });
                  Navigator.of(context).pop();
                }, child: Text('Добавить'))
              ],
            );
          });
        },
        child: Icon(
            Icons.add_box,
            color: Colors.white,
            size: 30,
        ),
      ),
    );
  }
}
