import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/home/home_view.dart';
import 'package:qonstanta/ui/views/profile/profile_view.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await F.onWillPop(),
      child: ViewModelBuilder<DashboardViewModel>.reactive(
          onModelReady: (model) async {},
          builder: (context, model, child) => Scaffold(
                body: Stack(
                  children: [
                    PageTransitionSwitcher(
                      duration: Duration(milliseconds: 500),
                      reverse: true,
                      // reverse: model.reverse,
                      transitionBuilder: (
                        Widget child,
                        Animation<double> primaryAnimation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return SharedAxisTransition(
                          child: child,
                          animation: primaryAnimation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                        );
                      },
                      child: pages(model.currentIndex),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: bottomNavBar(model),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 125.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: gradientColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // bottomNavigationBar: bottomNavBar(model),
              ),
          viewModelBuilder: () => DashboardViewModel()),
    );
  }

  Widget pages(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return Container(
          color: primaryColor,
          child: Center(
            child: Text(
              'Class',
              style: heading1Style,
            ),
          ),
        );
      case 2:
        return Container(
          color: primaryColor,
          child: Center(
            child: Text(
              'Schedule',
              style: heading1Style,
            ),
          ),
        );
      case 3:
        return ProfileView();
      default:
        return Container(
          color: primaryColor,
          child: Center(
            child: Text(
              'Unknown Page',
              style: heading1Style,
            ),
          ),
        );
    }
  }

  bottomNavBar(DashboardViewModel model) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: model.currentIndex,
        onTap: model.setIndex,
        backgroundColor: Color.fromARGB(255, 46, 46, 102),
        selectedItemColor: secondaryColor,
        unselectedItemColor: oWhite,
        selectedLabelStyle: captionStyle.copyWith(fontFamily: 'Cinzel'),
        unselectedLabelStyle: captionStyle.copyWith(fontFamily: 'Cinzel'),
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Class',
            icon: Icon(Icons.star_border_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: Icon(Icons.schedule),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.person_outline),
          ),
        ],
      );
}
