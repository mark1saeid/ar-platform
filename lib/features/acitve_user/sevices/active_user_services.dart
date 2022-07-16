// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ActiveUserProvider {
//   static Future<String> searchSingleUserMethod({String userName}) {
//     String myUserName = '';
//     FirebaseFirestore.instance.collection('users').get().then((value) {
//       value.docs.forEach((element) {
//         if (element.data()['username'] == userName) {
//           myUserName = element.data()['username'];
//         }
//       });
//     });
//   }
// }
