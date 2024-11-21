import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/view_model/signinmodel.dart';
import 'package:shopzonee/view_model/signup_viewmodel.dart';


class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.network(
                'https://www.shutterstock.com/image-photo/portrait-excited-beautiful-girl-wearing-600nw-1038849250.jpg',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            // Page content
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Email Address Field
                        _buildTextField('Email Address', Icons.email, _emailController),
                        // Password Field
                        _buildTextField('Password', Icons.lock, _passwordController, isPassword: true),
                        SizedBox(height: 30),
                        // Sign In Button
                        _buildSigninButton(),
                        SizedBox(height: 20),
                        // Forgot password
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.forgotpassword);
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Social Sign In Options
                        Text(
                          'or sign in with',
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/Frame 12.png'),
                            Image.asset('assets/images/Frame 13.png'),
                            Image.asset('assets/images/Frame 14.png'),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Sign up option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.signupPage);
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $hintText';
          }
          if (isPassword && value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        },
      ),
    );
  }
  Widget _buildSigninButton() {
    return Consumer<Signinviewmodel>(
      builder: (context, signinviewmodel, child) {
        return InkWell(
          onTap: () {
           
              signinviewmodel.login(
                email: _emailController.text,
                password: _passwordController.text,
                context: context,
              );
            
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: signinviewmodel.loading ? Colors.grey : Colors.black,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: signinviewmodel.loading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
