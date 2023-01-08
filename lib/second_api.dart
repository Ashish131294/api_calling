import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class second_api extends StatefulWidget {
  const second_api({Key? key}) : super(key: key);

  @override
  State<second_api> createState() => _second_apiState();
}

class _second_apiState extends State<second_api> {

  List l=[];
  bool status=false;


  @override
  void initState() {
    super.initState();
    //httpgetdata();
    diogetdata();
  }

  httpgetdata()
  async {


    var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    l=jsonDecode(response.body);
    setState(() {
      status=true;
    });
  }

  diogetdata()
  async {
    Response response;
    var dio = Dio();
    response = await dio.get('https://jsonplaceholder.typicode.com/comments');
    print(response.data.toString());
    l=response.data;
    setState(() {
      status=true;
    });
return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body: status?ListView.builder(itemCount:l.length,itemBuilder: (context, index) {
      user m=user.fromJson(l[index]);
      return Card(elevation: 10,
      shadowColor: Colors.grey,
        margin: EdgeInsets.all(5),
        child: ListTile(
          leading: Text("${m.id}"),
          title: Text("${m.name}"),
          subtitle: Text("${m.email}",overflow: TextOverflow.ellipsis,),
        ),
      );
    },):Center(child: CircularProgressIndicator())
    );
  }
}

class user {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  user({this.postId, this.id, this.name, this.email, this.body});

  user.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}
