import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remove_diacritic/remove_diacritic.dart';

import '../../../core/constants/assets_path.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../generated/locale_keys.g.dart';

class SearchBankScreen extends StatefulWidget {
  const SearchBankScreen({super.key, required this.searchTerms, required this.titleField});
  static const String routeName = '/search_bank_screen';
  final List<String> searchTerms;
  final String titleField;

  @override
  State<SearchBankScreen> createState() => _SearchBankScreenState();
}

class _SearchBankScreenState extends State<SearchBankScreen> {
  final List<String> imagePaths = [
    AssetPath.logoBank1,
    AssetPath.logoBank2,
    AssetPath.logoBank3,
    AssetPath.logoBank4,
    AssetPath.logoBank5,
    AssetPath.logoBank6,
    AssetPath.logoBank1,
    AssetPath.logoBank2,
    AssetPath.logoBank3,
    AssetPath.logoBank4,
    AssetPath.logoBank5,
    AssetPath.logoBank6,
  ];
  final List<String> listNameBank = [
    'Vietcombank',
    'Tiên phong bank',
    'VP bank',
    'Vietinbank',
    'Tecombank',
    'Agribank',
    'Vietcombank',
    'Tiên phong bank',
    'VP bank',
    'Vietinbank',
    'Tecombank',
    'Agribank',
  ];

  final List<String> bankDescription = [
    'Ngân hàng  TMCP Ngoại thương Việt Nam',
    'Ngân hàng Thương mại Cổ phần Tiên Phong',
    'Ngân Hàng TMCP Việt Nam Thịnh Vượng',
    'Ngân hàng Thương mại Cổ phần Công thương Việt Nam',
    'Ngân hàng  TMCP Ngoại thương Việt Nam',
    'Ngân hàng TMCP Kỹ thương Việt Nam',
    'Ngân hàng Nông nghiệp và Phát triển nông thôn Việt nam',
    'Ngân hàng  TMCP Ngoại thương Việt Nam',
    'Ngân hàng Thương mại Cổ phần Tiên Phong',
    'Ngân Hàng TMCP Việt Nam Thịnh Vượng',
    'Ngân hàng Thương mại Cổ phần Công thương Việt Nam',
    'Ngân hàng  TMCP Ngoại thương Việt Nam',
    'Ngân hàng TMCP Kỹ thương Việt Nam',
    'Ngân hàng Nông nghiệp và Phát triển nông thôn Việt nam',
  ];


  final TextEditingController _searchController = TextEditingController();
  bool isSearchClicked = false;
  String searchText = '';
  List<String> filteredItems = [];

  Future<bool> _onWillPop() async {
    Navigator.pop(context,widget.titleField);
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    myFilterItems();
    super.initState();
  }
  void myFilterItems() {
    if (searchText.isEmpty) {
      //TODO doi co data
      // filteredItems = List.from(widget.searchTerms);
      filteredItems = List.from(listNameBank);
    } else {
      String textChoose = removeDiacritics(searchText);
      // filteredItems = widget.searchTerms
      filteredItems = listNameBank
          .where(
              (item) => (removeDiacritics(item.toLowerCase()).contains(textChoose.toLowerCase())
              || item.toLowerCase().contains(textChoose.toLowerCase() )))
          .toList();
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
      myFilterItems();
    });
  }

  Widget _buildSearch() {
    return Container(
      height: 40,
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
          hintText: 'Nhập tên ngân hàng',
          hintStyle: TextStyle(fontSize: 18),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        contentPadding: EdgeInsets.symmetric(vertical: 5),
      ),
    ));
  }

  void _onItemTapped(String selectedItem) {
    Navigator.pop(context, selectedItem); // Trả về giá trị đã chọn khi quay lại màn hình trước
  }

  Widget _buildItemBank(int index) {
    String bankName = filteredItems[index];
    int bankIndex = listNameBank.indexOf(bankName);
    String imagePath = imagePaths[bankIndex];
    String description = bankDescription[bankIndex];

    return Row(
      children: [
        Image.asset(imagePath, width: 50, height: 50), // Chỉnh sửa kích thước ảnh nếu cần
        SizedBox(width: 10), // Khoảng cách giữa ảnh và chữ
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bankName, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(description),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        behavior: HitTestBehavior
            .translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
        onTap: () {
          // Khi bên ngoài form được chạm, ẩn bàn phím bằng cách mất trọng tâm
          FocusScope.of(context).requestFocus(FocusNode());
        },
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
                          onTap: _onWillPop,
                          child: const Icon(FontAwesomeIcons.xmark),
                        ),
                      )
                    ],
                  ),
                ),
                _buildSearch(),
                Expanded(
                  child: SingleChildScrollView(
                    child:
                    // (filteredItems.isEmpty || widget.searchTerms.isEmpty)
                    (filteredItems.isEmpty || listNameBank.isEmpty)
                        ?  Center(child: Text(LocaleKeys.notFoundData.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),)
                        :ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredItems[index], style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(bankDescription[index]),
                          leading: SizedBox(
                              width: 50, height: 50,
                              child: Image.asset(imagePaths[index])),
                          // title: _buildItemBank(index),
                          // leading: _buildItemBank(index),
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
      ),
    );

  }
}
