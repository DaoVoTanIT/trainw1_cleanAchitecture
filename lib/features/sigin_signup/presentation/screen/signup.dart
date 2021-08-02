import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  // final Function toggle;
  // SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text('Chat with me')),
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Spacer(),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) {
                    return val!.trim().isEmpty || val.length < 4
                        ? 'Tên không hợp lệ'
                        : null;
                  },
                  controller: userNameTextEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.account_box_sharp),
                      hintText: 'Username'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                        ? null
                        : "Email không hợp lệ";
                  },
                  controller: emailTextEditingController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _isObscure, //ma hoa password
                  validator: (val) {
                    return val!.trim().length > 6
                        ? null
                        : "Nhập mật khẩu từ 6 ký tự trở lên";
                  },
                  controller: passwordTextEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.vpn_key),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      hintText: 'Password'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              //signIn();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange,
                      Colors.red,
                    ],
                  )),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Sign Up",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have account? ",
                // style: simpleTextStyle(),
              ),
              GestureDetector(
                onTap: () {
                  //widget.toggle();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Sign In now",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ],
      ),
    ));
  }
}
