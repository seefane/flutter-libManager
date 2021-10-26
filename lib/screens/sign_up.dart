import 'package:flutter/material.dart';

class signUp_screen extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return _signUp_screen();
  }
}

class _signUp_screen extends State<signUp_screen> {
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cornfirm_pass = TextEditingController();

  late bool _result;
  late String _usermail;
  late String _error;
  //String _userid;

  @override
  Widget build(BuildContext context) {
    AssetImage imgSignup = const AssetImage('images/sign-up.png');
    Image signUp = Image(
      image: imgSignup,
      width: 200.1,
      height: 200.2,
    );
    return Material(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      // body: Container(
      //   decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //           begin: Alignment.topLeft,
      //           end: Alignment.bottomRight,
      //           colors: [Colors.blue[800], Colors.blue[100]])),
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              signUp,
              TextFormField(
                  controller: _firstname,
                  decoration: const InputDecoration(labelText: "First Name"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your first name";
                    }
                  }),
              TextFormField(
                  controller: _lastname,
                  decoration: const InputDecoration(labelText: "Last Name"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your last name";
                    }
                  }),
              TextFormField(
                  controller: _email,
                  decoration:
                      const InputDecoration(labelText: "Please Enter your email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                  }),
              TextFormField(
                  obscureText: true,
                  controller: _password,
                  decoration: const InputDecoration(labelText: "Create password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                  }),
              TextFormField(
                obscureText: true,
                controller: _cornfirm_pass,
                decoration: const InputDecoration(labelText: "Confirm password"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  } else if (value != _password.text) {
                    return "Please enter matching passwords";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[800],
                            borderRadius: BorderRadius.circular(15.0)),
                        child: TextButton(
                          child: const Text("Sign Up"),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              _register();
                            }
                            return;
                          },
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[800],
                            borderRadius: BorderRadius.circular(15.0)),
                        child: TextButton(
                            child: const Text(
                              "Clear Fields",
                            ),
                            onPressed: () async {
                              _resetInputs();
                            }),
                      )),
                ],
              ),
              Container(
                width: 400.0,
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(15.0)),
                alignment: Alignment.center,
                height: 50.5,
                child: Text(_result == null
                    ? ''
                    : (_result
                        ? 'Registration Successfull ' + _usermail
                        : _error)),
              )
            ],
          )),
        ),
      ),
    ));
  }

  void _register() async {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  void _resetInputs() {
    _email.clear();
    _cornfirm_pass.clear();
    _password.clear();
    _firstname.clear();
    _lastname.clear();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _cornfirm_pass.dispose();
    _firstname.dispose();
    _lastname.dispose();
    super.dispose();
  }
}
