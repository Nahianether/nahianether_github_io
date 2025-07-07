import 'dart:ui';

import 'package:flutter/material.dart';

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
      backgroundColor: bgColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: const SafeArea(child: Body()),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: kDefaultColor,
        onPressed: () async {
          if (topIntroSectionKey.currentContext != null) {
            await Scrollable.ensureVisible(
              topIntroSectionKey.currentContext!,
              duration: const Duration(milliseconds: 1000), 
              curve: Curves.easeInOutCubic,
            );
          }
        },
        child: const Icon(Icons.arrow_upward_sharp, size: 20.0),
      ),
      drawer: Responsive.isDesktop(context)
          ? null
          : BackdropFilter(filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), child: const Sidebar()),
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
                    await Scrollable.ensureVisible(topIntroSectionKey.currentContext!,
                        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOutCubic);
                  }),
              const SizedBox(height: defaultPadding),
              TopBarButton(
                  label: 'About',
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(aboutSectionKey.currentContext!,
                        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOutCubic);
                  }),
              const SizedBox(height: defaultPadding),
              TopBarButton(
                  label: 'Recent Works',
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(recentWorksSectionKey.currentContext!,
                        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOutCubic);
                  }),
              const SizedBox(height: defaultPadding),
              TopBarButton(
                  label: 'Contact',
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(contactSectionKey.currentContext!,
                        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOutCubic);
                  }),
              const SizedBox(height: defaultPadding),
              const SizedBox(height: defaultPadding * 2),
              const FooterAllSocialsLinks(isInDrawer: true),
            ],
          ),
        ),
      ),
    );
  }
}
