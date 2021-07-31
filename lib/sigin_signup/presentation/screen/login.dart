import 'package:clean_achitecture/sigin_signup/data/service/auth.dart';
import 'package:clean_achitecture/sigin_signup/presentation/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  // final Function toggleView;
  // SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool isLoading = false;
  // signIn() async {
  //   if (formKey.currentState!.validate()) {
  //     HelpFunction.saveUserEmailSharedPreference(emailEditingController.text);
  //      database.getUserInfo(emailEditingController.text).then((value) {
  //       userInfoSnapshot = value;
  //       HelpFunction.saveUserEmailSharedPreference(
  //           userInfoSnapshot.docs[0]["name"]);
  //     });
  //     setState(() {
  //       isLoading = true;
  //     });
  //     print("Email: ${emailEditingController.text}");
  //     print("Password: ${passwordEditingController.text}");

  //     authService
  //         .signInWithEmailAndPassword(
  //             emailEditingController.text, passwordEditingController.text)
  //         .then((result) {
  //       if (result != null) {
  //         HelpFunction.saveUserLoggedInSharedPreference(true);
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => ChatRoom()));
  //       }
  //     });
  //   }
  //   else {
  //     setState(() {
  //       isLoading = false;
  //       //show snackbar
  //     });
  //   }
  // }

//  signIn() async {
//     if (formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//       });
//       await authService
//           .signInWithEmailAndPassword(
//               emailEditingController.text, passwordEditingController.text)
//           .then((result) async {
//         if (result != null)  {
//           QuerySnapshot userInfoSnapshot =
//               await DatabaseMethods().getUserInfo(emailEditingController.text);

//           HelpFunction.saveUserLoggedInSharedPreference(true);
//           HelpFunction.saveUserNameSharedPreference(
//               userInfoSnapshot.docs[0]["name"]);
//           HelpFunction.saveUserEmailSharedPreference(
//               userInfoSnapshot.docs[0]["email"]);
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => ChatRoom()));
//         } else {
//           setState(() {
//             isLoading = false;
//             //show snackbar
//           });
//         }
//       });
//     }
//   }
  // signIn() async {
  //   if (formKey.currentState!.validate()) {
  //     HelpFunction.saveUserNameSharedPreference(emailEditingController.text);
  //     setState(() {
  //       isLoading = true;
  //     });
  //     database.getUserInfo(emailEditingController.text).then((value) {
  //       print(emailEditingController.text);
  //       userInfoSnapshot = value;
  //       HelpFunction.saveUserEmailSharedPreference(
  //           userInfoSnapshot.docs[0]["name"]);
  //     });
  //     authService
  //         .signInWithEmailAndPassword(
  //             emailEditingController.text, passwordEditingController.text)
  //         .then((value) {
  //       // if (value != null) {
  //       //   print('ket quaaaaaaaaaa: $value');
  //       HelpFunction.saveUserLoggedInSharedPreference(true);
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => ChatRoom()
  //               //ChatsScreen(),
  //               ));
  //       //}
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please Enter Correct Email";
                          },
                          controller: emailEditingController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          validator: (val) {
                            return val!.trim().length > 6
                                ? null
                                : "Enter Password 6+ characters";
                          },
                          controller: passwordEditingController,
                          decoration: InputDecoration(
                              hintText: 'Password',
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
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
                        "Sign In",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ForgotPassword()));
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "Forgot Password?",
                            )),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account? ",
                      ),
                      GestureDetector(
                        onTap: () {
                          // widget.toggleView();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
    );
  }
}
