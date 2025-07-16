import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universal_html/html.dart' as html;

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';

class CVSection extends StatefulWidget {
  const CVSection({super.key});

  @override
  State<CVSection> createState() => _CVSectionState();
}

class _CVSectionState extends State<CVSection> {

  void _downloadCV() {
    html.AnchorElement(href: 'assets/Intishar_Ul_Islam_CV.pdf')
      ..setAttribute('download', 'Intishar_Ul_Islam_CV.pdf')
      ..click();
    
    // Show a snackbar to confirm download
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('CV download started'),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? spacing64 : spacing24,
        vertical: spacing64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            margin: const EdgeInsets.only(bottom: spacing48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => neonGradient.createShader(bounds),
                  child: const Text(
                    'Intishar Resume',
                    style: TextStyle(
                      fontSize: text4XL,
                      fontWeight: FontWeight.w900,
                      color: white,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
                const SizedBox(height: spacing16),
                const Text(
                  'Download my professional CV',
                  style: TextStyle(
                    fontSize: textLG,
                    color: textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // CV Download Section
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 600 : screenWidth * 0.9,
              ),
              child: Container(
                padding: const EdgeInsets.all(spacing32),
                decoration: BoxDecoration(
                  gradient: cardGradient,
                  borderRadius: BorderRadius.circular(radiusLG),
                  border: Border.all(color: borderColor),
                  boxShadow: shadowMD,
                ),
                child: Column(
                  children: [
                    // Resume Icon with gradient background
                    Container(
                      padding: const EdgeInsets.all(spacing20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [primaryColor, secondaryColor],
                        ),
                        borderRadius: BorderRadius.circular(radiusMD),
                        boxShadow: neonGlow,
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/download.svg',
                        width: isDesktop ? 80 : 60,
                        height: isDesktop ? 80 : 60,
                        colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
                      ),
                    ),
                    
                    const SizedBox(height: spacing24),
                    
                    Text(
                      'Download Resume',
                      style: TextStyle(
                        fontSize: isDesktop ? text2XL : textXL,
                        color: textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    
                    const SizedBox(height: spacing16),
                    
                    const Text(
                      'Get a copy of my complete professional resume including experience, skills, and achievements.',
                      style: TextStyle(
                        fontSize: textBase,
                        color: textSecondary,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: spacing32),
                    
                    // Download Button
                    ElevatedButton.icon(
                      onPressed: _downloadCV,
                      icon: const Icon(Icons.download),
                      label: const Text('Download CV'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: spacing32,
                          vertical: spacing16,
                        ),
                        textStyle: const TextStyle(
                          fontSize: textLG,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

