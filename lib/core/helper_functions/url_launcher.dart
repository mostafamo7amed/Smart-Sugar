import 'package:flutter/cupertino.dart';
import 'package:smart_sugar/core/helper_functions/snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchPhoneDialer(String contactNumber,BuildContext context) async {
  final call = Uri.parse('tel:$contactNumber');
  if (await canLaunchUrl(call)) {
    launchUrl(call);
  } else {
    if (!context.mounted) return;
    showSnackBar(context, "Cannot dial");
  }
}