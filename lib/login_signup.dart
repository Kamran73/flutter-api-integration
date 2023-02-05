import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login (String email, String password) async{
    try{
      var response = await http.post(
          Uri.parse('https://reqres.in/api/login'),
          body: {
            'email' : email,
            'password' : password,
          }
      );
      if(response.statusCode == 200){
        debugPrint('login successful');
      }
      else{
        debugPrint(response.statusCode.toString());
      }
    }
    catch(e){
      debugPrint(e.toString());
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                label: Text('email'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                label: Text('password'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint(emailController.text);
                debugPrint(passwordController.text);
                login(emailController.text, passwordController.text);
              },
              style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.cyan),),
              child: const Text(
                'Sign Up', style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
