import 'package:flutter/cupertino.dart';

import 'address_form_widget.dart';

class LocationBranchWidget extends StatelessWidget {
  const LocationBranchWidget({super.key, required this.addressList});
  final List<AddressFormWidget> addressList;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: addressList,
    );
  }
}
