// ignore_for_file: prefer_const_constructors
import 'package:build_my_garden/pages/navpages/categorylistpage.dart';
import 'package:build_my_garden/app/welcome_app.dart';
import 'package:build_my_garden/pages/navpages/account_page.dart';
import 'package:build_my_garden/pages/navpages/marketplace_listing.dart';
import 'package:build_my_garden/pages/navpages/mygarden_page.dart';
import 'package:build_my_garden/pages/subpages/add_listing_page.dart';
import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

void main() async {
  /// Runs the app after checking if the user has previously signed in
  /// If not the user will go through the welcome page

  // Load env file into flutter
  await dotenv.load(fileName: "lib/.env");

  // Helps the await to fully run before starting the app
  WidgetsFlutterBinding.ensureInitialized();
  bool? isSignedIn = await SecureStorage.getIsSignedIn();
  if (isSignedIn != null) {
    isSignedIn ? runApp(MainApp()) : runApp(WelcomeApp());
  }
  // Allows the app to be full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
}

// The main app state
class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  String _currentPage = "Learn";

  // The following list is to access the navigatorkey map
  List<String> pageKeys = ["Learn", "MyGarden", "Marketplace", "Account"];
  // Every new page will need a navigator state
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Learn": GlobalKey<NavigatorState>(),
    "MyGarden": GlobalKey<NavigatorState>(),
    "Marketplace": GlobalKey<NavigatorState>(),
    "Account": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    /// The function takes in the what page it wants to switch to and
    /// sets the current page as to the needed page

    // If the tabItem is already in current page, it will go backwards
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(String tabItem) {
    /// The widget creates an offstage widget based on the required
    /// page.
    /// Offstage widget - if not mistaken is a widget that loads everything but hides it
    /// until it is called.

    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Build Your Garden', //The title of the Flutter App
        theme: ThemeData(primaryColor: Color.fromARGB(255, 8, 78, 83)

            // primaryColor: Color.fromARGB(255, 8, 78, 83)
            // primarySwatch: Color.fromARGB(255, 8, 78, 83),
            ), //ThemeData
        home: WillPopScope(
          onWillPop: () async {
            /// OnWillPop handles the function of what will happen when the back
            /// button is pressed.
            /// The following function will allow the back button instead of exiting the app
            /// make it go back one page or go back to the home page

            final isFirstRouteInCurrentTab =
                !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
            if (isFirstRouteInCurrentTab) {
              if (_currentPage != "Learn") {
                _selectTab("Learn", 0);

                return false;
              }
            }
            // Let system handle back button if we are on the first route
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: null,
            body: Stack(
              children: <Widget>[
                _buildOffstageNavigator("Learn"),
                _buildOffstageNavigator("MyGarden"),
                _buildOffstageNavigator("Marketplace"),
                _buildOffstageNavigator("Account"),
              ],
            ),
            bottomNavigationBar: BottomNav(
              currentIndex: _selectedIndex,
              onPress: (int index) {
                _selectTab(pageKeys[index], index);
              },
            ),
          ),
        ));
  }
}

class TabNavigator extends StatelessWidget {
  /// TabNavigator depending on the accepted navigator and key name
  /// will create a widget of the pages
  final GlobalKey<NavigatorState>? navigatorKey;
  final String tabItem;

  const TabNavigator({Key? key, this.navigatorKey, required this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// If new tab is added, must add in TabNavigator, _navigatorkey, and pageKeys
    Widget child = Container();

    if (tabItem == "Learn") child = CategoryListPage();
    if (tabItem == "MyGarden") child = MyGardenPage();
    if (tabItem == "Marketplace") child = MarketPlaceHome();
    if (tabItem == "Account") child = AccountPage();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

// A bottom navigation app
class BottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onPress;

  const BottomNav({Key? key, this.currentIndex = 0, required this.onPress})
      : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 8, 78, 83),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 212, 225, 209),
        showUnselectedLabels: false,
        currentIndex: widget.currentIndex,
        onTap: widget.onPress,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Learn',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist_outlined),
            label: 'Your Plants',
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'Marketplace',
            backgroundColor: Colors.yellowAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Colors.greenAccent,
          ),
        ]);
  }
}

// A center app - soon to be removed
class CenterWithButton extends StatelessWidget {
  final String text;
  final bool addListing;

  const CenterWithButton(
      {Key? key, required this.text, this.addListing = false})
      : super(key: key);

  // Connecting with the backend using http
  Future<http.Response> buttonPressed() async {
    http.Response returnedResult = await http.get(
        Uri.parse('$baseUrl/app/IBMWelcomeGarden'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset-UTF-8'
        });
    print(returnedResult.body);
    return returnedResult;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(("Welcome to $text")),
        ),
        Padding(
            padding: const EdgeInsets.all(0.0),
            child: ElevatedButton(
                onPressed: addListing
                    ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ListingForm())))
                    : buttonPressed,
                child: Text('Click')))
      ],
    ));
  }
}
