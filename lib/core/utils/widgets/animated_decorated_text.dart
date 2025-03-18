import 'package:flutter/material.dart';
import 'package:flutter_decorated_text/flutter_decorated_text.dart';

import '../app_manager/app_colors.dart';
import '../app_manager/app_styles.dart';

class AnimatedDecoratedText extends StatelessWidget {
  final String text ;
  const AnimatedDecoratedText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedText(
      text: text, // Use raw text, all transformations are now in DecoratorRule
      style: Styles.regular16.copyWith(color: AppColor.blackColor),
      rules: [
        // Rule to remove extra newlines (`\n\n`) and replace `*` with `•`
        DecoratorRule(
          regExp: RegExp(r'\n\s*\n|\n\n\*?'),
          transformMatch: (value) => value.replaceAll(RegExp(r'\n\s*\n|\n\n'), ' ').replaceAll('*', '•'),
          style: Styles.regular16.copyWith(color: AppColor.blackColor),
        ),

        // Rule to handle **bold** text (`**bold**` → `bold`)
        DecoratorRule(
          regExp: RegExp(r'\*\*(.*?)\*\*'),
          transformMatch: (value) => value.replaceAll('**', ''), // Remove `**` but keep text
          style: Styles.bold16.copyWith(color: AppColor.blackColor),
        ),

        // Rule to handle `*italic*` text
        DecoratorRule(
          regExp: RegExp(r'\*(.*?)\*'),
          transformMatch: (value) => value.replaceAll('*', ''), // Remove `*`
          style: Styles.semiBold16.copyWith(color: AppColor.blackColor),
        ),

        // Rule to handle ## Headings (`## Heading` → `Heading`)
        DecoratorRule(
          regExp: RegExp(r'^##\s*(.*)', multiLine: true),
          transformMatch: (value) => value.replaceAll('##', ''), // Remove `##`
          style: Styles.bold16.copyWith(color: AppColor.blackColor),
        ),

        // Rule to remove unwanted backslashes (`\`) and extra spaces
        DecoratorRule(
          regExp: RegExp(r'[\\"]'),
          transformMatch: (value) => value.replaceAll(RegExp(r'[\\"]'), ''), // Remove `\` and `"`
          style: Styles.regular16.copyWith(color: AppColor.blackColor),
        ),

        // Rule to handle ``` Code Blocks ```
        DecoratorRule(
          regExp: RegExp(r'```(.*?)```', multiLine: true),
          transformMatch: (value) => value.replaceAll('```', ''), // Remove ```
          leadingBuilder: (p0) => Icon(Icons.code, color: Colors.black),
          trailingBuilder: (p0) => Icon(Icons.code, color: Colors.black),
          style: Styles.regular16.copyWith(color: AppColor.blackColor),
        ),

        // Rule for URLs (Clickable)
        DecoratorRule.url(
          style: Styles.semiBold16.copyWith(color: AppColor.blueColor),
          onTap: (url) {
            // Handle URL clicks
          },
        ),

        // Rule for Emails (Clickable)
        DecoratorRule.email(
          style: Styles.semiBold16.copyWith(color: AppColor.blueColor),
          onTap: (email) {
            // Handle Email clicks
          },
        ),
      ],
    );

  }




}
