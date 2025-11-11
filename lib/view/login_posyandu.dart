import 'package:flutter/material.dart';
import 'package:project_ppkd/database/db_helper.dart';
import 'package:project_ppkd/extension/custom_widget.dart';
import 'package:project_ppkd/preferences/preferences_handler.dart';

class LoginPosyanduWidget extends StatefulWidget {
  const LoginPosyanduWidget({super.key});

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
          // Background Gradient
          Container(
            height: 420,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.teal.shade400,
                  Colors.teal.shade600,
                ],
              ),
            ),
          ),

          // Decorative Circles
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  // Logo
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 40,
                          color: Colors.teal.shade600,
                        ),
                        Positioned(
                          bottom: 8,
                          child: Icon(
                            Icons.child_care,
                            size: 28,
                            color: Colors.teal.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Selamat Datang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Posyandu Digital',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Masuk dengan email dan password Anda',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // White card container
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Social Login Buttons
                            Row(
                              children: [
                                // Google Button
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      side: BorderSide(color: Colors.grey.shade300),
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
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Facebook Button
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      side: BorderSide(color: Colors.grey.shade300),
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
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Divider with text
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'Atau masuk dengan',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Email Label & Field
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
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
                                        r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                    .hasMatch(value)) {
                                  return "Format Email tidak valid";
                                }
                                return null;
                              },
                            ),
                            // TextFormField(
                            //   controller: emailC,
                            //   keyboardType: TextInputType.emailAddress,
                            //   decoration: InputDecoration(
                            //     hintText: 'nama@email.com',
                            //     hintStyle: TextStyle(
                            //       color: Colors.grey.shade400,
                            //       fontSize: 14,
                            //     ),
                            //     prefixIcon: Icon(
                            //       Icons.email_outlined,
                            //       color: Colors.teal.shade600,
                            //       size: 22,
                            //     ),
                            //     contentPadding: const EdgeInsets.symmetric(
                            //       horizontal: 16,
                            //       vertical: 16,
                            //     ),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //       borderSide: BorderSide(color: Colors.grey.shade300),
                            //     ),
                            //     enabledBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //       borderSide: BorderSide(color: Colors.grey.shade300),
                            //     ),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //       borderSide: BorderSide(
                            //         color: Colors.teal.shade600,
                            //         width: 2,
                            //       ),
                            //     ),
                            //     filled: true,
                            //     fillColor: Colors.grey.shade50,
                            //   ),
                              

                            const SizedBox(height: 20),

                            // Password Label & Field
                            Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomWidget(
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

                            const SizedBox(height: 16),

                            // Remember me and Forgot password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _rememberMe = !_rememberMe;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: _rememberMe
                                              ? Colors.teal.shade600
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: _rememberMe
                                                ? Colors.teal.shade600
                                                : Colors.grey.shade400,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: _rememberMe
                                            ? const Icon(
                                                Icons.check,
                                                size: 14,
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Ingat Saya',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Lupa Password?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.teal.shade600,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 28),

                            // Log In button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final email = emailC.text;
                                    final password = passwordC.text;
                                    final user = await DbHelper.loginUser(
                                      email: email,
                                      password: password,
                                    );
                                     if (user == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Email atau password salah'),
                                        ),
                                      );
                                      return;
                                    }
                                    // Login logic here
                                    await PreferencesHandler.saveLogin(true);
                                    await PreferencesHandler.saveRole(user.role ?? 'user'); // "admin" atau "user"
                                    await PreferencesHandler.saveUserData(user.name?? '', user.email?? '', user.nomorHp?? '', user.alamat?? '',);
                                    if (user.role == 'admin') {
                                      // Masuk sebagai admin
                                      Navigator.pushNamed(
                                        context, 
                                        '/bottomnav');
                                      // Masuk sebagai user
                                    }else {
                                      Navigator.pushNamed(
                                      context, 
                                      '/bottomuser');
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal.shade600,
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shadowColor: Colors.teal.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Sign Up Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
                                  "Belum punya akun? ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to register
                                    Navigator.pushNamed(
                                      context, 
                                      '/register'); 
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Daftar Sekarang',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.teal.shade600,
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