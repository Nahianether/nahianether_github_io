import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';
import '../../../constants/size_config/responsive.dart';
import '../../content/footer.dart';
import '../../content/top_menu_bar.dart';
import '../components/body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(child: Body()),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: kDefaultColor,
        onPressed: () async => await Scrollable.ensureVisible(
            topMenubarSectionKey.currentContext!,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic),
        child: const Icon(Icons.arrow_upward_sharp, size: 20.0),
      ),
      drawer: Responsive.isDesktop(context)
          ? null
          : BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: const Sidebar()),
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarButton(
                  label: 'Home',
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(
                        topIntroSectionKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOutCubic);
                  }),
              const SizedBox(height: defaultPadding),
              TopBarButton(
                  label: 'About',
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(
                        aboutSectionKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOutCubic);
                  }),
              const SizedBox(height: defaultPadding),
              TopBarButton(
                  label: 'Recent Works',
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(
                        recentWorksSectionKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOutCubic);
                  }),
              // const SizedBox(height: defaultPadding),
              // TopBarButton(
              //     label: 'Collaboration',
              //     onPressed: () async {
              //       Navigator.pop(context);
              //       await Scrollable.ensureVisible(
              //           collaborationSectionKey.currentContext!,
              //           duration: const Duration(milliseconds: 1000),
              //           curve: Curves.easeInOutCubic);
              //     }),
              const SizedBox(height: defaultPadding),
              TopBarButton(
                  label: 'Contact',
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(
                        contactSectionKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOutCubic);
                  }),
              const SizedBox(height: defaultPadding),
              TopBarButton(
                label: 'Personal Blogs',
                onPressed: () async {
                  Navigator.pop(context);
                  String link = 'https://sabikrahat72428.blogspot.com/';
                  if (!await launchUrl(Uri.parse(link))) {
                    throw 'Could not launch';
                  }
                },
              ),
              const SizedBox(height: defaultPadding * 2),
              const FooterAllSocialsLinks(isInDrawer: true),
            ],
          ),
        ),
      ),
    );
  }
}
