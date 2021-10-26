import 'package:flutter/material.dart';
import 'package:library_manager/screens/homepage.dart';
import 'package:library_manager/service/auth_provider.dart';
import 'package:provider/provider.dart';
import 'sign_up.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LogInScreen();
  }
}

class _LogInScreen extends State<LogInScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserAuthProvider>(context, listen: false);
    return MaterialApp(
      home: Material(
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Log In",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _usernameController,
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your Username' : null,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (val) =>
                      val!.length < 6 ? 'Short password,6 chars minimum' : null,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: double.infinity,
                    height: 50.5,
                    child: ElevatedButton(
                        child: const Text("Log In"),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            var signedIn = authProvider.signIn(
                                _usernameController.text,
                                _passwordController.text);
                          }
                        })),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Dont have an account?"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        child: const Text("Sign up"), onPressed: () {}),
                  )
                ],
              ),
              Container(
                width: 400.0,
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(15.0)),
                alignment: Alignment.center,
                height: 50.5,
                child: const Text(' '),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
