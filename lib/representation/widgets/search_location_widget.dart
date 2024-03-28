import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../provider/dialog_provider.dart';
import 'package:remove_diacritic/remove_diacritic.dart';
class SearchLocationWidget extends SearchDelegate{


  List<String> searchTerms ;
  Function(String) onSelect;
  SearchLocationWidget({required this.searchTerms, required this.onSelect});


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: Icon(FontAwesomeIcons.deleteLeft))
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

    for(var item in searchTerms){
      if(removeDiacritics(item.toLowerCase()).contains(query.toLowerCase()) || item.toLowerCase().contains(query.toLowerCase() )){

        mathQuery.add(item);
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
              Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
              await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
              Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
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

    for(var item in searchTerms){
      if(removeDiacritics(item.toLowerCase()).contains(query.toLowerCase()) || item.toLowerCase().contains(query.toLowerCase() )){
        mathQuery.add(item);
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
              Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
              await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
              Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
              close(context, res);
            },
            child: ListTile(
              title: (mathQuery.isEmpty) ? Center(child: Text('Không có dữ liệu'),) : Text(res),
            ),
          );
        });
  }
}