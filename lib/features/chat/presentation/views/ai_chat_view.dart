import 'package:flutter/material.dart';
import 'package:smart_sugar/features/chat/presentation/views/widgets/receiver_message.dart';
import 'package:smart_sugar/features/chat/presentation/views/widgets/sender_message.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class AiChatView extends StatelessWidget {
  const AiChatView({super.key});

  static const String routeName = "chat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Chat GPT',
        showBackButton: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColor.lightGrayColor, width: .5),
                      ),
                      width: double.infinity,
                      child: Text(
                        'What type of exercises can I do to help lower my blood sugar ? ',
                        style: Styles.regular13
                            .copyWith(color: AppColor.lightGrayColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColor.lightGrayColor, width: .5),
                      ),
                      width: double.infinity,
                      child: Text(
                        'How can I quickly reduce high blood sugar levels if they spike?',
                        style: Styles.regular13
                            .copyWith(color: AppColor.lightGrayColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == 1) {
                          return buildSenderMessage(context);
                        } else {
                          return buildReceiverMessage(context);
                        }
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: 2),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    maxLines: null,
                    style: Styles.regular16,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: AppColor.lightGrayColor,
                          size: 28,
                        ),
                      ),
                      fillColor: AppColor.whiteColor,
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      hintText: 'What can I help you?',
                      hintStyle: Styles.regular16
                          .copyWith(color: AppColor.lightGrayColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.lightGrayColor,
                          width: .5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.lightGrayColor,
                          width: .5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
