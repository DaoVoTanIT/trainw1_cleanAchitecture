import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/Theme/theme.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/bloc/login_bloc.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/dto/login_dto.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/widget/Loading_widget.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../injection_container.dart';

class SignUpPage extends StatefulWidget {
  // final Function toggle;
  // SignUpPage(this.toggle);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late LoginBloc _bloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String inputLogin;
  late String inputPassword;
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController phoneNumberEditingController =
      new TextEditingController();
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
      // appBar: AppBar(
      //   title: Text('Login Demo'),
      // ),
      body: Center(
        child: _buildBody(),
      ),
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
                            controller: nameEditingController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.people),
                                hintText: "Họ tên",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: phoneNumberEditingController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: "Số điện thoại",
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final loginDTO = LoginDTO(
                                    username: inputLogin,
                                    password: inputPassword,
                                  );
                                  _bloc.add(CheckLoginEvent(login: loginDTO));
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
