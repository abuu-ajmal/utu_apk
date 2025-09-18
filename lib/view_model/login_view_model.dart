


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../repository/auth_repository.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class LoginViewModel with ChangeNotifier{

  bool _isLoading = false;

  String _phone = '';

  Client? _user;

  final _authRepository = AuthRepository();

  Client? get user => _user;

  bool get isLoading => _isLoading;

  String get phone => _phone;

  void setLoading(bool val){
    _isLoading = val;
    notifyListeners();
  }

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  // Future<dynamic> loginApi(BuildContext context) async{
  //   Map data = {
  //     'phone_no' : _phone,
  //   };
  //
  //   setLoading(true);
  //   _authRepository.loginApi(data).then((value) async{
  //     setLoading(false);
  //     List chechUser = value['clients'];
  //     if(chechUser.isEmpty){
  //       if (!context.mounted) return;
  //       Utils.flushBar("Hakupata taarifa zako", context, "warning");
  //     }else{
  //       Client user = Client.fromJson(value['clients'][0]);
  //       if (!context.mounted) return;
  //       Utils.showAlertDialog(
  //           context: context,
  //           onApprove: () async{
  //             // Navigator.pushNamed(context, RoutesName.home);
  //             // final DatabaseHelper dbHelper = DatabaseHelper();
  //             // await dbHelper.insertClient(user);
  //           },
  //           onCancel: (){},
  //           title: 'Je! Hizi ndio taarifa zako?',
  //           message: Column(
  //             children: [
  //               ListTile(
  //                 leading: CircleAvatar(
  //                   radius: 22,
  //                   backgroundColor: blueAccent,
  //                   child: CircleAvatar(
  //                     radius: 20,
  //                     backgroundColor: white,
  //                     child: const Icon(Icons.person),
  //                   ),
  //                 ),
  //                 // title: Text('${user.firstName.toString()} ${user.middleName.toString()} ${user.lastName.toString()}'),
  //               ),
  //               ListTile(
  //                 leading: CircleAvatar(
  //                   radius: 22,
  //                   backgroundColor: blueAccent,
  //                   child: CircleAvatar(
  //                     radius: 20,
  //                     backgroundColor: white,
  //                     child: const Icon(Icons.call),
  //                   ),
  //                 ),
  //                 // title: Text(user.phoneNo.toString()),
  //               ),
  //               ListTile(
  //                 leading: CircleAvatar(
  //                   radius: 22,
  //                   backgroundColor: blueAccent,
  //                   child: CircleAvatar(
  //                     radius: 20,
  //                     backgroundColor: white,
  //                     child: const Icon(Icons.mail),
  //                   ),
  //                 ),
  //                 // title: Text(user.email.toString()),
  //               ),
  //             ],
  //           ),
  //           icon: Icons.info,
  //           color: blue,
  //           confirmButtonName: 'Ndio',
  //           cancelButtonName: 'Hapana'
  //       );
  //     }
  //
  //   }).onError((error, stackTrace){
  //     setLoading(false);
  //
  //     if (!context.mounted) return;
  //     Utils.flushBar(error.toString(), context, "error");
  //   });
  // }
}