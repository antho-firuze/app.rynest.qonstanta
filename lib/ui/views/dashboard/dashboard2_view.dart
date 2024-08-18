import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/home/home_view.dart';
import 'package:qonstanta/ui/views/profile/profile_view.dart';
import 'package:qonstanta/ui/views/setting/setting_view.dart';
import 'package:qonstanta/ui/views/widgets/floating_bottom_bar.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_viewmodel.dart';

// PageController _controller = PageController();
HomeView _homeView = HomeView();
ProfileView _profileView = ProfileView();
SettingView _settingView = SettingView();

class Dashboard2View extends StatefulWidget {
  Dashboard2View({Key? key}) : super(key: key);

  @override
  _Dashboard2ViewState createState() => _Dashboard2ViewState();
}

class _Dashboard2ViewState extends State<Dashboard2View>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabBarView,
      bottomNavigationBar: _tabBar,
    );
  }

  get _tabBarView => TabBarView(
        controller: _controller,
        children: [
          _homeView,
          _profileView,
          _settingView,
        ],
      );

  get _tabBar => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Container(
            color: Colors.black54,
            child: TabBar(
              controller: _controller,
              labelColor: Colors.black,
              unselectedLabelColor: oWhite,
              labelStyle: oStyle.size(15.0),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.black54,
                  width: 0.0,
                ),
              ),
              indicatorColor: Colors.black54,
              tabs: [
                Tab(icon: Icon(Icons.home, size: 25), text: 'Home'),
                Tab(icon: Icon(Icons.book, size: 25), text: 'Profile'),
                Tab(icon: Icon(Icons.settings, size: 25), text: 'Setting'),
              ],
            ),
          ),
        ),
      );
}

// class DashboardView extends StatelessWidget {
//   const DashboardView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => await F.onWillPop(),
//       child: ViewModelBuilder<DashboardViewModel>.reactive(
//           onModelReady: (model) async {},
//           builder: (context, model, child) => Scaffold(
//                 // body: PageTransitionSwitcher(
//                 //   duration: Duration(milliseconds: 300),
//                 //   reverse: model.reverse,
//                 //   transitionBuilder: (Widget child,
//                 //       Animation<double> primaryAnimation,
//                 //       Animation<double> secondaryAnimation) {
//                 //     return SharedAxisTransition(
//                 //       child: child,
//                 //       animation: primaryAnimation,
//                 //       secondaryAnimation: secondaryAnimation,
//                 //       transitionType: SharedAxisTransitionType.horizontal,
//                 //     );
//                 //   },
//                 //   child: pages(model.currentIndex),
//                 // ),
//                 // bottomNavigationBar: bottomNavBar(model),

//                 // body: PageView(
//                 //   controller: _controller,
//                 //   children: [
//                 //     _homeView,
//                 //     _profileView,
//                 //     _settingView,
//                 //   ],
//                 // ),
//                 // extendBody: true,
//                 // bottomNavigationBar: floatingBottomNavBar(model),
//                 body: TabBarView(children: [
//                   _homeView,
//                   _profileView,
//                   _settingView,
//                 ]),
//                 bottomNavigationBar: _tabBar,
//               ),
//           viewModelBuilder: () => DashboardViewModel()),
//     );
//   }

  // Widget pages(int index) {
  //   switch (index) {
  //     case 0:
  //       return HomeView();
  //     case 1:
  //       return ProfileView();
  //     default:
  //       return SettingView();
  //   }
  // }

  // floatingBottomNavBar(DashboardViewModel model) => FloatingBottomBar(
  //       items: [
  //         FloatingBottomBarItem(Icons.home, label: 'Home'),
  //         FloatingBottomBarItem(Icons.book, label: 'Page2'),
  //         FloatingBottomBarItem(Icons.settings, label: 'Page3'),
  //       ],
  //       controller: _controller,
  //       // activeColor: Colors.black45,
  //       // color: Colors.white,
  //       onTap: (index) {
  //         _controller.animateToPage(
  //           index,
  //           duration: const Duration(milliseconds: 400),
  //           curve: Curves.easeOut,
  //         );
  //       },
  //     );

  // bottomNavBar(DashboardViewModel model) => BottomNavigationBar(
  //       type: BottomNavigationBarType.shifting,
  //       currentIndex: model.currentIndex,
  //       onTap: model.setIndex,
  //       fixedColor: lightGrey,
  //       // backgroundColor: lightGrey,
  //       items: [
  //         BottomNavigationBarItem(
  //           label: 'Home',
  //           icon: Image.asset(
  //             'assets/icons/home-01.png',
  //             color: model.currentIndex == 0 ? secondaryColor : null,
  //             height: 30,
  //           ),
  //         ),
  //         BottomNavigationBarItem(
  //           label: 'Profil',
  //           icon: Image.asset(
  //             'assets/icons/profile-01.png',
  //             color: model.currentIndex == 1 ? secondaryColor : null,
  //             height: 30,
  //           ),
  //         ),
  //         BottomNavigationBarItem(
  //           label: 'Setting',
  //           icon: Image.asset(
  //             'assets/icons/settings-01.png',
  //             color: model.currentIndex == 2 ? secondaryColor : null,
  //             height: 30,
  //           ),
  //         ),
  //       ],
  //     );
// }
