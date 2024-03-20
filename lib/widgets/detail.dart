import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  // View in DetailPage 1 - Map new variable to received the pass items from sender (home.dart)
  Map<String,dynamic> todo;
  int itemList;

  // View in DetailPage 2 - Create constructor,
  // to inform sender what to display in receiver (detail.dart)
  DetailPage({required this.todo, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page"),),
      body: Center(
        child: Column(
          children: [
            Text(
              "${todo["name"]}",
              style: TextStyle(fontSize: 28,),
            ),
            SizedBox(height: 8,),
            Text("${todo["description"]}"),
            SizedBox(height: 8,),
            Text("${todo["place"]}"),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      var item = {
                        "action":2,
                        "index":itemList
                      };
                      Navigator.pop(context,item);
                    },
                    child: Text(todo["completed"] == false ? "Mark as Completed" : "Unmark completion")
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                    onPressed: (){
                      print("Item $itemList will be deleted");
                      var item = {
                        "action":1,
                        "index":itemList,
                      };
                      Navigator.pop(context,item);
                    },
                    child: Text("Delete the Item",)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

