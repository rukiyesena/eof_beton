import 'dart:convert';

import 'package:android_std/constants/Theme.dart';
import 'package:android_std/models/UserModel.dart';
import 'package:android_std/page/kit.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberpwd = false;
  bool sec = true;
  bool _isLoading = false;
  bool _isChecked = false;

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  var visable = Icon(
    Icons.visibility,
    color: Color(0xff4c5166),
  );
  var visableoff = Icon(
    Icons.visibility_off,
    color: Color(0xff4c5166),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Container(
                    //color: Colors.white,

                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/blur-bg-mobile.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  SafeArea(
                    child: ListView(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 50, left: 24.0, right: 24.0, bottom: 0),
                        child: Card(
                            color: Colors.black.withOpacity(0.2),
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    color: Colors.black.withOpacity(0.2),
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                      "assets/images/eof-logo-beyaz.png",
                                                      height: 120,
                                                      fit: BoxFit.fill),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15, right: 15),
                                                  child: Column(
                                                    children: [
                                                      buildEmail(),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      buildPassword(),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      buildRememberassword(),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16),
                                                  child: Center(
                                                    child: FlatButton(
                                                      textColor:
                                                          NowUIColors.white,
                                                      color:Colors.black.withOpacity(0.2),
                                                      onPressed: () =>
                                                          _loginControl(
                                                              _usernameController
                                                                  .text,
                                                              _passwordController
                                                                  .text),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Colors.white,
                                                                width: 1,
                                                                style: BorderStyle.solid
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                      ),
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 60.0,
                                                                  right: 60.0,
                                                                  top: 12,
                                                                  bottom: 12),
                                                          child: Text("Giriş",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.0))),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.06,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    buildPhone(),
                                                    buildMail(),
                                                    //buildFacebook(),
                                                    // buildGoogle(),
                                                    // buildTwitter()
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            )),
                      ),
                    ]),
                  )
                ],
              ),
      ),
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.grey),
              color: Colors.black.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextField(
            controller: _usernameController,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
               // contentPadding: EdgeInsets.only(left: 5),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                    size: 15.0
                ),
                hintText: 'Kullanıcı Adı',
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey),
            color: Colors.black.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ],
          ),
          height: 40,
          child: TextField(
            controller: _passwordController,
            obscureText: sec,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
             /*   enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: NowUIColors.primary, width: 0.0),
                ),
                border: const OutlineInputBorder(),*/
                labelStyle: new TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      sec = !sec;
                    });
                  },
                  icon: sec ? visableoff : visable,
                ),
                border: InputBorder.none,
               // contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Colors.white,
                    size: 15.0
                ),
                hintText: "Şifre",
                hintStyle: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  Widget buildRememberassword() {
    return Container(
      height: 20,
      child: Row(
        children: [
          Theme(
              data: ThemeData(unselectedWidgetColor: NowUIColors.white),
              child: Checkbox(
                checkColor: Colors.white,
                activeColor: NowUIColors.primary,
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue!;
                    _handleRemeberme(_isChecked);
                  });
                },
              )),
          Text(
            "Beni Hatırla",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: NowUIColors.white),
          ),
        ],
      ),
    );
  }

  Widget buildPhone() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () => launch("tel:02167060363"),
        label: Text("0 (216) 706 0363",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: NowUIColors.white,
            )),
        icon: Icon(
          Icons.phone,
          color: NowUIColors.primary,
        ),
      ),
    );
  }

  Widget buildMail() {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () => launch("mailto:bilgi@eof.com.tr"),
        label: Text("bilgi@eof.com.tr",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: NowUIColors.white,
            )),
        icon: Icon(
          Icons.mail,
          color: NowUIColors.primary,
        ),
      ),
    );
  }


  _loginControl(String username, String password) async {
    //Notify();
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('http://proje.eofyazilim.com:35019/token'));
    request.bodyFields = {
      'grant_type': 'password',
      'username': username,
      'password': password
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var jsonData;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      var response2 = await http.Response.fromStream(response);
      final result = jsonDecode(response2.body) as Map<String, dynamic>;
      jsonData = result['access_token'];

      //usermodeldeki login metodunu çalıştırır
      Provider.of<UserModel>(context, listen: false)
          .login(_usernameController.text, jsonData);
      Navigator.pop(context);

      setState(() {
        _isLoading = false;
        sharedPreferences.setString("access_token", jsonData);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Kit()),
            (Route<dynamic> route) => false);
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void Notify() async {
    // local notification
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body',
            bigPicture: 'assets://images/protocoderlogo.png'));
  }

  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('username', _usernameController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("username") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        _usernameController.text = _username;
        _passwordController.text = _password;
      }
    } catch (e) {
      print(e);
    }
  }
}
