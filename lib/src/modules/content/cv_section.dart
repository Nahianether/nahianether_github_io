import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdfx/pdfx.dart';
import 'package:universal_html/html.dart' as html;

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';

class CVSection extends StatefulWidget {
  const CVSection({super.key});

  @override
  State<CVSection> createState() => _CVSectionState();
}

class _CVSectionState extends State<CVSection> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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

  void _viewCVFullScreen() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CVFullScreenDialog(
        onDownload: _downloadCV,
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
                  'Download or view my professional CV',
                  style: TextStyle(
                    fontSize: textLG,
                    color: textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // CV Preview and Actions
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 600 : screenWidth * 0.9,
              ),
              child: Row(
                children: [
                  // CV Preview
                  Expanded(
                    flex: 2,
                    child: MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _isHovered = true;
                        });
                        _animationController.forward();
                      },
                      onExit: (_) {
                        setState(() {
                          _isHovered = false;
                        });
                        _animationController.reverse();
                      },
                      child: GestureDetector(
                        onTap: _viewCVFullScreen,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Container(
                                height: isDesktop ? 400 : 300,
                                decoration: BoxDecoration(
                                  gradient: cardGradient,
                                  borderRadius: BorderRadius.circular(radiusLG),
                                  border: Border.all(
                                    color: _isHovered 
                                        ? primaryColor.withValues(alpha: 0.5)
                                        : borderColor,
                                    width: 2,
                                  ),
                                  boxShadow: _isHovered ? neonGlow : shadowMD,
                                ),
                                child: Stack(
                                  children: [
                                    // CV Preview placeholder
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(radiusLG),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            surfaceColor,
                                            cardColor,
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // Resume Icon with gradient background
                                          Container(
                                            padding: const EdgeInsets.all(spacing16),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [primaryColor, secondaryColor],
                                              ),
                                              borderRadius: BorderRadius.circular(radiusMD),
                                              boxShadow: neonGlow,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/svgs/download.svg',
                                              width: isDesktop ? 60 : 45,
                                              height: isDesktop ? 60 : 45,
                                              colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
                                            ),
                                          ),
                                          const SizedBox(height: spacing16),
                                          Text(
                                            'CV Preview',
                                            style: TextStyle(
                                              fontSize: isDesktop ? textXL : textLG,
                                              color: textSecondary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: spacing8),
                                          const Text(
                                            'Click to view full screen',
                                            style: TextStyle(
                                              fontSize: textSM,
                                              color: textMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Hover overlay
                                    if (_isHovered)
                                      Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(radiusLG),
                                          gradient: LinearGradient(
                                            colors: [
                                              primaryColor.withValues(alpha: 0.1),
                                              secondaryColor.withValues(alpha: 0.1),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: spacing24,
                                              vertical: spacing12,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: primaryGradient,
                                              borderRadius: BorderRadius.circular(radiusMD),
                                            ),
                                            child: const Text(
                                              'View Full Screen',
                                              style: TextStyle(
                                                fontSize: textBase,
                                                color: white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: spacing32),
                  
                  // Actions
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              horizontal: spacing24,
                              vertical: spacing12,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: spacing16),
                        
                        // View Button
                        OutlinedButton.icon(
                          onPressed: _viewCVFullScreen,
                          icon: const Icon(Icons.visibility),
                          label: const Text('View CV'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryColor,
                            side: const BorderSide(color: primaryColor),
                            padding: const EdgeInsets.symmetric(
                              horizontal: spacing24,
                              vertical: spacing12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CVFullScreenDialog extends StatefulWidget {
  final VoidCallback onDownload;

  const CVFullScreenDialog({
    super.key,
    required this.onDownload,
  });

  @override
  State<CVFullScreenDialog> createState() => _CVFullScreenDialogState();
}

class _CVFullScreenDialogState extends State<CVFullScreenDialog> {
  late PdfController _pdfController;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePdfController();
  }

  void _initializePdfController() async {
    try {
      _pdfController = PdfController(
        document: PdfDocument.openAsset('assets/Intishar_Ul_Islam_CV.pdf'),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          gradient: cardGradient,
          borderRadius: BorderRadius.circular(radiusLG),
          border: Border.all(color: borderColor),
          boxShadow: shadowXL,
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(spacing16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: borderColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Resume - Intishar Ul Islam',
                    style: TextStyle(
                      fontSize: textXL,
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      // Download button
                      IconButton(
                        onPressed: widget.onDownload,
                        icon: const Icon(Icons.download),
                        color: primaryColor,
                        tooltip: 'Download CV',
                      ),
                      const SizedBox(width: spacing8),
                      // Close button
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        color: textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // CV Content
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(spacing16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(radiusMD),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMD),
                    child: _buildPdfContent(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: primaryColor),
            SizedBox(height: spacing16),
            Text(
              'Loading PDF...',
              style: TextStyle(
                fontSize: textBase,
                color: textMuted,
              ),
            ),
          ],
        ),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: accentColor,
            ),
            const SizedBox(height: spacing16),
            const Text(
              'Error loading PDF',
              style: TextStyle(
                fontSize: text2XL,
                fontWeight: FontWeight.bold,
                color: black,
              ),
            ),
            const SizedBox(height: spacing8),
            const Text(
              'Please try downloading the PDF instead',
              style: TextStyle(
                fontSize: textBase,
                color: textMuted,
              ),
            ),
            const SizedBox(height: spacing24),
            ElevatedButton.icon(
              onPressed: widget.onDownload,
              icon: const Icon(Icons.download),
              label: const Text('Download PDF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: white,
              ),
            ),
          ],
        ),
      );
    }

    return PdfView(
      controller: _pdfController,
      onDocumentLoaded: (document) {
        // PDF loaded successfully
      },
      onPageChanged: (page) {
        // Page changed
      },
      scrollDirection: Axis.vertical,
      pageSnapping: false,
      physics: const BouncingScrollPhysics(),
    );
  }
}