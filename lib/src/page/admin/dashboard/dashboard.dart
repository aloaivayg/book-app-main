import 'package:book_app/src/config/navigation/global_key.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/page/admin/dashboard/dashboard_add_item.dart';
import 'package:book_app/src/page/admin/dashboard/dashboard_delete_item.dart';
import 'package:book_app/src/page/admin/dashboard/dashboard_edit_item.dart';
import 'package:book_app/src/page/admin/dashboard/dashboard_home.dart';
import 'package:book_app/src/page/admin/observer/home_screen_obs.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<String> _tabNames = [
    "Home",
    "Add Item",
    "Edit Item",
    "Delete Item"
  ];

  void _onMenuItemSelected(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<bool> _onWillPop() async {
    final isFirstRouteInCurrentTab =
        !(await _navigatorKeys[_selectedIndex].currentState?.maybePop() ??
            false);

    if (isFirstRouteInCurrentTab) {
      return true; // Exit the app if it's the first route
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Row(
          children: [
            // Static Sidebar
            Container(
              width: 250,
              color: Colors.grey[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: const Text(
                      'Admin Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  for (int i = 0; i < _tabNames.length; i++)
                    ListTile(
                      leading: Icon(
                        _getIconForIndex(i),
                        color: Colors.white,
                      ),
                      title: Text(
                        _tabNames[i],
                        style: const TextStyle(color: Colors.white),
                      ),
                      selected: _selectedIndex == i,
                      selectedTileColor: Colors.blueGrey,
                      onTap: () => _onMenuItemSelected(i),
                    ),
                ],
              ),
            ),

            // Main Content Area
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: List.generate(
                  _navigatorKeys.length,
                  (index) => Navigator(
                    key: _navigatorKeys[index],
                    observers: [
                      if (index == 0)
                        HomeScreenObserver(
                          onActive: () => GlobalKeys.homeScreenKey.currentState
                              ?.refreshData(),
                        ),
                    ],
                    onGenerateRoute: (routeSettings) {
                      return MaterialPageRoute(
                        builder: (_) => _getTabScreenForIndex(index),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.add;
      case 2:
        return Icons.edit;
      case 3:
        return Icons.delete;
      default:
        return Icons.help;
    }
  }

  Widget _getTabScreenForIndex(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return AddItemScreen();
      case 2:
        return EditItemScreen();
      case 3:
        return DeleteItemScreen();
      default:
        return Center(child: Text("Tab $index"));
    }
  }
}
