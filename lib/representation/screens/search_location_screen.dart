import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:remove_diacritic/remove_diacritic.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';

import '../../provider/dialog_provider.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key, required this.searchTerms, required this.titleField});
  static const String routeName = '/search_location_screen';
  final List<String> searchTerms;
  final String titleField;
  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearchClicked = false;
  String searchText = '';

  List<String> filteredItems = [];
  @override
  void initState() {
    super.initState();
    filteredItems = List.from(widget.searchTerms);
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
      myFilterItems();
    });
  }

  void myFilterItems() {
    if (searchText.isEmpty) {
      filteredItems = List.from(widget.searchTerms);
    } else {
      String textChoose = removeDiacritics(searchText);
      filteredItems = widget.searchTerms
          .where(
              (item) => (removeDiacritics(item.toLowerCase()).contains(textChoose.toLowerCase())
                  || item.toLowerCase().contains(textChoose.toLowerCase() )))
          .toList();
    }
  }
  Future<bool> _onWillPop() async {
    Navigator.pop(context, widget.titleField);
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.titleField,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, widget.titleField);
                        },
                        child: const Icon(FontAwesomeIcons.xmark),
                      ),
                    )
                  ],
                ),
              ),
              _buildSearch(),
              Expanded(
                child: SingleChildScrollView(
                  child: (filteredItems.isEmpty || widget.searchTerms.isEmpty)
                      ? const Center(child: Text(LocaleKeys.notFoundData, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),)
                      :ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItems[index]),
                        onTap: () {
                          _onItemTapped(filteredItems[index]); // Gọi hàm khi một mục được chọn
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(String selectedItem) {
    Navigator.pop(context, selectedItem); // Trả về giá trị đã chọn khi quay lại màn hình trước
  }


  Widget _buildSearch() {

    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade100,
        // thay doi mau vien
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: const InputDecoration(
          hintText: LocaleKeys.searchLocal,
          hintStyle: TextStyle(fontSize: 18),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: 12.0), ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
