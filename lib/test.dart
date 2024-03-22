import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MaterialApp(
    home: Authen(),
  ));
}
class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}



class _AuthenState extends State<Authen> {

  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_supportState)
              Text("day la thiet bi ho tro")
            else
              Text("day khong phai thiet bi ho tro"),
            const Divider(height: 100,),
            ElevatedButton(
              onPressed: _getAvailableBiometrics,
              child: Text('Authenticate'),
            ),
            Divider(height: 100,),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    try{
      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate for testing',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      print("authen --- $authenticated");
    } catch(e){
      print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    print(availableBiometrics);
    if(!mounted){
      return;
    }
  }
}

