import 'package:crud_app/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
// ignore: must_be_immutable
class SendOtpScreen extends StatelessWidget {
   SendOtpScreen({Key? key}) : super(key: key);
    TextEditingController mobileNumber = TextEditingController();
    void submit(context) async {
      if (mobileNumber.text == "") return;

      var appSignatureID = await SmsAutoFill().getAppSignature;
      Map sendOtpData = {
        "mobile_number": mobileNumber.text,
        "app_signature_id": appSignatureID
      };
      print(sendOtpData);
      Navigator.push(
      context,
       MaterialPageRoute(builder: (context) => const VerifyOTPScreen()),
      );
    }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("CrudApp", style: TextStyle(fontWeight: FontWeight.bold),))),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFC2C0C0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: mobileNumber,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Mobile Number",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {submit(context);},
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );

    
    
  }
}