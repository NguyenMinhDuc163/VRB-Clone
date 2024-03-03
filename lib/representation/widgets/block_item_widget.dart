import 'package:flutter/cupertino.dart';
import 'package:vrb_client/core/constants/assets_path.dart';

class BlockItemWidget extends StatelessWidget {
  const BlockItemWidget(
      {super.key, required this.description, required this.iconInner});
  final String iconInner;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
                width: 85,
                height: 85,
                child: Image.asset(AssetPath.icoRectangleFull)
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 10,
              child: Image.asset(iconInner),
            ),
          ],
        ),

        SizedBox(
          width: 102,
          height: 40,
          child: Text(
            description,
            style: const TextStyle(fontSize: 14),
            // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2
          ),

        )
      ],
    );
  }
}
