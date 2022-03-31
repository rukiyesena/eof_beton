import 'package:android_std/constants/Theme.dart';
import 'package:android_std/models/UserModel.dart';
import 'package:android_std/page/ebisIstekler.dart';
import 'package:android_std/page/kit.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  final String currentPage;

  NavigationDrawerWidget({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blur-bg-mobile.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        //color: NowUIColors.primary,

        child: ListView(
          children: <Widget>[
            Selector<UserModel, String>(
              builder: (context, username, child) {
                return buildHeader(
                  logoImage: "assets/images/eof-logo-beyaz.png",
                  name: "$username",
                  /*  onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserPage(
                    name: 'Sarah Abs',
                    urlImage: urlImage,
                  ),
                )),*/
                );
              },
              selector: (context, model) => model.username,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  Divider(color: Colors.white70),
                  const SizedBox(height: 20),
                  buildMenuItem(
                    text: 'QR Form',
                    icon: Icons.device_hub,
                    onClicked: () => selectedItem(context, 0),
                    iconColor: Colors.deepOrange,
                    isSelected: currentPage == "QR Form" ? true : false,
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'EBIS İstekler',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 1),
                    iconColor: Colors.deepOrange,
                    isSelected: currentPage == "EBIS İstekler" ? true : false,
                  ),
                  const SizedBox(height: 16),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
    required bool isSelected,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
          margin: EdgeInsets.only(top: 6),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: isSelected
                        ? NowUIColors.black.withOpacity(0.07)
                        : Colors.transparent,
                    offset: Offset(0, 0.5),
                    spreadRadius: 3,
                    blurRadius: 10)
              ],
              color:
                  isSelected ? NowUIColors.primaryWhite : Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(54))),
          child: Row(
            children: [
              Icon(icon,
                  size: 18,
                  color: isSelected
                      ? NowUIColors.primary
                      : NowUIColors.white.withOpacity(0.6)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(text,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? NowUIColors.primary
                            : NowUIColors.white.withOpacity(0.8))),
              )
            ],
          )),
    );
  }

  Widget buildHeader({
    required String logoImage,
    required String name,

    //  required VoidCallback onClicked,
  }) =>
      InkWell(
          // onTap: onClicked,

          child: Column(
        children: [
          SizedBox(height: 30,),
          Container(
            //padding: padding.add(EdgeInsets.only(left:5)),
            color: Colors.white.withOpacity(0.4),
            height: 55,
            width: double.infinity,
            alignment: Alignment.center,
            child: Image.asset(logoImage),
          ),
          Padding(
            padding:
                padding.add(EdgeInsets.only(right: 20, bottom: 20, top: 20)),
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: NowUIColors.info.withOpacity(0.7),
                    radius: 25,
                    child: Text(
                      '${name[0].toUpperCase()}${name.characters.take(0)}',
                      style: TextStyle(fontSize: 25, color: NowUIColors.white),
                    )),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ));

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Kit(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EbisIstekler(),
        ));
        break;
    }
  }
}
