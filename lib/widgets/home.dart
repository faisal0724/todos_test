import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_test/widgets/add.dart';
import 'package:todos_test/widgets/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<dynamic> todos = [
    {
      "name" : "Learn ListView",
      "description" : "ListView, ListTile, Card",
      "place" : "Online Google Meet",
      "completed" : true,
    },
    {
      "name" : "Homework Class",
      "description" : "Do the homework to submit on next class",
      "place" : "Bangi",
      "completed" : false,
    },
    {
      "name" : "Buka Puasa",
      "description" : "Buka puasa di rumah",
      "place" : "Home",
      "completed" : false,
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var todoString = prefs.getString("todos_test");
    if (todoString != null){
      setState(() {
        todos = jsonDecode(todoString);
      });
    }

  }

  void save() async {
    //to Save new Item data
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("todos_test", jsonEncode(todos));
    //"todos_test" is the key or filename,
    //jsonEncode is the value
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Home Page",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,

        ),
        body: ListView.builder(
          //ini listview dynamic
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              // return Container(
              //   height: 50,
              //   color: Colors.amber,
              //   child: Center(child: Text('${todos[index]["name"]}')),
              // );

              // initial use container. however, better change to ListTile
              // purpose to show the list and after tap will go to detail page
              return Card(
                color: Colors.yellow,
                child: ListTile(
                  leading: todos[index]["completed"] == true ? Icon(Icons.check) : SizedBox(),
                  title: Text(
                    "${todos[index]["name"]}",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  subtitle: Text(
                    "${todos[index]["place"]}",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.blueGrey,
                  ),
                  onTap: () async {
                    var response = await Navigator.push(
                        context,
                        //View in DetailPage 3 - In sender put the constructor.
                        MaterialPageRoute(builder: (context) => DetailPage(
                          todo: todos[index], itemList: index,
                        )
                        )
                    );
                    if (response != null){
                      if (response["action"] == 1){
                        todos.removeAt(response["index"]);
                        save();
                        setState(() {
                          todos;
                        });
                      } else {
                        todos[index]["completed"] = !todos[index]["completed"];
                        save();
                        setState(() {
                          todos;
                        });
                      }

                    }
                  },
                ),

              );


            }
        ),

        //Text("To-Do Item", style: TextStyle(fontSize: 26),),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.add, color: Colors.white,),
          onPressed: () async {

            // newItem in Homepage 1 - in order to add new item,
            // var newItem in both sender(HomePage) and receiver (addPage)
            // async and await to wait for data from addPage
            var newItem = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPage())
            );

            if (newItem != null){
              todos.add(newItem);
              save();
              setState(() {
                todos;
              });
            }

          },
        ),
      );
    }
}
