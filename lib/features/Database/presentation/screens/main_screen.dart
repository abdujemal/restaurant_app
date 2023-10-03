import 'package:flutter/material.dart';
import 'package:restaurant_app/features/Database/presentation/screens/cart.dart';
import 'package:restaurant_app/features/Database/presentation/screens/favorite_screen.dart';
import 'package:restaurant_app/features/Database/presentation/screens/home.dart';
import 'package:restaurant_app/features/Database/presentation/screens/notifications.dart';
import 'package:restaurant_app/features/Authentication/presentation/pages/profile.dart';
import 'package:restaurant_app/features/Database/presentation/screens/search.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Database/presentation/widget/badge.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController? _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(Constants.appName,
              style: const TextStyle(color: Colors.grey)),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: IconBadge(
                icon: Icons.notifications,
                size: 22.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Notifications();
                    },
                  ),
                );
              },
              tooltip: "Notifications",
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Home(),
            FavoriteScreen(),
            SearchScreen(),
            CartScreen(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(width: 7),
              IconButton(
                icon: const Icon(
                  Icons.home,
                  size: 24.0,
                ),
                color: _page == 0
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).textTheme.caption!.color,
                onPressed: () => _pageController!.jumpToPage(0),
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  size: 24.0,
                ),
                color: _page == 1
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).textTheme.caption!.color,
                onPressed: () => _pageController!.jumpToPage(1),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 24.0,
                  color: Theme.of(context).primaryColor,
                ),
                color: _page == 2
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).textTheme.caption!.color,
                onPressed: () => _pageController!.jumpToPage(2),
              ),
              IconButton(
                icon: IconBadge(
                  icon: Icons.shopping_cart,
                  size: 24.0,
                ),
                color: _page == 3
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).textTheme.caption!.color,
                onPressed: () => _pageController!.jumpToPage(3),
              ),
              IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 24.0,
                ),
                color: _page == 4
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).textTheme.caption!.color,
                onPressed: () => _pageController!.jumpToPage(4),
              ),
              const SizedBox(width: 7),
            ],
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(
            Icons.search,
            color: Theme.of(context).textTheme.caption!.color,
          ),
          onPressed: () => _pageController!.jumpToPage(2),
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController!.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
