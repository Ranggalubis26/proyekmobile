// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../Provider/user_data.dart';
import 'Home.dart';
import 'Register.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool check = true;
  TextEditingController nsipController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isNSIPEmpty = false;
  bool isKataSandiEmpty = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<DataUser>(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(127, 218, 244, 100),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.elliptical(80, 80),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset(
                              'images/profile.png',
                              width: 140,
                              height: 110,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "MASUK",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                controller: nsipController,
                                decoration: InputDecoration(
                                  labelText: "NSIP",
                                  prefixIcon: Icon(Icons.person),
                                  counterText: "",
                                  errorText:
                                      isNSIPEmpty ? 'Harap isi NSIP' : null,
                                ),
                                maxLength: 9,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    isNSIPEmpty = value.isEmpty;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: check,
                          decoration: InputDecoration(
                            labelText: "Kata Sandi",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  check = !check;
                                });
                              },
                              icon: Icon(
                                check ? Icons.visibility_off : Icons.visibility,
                              ),
                            ),
                            errorText: isKataSandiEmpty
                                ? 'Harap isi Kata Sandi'
                                : null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              isKataSandiEmpty = value.isEmpty;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(22.0),
                      child: SizedBox(
                        height: 47,
                        width: 193,
                        child: ElevatedButton(
                          onPressed: performLogin,
                          child: Text(
                            "Masuk",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 154, 205, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum Punya Akun ?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyRegister(),
                                  ),
                                );
                              },
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 154, 205, 100),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 200,
            child: Align(
              alignment: Alignment.center,
              child: Visibility(
                visible: isLoading,
                child: SpinKitCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void performLogin() {
    var prov = Provider.of<DataUser>(context, listen: false);

    if (nsipController.text.isEmpty) {
      setState(() {
        isNSIPEmpty = true;
      });
      return;
    } else {
      setState(() {
        isNSIPEmpty = false;
      });
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        isKataSandiEmpty = true;
      });
      return;
    } else {
      setState(() {
        isKataSandiEmpty = false;
      });
    }

    // Show the loading indicator before the login process starts
    setState(() {
      isLoading = true;
    });

    // Simulate a delay to show the loading indicator
    Future.delayed(Duration(seconds: 2), () {
      var userData = prov.datauser['user'] as List<Map<String, String>>;
      var nsipExists =
          userData.any((user) => nsipController.text == user['NSIP']);

      if (!nsipExists) {
        // Hide the loading indicator
        setState(() {
          isLoading = false;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Akun Tidak Valid'),
            content: Text('Akun yang anda masukkan tidak terdaftar'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        var passwordMatches = userData
            .firstWhere((user) => nsipController.text == user['NSIP'])
            .containsValue(passwordController.text);

        // Hide the loading indicator
        setState(() {
          isLoading = false;
        });

        if (!passwordMatches) {
          // Password is incorrect
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Password Salah'),
              content: Text('Password yang anda masukkan salah'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          if (prov.login(nsipController.text, passwordController.text)) {
            // Navigate to the home page after successful login
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
              (route) => false,
            );
          }
        }
      }
    });
  }
}
