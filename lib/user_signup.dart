import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'user_home_screen.dart';

class UserSignUpScreen extends StatefulWidget {
  @override
  _UserSignUpScreenState createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _collegeNameController = TextEditingController();
  final _degreeController = TextEditingController();
  final _branchController = TextEditingController();

  bool _passwordVisible = false;
  bool _repeatPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;
  File? _profileImage;
  String? _selectedGender;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    if (_passwordController.text != _repeatPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match';
        _isLoading = false;
      });
      return;
    }

    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _schoolNameController.text.isNotEmpty &&
        _collegeNameController.text.isNotEmpty &&
        _degreeController.text.isNotEmpty &&
        _branchController.text.isNotEmpty &&
        _selectedGender != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserHomeScreen(username: 'user',)),
      );
    } else {
      setState(() {
        _errorMessage = 'Please fill in all fields';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up',style: TextStyle(
          color: Colors.white
        ),),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color here
        ),
        backgroundColor: Color.fromARGB(255, 76, 0, 216),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 76, 0, 216),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Color.fromARGB(255, 76, 0, 216),
                  child: _profileImage != null
                      ? ClipOval(
                          child: Image.file(
                            _profileImage!,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(_fullNameController, 'Full Name', Icons.person),
              SizedBox(height: 15),
              _buildTextField(_usernameController, 'Username', Icons.person_outline),
              SizedBox(height: 15),
              _buildTextField(
                _passwordController,
                'Password',
                Icons.lock,
                obscureText: !_passwordVisible,
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              _buildTextField(
                _repeatPasswordController,
                'Repeat Password',
                Icons.lock_outline,
                obscureText: !_repeatPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(_repeatPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _repeatPasswordVisible = !_repeatPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              _buildTextField(_locationController, 'Location', Icons.location_on),
              SizedBox(height: 15),
              _buildTextField(_phoneController, 'Phone Number', Icons.phone, keyboardType: TextInputType.phone),
              SizedBox(height: 15),
              _buildTextField(_emailController, 'Email', Icons.email, keyboardType: TextInputType.emailAddress),
              SizedBox(height: 15),
              _buildTextField(_schoolNameController, 'School Name', Icons.school),
              SizedBox(height: 15),
              _buildTextField(_collegeNameController, 'College Name', Icons.school),
              SizedBox(height: 15),
              _buildTextField(_degreeController, 'Degree', Icons.school),
              SizedBox(height: 15),
              _buildTextField(_branchController, 'Branch', Icons.star),
              SizedBox(height: 20),
              Text(
                'Gender',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 76, 0, 216),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGenderOption('Male'),
                  _buildGenderOption('Female'),
                  _buildGenderOption('Other'),
                ],
              ),
              SizedBox(height: 20),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 20),
              if (_isLoading)
                Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 76, 0, 216),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _signUp,
                  child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Login',style: TextStyle(
                  color: Colors.blue
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(icon, color: Color.fromARGB(255, 76, 0, 216)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }

  Widget _buildGenderOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: _selectedGender,
          onChanged: (String? value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
        Text(
          gender,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}