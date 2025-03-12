import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color here
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildExpandableTile(
                    title: 'How to use the app?',
                    content:
                        'This app allows you to build your resume, find recommended jobs, and manage your account settings.',
                  ),
                  _buildExpandableTile(
                    title: 'How to update my account settings?',
                    content:
                        'You can update your account settings by navigating to the "Account Settings" page from the menu.',
                  ),
                  _buildExpandableTile(
                    title: 'How to get job recommendations?',
                    content:
                        'The app provides recommended jobs based on your profile and preferences. Go to the "Recommended Jobs" section to view them.',
                  ),
                  // Add more FAQ items as needed
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Need More Help?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildContactUsSection(context),
            SizedBox(height: 20),
            _buildFeedbackForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search for help...',
        prefixIcon: Icon(Icons.search, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildExpandableTile({required String title, required String content}) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ExpansionTile(
        title: Text(title),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: BoxConstraints(maxHeight: 150), // Set maximum height
              child: SingleChildScrollView(
                child: Text(content),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactUsSection(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.email, color: Colors.black),
            title: Text('Contact Support'),
            subtitle: Text('support@careernexus.com'),
            onTap: () {
              // Implement email support functionality
              // E.g., launch URL to open email client
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.black),
            title: Text('Call Us'),
            subtitle: Text('+1-800-123-456'),
            onTap: () {
              // Implement phone support functionality
              // E.g., launch URL to call
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackForm(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Feedback',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Your feedback or question',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Handle feedback submission
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Feedback submitted!')),
                );
              },
              child: Text(
                'Submit Feedback',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text('How to use the app?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Here you can explain how users can navigate and use the various features of the app.',
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('How to update my account settings?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'You can update your account settings by navigating to the "Account Settings" page from the menu.',
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('How to get job recommendations?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'The app provides recommended jobs based on your profile and preferences. Go to the "Recommended Jobs" section to view them.',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Need More Help?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Contact Support'),
              subtitle: Text('support@careernexus.com'),
              onTap: () {
                // Implement email support functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Call Us'),
              subtitle: Text('+1-800-123-456'),
              onTap: () {
                // Implement phone support functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/