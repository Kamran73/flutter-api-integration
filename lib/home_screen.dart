import 'dart:convert';

import 'package:api_integration/models/PostsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {



    List<PostsModel> list = [];

    Future<List<PostsModel>> getDataApi () async{
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var posts = jsonDecode(response.body.toString());
      if(response.statusCode == 200){
        for(Map i in posts){
          list.add(PostsModel.fromJson(i));
        }
        return list;
      }
      else{
        return list;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('api integration'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDataApi(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return const Text('loading');
                }
                else {
                  return ListView.builder(itemBuilder: (context, index){
                    return Padding(
                      padding:const  EdgeInsets.all(10),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, ),),
                            const SizedBox(height: 5,),
                            Text(list[index].title.toString()),
                            const SizedBox(height: 5,),
                            const Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, ),),
                            const SizedBox(height: 5,),
                            Text(list[index].body.toString()),

                          ],
                        ),
                      ),
                    );
                  },
                    itemCount: list.length,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
