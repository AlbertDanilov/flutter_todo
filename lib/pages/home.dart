import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String _userToDo;
  List todoList = [];

  // void initFirebase() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // }

  @override
  void initState() {
    super.initState();

    //initFirebase();

    todoList.addAll(['Buy milk', 'Wash dishes', 'Play footbal']);
  }

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Меню'),
            backgroundColor: Colors.deepOrange[600],
          ),
          body: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                child: Text('На главную'),
              ),
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('Наше простое меню')
            ],
          ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Список дел'),
        backgroundColor: Colors.deepOrange[600],
        actions: [
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: _menuOpen
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('Нет записей');
          return ListView.builder(
            itemCount: snapshot.data!.docs.length, // todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(snapshot.data!.docs[index].id), //Key(todoList[index]),
                child: Card(
                  child: ListTile(
                    title: Text(snapshot.data!.docs[index].get('item')), //Text(todoList[index]),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_sweep,
                        color: Colors.deepOrange[600],
                      ),
                      onPressed: () {
                        // setState(() {
                        //   todoList.removeAt(index);
                        // });
                        FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                      },
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  // if(direction == DismissDirection.endToStart) {}
                  // setState(() {
                  //   todoList.removeAt(index);
                  // });
                  FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                },
              );
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
                  // setState(() {
                  //   todoList.add(_userToDo);
                  // });
                  FirebaseFirestore.instance.collection('items').add({'item': _userToDo});
                  
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
