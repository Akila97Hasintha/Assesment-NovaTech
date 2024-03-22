import 'package:assesment/services/auth.dart';
import 'package:assesment/home/home.dart';
import 'package:assesment/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool rememberMe = false;
final Auth auth = Auth();

String? validateEmail(String? value){
  if(value == null || value.isEmpty){
    return "please enter your email";
  }
  return null;
}

String? validatePassword(String? value){
  if(value == null || value.isEmpty){
    return "Please enter your password";
  }else if(value.length < 6){
    return "Password must be at least 6 characters";
  }
  return null;
}

Future<void> submitForm() async {
  if(_formKey.currentState!.validate()){
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    User? user = await auth.logIn(email, password);
    if (user != null) {
     // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login Successfull....'),
        duration: Duration(seconds: 3),
      ));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                       );
    } else {
      // Show error message to the user
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid email or password'),
        duration: Duration(seconds: 3),
      ));
    }
    
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color.fromARGB(255, 58, 102, 138),
              Colors.blue.withOpacity(0.5)
            ]
          ),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpg'), 
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  
                  decoration: const InputDecoration(
                    labelText: 'Email ID',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 6, 78, 138),fontWeight: FontWeight.bold),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide (
                        color: Color.fromARGB(255, 7, 2, 80),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    prefixIcon: Icon(Icons.email,color: Color.fromARGB(255, 6, 78, 138),), 
                    ),
                    validator: validateEmail,
                ),
                 TextFormField(
                  controller: _passwordController,
                  validator: validatePassword,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 6, 78, 138),fontWeight: FontWeight.bold),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide (
                        color: Colors.blue,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                     prefixIcon: Icon(Icons.lock,color: Color.fromARGB(255, 6, 78, 138),),
                    ),
                    obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe, 
                      onChanged: (newValue){
                        setState(() {
                          rememberMe = newValue!;
                        });
                      }
                      ),
                      const Text('Remember Me',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
                      const SizedBox(width: 50,),
                      const Text('Fogot Password?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
            
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                  onPressed: () {
                    submitForm();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)
                    ), backgroundColor: const Color.fromARGB(255, 12, 74, 124),
                    padding: const EdgeInsets.all(16.0),
                  ),
                  child: const Text('LOG IN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                              ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                       );
                  },
                  child: const Text('If you are not register please register',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15))
                  ),
            
              ]
              ),
          ),
        ),
      ),
    );
  }
}