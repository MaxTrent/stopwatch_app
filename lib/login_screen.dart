import 'package:flutter/material.dart';
import 'package:stopwatch/stopwatch.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }

    final name = _nameController.text;
    final email = _emailController.text;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => StopWatch(),
      ),
    );


    Navigator.of(context).pushReplacementNamed(
      StopWatch.route,
      arguments: name,
    );
        }

  Widget _buildSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.check, color: Colors.green),
        Text('Welcome $name'),

      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (text) {
                if (text!.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
            ),
            TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email Address'),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Enter Email Address';
                  }
                  final regex = RegExp('[^@]+@[^\.]+\..+');
                  if (regex.hasMatch(text)) {
                    return 'Enter a valid email';
                  }
                  return null;
                }

            ),

            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Continue'),
                onPressed: _validate,
            ),
          ],

        ),

      ),

    );
  }
}
