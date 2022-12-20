import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//list for todo
  List todo = <dynamic> [];

  @override
  void initState(){
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do"),
      ),
      body: ListView.builder(
        itemCount: todo.length,
        itemBuilder: (context, index){
          final item = todo[index] as Map;
          return Dismissible(
            key: ValueKey(item[index]),
            background: slideLeftBackground(),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                final bool res = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "Delete Todo ${todo[index]['title']}?"),
                        actions: <Widget>[
                          FloatingActionButton(
                            child: const Icon(
                              Icons.check,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                todo.removeAt(index);
                              }
                              );
                              Navigator.of(context).pop();
                            },
                          ),

                        ],
                      );
                    }
                );
                return res;
              } else {
                setState(() {
                  (item);
                }
                );
              }
              return null;
            },
            //Number and title
            child: ListTile(
                leading: Text('${index + 1}'),
                title: Text(todo[index]['title'],
                  style : const TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(todo[index]['body']),

            ),
          );
        },
      ),

    );
  }
  //Delete 
  Future<void> deleteTodo(String id) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      final filtered = todo.where((e) => e['_id'] != id).toList();
      setState(() {
        todo = filtered;
      }
      );
    }
    getTodos();
  }
//Get 
  Future <void> getTodos() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    setState(() {
      todo = convert.jsonDecode(response.body) as List;
    }
    );
  }
//For Delete slide
  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.delete,
              color: Colors.black,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

}
