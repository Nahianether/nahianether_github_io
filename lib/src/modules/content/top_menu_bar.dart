import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';

class TopMenuBar extends StatelessWidget {
  const TopMenuBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Card(
        elevation: 0.5,
        color: const Color(0xFFf7f8fa),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context) ? defaultPadding * 2 : 0, vertical: defaultPadding * 0.5),
          child: Row(
            children: [
              if (Responsive.isMobile(context))
                InkWell(
                  child: SizedBox(
                    width: 35,
                    child: SvgPicture.asset(
                      'assets/svgs/menu.svg',
                      colorFilter: const ColorFilter.mode(Colors.cyan, BlendMode.srcIn),
                    ),
                  ),
                  onTap: () => Scaffold.of(context).openDrawer(),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Image.asset('assets/icons/ether.jpeg'),
              ),
              const SizedBox(width: defaultPadding * 0.7),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Portfoli',
                      style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 0.55,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'o',
                      style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 0.55,
                        color: kDefaultColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (Responsive.isDesktop(context))
                Row(
                  children: [
                    TopBarButton(
                        label: 'Home',
                        onPressed: () async => await Scrollable.ensureVisible(topIntroSectionKey.currentContext!,
                            duration: const Duration(milliseconds: 1000), curve: Curves.easeInOutCubic)),
                    const SizedBox(width: defaultPadding),
                    TopBarButton(
                        label: 'About',
                        onPressed: () async => await Scrollable.ensureVisible(aboutSectionKey.currentContext!,
                            duration: const Duration(milliseconds: 1000), curve: Curves.easeInOutCubic)),
                    const SizedBox(width: defaultPadding),
                    TopBarButton(
                        label: 'Recent Works',
                        onPressed: () async => await Scrollable.ensureVisible(recentWorksSectionKey.currentContext!,
                            duration: const Duration(milliseconds: 1000), curve: Curves.easeInOutCubic)),
                    // const SizedBox(width: defaultPadding),
                    // TopBarButton(
                    //     label: 'Collaboration',
                    //     onPressed: () async => await Scrollable.ensureVisible(
                    //         collaborationSectionKey.currentContext!,
                    //         duration: const Duration(milliseconds: 1000),
                    //         curve: Curves.easeInOutCubic)),
                    const SizedBox(width: defaultPadding),
                    TopBarButton(
                        label: 'Contact',
                        onPressed: () async => await Scrollable.ensureVisible(contactSectionKey.currentContext!,
                            duration: const Duration(milliseconds: 1000), curve: Curves.easeInOutCubic)),
                    const SizedBox(width: defaultPadding),
                    TopBarButton(
                      label: 'Personal Blogs',
                      onPressed: () async {
                        String link = 'http://blog.int8bit.xyz/';
                        if (!await launchUrl(Uri.parse(link))) {
                          throw 'Could not launch';
                        }
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopBarButton extends StatelessWidget {
  const TopBarButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: WidgetStateProperty.all<double>(1.0),
            foregroundColor: WidgetStateProperty.all<Color>(const Color(0xFFf7f8fa)),
            backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFf7f8fa)),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0), side: const BorderSide(color: kDefaultColor, width: 1.0)))),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 13.0, color: black)));
  }
}
