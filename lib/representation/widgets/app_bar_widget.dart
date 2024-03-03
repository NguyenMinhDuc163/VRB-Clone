import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/representation/widgets/search_widget.dart';

import '../../core/constants/assets_path.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {super.key,
      required this.fullName,
      required this.avatar,
      required this.child});
  final String fullName;
  final Image avatar;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              height: size.height / 2.8,
              child: AppBar(
                flexibleSpace: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF19226D).withOpacity(0.9),
                          Color(0xFFED1C24).withOpacity(0.8),
                        ],
                        stops: [0.5, 1],
                      )),
                    ),
                    Positioned(
                      right: 0,
                      child: Image.asset(AssetPath.icoBlockWhite,
                          color: Colors.grey.withOpacity(0.3)),
                    ),

                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        AssetPath.hv,
                        width: double
                            .infinity, // Đặt chiều rộng của hình ảnh là đủ rộng để tràn hết container
                        height: size.height / 3.2, fit: BoxFit.fill,
                      ),
                    ),

                    Positioned(
                      child: Row(
                        children: [
                          Image.asset(AssetPath.logoBankVRB),
                          Spacer(),
                          SizedBox(
                            width: size.width * 0.57,
                            child: SearchWidget(),
                          )

                          // Spacer(),
                          // SearchWidget()
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Chào buổi sáng",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            fullName,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          avatar
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height / 3),
            padding: const EdgeInsets.all(10),
            child: child,
          )
        ],
      ),
    );
  }
}
