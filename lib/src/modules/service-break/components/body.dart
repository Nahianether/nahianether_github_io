import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';
import '../../../constants/size_config/size_config.dart';

class ServiceBreakBody extends StatelessWidget {
  const ServiceBreakBody({super.key});

  static const _url = 'https://blog.int8bit.xyz/';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: mainCenter,
        mainAxisSize: mainMin,
        children: [
          SvgPicture.asset(
            'assets/svgs/maintenance.svg',
            semanticsLabel: 'Maintenance Break',
            width: ScreenSize.width * 0.25,
            placeholderBuilder: (BuildContext context) =>
                Container(padding: const EdgeInsets.all(30.0), child: const CircularProgressIndicator()),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'We are Under Maintenance.',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
              ),
              textScaler: TextScaler.linear(1.4),
            ),
          ),
          const Text(
            'We will be back soon!',
            textScaler: TextScaler.linear(1.1),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: OutlinedButton.icon(
              onPressed: () async {
                if (!await launchUrl(Uri.parse(_url))) {
                  throw 'Could not launch $_url';
                }
              },
              icon: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Icon(
                  Icons.engineering_sharp,
                  color: kDefaultColor,
                  size: 20.0,
                ),
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Contact with Admin',
                  style: TextStyle(color: kDefaultColor),
                  textScaler: TextScaler.linear(0.8),
                ),
              ),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: kDefaultColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
