import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';  // Import the Lottie package

class RecommendedJobsPage extends StatefulWidget {
  final bool isDarkMode; // Add this line

  RecommendedJobsPage({required this.isDarkMode}); // Update constructor

  @override
  _RecommendedJobsPageState createState() => _RecommendedJobsPageState();
}

class _RecommendedJobsPageState extends State<RecommendedJobsPage> {
  List<dynamic> recommendedJobs = [];
  bool isLoading = false;
  final TextEditingController _skillsController = TextEditingController();

  Future<void> fetchRecommendedJobs(List<String> userSkills) async {
    final String apiUrl = "http://127.0.0.1:5000/recommend";  // Replace with your Flask API URL

    var body = jsonEncode({'skills': userSkills});

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          recommendedJobs = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching jobs: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  void submitSkills() {
    String skillsInput = _skillsController.text.trim();
    
    if (skillsInput.isNotEmpty) {
      List<String> userSkills = skillsInput.split(',').map((skill) => skill.trim()).toList();
      fetchRecommendedJobs(userSkills);
    } else {
      print("No skills provided");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Jobs', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 76, 0, 216),
      ),
      body: Container(
        color: widget.isDarkMode ? Colors.black : Colors.white, // Change background color based on dark mode
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Lottie animation at the top
              Center(
                child: Lottie.asset(
                  'assets/job.json',  // Replace with your Lottie animation file
                  width: 175,  // Adjust the size of the Lottie animation
                  height: 175,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),  // Add spacing between the Lottie and the rest of the UI
              
              Text(
                'Enter your skills (comma-separated):',
                style: TextStyle(fontSize: 18, color: widget.isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _skillsController,
                decoration: InputDecoration(
                  hintText: 'e.g., Python, Java, SQL',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black), // Change text color based on dark mode
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitSkills,
                child: Text('Get Recommendations', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 76, 0, 216)),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: recommendedJobs.isEmpty
                          ? Text(
                              'No recommendations yet. Enter your skills and press Get Recommendations.',
                              style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black), // Change text color based on dark mode
                            )
                          : ListView.builder(
                              itemCount: recommendedJobs.length,
                              itemBuilder: (context, index) {
                                final job = recommendedJobs[index];
                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  elevation: 3,
                                  color: widget.isDarkMode ? Colors.grey[800] : Colors.white, // Change card color based on dark mode
                                  child: InkWell(
                                    onTap: () {
                                      // Add your onTap functionality here
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  job['Job Title'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: widget.isDarkMode ? Colors.white : Colors.black, // Change text color based on dark mode
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  'Company: ${job['Company'] ?? "Unknown"}',
                                                  style: TextStyle(color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700]),
                                                ),
                                                Text(
                                                  'Location: ${job['Location'] ?? "Remote"}',
                                                  style: TextStyle(color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700]),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  "Similarity: ${job['Similarity'].toStringAsFixed(2)}",
                                                  style: TextStyle(color: Colors.green),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward, color: Colors.black),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';  // Import the Lottie package

class RecommendedJobsPage extends StatefulWidget {
  @override
  _RecommendedJobsPageState createState() => _RecommendedJobsPageState();
}

class _RecommendedJobsPageState extends State<RecommendedJobsPage> {
  List<dynamic> recommendedJobs = [];
  bool isLoading = false;
  final TextEditingController _skillsController = TextEditingController();

  Future<void> fetchRecommendedJobs(List<String> userSkills) async {
    final String apiUrl = "http://127.0.0.1:5000/recommend";  // Replace with your Flask API URL

    var body = jsonEncode({'skills': userSkills});

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          recommendedJobs = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching jobs: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  void submitSkills() {
    String skillsInput = _skillsController.text.trim();
    
    if (skillsInput.isNotEmpty) {
      List<String> userSkills = skillsInput.split(',').map((skill) => skill.trim()).toList();
      fetchRecommendedJobs(userSkills);
    } else {
      print("No skills provided");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Jobs', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 76, 0, 216),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Lottie animation at the top
            Center(
              child: Lottie.asset(
                'assets/job.json',  // Replace with your Lottie animation file
                width: 175,  // Adjust the size of the Lottie animation
                height: 175,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),  // Add spacing between the Lottie and the rest of the UI
            
            Text(
              'Enter your skills (comma-separated):',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _skillsController,
              decoration: InputDecoration(
                hintText: 'e.g., Python, Java, SQL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitSkills,
              child: Text('Get Recommendations', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 76, 0, 216)),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: recommendedJobs.isEmpty
                        ? Text('No recommendations yet. Enter your skills and press Get Recommendations.')
                        : ListView.builder(
                            itemCount: recommendedJobs.length,
                            itemBuilder: (context, index) {
                              final job = recommendedJobs[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                elevation: 3,
                                child: InkWell(
                                  onTap: () {
                                    // Add your onTap functionality here
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                job['Job Title'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Company: ${job['Company'] ?? "Unknown"}',
                                                style: TextStyle(color: Colors.grey[700]),
                                              ),
                                              Text(
                                                'Location: ${job['Location'] ?? "Remote"}',
                                                style: TextStyle(color: Colors.grey[700]),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Similarity: ${job['Similarity'].toStringAsFixed(2)}",
                                                style: TextStyle(color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward, color: Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
*/



/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommendedJobsPage extends StatefulWidget {
  @override
  _RecommendedJobsPageState createState() => _RecommendedJobsPageState();
}

class _RecommendedJobsPageState extends State<RecommendedJobsPage> {
  List<dynamic> recommendedJobs = [];
  bool isLoading = false;
  final TextEditingController _skillsController = TextEditingController();

  Future<void> fetchRecommendedJobs(List<String> userSkills) async {
    final String apiUrl = "http://127.0.0.1:5000/recommend";  // Replace with your Flask API URL

    var body = jsonEncode({'skills': userSkills});

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          recommendedJobs = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching jobs: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  void submitSkills() {
    String skillsInput = _skillsController.text.trim();
    
    if (skillsInput.isNotEmpty) {
      List<String> userSkills = skillsInput.split(',').map((skill) => skill.trim()).toList();
      fetchRecommendedJobs(userSkills);
    } else {
      print("No skills provided");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Jobs', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              'Enter your skills (comma-separated):',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _skillsController,
              decoration: InputDecoration(
                hintText: 'e.g., Python, Java, SQL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitSkills,
              child: Text('Get Recommendations', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(primary: Colors.black),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: recommendedJobs.isEmpty
                        ? Text('No recommendations yet. Enter your skills and press Get Recommendations.')
                        : ListView.builder(
                            itemCount: recommendedJobs.length,
                            itemBuilder: (context, index) {
                              final job = recommendedJobs[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                elevation: 3,
                                child: InkWell(
                                  onTap: () {
                                    // Add your onTap functionality here
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                job['Job Title'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Company: ${job['Company'] ?? "Unknown"}',
                                                style: TextStyle(color: Colors.grey[700]),
                                              ),
                                              Text(
                                                'Location: ${job['Location'] ?? "Remote"}',
                                                style: TextStyle(color: Colors.grey[700]),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Similarity: ${job['Similarity'].toStringAsFixed(2)}",
                                                style: TextStyle(color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward, color: Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
*/

/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommendedJobsPage extends StatefulWidget {
  @override
  _RecommendedJobsPageState createState() => _RecommendedJobsPageState();
}

class _RecommendedJobsPageState extends State<RecommendedJobsPage> {
  List<dynamic> recommendedJobs = [];
  bool isLoading = false;
  final TextEditingController _skillsController = TextEditingController();
  
  Future<void> fetchRecommendedJobs(List<String> userSkills) async {
    final String apiUrl = "http://127.0.0.1:5000/recommend";  // Replace with your Flask API URL

    // Encode the user skills into the request body
    var body = jsonEncode({
      'skills': userSkills,
    });

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          recommendedJobs = json.decode(response.body);  // Parse the job recommendations
          isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching jobs: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  void submitSkills() {
    // Get the skills from the input
    String skillsInput = _skillsController.text.trim();
    
    if (skillsInput.isNotEmpty) {
      // Split the input by commas and remove extra spaces
      List<String> userSkills = skillsInput.split(',').map((skill) => skill.trim()).toList();
      
      // Fetch recommendations using user-provided skills
      fetchRecommendedJobs(userSkills);
    } else {
      print("No skills provided");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Jobs',style: TextStyle(
          color: Colors.white
        ),),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color here
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your skills (comma-separated):',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _skillsController,
              decoration: InputDecoration(
                hintText: 'e.g., Python, Java, SQL',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitSkills,
              child: Text('Get Recommendations',style: TextStyle(
                color: Colors.white
              ),),
              style: ElevatedButton.styleFrom(primary:Colors.black),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: recommendedJobs.isEmpty
                        ? Text('No recommendations yet. Enter your skills and press Get Recommendations.')
                        : ListView.builder(
                            itemCount: recommendedJobs.length,
                            itemBuilder: (context, index) {
                              final job = recommendedJobs[index];
                              return ListTile(
                                title: Text(job['Job Title']),
                                subtitle: Text("Similarity: ${job['Similarity'].toStringAsFixed(2)}"),
                                trailing: Icon(Icons.arrow_forward),
                                onTap: () {
                                  // Add your onTap functionality here
                                },
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
*/