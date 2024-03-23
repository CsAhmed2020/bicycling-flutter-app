import 'package:bicycling_app/_base/base_widgets/base_stateful_screen_widget.dart';
import 'package:bicycling_app/features/auth/login/screen/login_screen.dart';
import 'package:bicycling_app/features/home/screen/home_screen.dart';
import 'package:bicycling_app/features/navigation_drawer/bloc/navigation_drawer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerNavigationScreen extends StatelessWidget {
  static const routeName = '/drawer_navigation_screen';
  static const navigationDrawerIndex = 'navigationDrawerIndex';

  static Future<void> open(BuildContext context, int index) async {
    await Navigator.of(context).pushNamedAndRemoveUntil(
        DrawerNavigationScreen.routeName, (_) => false,
        arguments: {navigationDrawerIndex: index});
  }

  const DrawerNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var blocInstance = NavigationDrawerBloc();
    return BlocProvider<NavigationDrawerBloc>(
      create: (BuildContext context) => blocInstance,
      child: _DrawerNavigationScreen(indexToOpen(context), blocInstance),
    );
  }

  int? indexToOpen(BuildContext context) {
    var arguments = ModalRoute
        .of(context)!
        .settings
        .arguments;
    if (arguments != null) {
      return (arguments as Map)[navigationDrawerIndex];
    } else {
      return null;
    }
  }
}

class _DrawerNavigationScreen extends BaseStatefulScreenWidget {
  final int? indexToOpen;
  final NavigationDrawerBloc blocInstance;

  const _DrawerNavigationScreen(this.indexToOpen, this.blocInstance);

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _DrawerNavigationScreenState();
}

class _DrawerNavigationScreenState
    extends BaseScreenState<_DrawerNavigationScreen> {
  int _selectedDrawerItem = 0;

  @override
  void initState() {
    _selectedDrawerItem = widget.indexToOpen ?? 0;
    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return PopScope(
      canPop: cnBack,
      onPopInvoked: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  _onDrawerItemTapped(0);
                },
              ),
              ListTile(
                title: const Text('Wishlist'),
                onTap: () {
                  _onDrawerItemTapped(1);
                },
              ),
              ListTile(
                title: const Text('Bookings'),
                onTap: () {
                  _onDrawerItemTapped(2);
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  _onDrawerItemTapped(3);
                },
              ),
            ],
          ),
        ),
        body: BlocConsumer<NavigationDrawerBloc, NavigationDrawerState>(
          listener: (context, state) {
            if (state is HomeClickedSte) {
              _selectedDrawerItem = 0;
            } else if (state is WishlistClickedSte) {
              _selectedDrawerItem = 1;
            } else if (state is BookingsClickedSte) {
              _selectedDrawerItem = 2;
            } else if (state is ProfileClickedSte) {
              _selectedDrawerItem = 3;
            }
          },
          builder: (context, state) {
            return _buildScreenWidget(state);
          },
        ),
      ),
    );
  }

  Widget _buildScreenWidget(NavigationDrawerState state) {
    if (state is HomeClickedSte) {
      return _homeWidget();
    } else if (state is WishlistClickedSte) {
      return _loginWidget();
    } else if (state is BookingsClickedSte) {
      return _homeWidget();
    } else if (state is ProfileClickedSte) {
      return _loginWidget();
    } else {
      switch (_selectedDrawerItem) {
        case 1:
          return _loginWidget();
        case 2:
          return _homeWidget();
        case 3:
          return _loginWidget();

        default:
          return _homeWidget();
      }
    }
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _homeWidget() {
    return HomeScreen();
  }

  Widget _loginWidget() {
    return LoginScreen();
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  NavigationDrawerBloc get currentBloc =>
      BlocProvider.of<NavigationDrawerBloc>(context);

  bool get cnBack => _selectedDrawerItem == 0;

  void _onDrawerItemTapped(int index) {
    currentBloc.add(ItemNavigationDrawerClickedEvent(index));
    Navigator.pop(context);
  }

  void _onBackPressed(bool value) async {
    if (value) {
      return;
    } else {
      _onDrawerItemTapped(0);
    }
  }
}
