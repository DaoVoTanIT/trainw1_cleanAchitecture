import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:clean_achitecture/LocalStoreKey.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/Theme/theme.dart';
import 'package:clean_achitecture/common/Config.dart';
import 'package:clean_achitecture/common/DioClientInit.dart';
import 'package:clean_achitecture/features/Loading/LoadingPage.dart';
import 'package:clean_achitecture/features/sigin_signup/data/loginAPI.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/widget/Loading_widget.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localstorage/localstorage.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String inputLogin;
  late String inputPassword;
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  bool _isObscure = true;
  bool isLoading = false;
  LoginAPI loginAPI = LoginAPI();
  late Dio dio;
  bool loading = false;

  final LocalStorage storage = new LocalStorage(keyLocalStore);
  String token = '';
  void initState() {
    super.initState();
    dio = createDioClientNoAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: _buildForm(),
    //   ),
    // );
    if (loading == true) return LoadingPage();

    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == true) {
          return _buildForm();
        } else {
          return LoadingPage();
        }
      },
    );
  }

  _buildForm() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            //scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/logo.png",
                            color: kBlueColor,
                            width: 70,
                            height: 60,
                            fit: BoxFit.fill),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TKPT",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              "Tìm kiếm phòng trọ",
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Xin chào",
                        style: TextStyles.headline4,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Vui lòng đăng nhập để sử dụng dịch vụ",
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            // validator: (val) {
                            //   return RegExp(
                            //               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            //           .hasMatch(val!)
                            //       ? null
                            //       : "Please Enter Correct Email";
                            // },
                            onChanged: (value) {
                              inputLogin = value;
                            },
                            controller: emailEditingController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.people),
                                hintText: "Tên đăng nhập",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: _isObscure,
                            validator: (val) {
                              return val!.trim().length >= 6
                                  ? null
                                  : "Enter Password 6+ characters";
                            },
                            onChanged: (value) {
                              inputPassword = value;
                            },
                            controller: passwordEditingController,
                            decoration: InputDecoration(
                                hintText: 'Mật khẩu',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                suffixIcon: IconButton(
                                    icon: Icon(_isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    }),
                                prefixIcon: Icon(Icons.vpn_key)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Text('Bạn quên tài khoản?')),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.lightBlueAccent),
                            child: Center(
                                child: FlatButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // try {
                                  //   String token =
                                  //       await loginAPI.authenticateAPI(
                                  //           inputLogin, inputPassword);
                                  //   if (token.isNotEmpty) {
                                  //     Navigator.pushNamed(context,
                                  //         RouteName.curvedNavigationBarWidget);
                                  //   }
                                  // } catch (e) {
                                  //   ArtSweetAlert.show(
                                  //       context: context,
                                  //       artDialogArgs: ArtDialogArgs(
                                  //           sizeSuccessIcon: 70,
                                  //           type: ArtSweetAlertType.danger,
                                  //           title:
                                  //               "Tài khoản không hợp lệ. Vui lòng thử lại"));
                                  //   return;
                                  // }
                                  _submitPhone();
                                }
                                // Navigator.pushNamed(
                                //     context, RouteName.homePage);
                              },
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue),
                        child: Center(
                            child: FlatButton.icon(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.facebook,
                              color: Colors.white),
                          label: Text(
                            'Facebook',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )),
                      )),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.red),
                          child: Center(
                              child: FlatButton.icon(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.google,
                                color: Colors.white),
                            label: Text(
                              ' Google',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bạn chưa có tài khoản?',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.signupPage);
                        },
                        child: Text(
                          ' Đăng kí ngay',
                          style: TextStyle(fontSize: 17.0, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<void> _submitPhone() async {
    setState(() {
      loading = true;
    });
    try {
      var result = await loginAPI.authenticateAPI(inputLogin, inputPassword);
      if (result == "") {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                sizeSuccessIcon: 70,
                type: ArtSweetAlertType.danger,
                title: "Tài khoản không hợp lệ. Vui lòng thử lại"));
        setState(() {
          loading = false;
        });
        return;
      } else {
        storage.setItem(LocalStoreKey.tokenUser, result);
        var test = storage.getItem(LocalStoreKey.tokenUser);
        print(test);
        try {
          Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.curvedNavigationBarWidget,
              (Route<dynamic> route) => false);
        } catch (e) {
          print(e);
        }
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              sizeSuccessIcon: 70,
              type: ArtSweetAlertType.danger,
              title: "Không truy cập được. Vui lòng thử lại"));
      return;
    }
  }
}
