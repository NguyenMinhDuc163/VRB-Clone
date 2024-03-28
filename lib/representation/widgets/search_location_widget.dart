import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/dialog_provider.dart';

class SearchLocationWidget extends SearchDelegate{


  List<String> searchTerms ;
  Function(String) onSelect;
  late FocusNode _focusNode;
  SearchLocationWidget({required this.searchTerms, required this.onSelect}){
    _focusNode = FocusNode();
  }


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
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
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
            onTap: () async {
              // Gọi hàm callback khi người dùng chọn một từ
              onSelect(res);
              // Đóng SearchLocationWidget và trả về từ đã chọn
              close(context, res);
            },
            child: ListTile(
              title: (mathQuery.isEmpty) ? Center(child: Text('Không có dữ liệu'),) : Text(res),
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
              // Gọi hàm callback khi người dùng chọn một từ
              onSelect(res);
              // Đóng SearchLocationWidget và trả về từ đã chọn
              close(context, res);
            },
            child: ListTile(
              title: (mathQuery.isEmpty) ? Center(child: Text('Không có dữ liệu'),) : Text(res),
            ),
          );
        });
  }
}