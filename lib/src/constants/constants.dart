import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const appName = 'flutter_app';

const Color white = Colors.white;
const Color black = Colors.black;
const Color kDefaultColor = Color(0xFF50afc0);
const primaryColor = Color(0xFFFFC107);
const secondaryColor = Color(0xFF242430);
const darkColor = Color(0xFF191923);
const bodyTextColor = Color(0xFF8B8B8D);
const bgColor = Color(0xFF1E1E28);
const Color kTextColor = Color(0xFF707070);

Color kLightPrimaryColor = Colors.cyan.shade900.withOpacity(0.85);

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
  'Dart',
  'Android',
  'Java',
  'Rust',
  'C/C++',
  'PHP',
  'Database',
  'HTML',
  'CSS',
  'Web Development',
];

const defaultPadding = 20.0;
const defaultDuration = Duration(seconds: 1);
const maxWidth = 1400.0;

final kDefaultCardShadow = BoxShadow(
  offset: const Offset(0, 20),
  blurRadius: 50,
  color: Colors.black.withOpacity(0.1),
);

final kDefaultShadow = BoxShadow(
  offset: const Offset(0, 50),
  blurRadius: 50,
  color: const Color(0xFF0700B1).withOpacity(0.15),
);

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
final collaborationSectionKey = GlobalKey();
final contactSectionKey = GlobalKey();
final socialLinksSectionKey = GlobalKey();
