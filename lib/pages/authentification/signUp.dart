import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';
import 'package:multi_ecommerce/widgets/sub_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Handle successful sign-up
      Get.snackbar('Success', 'User signed up successfully');
      Get.offNamed('/sign_in'); // Redirect to home page or other page
    } catch (e) {
      // Handle sign-up errors
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),
              RegularText(
                text: 'Sign Up',
                fontSize: 20,
              ),
              Gap(20),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Address',
                    ),
                  ),
                ),
              ),
              Gap(20),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible, // Toggle visibility
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Gap(20),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: _signUp,
                    child: RegularText(
                      text: 'SIGN UP',
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RegularText(text: 'Or sign up with'),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.lightGrey,
                    ),
                    child: Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: AppColors.lightGrey,
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/icon/google.png'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: AppColors.lightGrey,
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/icon/phone.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegularText(text: 'Already have an account ?'),
                  Gap(10),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/sign_in');
                    },
                    child: RegularText(text: 'Sign in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
