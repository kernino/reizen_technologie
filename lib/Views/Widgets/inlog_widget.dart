import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reizen_technologie/ViewModel/InlogViewModel.dart';


//login = u0598673 met ww stefan
class Inlog extends StatefulWidget {
  @override
  _Inlog createState() => new _Inlog();
}

class _Inlog extends State<Inlog> {
  @override
  Widget build(BuildContext context) {

    InlogViewModel vm = new InlogViewModel();
    final usernameController = new TextEditingController();
    final passwordController = new TextEditingController();


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return new Scaffold(
        resizeToAvoidBottomInset : false,
        body: Container(
            padding: EdgeInsets.only(left: 10.0, top: 0.0),
            alignment: Alignment.center,
            color: Color.fromRGBO(224, 0, 73, 1.0),
            child: Column(
              children: <Widget>[
                UcllImageAsset(),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          "Reizen Technologie",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 35.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          "R-nummer",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                    Expanded(
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'R-nummer',
                          ),
                        )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          "Paswoord",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                    Expanded(
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        )),
                  ],
                ),
            Container(
        margin: EdgeInsets.only(top: 30.0),
      width: 250.0,
      height: 50.0,
      child: RaisedButton(
          color: Colors.grey,
          child: Text(
            "Activeer",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700),
          ),
          elevation: 6.0,
          onPressed: () => vm.FetchJSON(usernameController.text,passwordController.text,context)),
    ),
              ],
            )));
  }
}

class UcllImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/inlogscherm/ucll.png');
    Image image = Image(
      image: assetImage,
      width: 350.0,
      height: 200.0,
    );
    return Container(
      child: image,
    );
  }
}

