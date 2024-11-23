import 'package:flutter/material.dart';
import 'CategoryScreen.dart'; // Ensure CategoryScreen is imported
import 'AccountScreen.dart'; // Import the AccountScreen
import 'MyPostsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    CategoryScreen(),
    MyPostsScreen(),
    AccountScreen(), // AccountScreen added to the list of screens
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the corresponding screen based on the index
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyPostsScreen()), // Navigate to MyPostsScreen when "Add Post" is clicked
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountScreen()), // Navigate to AccountScreen when "Account" is clicked
      );
    }
  }

  void _showCategorySelectionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen()), // Navigate to the Category Screen
    );
  }

  void _searchFunction() {
    // Implement your search functionality here (e.g., show a search bar)
    print("Search function clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800], // Dark green background for AppBar
        title: Row(
          children: [
            Text('Home', style: TextStyle(color: Colors.white)),
            Spacer(), // Adds space between "Home" and the right icons
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _searchFunction, // Search functionality when clicked
            ),
            IconButton(
              icon: Icon(Icons.menu), // Menu icon (three horizontal lines)
              onPressed: () {
                // Handle menu action here
                print("Menu icon clicked");
              },
            ),
          ],
        ),
        leading: GestureDetector(
          onTap: _showCategorySelectionScreen, // Show category selection screen when tapped
          child: Center(
            child: Text('=', style: TextStyle(fontSize: 28, color: Colors.white)), // Equal sign in the center
          ),
        ),
      ),
      body: Container(
        color: Colors.green[700], // Dark green background for the body
        child: ListView(
          children: [
            // Content Cards
            _buildContentCard('Handsome boy ', 'assets/images/icons/image1.png'),
            _buildContentCard('Best University', 'assets/images/icons/bbu.png'),
            _buildContentCard('Amazing Sunset', 'assets/images/icons/beer.png'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Updated to navigate to the screens
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box), // Add Post Icon
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), // Account Icon
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(String caption, String imagePath) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(caption, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          // Interaction Icons (like, comment, views)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {
                    print("Like clicked");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment_outlined),
                  onPressed: () {
                    print("Comment clicked");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    print("View clicked");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
