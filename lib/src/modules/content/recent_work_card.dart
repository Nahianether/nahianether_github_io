// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../constants/constants.dart';
// import '../../constants/size_config/size_config.dart';
// import 'models/works.dart';

// class RecentWorkCard extends StatefulWidget {
//   const RecentWorkCard({
//     super.key,
//     required this.index,
//   });

//   final int index;

//   @override
//   RecentWorkCardState createState() => RecentWorkCardState();
// }

// class RecentWorkCardState extends State<RecentWorkCard> {
//   bool isHover = false;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         if (!await launchUrl(Uri.parse(works[widget.index].link))) {
//           throw 'Could not launch';
//         }
//       },
//       onHover: (value) {
//         setState(() {
//           isHover = value;
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         height: ScreenSize.height * 0.3,
//         width: ScreenSize.width * 0.3,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [if (isHover) kDefaultCardShadow],
//         ),
//         child: Row(
//           children: [
//             Image.asset(
//               works[widget.index].imageUrl,
//               fit: BoxFit.cover,
//               height: ScreenSize.height * 0.3,
//               width: ScreenSize.width * 0.1,
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(works[widget.index].name.toUpperCase(),
//                         style: TextStyle(
//                             fontSize: 13, color: kTextColor.withOpacity(0.8))),
//                     const SizedBox(height: defaultPadding / 2),
//                     Text(
//                       works[widget.index].description,
//                       maxLines: 6,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                           fontSize: 20.0, fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(height: defaultPadding),
//                     const Text(
//                       'View Details',
//                       style: TextStyle(decoration: TextDecoration.underline),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
