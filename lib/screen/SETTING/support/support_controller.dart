import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/utils.dart';

class SupportController extends GetxController {
  final ctrlSubject = TextEditingController();
  final ctrlBody = TextEditingController();

  sendMail() async {
    if (ctrlSubject.text.isEmpty) {
      Utils.messageError('Заповніть тему листа'.tr);
      return;
    }
    if (ctrlBody.text.isEmpty) {
      Utils.messageError('Заповніть текст листа'.tr);
      return;
    }
    final Email sendEmail = Email(
      body: ctrlBody.text,
      subject: ctrlSubject.text,
      recipients: ['mobile2021app@gmail.com'],
      isHTML: false,
    );
    
    try {
      await FlutterEmailSender.send(sendEmail);
      Get.back();
    } on PlatformException catch(e) {
      Utils.messageError('Error E-Mail'.tr + '\n\n${e.message}');
    } on Exception catch (e) {
      Utils.messageError('Error E-Mail'.tr + '\n$e');
    }
    
  }

  @override
  void onClose() {
    ctrlSubject.dispose();
    ctrlBody.dispose();
    super.onClose();
  }
}
