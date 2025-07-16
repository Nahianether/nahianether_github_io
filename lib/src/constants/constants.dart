import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const appName = 'Intishar-Ul Islam';

// Ultra Modern Color Palette - 2024 Portfolio Design
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);

// Dark Theme Base Colors
const Color bgColor = Color(0xFF0A0A0B); // Deep black background
const Color surfaceColor = Color(0xFF111113); // Slightly lighter surface
const Color cardColor = Color(0xFF1A1A1C); // Card background
const Color borderColor = Color(0xFF27272A); // Subtle borders

// Vibrant Accent Colors
const Color primaryColor = Color(0xFF00D4FF); // Electric cyan
const Color primaryLight = Color(0xFF3DDBFF); // Light cyan
const Color primaryDark = Color(0xFF0099CC); // Dark cyan

// Secondary Accents
const Color secondaryColor = Color(0xFF00FF87); // Electric green
const Color accentColor = Color(0xFFFF6B6B); // Coral red
const Color warningColor = Color(0xFFFFBE0B); // Electric yellow
const Color purpleAccent = Color(0xFF8B5CF6); // Purple accent

// Text Colors (High Contrast)
const Color textPrimary = Color(0xFFFFFFFF); // Pure white
const Color textSecondary = Color(0xFFE4E4E7); // Light gray
const Color textMuted = Color(0xFF71717A); // Medium gray
const Color textDark = Color(0xFF3F3F46); // Dark gray

// Legacy support
const Color kDefaultColor = primaryColor;
const Color bodyTextColor = textSecondary;
const Color darkColor = surfaceColor;
const Color kTextColor = textMuted;

Color kLightPrimaryColor = Colors.cyan.shade900.withValues(alpha: 0.85);

DateFormat dateFormat = DateFormat('MMM yyyy');

String getFormatedDate(DateTime dt) => dateFormat.format(dt);

String diffDate({required DateTime startDate, required DateTime endDate}) {
  final difference = endDate.difference(startDate);
  final days = difference.inDays.toInt();
  final months = (days ~/ 30);
  final years = (months ~/ 12);

  if (years > 0 && months - years * 12 > 0) {
    int mnths = months - years * 12;
    return '$years years and $mnths months';
  } else if (years > 0) {
    return '$years years';
  } else if (months > 0) {
    return '$months months';
  } else {
    return '$days days';
  }
}

final skills = [
  'Flutter',
  'Rust',
  'Dart',
  'Android',
  'System Programming',
  'WebAssembly',
  'C/C++',
  'Database',
  'REST APIs',
  'Web Development',
  'Backend Development',
];

final officeProjects = [
  'AGGS',
  'GariBook(Client & Driver)',
  'Clerk File Share',
  'Probashi',
  'AG E-commerce',
  'Point Of Sale(POS)',
  'Like Dislike(Tinder Copy)',
  'Meeting Schedule',
  'Clerk',
  'Team Wave',
  'D\'Arrigo Brothers(DAB)',
  'Dhaka Boss Merchant App',
  'Dhaka Boss Shopping App',
  'Dhaka Boss Ticketing App',
  'Smart Car Parking System',
];

// Modern Spacing System
const double spacing2 = 2.0;
const double spacing4 = 4.0;
const double spacing6 = 6.0;
const double spacing8 = 8.0;
const double spacing12 = 12.0;
const double spacing16 = 16.0;
const double spacing20 = 20.0;
const double spacing24 = 24.0;
const double spacing32 = 32.0;
const double spacing40 = 40.0;
const double spacing48 = 48.0;
const double spacing64 = 64.0;
const double spacing80 = 80.0;

// Legacy support
const defaultPadding = spacing20;
const defaultDuration = Duration(milliseconds: 300);
const maxWidth = 1400.0;

// Modern Border Radius
const double radiusXS = 4.0;
const double radiusSM = 8.0;
const double radiusMD = 12.0;
const double radiusLG = 16.0;
const double radiusXL = 24.0;
const double radiusXXL = 32.0;

// Ultra Modern Shadow System with Neon Effects
final List<BoxShadow> shadowSM = [
  BoxShadow(
    offset: const Offset(0, 2),
    blurRadius: 8,
    color: Colors.black.withValues(alpha: 0.4),
  ),
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 3,
    color: Colors.black.withValues(alpha: 0.2),
  ),
];

final List<BoxShadow> shadowMD = [
  BoxShadow(
    offset: const Offset(0, 8),
    blurRadius: 25,
    color: Colors.black.withValues(alpha: 0.6),
  ),
  BoxShadow(
    offset: const Offset(0, 3),
    blurRadius: 10,
    color: Colors.black.withValues(alpha: 0.3),
  ),
];

final List<BoxShadow> shadowLG = [
  BoxShadow(
    offset: const Offset(0, 20),
    blurRadius: 40,
    color: Colors.black.withValues(alpha: 0.7),
  ),
  BoxShadow(
    offset: const Offset(0, 8),
    blurRadius: 15,
    color: Colors.black.withValues(alpha: 0.4),
  ),
];

final List<BoxShadow> shadowXL = [
  BoxShadow(
    offset: const Offset(0, 30),
    blurRadius: 60,
    color: Colors.black.withValues(alpha: 0.8),
  ),
  BoxShadow(
    offset: const Offset(0, 12),
    blurRadius: 25,
    color: Colors.black.withValues(alpha: 0.5),
  ),
];

// Neon Glow Effects
final List<BoxShadow> neonGlow = [
  BoxShadow(
    offset: const Offset(0, 0),
    blurRadius: 20,
    color: primaryColor.withValues(alpha: 0.5),
  ),
  BoxShadow(
    offset: const Offset(0, 0),
    blurRadius: 40,
    color: primaryColor.withValues(alpha: 0.2),
  ),
];

final List<BoxShadow> greenGlow = [
  BoxShadow(
    offset: const Offset(0, 0),
    blurRadius: 20,
    color: secondaryColor.withValues(alpha: 0.5),
  ),
  BoxShadow(
    offset: const Offset(0, 0),
    blurRadius: 40,
    color: secondaryColor.withValues(alpha: 0.2),
  ),
];

// Enhanced Glass Effect
final List<BoxShadow> glassEffectShadow = [
  BoxShadow(
    offset: const Offset(0, 8),
    blurRadius: 32,
    color: Colors.black.withValues(alpha: 0.6),
  ),
  BoxShadow(
    offset: const Offset(0, 0),
    blurRadius: 1,
    color: primaryColor.withValues(alpha: 0.1),
  ),
];

// Modern Typography Scale
const double textXS = 12.0;
const double textSM = 14.0;
const double textBase = 16.0;
const double textLG = 18.0;
const double textXL = 20.0;
const double text2XL = 24.0;
const double text3XL = 30.0;
const double text4XL = 36.0;
const double text5XL = 48.0;
const double text6XL = 64.0;
const double text7XL = 72.0;
const double text8XL = 96.0;
const double text9XL = 128.0;

// Ultra Modern Gradients
const LinearGradient primaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [primaryColor, secondaryColor],
  stops: [0.0, 1.0],
);

const LinearGradient heroGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [bgColor, surfaceColor, bgColor],
  stops: [0.0, 0.5, 1.0],
);

const LinearGradient cardGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [cardColor, Color(0xFF1F1F23)],
);

// Neon Glow Effect
const LinearGradient neonGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [primaryColor, purpleAccent, secondaryColor],
  stops: [0.0, 0.5, 1.0],
);

// Electric Glass Effect
const LinearGradient glassGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0x1A00D4FF),
    Color(0x0D00FF87),
  ],
);

// Background Pattern Gradient
const LinearGradient backgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF0A0A0B),
    Color(0xFF111113),
    Color(0xFF0A0A0B),
  ],
  stops: [0.0, 0.5, 1.0],
);

// Legacy support
final kDefaultCardShadow = shadowMD.first;
final kDefaultShadow = shadowLG.first;

//WebView User Agent
const String webViewUserAgent =
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36';

final RegExp emailValidatorRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

final RegExp emailPhoneValidatorRegExp = RegExp(r'^([0-9]{9})|([A-Za-z0-9._%\+\-]+@[a-z0-9.\-]+\.[a-z]{2,3})$');

//SignUp Form Error
const String kEmailNullError = 'Please Enter your email';
const String kInvalidEmailError = 'Please Enter Valid Email';
const String kPassNullError = 'Please Enter your password';
const String kShortPassError = 'Password is too short';
const String kMatchPassError = "Passwords don't match";
const String kInvaliedInfoError = 'Email or Password Invalied';
const String kFirstNameNullError = 'Please Enter your first name';
const String kLastNameNullError = 'Please Enter your last name';
const String kPhoneNumberNullError = 'Please Enter your phone number';
const String kInvaliedPhoneNumberError = 'Please Enter valid phone number';
const String kAddressNullError = 'Please Enter your address';
const String kCountryNullError = 'Please Select your Country';
const String kStateNullError = 'Please Select your State';

const String baseLink = '';

const String playStoreUrl = 'https://play.google.com/store/apps/details?id= ';

const Map<String, String> headerNoAuth = {'Accept': 'application/json'};

Map<String, String> headers = {
  'Accept': 'application/json',
  'Authorization': 'Bearer ...',
};

// MultipartRequest postURL(String trail) =>
//     MultipartRequest('POST', Uri.parse(baseLink + trail));

// MultipartRequest getURL(String trail) =>
//     MultipartRequest('GET', Uri.parse(baseLink + trail));

///
const isGlobalMaintainence = false;

///

final topMenubarSectionKey = GlobalKey();
final topIntroSectionKey = GlobalKey();
final aboutSectionKey = GlobalKey();
final recentWorksSectionKey = GlobalKey();
final cvSectionKey = GlobalKey();
final collaborationSectionKey = GlobalKey();
final contactSectionKey = GlobalKey();
final socialLinksSectionKey = GlobalKey();
