import 'dart:convert';

import 'package:api_calling/map_demo.dart';
import 'package:api_calling/second_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
void main() {
  runApp(MaterialApp(
    home: map_demo(),
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  List l = [];
  bool status = false;

  @override
  void initState() {
    super.initState();
    //getdata();
    diogetdata();
  }

  getdata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    l = jsonDecode(response.body);
    setState(() {
      status= true;
    });
  }

diogetdata()
async {
  Response response;
  var dio = Dio();
  response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
  print(response.data.toString());
  l=response.data;
  setState(() {
    status=true;
  });
  return l;

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("API Calling"),
        ),
        body: status
            ? ListView.builder(
                itemCount: l.length,
                itemBuilder: (context, index) {
                  demo1 m = demo1.fromJson(l[index]);
                  return /*ListTile(
                    leading: Text("${m.id}"),
                    title: Text("${m.title}"),
                    subtitle: Text("${m.body}"),
                  );*/
                  Card(elevation: 10,
                  shadowColor: Colors.grey,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Text("${m.id}"),
                      title: Text("${m.title}"),
                      subtitle: Text("${m.body}",overflow: TextOverflow.ellipsis,),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()));
  }
}

class demo1 {
  int? userId;
  int? id;
  String? title;
  String? body;

  demo1({this.userId, this.id, this.title, this.body});

  demo1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
