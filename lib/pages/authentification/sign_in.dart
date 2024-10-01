import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';
import 'package:multi_ecommerce/widgets/sub_text.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isPasswordVisible = false; // Variable to manage password visibility

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
                text: 'Login Now',
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username',
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
                  child: RegularText(
                    text: 'SIGN UP',
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1, // Adjust thickness if needed
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RegularText(text: 'Or sign up with'),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1, // Adjust thickness if needed
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
                      size: 40, // Facebook icon size
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
                  RegularText(text: 'Don\'t have an account ?'),
                  Gap(10),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/sign_up');
                    },
                    child: RegularText(text: 'Sign Up'),
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
