import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(defaultPadding * 3, defaultPadding, defaultPadding * 3, defaultPadding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '© 2021 Intishar-Ul Islam. ALL RIGHTS RESERVED.',
            style: TextStyle(
              color: Color(0xFF85819C),
              height: 1.5,
              fontSize: 10.0, //10.0
              letterSpacing: 1.0,
            ),
          ),
          if (Responsive.isDesktop(context)) const Spacer(),
          if (Responsive.isDesktop(context)) const FooterAllSocialsLinks(),
        ],
      ),
    );
  }
}

class FooterAllSocialsLinks extends StatelessWidget {
  const FooterAllSocialsLinks({
    super.key,
    this.isInDrawer = false,
  });

  final bool isInDrawer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SocialLink(
          imgPath: 'assets/svgs/github.svg',
          link: 'https://github.com/Nahianether/',
          tooltip: 'Github',
          isInDrawer: isInDrawer,
        ),
        const SizedBox(width: defaultPadding * 0.7),
        SocialLink(
          imgPath: 'assets/svgs/linkedin.svg',
          link: 'https://www.linkedin.com/in/nahinxp21/',
          tooltip: 'LinkedIn',
          isInDrawer: isInDrawer,
        ),
        const SizedBox(width: defaultPadding * 0.7),
        SocialLink(
          imgPath: 'assets/svgs/gmail.svg',
          link: 'mailto:nahianether3@gmail.com',
          tooltip: 'Gmail',
          isInDrawer: isInDrawer,
        ),
      ],
    );
  }
}

class SocialLink extends StatelessWidget {
  const SocialLink({
    super.key,
    required this.imgPath,
    required this.link,
    this.tooltip = 'Open in browser',
    this.isInDrawer = false,
  });

  final String imgPath;
  final String link;
  final String? tooltip;
  final bool isInDrawer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isInDrawer) Navigator.pop(context);
        if (!await launchUrl(Uri.parse(link))) {
          throw 'Could not launch';
        }
      },
      child: Tooltip(
        message: tooltip,
        child: SvgPicture.asset(
          imgPath,
          height: 20.0,
          width: 20.0,
          colorFilter: ColorFilter.mode(
            isInDrawer ? Colors.cyan : const Color(0xFF85819C),
            BlendMode.srcIn,
          ),
          placeholderBuilder: (BuildContext context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
