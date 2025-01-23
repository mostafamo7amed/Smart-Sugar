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
          SizedBox(height: 10,),
          Expanded(
            child: ListView.separated(
                reverse: true,
                physics: const BouncingScrollPhysics(),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    maxLines: null,
                    style: Styles.regular16,
                    decoration: InputDecoration(
                      suffixIcon:IconButton(
                        onPressed: () {

                        },
                        icon: Icon(
                          Icons.send,
                          color: AppColor.lightGrayColor,
                          size: 28,
                        ),
                      ),
                      fillColor: AppColor.whiteColor,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      hintText: 'What can I help you?',
                      hintStyle: Styles.regular16.copyWith(color: AppColor.lightGrayColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.lightGrayColor,
                          width: .5,
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(12.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.lightGrayColor,
                          width: .5,
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(12.0)),
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