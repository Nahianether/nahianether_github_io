import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';

class ServiceBreakBanner extends StatelessWidget {
  const ServiceBreakBanner({
    super.key,
    this.onPressed,
    required this.height,
  });

  final double height;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    const url = 'https://blog.int8bit.xyz/';
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Colors.transparent,
      height: height,
      width: double.infinity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red[200]!, width: 1.5),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
          color: Colors.red[50],
        ),
        child: Row(
          children: [
            const Spacer(),
            const Text('Page is under maintenance. I\'ll come back soon.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                textScaler: TextScaler.linear(0.85)),
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: OutlinedButton.icon(
                onPressed: () async {
                  if (!await launchUrl(Uri.parse(url))) {
                    throw 'Could not launch $url';
                  }
                },
                icon: const Icon(
                  Icons.engineering_sharp,
                  color: kDefaultColor,
                  size: 15.0,
                ),
                label: const Text(
                  'Contact with Admin',
                  style: TextStyle(
                    color: kDefaultColor,
                    letterSpacing: 0.6,
                  ),
                  // textScaleFactor: 0.65,
                  textScaler: TextScaler.linear(0.65),
                ),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 1.3, color: kDefaultColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
