import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/Theme/theme.dart';
import 'package:clean_achitecture/features/sigin_signup/data/signupAPI.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String username;
  late String inputPassword;
  late String inputConfirmPassword;

  TextEditingController usernameEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController passwordConfirmEditingController =
      new TextEditingController();

  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController phoneNumberEditingController =
      new TextEditingController();
  bool _isObscure = true;
  bool isLoading = false;
  SignUpAPI signUpAPI = SignUpAPI();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login Demo'),
      // ),
      body: Center(
        child: _buildForm(),
      ),
    );
  }

  _buildForm() {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                        "Vui lòng đăng kí để sử dụng dịch vụ",
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
                            height: 10,
                          ),
                          TextFormField(
                            controller: nameEditingController,
                            onChanged: (value) {
                              username = value;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.people),
                                hintText: "Tên đăng nhập",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // TextFormField(
                          //   keyboardType: TextInputType.number,
                          //   controller: phoneNumberEditingController,
                          //   decoration: InputDecoration(
                          //       prefixIcon: Icon(Icons.phone),
                          //       hintText: "Số điện thoại",
                          //       border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10))),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          TextFormField(
                            obscureText: _isObscure,
                            validator: (val) {
                              return val!.trim().length >= 6
                                  ? null
                                  : "Mật khẩu phải trên 6 kí tự";
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
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: _isObscure,
                            validator: (val) {
                              // return val!.trim().length >= 6
                              //     ? null
                              //     : "Mật khẩu phải trên 6 kí tự";
                              if (inputPassword != inputConfirmPassword) {
                                return "Không trùng mật khẩu";
                              }
                            },
                            onChanged: (value) {
                              inputConfirmPassword = value;
                            },
                            controller: passwordConfirmEditingController,
                            decoration: InputDecoration(
                                hintText: 'Nhập lại mật khẩu',
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
                                if (_formKey.currentState!.validate() &&
                                    inputPassword == inputConfirmPassword) {
                                  await signUpAPI
                                      .createAccountAPI(username, inputPassword)
                                      .then((value) {
                                    if (value == true) {
                                      ArtSweetAlert.show(
                                          context: context,
                                          artDialogArgs: ArtDialogArgs(
                                              sizeSuccessIcon: 70,
                                              type: ArtSweetAlertType.success,
                                              title:
                                                  "Đăng kí tài thành công. Bạn có thể đăng nhập!"));
                                      return;
                                    }
                                  });
                                }
                              },
                              child: Text(
                                'Đăng kí',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Text('Điều khoản và chính sách')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
