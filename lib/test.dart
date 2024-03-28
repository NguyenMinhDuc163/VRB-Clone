import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearchClicked = false;
  String searchText = '';
  List<String> items = [
    'Items 1',
    'Messi',
    'Ronaldo',
    'Virat Kohli',
    '2',
    'Rock',
    'Elon Musk',
  ];

  List<String> filteredItems = [];
  @override
  void initState() {
    super.initState();
    filteredItems = List.from(items);
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
      myFilterItems();
    });
  }

  void myFilterItems() {
    if (searchText.isEmpty) {
      filteredItems = List.from(items);
    } else {
      filteredItems = items
          .where(
              (item) => item.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        /* if the search button is clickable then show
         the container otherwise text "Search Bar"*/
        title: isSearchClicked
            ? Container(
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200,
            // thay doi mau vien
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: const InputDecoration(
              hintText: 'Tìm kiếm',
              hintStyle: TextStyle(fontSize: 18),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 12.0), ),
          ),
        )
            : const Text("Search Bar"),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       setState(() {
        //         isSearchClicked = !isSearchClicked;
        //         if (!isSearchClicked) {
        //           _searchController.clear();
        //           myFilterItems();
        //         }
        //       });
        //     },
        //     icon: Icon(isSearchClicked ? Icons.close : Icons.search),
        //   )
        // ],
      ),
      // body parts
      body: ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredItems[index]),
            );
          }),
    );
  }
}
