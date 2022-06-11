import 'package:clean_achitecture/LocalStoreKey.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/common/config.dart';
import 'package:clean_achitecture/features/account/data/profileAPI.dart';
import 'package:clean_achitecture/features/account/presentation/widget/custom_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../widget/setting_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileAPI profileAPI = ProfileAPI();
  String name = '';
  final LocalStorage storage = new LocalStorage(keyLocalStore);

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      String token = storage.getItem(LocalStoreKey.tokenUser);
      name = await profileAPI.getProfileAPI(token);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // return CupertinoPageScaffold(
    //     backgroundColor: CupertinoColors.systemGrey,
    //     navigationBar: CupertinoNavigationBar(
    //       leading: Row(
    //         children: [
    //           GestureDetector(
    //             child: Row(
    //               children: [
    //                 Icon(
    //                   CupertinoIcons.back,
    //                   color: CupertinoColors.activeBlue,
    //                   size: 25,
    //                 ),
    //                 Text(
    //                   "Danh mục",
    //                   style: TextStyle(
    //                       color: CupertinoColors.activeBlue, fontSize: 16),
    //                 ),
    //               ],
    //             ),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //         ],
    //       ),
    //       middle: Text(
    //         "Tài khoản",
    //         style: TextStyle(
    //           fontSize: 16,
    //         ),
    //       ),
    //       trailing: GestureDetector(
    //           onTap: () {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => FliterScreen(),
    //     settings: RouteSettings(
    //       arguments: listRoom,
    //     ),
    //   ),
    // ).then((value) => {
    //       if (value != null)
    //         {
    //           setState(() {
    //             listRoom = value;
    //           })
    //         }
    //       else
    //         {getListRoom()}
    //     });
    //           },
    //           child: Icon(
    //             Icons.filter_alt_outlined,
    //             size: 26,
    //             color: CupertinoColors.activeBlue,
    //           )),
    //     ),
    //     child: buildBody());
    return Scaffold(
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              // backgroundColor: appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: getAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => buildBody(),
                childCount: 1,
              ),
            )
          ],
        ));
  }

  Widget getAppBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tài Khoản",
                  style: TextStyle(
                      color: CupertinoColors.activeBlue,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          // IconBox(
          //   child: SvgPicture.asset(
          //     "assets/icons/edit.svg",
          //     width: 18,
          //     height: 18,
          //   ),
          //   bgColor: appBgColor,
          // ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 20, top: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: <Widget>[
                CustomImage(
                  // profile["image"]!,
                  'assets/images/avt.jpg',
                  width: 80,
                  height: 80,
                  radius: 50,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  name,
                  style: TextStyle(
                    //color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // Text(
                //   "+12 345 6789",
                //   style: TextStyle(
                //     //color: labelColor,
                //     fontSize: 14,
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 40),
          SettingItem(
              title: "General Setting",
              leadingIcon: Icons.settings,
              leadingIconColor: orange,
              onTap: () {}),
          SizedBox(height: 10),
          SettingItem(
              title: "Bookings",
              leadingIcon: Icons.bookmark_border,
              leadingIconColor: blue,
              onTap: () {}),
          SizedBox(height: 10),
          SettingItem(
              title: "Favorites",
              leadingIcon: Icons.favorite,
              leadingIconColor: red,
              onTap: () {}),
          SizedBox(height: 10),
          SettingItem(
              title: "Privacy",
              leadingIcon: Icons.privacy_tip_outlined,
              leadingIconColor: green,
              onTap: () {}),
          SizedBox(height: 10),
          SettingItem(
            title: "Log Out",
            leadingIcon: Icons.logout_outlined,
            leadingIconColor: Colors.grey.shade400,
            onTap: () {
              showConfirmLogout();
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  showConfirmLogout() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text("Would you like to log out?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: Text(
              "Log Out",
              style: TextStyle(color: actionColor),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
