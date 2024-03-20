import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  var nameEditingController = TextEditingController();
  var descEditingController = TextEditingController();
  var placeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Page"),),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("Add Page"),
            TextField(
              decoration: InputDecoration(hintText: "Enter To-Do Item"),
              controller: nameEditingController,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Enter Description"),
              controller: descEditingController,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Enter Place"),
              controller: placeEditingController,
            ),
            ElevatedButton(
                onPressed: (){
                  print(nameEditingController.text);
                  print(descEditingController.text);
                  print(placeEditingController.text);

                  var newItem = {
                    "name" : nameEditingController.text,
                    "description" : descEditingController.text,
                    "place" : placeEditingController.text,
                    "completed" : false,
                  };

                  //newItem in Homepage 2 , add newItem after context
                  Navigator.pop(context, newItem);
                },
                child: Text("Add New Item"))
          ],
        ),
      ),
    );
  }
}
