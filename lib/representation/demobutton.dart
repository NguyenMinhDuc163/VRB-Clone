import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> data;
  TextEditingController queryTextController = TextEditingController();
  CustomSearchDelegate({required this.data});

  @override
  Widget buildSearchField(BuildContext context) {
    return TextField(
      controller: queryTextController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Nhập từ khóa tìm kiếm', // Văn bản mặc định
        border: OutlineInputBorder(), // Border cho thanh tìm kiếm
      ),
      style: TextStyle(
        color: Colors.black, // Màu sắc văn bản
        fontSize: 16.0, // Kích thước văn bản
      ),
      onChanged: (value) {
        query = value;
      },
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon ở bên trái của thanh tìm kiếm để quay lại
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Các hành động trong thanh tìm kiếm (ví dụ: xóa nội dung)
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    // Kết quả tìm kiếm dựa trên query
    final List<String> results = data.where((element) => element.contains(query)).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Gợi ý tìm kiếm dựa trên query
    final List<String> suggestions = data.where((element) => element.contains(query)).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Thanh tìm kiếm được tùy chỉnh với một nút trên cùng
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            close(context, "null");
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Xử lý khi nhấn vào nút tùy chỉnh
              print('Custom action');
            },
            icon: Icon(Icons.settings),
          ),
        ],
        title: TextField(
          controller: query.isEmpty ? null : TextEditingController(text: query),
          onChanged: (value) {
            query = value;
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: buildSuggestions(context),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> data = [
    'Apple',
    'Banana',
    'Orange',
    'Pineapple',
    'Grapes',
    'Watermelon',
    'Mango',
    'Strawberry',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Search Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            openSearch(context, data);
          },
          child: Text('Open Search'),
        ),
      ),
    );
  }
}

void openSearch(BuildContext context, List<String> data) async {
  final String? selectedResult = await showSearch<String>(
    context: context,
    delegate: CustomSearchDelegate(data: data),
  );

  if (selectedResult != null) {
    // Xử lý khi một kết quả được chọn
    print('Selected result: $selectedResult');
  }
}
