import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scannerprovider/provider/api_changenotifier.dart';
import 'package:scannerprovider/screens/register_screen.dart';
import 'package:scannerprovider/screens/view_screen.dart';
import 'package:scannerprovider/services/api_services.dart';
import 'package:scannerprovider/utils/colors.dart';
import 'package:scannerprovider/widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final rollnumbController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = context.watch<ScanNotifier>();
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const Text(
            'Login',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 30, color: kColorwhite),
          ),
          const SizedBox(
            height: 40,
          ),
          TextfieldWiget(
              hittext: 'Enter your roll number',
              textcontroller: rollnumbController),
          TextfieldWiget(
              hittext: 'Enter your password',
              textcontroller: passwordController),
          data.loading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : ElevatedButton(
                  onPressed: () {
                    print(data);
                    context.read<ScanNotifier>().loginNotifier(
                        roll: rollnumbController.text,
                        pass: passwordController.text,
                        context: context);
                  },
                  child: Text('Login')),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ));
            },
            child: Container(
              width: 300,
              height: 30,
              child: Center(
                  child: Text(
                'dont have account?register',
                style: TextStyle(color: kColorwhite),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
