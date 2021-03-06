import 'package:clean_achitecture/LocalStoreKey.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/common/config.dart';
import 'package:clean_achitecture/features/account/data/profileAPI.dart';
import 'package:clean_achitecture/features/sigin_signup/model/user.dart';
import 'package:clean_achitecture/routes/route_name.dart';
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
  final LocalStorage storage = new LocalStorage(keyLocalStore);
  User userModel = User();
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      String token = storage.getItem(LocalStoreKey.tokenUser);
      userModel = await profileAPI.getProfileAPI(token);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBarColor,
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
                  "T??i Kho???n",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(right: 20, top: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: <Widget>[
                // CustomImage(
                //   // profile["image"]!,
                //   'assets/images/avt.jpg',
                //   width: 80,
                //   height: 80,
                //   radius: 50,
                // ),
                CircleAvatar(
                  backgroundColor: CupertinoColors.systemGrey3,
                  radius: 80,
                  child: CircleAvatar(
                    backgroundColor: CupertinoColors.systemGrey,
                    radius: 75,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/avt.jpg"), //NetworkImage
                      radius: 100,
                    ), //CircleAvatar
                  ), //CircleAvatar
                ),

                SizedBox(
                  height: 12,
                ),
                _infoSection(),
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
              title: "C??i ?????t",
              leadingIcon: Icons.settings,
              leadingIconColor: orange,
              onTap: () {}),
          SizedBox(height: 10),
          SettingItem(
              title: "Ph??ng ???? ????ng",
              leadingIcon: Icons.bookmark_border,
              leadingIconColor: blue,
              onTap: () {
                Navigator.pushNamed(context, RouteName.MyRoomPage);
              }),
          SizedBox(height: 10),
          SettingItem(
              title: "Ph??ng ???? l??u",
              leadingIcon: Icons.favorite,
              leadingIconColor: red,
              onTap: () {
                Navigator.pushNamed(context, RouteName.savedRoomPage);
              }),
          SizedBox(height: 10),
          // SettingItem(
          //     title: "Privacy",
          //     leadingIcon: Icons.privacy_tip_outlined,
          //     leadingIconColor: green,
          //     onTap: () {}),
          SizedBox(height: 10),
          SettingItem(
            title: "????ng xu???t",
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
        message: Text("B???n c?? mu???n ????ng xu???t kh??ng?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              logout();
            },
            child: Text(
              "????ng xu???t",
              style: TextStyle(color: actionColor),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Hu???"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  logout() {
    storage.deleteItem(LocalStoreKey.keyStore).then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.loginPage, (Route<dynamic> route) => false);
    });
  }

  Column _infoCell({required String title, required String value}) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w300,
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Row _infoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _infoCell(
          title: 'N??m sinh',
          value:
              userModel.birthday == null ? '' : userModel.birthday.toString(),
        ),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey,
        ),
        _infoCell(
          title: 'T??n',
          value: userModel.name == null ? '' : userModel.name.toString(),
        ),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey,
        ),
        _infoCell(
          title: '?????a ch???',
          value: userModel.address == null ? '' : userModel.address.toString(),
        ),
      ],
    );
  }
}
