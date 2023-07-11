import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../Provider/user_data.dart';
import 'Home.dart';
import 'Register.dart';
// import 'package:flutterhelp/profil_rangga/template_form.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool check = false;
  TextEditingController nsipController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<DataUser>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: Column(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.elliptical(80, 80))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 22.0, 8.0, 1.0),
                      child: Image.asset(
                        'images/profile.png',
                        width: 140,
                        height: 110,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Container(
                        child: Text(
                          "MASUK",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
                              counterText: ""),
                          maxLength: 9,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
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
                            icon: Icon(check
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(22.0),
                child: SizedBox(
                    height: 47,
                    width: 193,
                    child: ElevatedButton(
                      onPressed: () {
                        // print(nsipController.text);
                        if (nsipController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text(
                                  'Silakan lengkapi semua field sebelum melanjutkan.'),
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
                        }
                        var data = (prov.datauser['user']
                                as List<Map<String, String>>)
                            .any((user) => nsipController.text != user['NSIP']);
                        if (nsipController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            data) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Akun Tidak Valid'),
                              content: Text(
                                  'Akun yang anda masukkan tidak terdaftar'),
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
                        }
                        if (prov.login(
                            nsipController.text, passwordController.text)) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHome()),
                          );
                        } else {}
                      },
                      child: Text(
                        "Masuk",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(93, 189, 17, 100),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
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
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyRegister()),
                          );
                        },
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                              color: Color.fromRGBO(41, 202, 225, 100)),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
