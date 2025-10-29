import 'package:flutter/material.dart';

class RegisterScreenWidget extends StatefulWidget {
  const RegisterScreenWidget({super.key});

  @override
  State<RegisterScreenWidget> createState() => _RegisterScreenWidgetState();
}

class _RegisterScreenWidgetState extends State<RegisterScreenWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _domisiliController = TextEditingController();
  final TextEditingController _nomorhpController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isVisibile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 397,
            decoration: const BoxDecoration(
              color: Color(0xFF4169E1),
            ),
          ),
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
                  const SizedBox(height: 16),

                  // Title
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Your Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Nama Lengkap',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama Tidak Boleh Kosong';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
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
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !isVisibile,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isVisibile
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isVisibile = !isVisibile;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password tidak boleh kosong";
                                } else if (value.length < 6) {
                                  return "Password minimal 6 karakter";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 24),
                            TextFormField(
                              controller: _domisiliController,
                              decoration: InputDecoration(
                                labelText: 'Domisili',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                               validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Domisili Tidak Boleh Kosong';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 24),
                            TextFormField(
                              controller: _nomorhpController,
                              decoration: InputDecoration(
                                labelText: 'Nomor HP',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nomor HP tidak boleh kosong";
                              } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return "Nomor HP hanya boleh berisi angka";
                              } else if (value.length < 10 || value.length > 13) {
                                return "Nomor HP harus 10–13 digit";
                              }
                              return null;
                            },

                            ),
                            const SizedBox(height: 22),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  print(_emailController.text);
                                  // final UserModel data = UserModel(
                                  //   name: _nameController.text,
                                  //   email: _emailController.text,
                                  //   password: _passwordController.text,
                                  //   domisili: _domisiliController.text,
                                  //   nomorhp: _nomorhpController.text,
                                  // );
                                  // await DbHelper.registerUser(data);
                                  // final all = await DbHelper.getALLUser();
                                  // print("Total user di database: ${all.length}");
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //     content: Text('Register Success'),
                                  //   ),
                                  // );
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4169E1),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 80,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: (){
                              Navigator.pop(context);
                            }, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4169E1),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 35,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}