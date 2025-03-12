/*
import 'package:careernexus/account_settings_page.dart';
import 'package:careernexus/help_page.dart';
import 'package:flutter/material.dart';
import 'resume_building_page.dart';
import 'recommended_jobs_page.dart';
import 'user_login.dart';

class UserHomeScreen extends StatefulWidget {
  final String username;
  UserHomeScreen({required this.username});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // Store the hover state for each menu item
  Map<String, bool> _isHovering = {
    'resume': false,
    'recommended': false,
    'settings': false,
    'help': false,
    'logout': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Career Nexus',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color here
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              // Handle logout logic here
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => UserLoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hello, ${widget.username}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              'resume',
              icon: Icons.account_box,
              text: 'Build Resume',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                );
              },
            ),
            _buildDrawerItem(
              context,
              'recommended',
              icon: Icons.recommend,
              text: 'Recommended Jobs',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                );
              },
            ),
            _buildDrawerItem(
              context,
              'settings',
              icon: Icons.settings,
              text: 'Account Settings',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountSettingsPage()),
                );
              },
            ),
            _buildDrawerItem(
              context,
              'help',
              icon: Icons.help,
              text: 'Help',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
              },
            ),
            _buildDrawerItem(
              context,
              'logout',
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                Navigator.pop(context);
                // Handle logout logic here
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserLoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Welcome, ${widget.username}!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Dashboard Overview
            SizedBox(height: 10),
            _buildInteractiveCard(
              title: 'Build Your Resume',
              icon: Icons.build,
              image: 'assets/resume.jpg', // Add your image path
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                );
              },
            ),
            SizedBox(height: 10),
            _buildInteractiveCard(
              title: 'Recommended Jobs',
              icon: Icons.recommend,
              image: 'assets/job.png', // Add your image path
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                );
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveCard({
    required String title,
    required IconData icon,
    required String image, // Add image parameter
    required Function() onTap,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovering[title] = true;
      }),
      onExit: (_) => setState(() {
        _isHovering[title] = false;
      }),
      child: AnimatedScale(
        scale: _isHovering[title] == true ? 1.05 : 1.0,
        duration: Duration(milliseconds: 200),
        child: Card(
          color: Colors.black,
          elevation: 5,
          child: Container(
            height: 150, // Set a fixed height for the card
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  image,
                  width: 80, // Set the width of the image
                  height: 80, // Set the height of the image
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16), // Space between image and text
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String key,
      {required IconData icon, required String text, required Function() onTap}) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering[key] = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering[key] = false;
        });
      },
      child: Transform.scale(
        scale: _isHovering[key]! ? 1.05 : 1.0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: _isHovering[key]! ? Colors.black : Colors.transparent,
          child: ListTile(
            leading: Icon(
              icon,
              color: _isHovering[key]! ? Colors.white : Colors.black,
            ),
            title: Text(
              text,
              style: TextStyle(
                color: _isHovering[key]! ? Colors.white : Colors.black,
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
*/


/*
import 'package:careernexus/account_settings_page.dart';
import 'package:careernexus/help_page.dart';
import 'package:flutter/material.dart';
import 'resume_building_page.dart';
import 'recommended_jobs_page.dart';
import 'user_login.dart';
import 'package:lottie/lottie.dart';


class UserHomeScreen extends StatefulWidget {
  final String username;
  UserHomeScreen({required this.username});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // Store the hover state for each menu item
  Map<String, bool> _isHovering = {
    'resume': false,
    'recommended': false,
    'settings': false,
    'help': false,
    'logout': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Career Nexus',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color here
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              // Handle logout logic here
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => UserLoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [              
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hello, ${widget.username}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              'resume',
              icon: Icons.account_box,
              text: 'Build Resume',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                );
              },
            ),
            _buildDrawerItem(
              context,
              'recommended',
              icon: Icons.recommend,
              text: 'Recommended Jobs',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                );
              },
            ),
            _buildDrawerItem(
              context,
              'settings',
              icon: Icons.settings,
              text: 'Account Settings',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountSettingsPage()),
              );
              },
            ),
            _buildDrawerItem(
              context,
              'help',
              icon: Icons.help,
              text: 'Help',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
              },
            ),
            _buildDrawerItem(
              context,
              'logout',
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                Navigator.pop(context);
                // Handle logout logic here
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserLoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
  radius: 100,
  backgroundColor: Colors.white,
  child: Lottie.asset(
    'assets/animation.json',  
    width: 250,
    height:250,
    fit: BoxFit.cover,
  ),
),
              /*CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),*/
            ),
            //SizedBox(height: 20),
            Center(
              child: Text(
                'Welcome, ${widget.username}!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Dashboard Overview
            SizedBox(height: 10),
            Card(
              color: Colors.black,
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'Build Your Resume',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: SizedBox(
      width: 50,  // Adjust the size based on your Lottie file size
      height: 50,
      child: Lottie.asset(
        'assets/resume.json',  // Replace with your Lottie file path
        fit: BoxFit.cover,
      ),
    ),
                /*trailing: Icon(
                  Icons.build,
                  color: Colors.white,
                ),*/
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Card(
              color: Colors.black,
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'Recommended Jobs',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: SizedBox(
      width: 50,  // Adjust the size based on your Lottie file size
      height: 50,
      child: Lottie.asset(
        'assets/job.json',  // Replace with your Lottie file path
        fit: BoxFit.cover,
      ),
    ),
                /*trailing: Icon(
                  Icons.recommend,
                  color: Colors.white,
                ),*/
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String key,
      {required IconData icon, required String text, required Function() onTap}) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering[key] = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering[key] = false;
        });
      },
      child: Transform.scale(
        scale: _isHovering[key]! ? 1.05 : 1.0, // Add pop effect
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Smooth transition
          color: _isHovering[key]! ? Colors.black : Colors.transparent,
          child: ListTile(
            leading: Icon(
              icon,
              color: _isHovering[key]! ? Colors.white : Colors.black, // Change icon color
            ),
            title: Text(
              text,
              style: TextStyle(
                color: _isHovering[key]! ? Colors.white : Colors.black, // Change text color
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
*/


/*
import 'package:careernexus/account_settings_page.dart';
import 'package:careernexus/help_page.dart';
import 'package:flutter/material.dart';
import 'resume_building_page.dart';
import 'recommended_jobs_page.dart';
import 'user_login.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For theme persistence

class UserHomeScreen extends StatefulWidget {
  final String username;
  UserHomeScreen({required this.username});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // Store the hover state for each menu item
  Map<String, bool> _isHovering = {
    'resume': false,
    'recommended': false,
    'settings': false,
    'help': false,
    'logout': false,
  };

  bool _isDarkMode = false; // For theme control

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  // Load saved theme from shared preferences
  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save theme preference
  _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Career Nexus',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Set the back button color here
          ),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                // Handle logout logic here
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserLoginScreen()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hello, ${widget.username}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                context,
                'resume',
                icon: Icons.account_box,
                text: 'Build Resume',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'recommended',
                icon: Icons.recommend,
                text: 'Recommended Jobs',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'settings',
                icon: Icons.settings,
                text: 'Account Settings',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountSettingsPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'help',
                icon: Icons.help,
                text: 'Help',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'logout',
                icon: Icons.logout,
                text: 'Logout',
                onTap: () {
                  Navigator.pop(context);
                  // Handle logout logic here
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UserLoginScreen()),
                  );
                },
              ),
              // Dark mode switcher
              SwitchListTile(
                title: Text('Dark Mode'),
                value: _isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    _isDarkMode = value;
                    _saveTheme(value); // Save the user's theme preference
                  });
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: Lottie.asset(
                    'assets/animation.json',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Welcome, ${widget.username}!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Notification Panel or Recent Activity Section
              SizedBox(height: 10),
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.blueAccent,
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.notifications, color: Colors.white),
                  title: Text(
                    'New Job Alert: Software Engineer at XYZ',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
              Card(
                color: Colors.greenAccent,
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.white),
                  title: Text(
                    'Application submitted!',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),

              // Dashboard Overview
              SizedBox(height: 10),
              Card(
                color: Colors.black,
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    'Build Your Resume',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: SizedBox(
                    width: 50,
                    height: 50,
                    child: Lottie.asset(
                      'assets/resume.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.black,
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    'Recommended Jobs',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: SizedBox(
                    width: 50,
                    height: 50,
                    child: Lottie.asset(
                      'assets/job.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String key,
      {required IconData icon, required String text, required Function() onTap}) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering[key] = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering[key] = false;
        });
      },
      child: Transform.scale(
        scale: _isHovering[key]! ? 1.05 : 1.0, // Add pop effect
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Smooth transition
          color: _isHovering[key]! ? Colors.black : Colors.transparent,
          child: ListTile(
            leading: Icon(
              icon,
              color: _isHovering[key]! ? Colors.white : Colors.black, // Change icon color
            ),
            title: Text(
              text,
              style: TextStyle(
                color: _isHovering[key]! ? Colors.white : Colors.black, // Change text color
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
*/



/*
import 'package:careernexus/account_settings_page.dart';
import 'package:careernexus/help_page.dart';
import 'package:flutter/material.dart';
import 'resume_building_page.dart';
import 'recommended_jobs_page.dart';
import 'user_login.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For theme persistence

class UserHomeScreen extends StatefulWidget {
  final String username;
  UserHomeScreen({required this.username});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // Store the hover state for each menu item
  Map<String, bool> _isHovering = {
    'resume': false,
    'recommended': false,
    'settings': false,
    'help': false,
    'logout': false,
  };

  bool _isDarkMode = false; // For theme control

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  // Load saved theme from shared preferences
  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save theme preference
  _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Career Nexus',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Set the back button color here
          ),
          backgroundColor: Color.fromARGB(255, 76, 0, 216),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                // Handle logout logic here
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserLoginScreen()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 76, 0, 216),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hello, ${widget.username}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                context,
                'resume',
                icon: Icons.account_box,
                text: 'Build Resume',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'recommended',
                icon: Icons.recommend,
                text: 'Recommended Jobs',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'settings',
                icon: Icons.settings,
                text: 'Account Settings',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountSettingsPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'help',
                icon: Icons.help,
                text: 'Help',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'logout',
                icon: Icons.logout,
                text: 'Logout',
                onTap: () {
                  Navigator.pop(context);
                  // Handle logout logic here
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UserLoginScreen()),
                  );
                },
              ),
              // Dark mode switcher
              SwitchListTile(
                title: Text('Dark Mode'),
                value: _isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    _isDarkMode = value;
                    _saveTheme(value); // Save the user's theme preference
                  });
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: Lottie.asset(
                    'assets/animation.json',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Welcome, ${widget.username}!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 76, 0, 216),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Notification Panel or Recent Activity Section
              SizedBox(height: 10),
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 76, 0, 216),
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.blueAccent,
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.notifications, color: Colors.white),
                  title: Text(
                    'New Job Alert: Software Engineer at XYZ',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
              Card(
                color: Colors.greenAccent,
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.white),
                  title: Text(
                    'Application submitted!',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),

              // Dashboard Overview
              SizedBox(height: 10),
              Card(
                color: Color.fromARGB(255, 76, 0, 216),
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    'Build Your Resume',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: SizedBox(
                    width: 50,
                    height: 50,
                    child: Lottie.asset(
                      'assets/resume.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Color.fromARGB(255, 76, 0, 216),
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    'Recommended Jobs',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: SizedBox(
                    width: 50,
                    height: 50,
                    child: Lottie.asset(
                      'assets/job.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String key,
      {required IconData icon, required String text, required Function() onTap}) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering[key] = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering[key] = false;
        });
      },
      child: Transform.scale(
        scale: _isHovering[key]! ? 1.05 : 1.0, // Add pop effect
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Smooth transition
          color: _isHovering[key]! ? Colors.black : Colors.transparent,
          child: ListTile(
            leading: Icon(
              icon,
              color: _isHovering[key]! ? Colors.white : Colors.black, // Change icon color
            ),
            title: Text(
              text,
              style: TextStyle(
                color: _isHovering[key]! ? Colors.white : Colors.black, // Change text color
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
*/



/*
import 'package:careernexus/account_settings_page.dart';
import 'package:careernexus/help_page.dart';
import 'package:flutter/material.dart';
import 'resume_building_page.dart';
import 'recommended_jobs_page.dart';
import 'user_login.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For theme persistence
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel slider

class UserHomeScreen extends StatefulWidget {
  final String username;
  UserHomeScreen({required this.username});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  Map<String, bool> _isHovering = {
    'resume': false,
    'recommended': false,
    'settings': false,
    'help': false,
    'logout': false,
  };

  bool _isDarkMode = false; // For theme control

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  // Load saved theme from shared preferences
  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save theme preference
  _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Career Nexus',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Set the back button color here
          ),
          backgroundColor: Color.fromARGB(255, 76, 0, 216),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                // Handle logout logic here
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserLoginScreen()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 76, 0, 216),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hello, ${widget.username}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                context,
                'resume',
                icon: Icons.account_box,
                text: 'Build Resume',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'recommended',
                icon: Icons.recommend,
                text: 'Recommended Jobs',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'settings',
                icon: Icons.settings,
                text: 'Account Settings',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountSettingsPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'help',
                icon: Icons.help,
                text: 'Help',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                'logout',
                icon: Icons.logout,
                text: 'Logout',
                onTap: () {
                  Navigator.pop(context);
                  // Handle logout logic here
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UserLoginScreen()),
                  );
                },
              ),
              // Dark mode switcher
              SwitchListTile(
                title: Text('Dark Mode'),
                value: _isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    _isDarkMode = value;
                    _saveTheme(value); // Save the user's theme preference
                  });
                },
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF76c7c0), // Start color
                Color(0xFFb3e5fc), // End color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: Lottie.asset(
                      'assets/animation.json',
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Welcome, ${widget.username}!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 76, 0, 216),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Carousel for Recent Activity
                Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 76, 0, 216),
                  ),
                ),
                SizedBox(height: 10),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    Card(
                      color: Colors.blueAccent,
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.notifications, color: Colors.white),
                        title: Text(
                          'New Job Alert: Software Engineer at XYZ',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                    Card(
                      color: Colors.greenAccent,
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.check_circle, color: Colors.white),
                        title: Text(
                          'Application submitted!',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Dashboard Overview
                Card(
                  color: Color.fromARGB(255, 76, 0, 216),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Build Your Resume',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 50,
                      child: Lottie.asset(
                        'assets/resume.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResumeBuildingPage()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  color: Color.fromARGB(255, 76, 0, 216),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Recommended Jobs',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 50,
                      child: Lottie.asset(
                        'assets/job.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecommendedJobsPage()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String key,
      {required IconData icon, required String text, required Function() onTap}) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering[key] = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering[key] = false;
        });
      },
      child: Transform.scale(
        scale: _isHovering[key]! ? 1.05 : 1.0,
        child: ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(text),
          onTap: onTap,
        ),
      ),
    );
  }
}

*/
import 'package:careernexus/account_settings_page.dart';
import 'package:careernexus/help_page.dart';
import 'package:flutter/material.dart';
import 'resume_building_page.dart';
import 'recommended_jobs_page.dart';
import 'user_login.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For theme persistence
import 'package:carousel_slider/carousel_slider.dart'; // Import Carousel Slider

class UserHomeScreen extends StatefulWidget {
  final String username;
  UserHomeScreen({required this.username});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  bool _isDarkMode = false; // For theme control

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  // Load saved theme from shared preferences
  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save theme preference
  _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Career Nexus',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Set the back button color here
          ),
          backgroundColor: Color.fromARGB(255, 76, 0, 216),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                // Handle logout logic here
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserLoginScreen()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 76, 0, 216),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hello, ${widget.username}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                context,
                icon: Icons.account_box,
                text: 'Build Resume',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResumeBuildingPage(isDarkMode: _isDarkMode)),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.recommend,
                text: 'Recommended Jobs',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecommendedJobsPage(isDarkMode: _isDarkMode)),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.settings,
                text: 'Account Settings',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountSettingsPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.help,
                text: 'Help',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.logout,
                text: 'Logout',
                onTap: () {
                  Navigator.pop(context);
                  // Handle logout logic here
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UserLoginScreen()),
                  );
                },
              ),
              // Dark mode switcher
              SwitchListTile(
                title: Text('Dark Mode'),
                value: _isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    _isDarkMode = value;
                    _saveTheme(value); // Save the user's theme preference
                  });
                },
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: _isDarkMode
                ? LinearGradient(
                    colors: [
                      Color(0xFF121212), // Dark mode start color
                      Color(0xFF1E1E1E), // Dark mode end color
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                      //Color(0xFF76c7c0), // Light mode start color
                      //Color(0xFFb3e5fc), // Light mode end color
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: Lottie.asset(
                      'assets/animation.json',
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Welcome, ${widget.username}!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      //color: _isDarkMode ? Colors.white : Color.fromARGB(255, 76, 0, 216),
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Carousel for Recent Activity
                Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                CarouselSlider(
  options: CarouselOptions(
    height: 150.0,
    autoPlay: true,
    enlargeCenterPage: true,
  ),
  items: [
    Card(
      color: Colors.blueAccent,
      elevation: 5,
      child: Center(  // Centering the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            Icon(Icons.notifications, color: Colors.white, size: 30), // Adjust icon size as needed
            SizedBox(height: 8), // Space between icon and text
            Text(
              'New Job Alert: Software Engineer at XYZ',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center, // Centering text
            ),
          ],
        ),
      ),
    ),
    Card(
      color: Colors.greenAccent,
      elevation: 5,
      child: Center(  // Centering the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 30), // Adjust icon size as needed
            SizedBox(height: 8), // Space between icon and text
            Text(
              'Application submitted!',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center, // Centering text
            ),
          ],
        ),
      ),
    ),
  ],
),
                SizedBox(height: 20),

                // Dashboard Overview
                Card(
                  color: Color.fromARGB(255, 76, 0, 216),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Build Your Resume',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 50,
                      child: Lottie.asset(
                        'assets/resume.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResumeBuildingPage(isDarkMode: _isDarkMode)),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  color: Color.fromARGB(255, 76, 0, 216),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Recommended Jobs',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 50,
                      child: Lottie.asset(
                        'assets/job.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecommendedJobsPage(isDarkMode: _isDarkMode)),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String text, required Function onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(text),
      onTap: () => onTap(),
    );
  }
}
