// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/route_name.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/home_controller.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();
  final homeController = Get.find<HomeController>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String userName = '';
  String password = '';
  bool isAutoLogin = false;

  @override
  void initState() {
    super.initState();

    _getThingsOnStartup().then((_) {
      if (isAutoLogin == true) {
        login();
      }
    });
  }

  Future _getThingsOnStartup() async {
    // print('Things To do');

    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('username') ?? '';
    password = pref.getString('password') ?? '';
    isAutoLogin = pref.getBool('isAutoLogin') ?? false;

    userNameController.text = userName;
    passwordController.text = password;

    await Future.delayed(Duration(seconds: 1));
  }

  Future login() async {
    authController
        .login(
            userName: userNameController.text,
            password: passwordController.text)
        .then((_) {
      if (authController.isAuth.value == true) {
        homeController.getSaldoStokSum(
            userId: authController.userId.value,
            outletId: authController.userOutletId.value);
        Future.delayed(Duration(seconds: 3)).then((_) async {
          SharedPreferences pref = await SharedPreferences.getInstance();

          pref.setString('username', userNameController.text);

          pref.setString('password', passwordController.text);

          pref.setBool('isAutoLogin', true);

          Get.offAllNamed(RouteName.menuBar);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 70),
                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        suffixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon masukkan username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.lock),
                      ),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon masukkan password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),

                    // *Login
                    ElevatedButton(
                      child: Text(
                        'Masuk',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFEF4DB),
                        onPrimary: Colors.black,
                        fixedSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        textStyle: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.22,
            child: Column(
              children: [
                Image(
                  height: 45,
                  image: AssetImage('assets/images/splashscreen/Icon JTI.png'),
                ),
                Text(
                  'Powered By',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                SizedBox(height: 10),
                Text('Jagat Teknologi Indonesia'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
