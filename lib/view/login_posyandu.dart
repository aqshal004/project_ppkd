import 'package:flutter/material.dart';
import 'package:project_ppkd/extension/custom_widget.dart';
import 'package:project_ppkd/preferences/preferences_handler.dart';
import 'package:project_ppkd/view/dashboard.dart';
import 'package:project_ppkd/view/register_screen.dart';

class LoginPosyanduWidget extends StatefulWidget {
  const LoginPosyanduWidget({super.key,});

  @override
  State<LoginPosyanduWidget> createState() => _LoginPosyanduWidgetState();
  
}

class _LoginPosyanduWidgetState extends State<LoginPosyanduWidget> {
  final _formKey = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  bool _rememberMe = false;
  // bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background biru penuh
          Container(
            height: 396,
            decoration: const BoxDecoration(
              color: Color(0xFFABE7B2),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Color(0xFF4169E1),
              //     Color(0xFF1E50C8),
              //   ],
              // ),
            ),
          ),
          
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // Logo
                    Image.asset( 
                      'assets/images/logo.png',
                      width: 28,
                      height: 28,
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Title
                  const Text(
                    'Sign in to your',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Subtitle
                  const Text(
                    'Enter your email and password to log in',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // White card container
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                        child:Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Baris: Continue with Google & Facebook
                            Row(
                              children: [
                                // Tombol Google
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      side: const BorderSide(color: Color(0xFFE0E0E0)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/google.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Google',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),
                                // Tombol Facebook
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      side: const BorderSide(color: Color(0xFFE0E0E0)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/facebook.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Facebook',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                                  const SizedBox(height: 20),
                                  
                                  // Divider with text
                                  Row(
                                    children: [
                                      Expanded(child: Divider(color: Colors.grey[300])),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          'Or login with',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Divider(color: Colors.grey[300])),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 20),
                                  Text("Email", style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500],
                                  ),
                                  ),
                                  SizedBox(height: 8),
                                  // Email TextField
                                  CustomWidget(
                                    // labelText: 'Email',
                                    hintText: 'Email',
                                    controller: emailC,
                                    validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email tidak boleh kosong";
                                    } else if (!value.contains('@')) {
                                    return "Email tidak valid";
                                    } else if (!RegExp(
                                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                                    ).hasMatch(value)) {
                                    return "Format Email tidak valid";
                                    }
                                      return null;
                                    },
                                    ),
                                  const SizedBox(height: 16),
                                  Text("Password", style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500],
                                  ),
                                  ),
                                  SizedBox(height: 8),
                                  CustomWidget(
                                    // labelText: 'Password',
                                    isPassword: true,
                                    hintText: 'Password',
                                    controller: passwordC,
                                    validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password tidak boleh kosong";
                                    } else if (value.length < 6) {
                                      return "Password minimal 6 karakter";
                                    }
                                    return null;
                                  },
                                  ),
                                  // Password TextField
                                  // TextField(
                                  //   obscureText: _obscurePassword,
                                  //   decoration: InputDecoration(
                                  //     hintText: '••••••••',
                                  //     contentPadding: const EdgeInsets.symmetric(
                                  //       horizontal: 16,
                                  //       vertical: 16,
                                  //     ),
                                  //     border: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //       borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                                  //     ),
                                  //     enabledBorder: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //       borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                                  //     ),
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //       borderSide: const BorderSide(color: Color(0xFF4169E1)),
                                  //     ),
                                  //     suffixIcon: IconButton(
                                  //       icon: Icon(
                                  //         _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  //         color: Colors.grey,
                                  //       ),
                                  //       onPressed: () {
                                  //         setState(() {
                                  //           _obscurePassword = !_obscurePassword;
                                  //         });
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  
                                  const SizedBox(height: 12),
                                  
                                  // Remember me and Forgot password ae
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _rememberMe = !_rememberMe;
                                          });
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Checkbox(
                                                value: _rememberMe,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _rememberMe = value ?? false;
                                                  });
                                                },
                                                activeColor: const Color(0xFF4169E1),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'Remember me',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Forgot Password ?',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF4169E1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 20),
                                  
                                  // Log In button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                        // final email = emailC.text;
                                        // final password = passwordC.text;
                                        // final user = await DbHelper.loginUser(
                                        //   email: email,
                                        //   password: password,
                                        // );
                                        // if (user == null) {
                                        //   ScaffoldMessenger.of(context).showSnackBar(
                                        //     const SnackBar(
                                        //       content: Text('Email atau password salah'),
                                        //     ),
                                        //   );
                                        //   return;
                                        // } 
                                        await PreferencesHandler.saveLogin(true);
                                        // await PreferencesHandler.saveUserData(
                                        //   user.name,
                                        //   user.email,
                                        // );
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) => DashboardWidget(
                                            // name: user.name,
                                            // email: user.email,
                                            // password: user.password,
                                            // domisili: user.domisili,
                                          ),
                                          ),
                                          );
                                      }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF4169E1),
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        'Log In',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      TextButton(onPressed: () {
                                        Navigator.pushNamed(
                                          context, 
                                          '/register',
                                          );
                                    // Navigator.pushNamed(context, '/signup');
                                  }, 
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF4169E1),
                                    ),
                                  ),
                                  ),
                                  ],
                                  ),
                                  
                                    // Sign Up button
                                  // OutlinedButton(
                                  //   onPressed: () {},
                                  //   style: OutlinedButton.styleFrom(
                                  //     padding: const EdgeInsets.symmetric(vertical: 16),
                                  //     side: const BorderSide(color: Color(0xFFE0E0E0)),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //     ),
                                  //   ),
                                  //   child: RichText(
                                  //     text: const TextSpan(
                                  //       style: TextStyle(fontSize: 14),
                                  //       children: [
                                  //         TextSpan(
                                  //           text: "Don't have an account. ",
                                  //           style: TextStyle(color: Colors.black54),
                                  //         ),
                                  //         TextSpan(
                                  //           text: 'Sign Up',
                                  //           style: TextStyle(
                                  //             color: Color(0xFF4169E1),
                                  //             fontWeight: FontWeight.w600,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                          ),
                          ),
                        ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}