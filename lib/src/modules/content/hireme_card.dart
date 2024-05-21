import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/default_button.dart';
import '../../components/section_title.dart';
import '../../constants/constants.dart';

class HireMeCard extends StatelessWidget {
  const HireMeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: defaultPadding * 2),
        SectionTitle(
          title: 'Collaboration',
          subTitle: "Want to collaborate? Let's talk!",
          color: Color.fromARGB(255, 7, 22, 226),
        ),
        SizedBox(height: defaultPadding * 2),
        HireMeBox(),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}

class HireMeBox extends StatelessWidget {
  const HireMeBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding * 2),
      constraints: const BoxConstraints(maxWidth: 1110),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [kDefaultShadow],
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/email.png',
            height: 60,
            width: 60,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: SizedBox(
              height: 70,
              child: VerticalDivider(),
            ),
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Starting New Project?',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: defaultPadding / 2),
                Text(
                  "Let's talk about an estimate for the new project",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          DefaultButton(
            text: 'Hire Me!',
            imageSrc: 'assets/images/hand.png',
            onPressed: () async {
              var link = 'mailto:nahianether3@gmail.com';
              if (!await launchUrl(Uri.parse(link))) {
                throw 'Could not launch';
              }
            },
          )
        ],
      ),
    );
  }
}
