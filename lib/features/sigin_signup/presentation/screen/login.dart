import 'package:clean_achitecture/features/sigin_signup/presentation/bloc/login_bloc.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/dto/login_dto.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/widget/Loading_widget.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _bloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String inputLogin;
  late String inputPassword;
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  bool _isObscure = true;
  bool isLoading = false;
  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _bloc = serviceLocator<LoginBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Demo'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ErrorLoggedState) {
            // final snackBar = SnackBar(content: Text('Invalid credentials...'));
            // Scaffold.of(context).showSnackBar(snackBar);
            Navigator.pushNamed(context, RouteName.homePage);
          } else if (state is LoggedState) {
            final snackBar = SnackBar(content: Text('User logged...'));
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, state) {
            if (state is LoginInitial) {
              return _buildForm();
            } else if (state is CheckLoginEvent) {
              return LoadingWidget();
            } else {
              return _buildForm();
            }
          },
        ),
      ),
    );
  }

  _buildForm() {
    return Form(
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
              validator: (val) {
                return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val!)
                    ? null
                    : "Please Enter Correct Email";
              },
              onChanged: (value) {
                inputLogin = value;
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
              onChanged: (value) {
                inputPassword = value;
              },
              controller: passwordEditingController,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
                  prefixIcon: Icon(Icons.vpn_key)),
            ),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     hintText: 'Enter the username',
            //     labelText: 'Username *',
            //   ),
            //   onChanged: (value) {
            //     inputLogin = value;
            //   },
            // ),
            // SizedBox(
            //   height: 30.0,
            // ),
            // TextFormField(
            //   obscureText: true,
            //   decoration: const InputDecoration(
            //     hintText: 'Enter the password',
            //     labelText: 'Password *',
            //   ),
            //   onChanged: (value) {
            //     inputPassword = value;
            //   },

            // ),
            SizedBox(
              height: 30.0,
            ),
            FlatButton(
              color: Colors.black12,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final loginDTO = LoginDTO(
                    username: inputLogin,
                    password: inputPassword,
                  );
                  _bloc.add(CheckLoginEvent(login: loginDTO));
                }
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}

//   // final Function toggleView;
//   // LoginPage(this.toggleView);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailEditingController = new TextEditingController();
//   TextEditingController passwordEditingController = new TextEditingController();
//   AuthService authService = new AuthService();
//     late LoginBloc _bloc;
//   final formKey = GlobalKey<FormState>();
//   bool _isObscure = true;
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading
//           ? Container(
//               child: Center(child: CircularProgressIndicator()),
//             )
//           : Container(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Form(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           validator: (val) {
//                             return RegExp(
//                                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                     .hasMatch(val!)
//                                 ? null
//                                 : "Please Enter Correct Email";
//                           },
//                           controller: emailEditingController,
//                           decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.mail),
//                               hintText: "Email",
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10))),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                           obscureText: _isObscure,
//                           validator: (val) {
//                             return val!.trim().length > 6
//                                 ? null
//                                 : "Enter Password 6+ characters";
//                           },
//                           controller: passwordEditingController,
//                           decoration: InputDecoration(
//                               hintText: 'Password',
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                               suffixIcon: IconButton(
//                                   icon: Icon(_isObscure
//                                       ? Icons.visibility
//                                       : Icons.visibility_off),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isObscure = !_isObscure;
//                                     });
//                                   }),
//                               prefixIcon: Icon(Icons.vpn_key)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       //LoginPage();
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.orange,
//                               Colors.red,
//                             ],
//                           )),
//                       width: MediaQuery.of(context).size.width,
//                       child: Text(
//                         "Sign In",
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 16,
//                   ),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => ForgotPassword()));
//                         },
//                         child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             child: Text(
//                               "Forgot Password?",
//                             )),
//                       )
//                     ],
//                   ),
//                   // SizedBox(
//                   //   height: 10,
//                   // ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Don't have account? ",
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           // widget.toggleView();
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SignUp()));
//                         },
//                         child: Text(
//                           "Register now",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               decoration: TextDecoration.underline),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
