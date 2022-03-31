import 'package:android_std/constants/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EbisIsteklerContent extends StatefulWidget {
  @override
  EbisIsteklerContentState createState() => EbisIsteklerContentState();
}

class EbisIsteklerContentState extends State<EbisIsteklerContent>{
  final emailController = TextEditingController();
  final requestController = TextEditingController();
  bool mailControlValue=false;

  _mailControl(String mail){
    if(mail != ""){
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mail);
      if(emailValid == true){
        mailControlValue= true;
      }else{
        print("geçersiz karakter");
        mailControlValue= false;
      }
    }

  }
  _sendRequest(String mail, String metin){

    if(mail != null && metin != null ){
      _mailControl(mail);
      print(mailControlValue);
    }else{
      print("boş değer girilemez");
      mailControlValue= false;
    }

  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: Form(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Card(
                        child: Container(
                          padding: EdgeInsets.only(left: 8.0),
                        //  height: 30,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "E-Mail: ",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: NowUIColors.primary,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '_ _ _ _ _ @ _ _ _ _ ',
                                      ),


                                      keyboardType: TextInputType.text,
                                      controller: emailController,
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ),
                      Card(
                          child: Container(
                            padding: EdgeInsets.only(left: 8.0),
                            //  height: 30,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "İstek Metni: ",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                      child: TextFormField(
                                        maxLines: 8,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: NowUIColors.primary,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'İstek bilgisi ',
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-zA-Z0-9]")
                                          ),
                                        ],
                                        keyboardType: TextInputType.text,
                                        //   controller: irsaliyeSeriNo,
                                      ),
                                    )),
                              ],
                            ),
                          )
                      ),
                      Card(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(NowUIColors.socialFacebook),
                                  ),
                                  onPressed: () => _sendRequest(emailController.text, requestController.text),
                                  child: const Text('Gönder'),
                                ),
                              ),
                            ),
                          ],
                        )
                      )
                    ],

                  )
                ],
              ),

            ),
          )
      ),
    );
  }
}