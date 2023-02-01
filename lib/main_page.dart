// import 'package:flutter/material.dart';
// import 'package:new_apps/screen.dart';
// import 'package:new_apps/screen2.dart';

// class MainPage extends StatefulWidget {
//   MainPage({Key? key}) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int currentIndex = 0;
//   void onTap(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   List<Widget> _screens = <Widget>[MyScreen(), Bookmarks()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//         unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//         selectedFontSize: 12,
//         unselectedFontSize: 12,
//         type: BottomNavigationBarType.fixed,
//         showUnselectedLabels: true,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
//         elevation: 2,
//         currentIndex: currentIndex,
//         onTap: onTap,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
            
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bookmark_added_outlined),
//             label: 'Bookmark',
//           ),
//         ],
//       ),
//     );
//   }
// }
