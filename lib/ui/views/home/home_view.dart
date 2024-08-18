import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/menu_icon.dart';
import 'package:qonstanta/ui/views/widgets/profile_pic.dart';
import 'package:stacked/stacked.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_viewmodel.dart';

HomeViewModel? _model;
ScrollController _scrollController = ScrollController();

bool _isVisible = false, _isHide = false;
int _currentIdx1 = 0, _currentIdx2 = 0, _currentIdx3 = 0;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // print('up');
        if (_scrollController.offset > 5) _isHide = true;
        if (_scrollController.offset > 57 && !_isVisible) {
          _isVisible = true;
          (context as Element).markNeedsBuild();
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // print('down');
        if (_scrollController.offset < 5) _isHide = false;
        if (_scrollController.offset < 75 && _isVisible) {
          _isVisible = false;
          (context as Element).markNeedsBuild();
        }
      }
    });

    return WillPopScope(
      onWillPop: () async => await F.onWillPop(),
      child: ViewModelBuilder<HomeViewModel>.reactive(
          // disposeViewModel: false,
          // initialiseSpecialViewModelsOnce: true,
          onModelReady: (model) async {
            _model = model;
          },
          builder: (context, model, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  body: Stack(children: [bg, content]),
                  floatingActionButton: Visibility(
                    visible: _isHide,
                    child: sectionMemberInfoFloating,
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerTop,
                ),
              ),
          viewModelBuilder: () => HomeViewModel()),
    );
  }

  get bg => Container(color: primaryColor);

  get content => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 17.0),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                sectionSearchAskUs,
                vSpaceSmall,
                sectionMemberInfo,
                vSpaceSmall,
                sectionCarousel,
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      top: 30.0,
                      left: screenWidth < 1000 ? 20.0 : 300.0,
                      right: screenWidth < 1000 ? 20.0 : 300.0,
                      bottom: 20.0),
                  child: Text(
                    'Main Menu',
                    style: heading3Style.copyWith(fontSize: 12),
                  ),
                ),
                sectionMainMenu,
                vSpaceSmall,
                divider(color: Color.fromARGB(100, 61, 63, 69)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          top: 30.0,
                          left: screenWidth < 1000 ? 20.0 : 300.0,
                          right: screenWidth < 1000 ? 20.0 : 300.0,
                          bottom: 25.0),
                      child: Text(
                        'Learning Video',
                        style: heading3Style.copyWith(fontSize: 12),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async =>
                              await F.showInfoDialog('about_this_menu'),
                          icon: Icon(
                            Icons.info,
                            color: secondaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () async =>
                              await F.showInfoDialog('goto_to_another_page'),
                          icon: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: secondaryColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                sectionLearningVideo,
                vSpaceSmall,
                divider(color: Color.fromARGB(100, 61, 63, 69)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          top: 30.0,
                          left: screenWidth < 1000 ? 20.0 : 300.0,
                          right: screenWidth < 1000 ? 20.0 : 300.0,
                          bottom: 25.0),
                      child: Text(
                        'Tips & Motivasi',
                        style: heading3Style.copyWith(fontSize: 12),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async =>
                              await F.showInfoDialog('about_this_menu'),
                          icon: Icon(
                            Icons.info,
                            color: secondaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () async =>
                              await F.showInfoDialog('goto_to_another_page'),
                          icon: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: secondaryColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                sectionTipsMotivation,
                vSpaceSmall,
                divider(color: Color.fromARGB(100, 61, 63, 69)),
                vSpaceLarge,
              ],
            ),
          ),
        ),
      );

  get sectionMemberInfoFloating => AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
        opacity: _isVisible ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 46, 46, 102),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 8.0),
                    child: ProfilePic(
                      width: 60,
                      height: 60,
                      image: 'https://i.pravatar.cc/300',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Hai, user...',
                              style: heading3Style.copyWith(fontSize: 18)),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Regular member', style: captionStyle)),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextButton(
                        onPressed: null,
                        child: Text(
                          'XII SMK',
                          style: heading3Style.copyWith(fontSize: 18),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  get sectionSearchAskUs => Padding(
        padding: EdgeInsets.only(
          left: screenWidth < 1000 ? 20.0 : 300.0,
          right: screenWidth < 1000 ? 20.0 : 300.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async =>
                    await F.showInfoDialog('open_searching_page'),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 46, 46, 102),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 8.0),
                        child: Icon(
                          Icons.search,
                          color: oWhite,
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Text(
                          'Cari materi pelajaran di sini...',
                          style: captionStyle.clr(oWhite),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () async =>
                      await F.showInfoDialog('open_ask_page'),
                  icon: Icon(
                    Icons.camera,
                    color: oWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  get sectionMemberInfo => Padding(
        padding: EdgeInsets.only(
          left: screenWidth < 1000 ? 20.0 : 300.0,
          right: screenWidth < 1000 ? 20.0 : 300.0,
        ),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 46, 46, 102),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 8.0),
                  child: ProfilePic(
                    width: 60,
                    height: 60,
                    image: 'https://i.pravatar.cc/300',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Hai, user...',
                            style: heading3Style.copyWith(fontSize: 18)),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Regular member', style: captionStyle)),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextButton(
                      onPressed: null,
                      child: Text(
                        'XII SMK',
                        style: heading3Style.copyWith(fontSize: 18),
                      )),
                ),
              ),
            ],
          ),
        ),
      );

  get sectionCarousel => Padding(
        padding: EdgeInsets.only(
          left: screenWidth < 1000 ? 20.0 : 300.0,
          right: screenWidth < 1000 ? 20.0 : 300.0,
        ),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, _) {
                    _currentIdx1 = index;
                    _model!.notifyListeners();
                  }),
              items: _model!.appBanners!.map(
                (e) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: screenHeightProp(s: 180, m: 245, l: 300),
                      child: imageNetwork(
                        e.imageUrl!,
                        onTap: () async =>
                            e.linkUrl!.isEmpty ? null : launch(e.linkUrl!),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _model!.appBanners!.map(
                    (image) {
                      int index = _model!.appBanners!.indexOf(image);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 2.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: oWhite),
                          color: _currentIdx1 == index
                              ? Color.fromRGBO(255, 255, 255, 0.9)
                              : Color.fromRGBO(255, 255, 255, 0.4),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      );

  get sectionMainMenu => Padding(
        padding: EdgeInsets.only(
          left: screenWidth < 1000 ? 20.0 : 300.0,
          right: screenWidth < 1000 ? 20.0 : 300.0,
        ),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 46, 46, 102),
            borderRadius: BorderRadius.circular(13),
          ),
          child: GridView.count(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 4,
            childAspectRatio: .75,
            physics: NeverScrollableScrollPhysics(),
            children: [
              MenuIcon(
                title: 'Menu-1',
                icon: Icon(Icons.menu_book),
                onTap: () async => await _model!.showMenu(1),
              ),
              MenuIcon(
                title: 'Menu-2',
                icon: Icon(Icons.play_arrow_rounded),
                onTap: () async => await _model!.showMenu(2),
              ),
              MenuIcon(
                title: 'Menu-3',
                icon: Icon(Icons.edit),
                onTap: () async => await _model!.showMenu(3),
              ),
              MenuIcon(
                title: 'Lainnya',
                icon: Icon(Icons.menu),
                onTap: () async => await _model!.showMenu(4),
              ),
            ],
          ),
        ),
      );

  get sectionLearningVideo => Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: false,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                onPageChanged: (index, _) {
                  _currentIdx2 = index;
                  _model!.notifyListeners();
                }),
            items: _model!.imgList2.map(
              (image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 300,
                    child: imageNetwork(
                      image,
                      onTap: () async => await _model!.learningVideo(),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      );

  get sectionTipsMotivation => Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: false,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                onPageChanged: (index, _) {
                  _currentIdx3 = index;
                  _model!.notifyListeners();
                }),
            items: _model!.imgList3.map(
              (image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 300,
                    child: imageNetwork(
                      image,
                      onTap: () async => await F.showInfoDialog('open_link'),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      );

  Widget imageNetwork(String image, {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: CachedNetworkImage(
          fit: BoxFit.none,
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
          placeholder: (context, url) => Stack(
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
