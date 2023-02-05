import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/UserModel.dart';
class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {

  List<UserModel> users = [];
  
  Future<List<UserModel>> getDataApi() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        users.add(UserModel.fromJson(i));
      }
      return users;
    }
    else {
      return users;
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('complex json data'), centerTitle: true,),
      body: Column(
        children: const [
          
        ],
      ),
    );
  }
}
