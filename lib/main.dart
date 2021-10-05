import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List todos = <dynamic>[];

  _deleteItem(context, e){
    setState(() {
      todos.remove(e);
      todos.join(', ');
    });
  }

  _onAlertWithCustomContentPressed(context) {
    final TextEditingController todo = TextEditingController();
    Alert(
      context: context,
      title: "Add Todo",
      content: Column(
        children: <Widget>[
          TextField(
            controller: todo,
            decoration: InputDecoration(
              icon: Icon(Icons.add_comment_rounded),
              labelText: 'Todo',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => {Navigator.pop(context),
          if(todo.value.text != ''){
            setState(() {
            todos.add(todo.value.text);
            })
          }
          },
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("All todos"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () {},
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          "All To-Do's",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {_onAlertWithCustomContentPressed(context);},
        backgroundColor: Colors.white,
      ),
      body: todos.length == 0? Padding(padding: EdgeInsets.only(left: 50, right: 50),
        child:Center(
          child: ListTile(
            leading: Icon(Icons.note_add_outlined),
            title: Text("No todos to display!"),),
            )
          ) :
        ListView(children: todos.map((e) => ListTile(
          title: Text(e),
          trailing: IconButton(
            onPressed: (){_deleteItem(context, e);},
            icon: Icon(Icons.delete)),)).toList())
    );
  }
}

