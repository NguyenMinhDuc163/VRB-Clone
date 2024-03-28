import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("search"),
      actions: [
        IconButton(onPressed: (){
          showSearch(context: context, delegate: CustomSearchDelegate());
        }, icon: Icon(Icons.search))
      ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate{

  List<String> searchTerms = [
    'Apple',
    'Banana',
    'pear',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> mathQuery = [];
    for(var x in searchTerms){
      if(x.toLowerCase().contains(query.toLowerCase())){
        mathQuery.add(x);
      }
    }
    return ListView.builder(
        itemCount: mathQuery.length,
        itemBuilder: (context, index){
      var res = mathQuery[index];
      return InkWell(
        onTap: () {
          // Thực hiện hành động bạn muốn khi từ được nhấn
          print('Từ được nhấn: $res');
        },
        child: ListTile(
          title: Text(res),
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> mathQuery = [];
    for(var x in searchTerms){
      if(x.toLowerCase().contains(query.toLowerCase())){
        mathQuery.add(x);
      }
    }
    return ListView.builder(
        itemCount: mathQuery.length,
        itemBuilder: (context, index){
          var res = mathQuery[index];
          return InkWell(
            onTap: () {
              // Thực hiện hành động bạn muốn khi từ được nhấn
              print('Từ được nhấn: $res');
            },
            child: ListTile(
              title: Text(res),
            ),
          );
        });
  }
}
