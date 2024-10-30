// import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final bool showSecondIcon;
//   final String? title;

//   const CustomAppBar({
//     super.key,
//     this.showSecondIcon = true,
//     this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       forceMaterialTransparency: true,
//       backgroundColor: Colors.transparent,
//       leading: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey.shade400,
//                   offset: Offset(0, 2),
//                   blurRadius: 2)
//             ],
//           ),
//           child: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios_new,
//               color: Color(0xff1E3354),
//               size: 16,
//             ),
//           ),
//         ),
//       ),
//       title: title != null
//           ? Text(
//               title!,
//               style: const TextStyle(
//                 color: Color(0xff1E3354),
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//           : null,
//       actions: showSecondIcon
//           ? [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.shade400,
//                           offset: Offset(0, 2),
//                           blurRadius: 2)
//                     ],
//                   ),
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.favorite,
//                       color: Color(0xffFF6E6E),
//                       size: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ]
//           : [],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(56.0);
// }
