import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/search_location_widget.dart';

class SearchLocalScreen extends StatefulWidget {
  const SearchLocalScreen({super.key, required this.searchTerms, required this.onTap});
  final List<String> searchTerms;
  final Function(String) onTap;
  @override
  State<SearchLocalScreen> createState() => _SearchLocalScreenState();
}

class _SearchLocalScreenState extends State<SearchLocalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search"),
      actions: [
        IconButton(onPressed: (){
          print(widget.searchTerms);
          showSearch(context: context, delegate: SearchLocationWidget(searchTerms: widget.searchTerms, onSelect: widget.onTap));
        }, icon: Icon(Icons.search))
        ],

      ),
    );
  }
}
