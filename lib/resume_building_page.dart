/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:lottie/lottie.dart';

class ResumeBuildingPage extends StatefulWidget {
  @override
  _ResumeBuildingPageState createState() => _ResumeBuildingPageState();
}

class _ResumeBuildingPageState extends State<ResumeBuildingPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _educationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _skillsController = TextEditingController();
  bool _isLoading = false;

  Future<void> _generatePdf() async {
    setState(() {
      _isLoading = true;
    });

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Resume', style: pw.TextStyle(fontSize: 40, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Name: ${_nameController.text}', style: pw.TextStyle(fontSize: 20)),
            pw.Text('Email: ${_emailController.text}', style: pw.TextStyle(fontSize: 20)),
            pw.Text('Phone: ${_phoneController.text}', style: pw.TextStyle(fontSize: 20)),
            pw.Text('Address: ${_addressController.text}', style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 20),
            pw.Text('Education', style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
            pw.Text(_educationController.text, style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 20),
            pw.Text('Experience', style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
            pw.Text(_experienceController.text, style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 20),
            pw.Text('Skills', style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
            pw.Text(_skillsController.text, style: pw.TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );

    final outputFile = await _getOutputFile();
    await outputFile.writeAsBytes(await pdf.save());

    setState(() {
      _isLoading = false;
    });
    print('PDF saved to: ${outputFile.path}');
  }

  Future<File> _getOutputFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/resume.pdf');
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Build Your Resume',style: TextStyle(
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
              Center(
                child: Lottie.asset(
                'assets/resume.json',  // Replace with your Lottie animation file
                width: 175,  // Adjust the size of the Lottie animation
                height: 175,
                fit: BoxFit.cover,
              ),  
              ),
              Text(
                'Resume Builder',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 76, 0, 216),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildTextField(_nameController, 'Name'),
              SizedBox(height: 15),
              _buildTextField(_emailController, 'Email'),
              SizedBox(height: 15),
              _buildTextField(_phoneController, 'Phone Number'),
              SizedBox(height: 15),
              _buildTextField(_addressController, 'Address'),
              SizedBox(height: 15),
              _buildTextField(_educationController, 'Education'),
              SizedBox(height: 15),
              _buildTextField(_experienceController, 'Experience'),
              SizedBox(height: 15),
              _buildTextField(_skillsController, 'Skills'),
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
                  onPressed: _generatePdf,
                  child: Text('Generate PDF', style: TextStyle(color: Colors.white)),
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
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
*/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:lottie/lottie.dart';

class ResumeBuildingPage extends StatefulWidget {
  final bool isDarkMode; // Add this line

  ResumeBuildingPage({required this.isDarkMode}); // Update constructor

  @override
  _ResumeBuildingPageState createState() => _ResumeBuildingPageState();
}

class _ResumeBuildingPageState extends State<ResumeBuildingPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _educationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _skillsController = TextEditingController();
  bool _isLoading = false;

  Future<void> _generatePdf() async {
    setState(() {
      _isLoading = true;
    });

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Resume', style: pw.TextStyle(fontSize: 40, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Name: ${_nameController.text}', style: pw.TextStyle(fontSize: 20)),
            pw.Text('Email: ${_emailController.text}', style: pw.TextStyle(fontSize: 20)),
            pw.Text('Phone: ${_phoneController.text}', style: pw.TextStyle(fontSize: 20)),
            pw.Text('Address: ${_addressController.text}', style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 20),
            pw.Text('Education', style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
            pw.Text(_educationController.text, style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 20),
            pw.Text('Experience', style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
            pw.Text(_experienceController.text, style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 20),
            pw.Text('Skills', style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
            pw.Text(_skillsController.text, style: pw.TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );

    final outputFile = await _getOutputFile();
    await outputFile.writeAsBytes(await pdf.save());

    setState(() {
      _isLoading = false;
    });
    print('PDF saved to: ${outputFile.path}');
  }

  Future<File> _getOutputFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/resume.pdf');
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Build Your Resume', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color here
        ),
        backgroundColor: Color.fromARGB(255, 76, 0, 216),
      ),
      body: Container(
        color: widget.isDarkMode ? Colors.black : Colors.white, // Change background color based on dark mode
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/resume.json', // Replace with your Lottie animation file
                    width: 175, // Adjust the size of the Lottie animation
                    height: 175,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Resume Builder',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 76, 0, 216),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildTextField(_nameController, 'Name'),
                SizedBox(height: 15),
                _buildTextField(_emailController, 'Email'),
                SizedBox(height: 15),
                _buildTextField(_phoneController, 'Phone Number'),
                SizedBox(height: 15),
                _buildTextField(_addressController, 'Address'),
                SizedBox(height: 15),
                _buildTextField(_educationController, 'Education'),
                SizedBox(height: 15),
                _buildTextField(_experienceController, 'Experience'),
                SizedBox(height: 15),
                _buildTextField(_skillsController, 'Skills'),
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
                    onPressed: _generatePdf,
                    child: Text('Generate PDF', style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black), // Change text color based on dark mode
    );
  }
}
