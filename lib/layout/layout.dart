import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/components/PopUp/create_todo.dart';
import 'package:todos_flutter_firebase/components/PopUp/popup.dart';
import 'package:todos_flutter_firebase/pages/completed_page.dart';
import 'package:todos_flutter_firebase/pages/deleted_page.dart';
import 'package:todos_flutter_firebase/pages/pending_page.dart';
import 'package:todos_flutter_firebase/pages/profile_page.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      const PendingPage(),
      const CompletedPage(),
      const DeletedPage(),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10.0, bottom: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'lib/images/logo.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text(
          'Todos.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.power_settings_new),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: navColor,
        selectedItemColor: selectColor,
        unselectedItemColor: descColor,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.pending : Icons.pending_outlined,
            ),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1
                  ? Icons.check_circle
                  : Icons.check_circle_outlined,
            ),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ? Icons.delete : Icons.delete_outlined,
            ),
            label: 'Deleted',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? Icons.person : Icons.person_outlined,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomPopup(
            context: context,
            content: const CreateTodo(),
          );
        },
        backgroundColor: selectColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
