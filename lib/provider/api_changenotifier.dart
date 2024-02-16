import 'package:flutter/material.dart';
import 'package:scannerprovider/screens/view_screen.dart';
import 'package:scannerprovider/services/api_services.dart';
import 'package:scannerprovider/utils/colors.dart';

class ScanNotifier extends ChangeNotifier {
  bool loading = false;
  Map<String, dynamic>? data;
  void loginNotifier(
      {required String roll,
      required String pass,
      required BuildContext context}) async {
    if (roll.isNotEmpty && pass.isNotEmpty) {
      try {
        loading = true;
        notifyListeners();
        String rollno = await ApiServices()
            .login(rollno: roll, passwords: pass, context: context);

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewScreen(
            text: roll,
          ),
        ));
        loading = false;
        notifyListeners();
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        loading = false;
        notifyListeners();
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Fill above fields')));
    }

    child:
    Text(
      'Login',
      style: TextStyle(color: kColorwhite),
    );
    style:
    ElevatedButton.styleFrom(
        backgroundColor: Colors.green, side: BorderSide(color: kColorwhite));
    notifyListeners();
  }

  void registerNotifier(
      {required String name,
      required String rollno,
      required String email,
      required String password,
      required BuildContext context}) async {
    if (name.isNotEmpty &&
        rollno.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      try {
        loading = true;
        notifyListeners();
        await ApiServices().register(
          context: context,
          name: name,
          rollno: rollno,
          email: email,
          password: password,
        );
        Navigator.of(context).pop();
        loading = false;
        notifyListeners();
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        loading = false;
        notifyListeners();
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Fill above fields!')));
    }
  }

  void profileNotifier({
    required String rollno,
    required BuildContext context,
  }) async {
    print('iiiiiiii');
    try {
      data = await ApiServices().profile(rollno: rollno, context: context);
      print('gggggggg');

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
      notifyListeners();
    }
  }
}
