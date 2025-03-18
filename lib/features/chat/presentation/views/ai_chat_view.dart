import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/chat/presentation/views/widgets/receiver_message.dart';
import 'package:smart_sugar/features/chat/presentation/views/widgets/sender_message.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class AiChatView extends StatefulWidget {
  const AiChatView({super.key});

  static const String routeName = "chat";

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  @override
  void initState() {
    UserCubit.get(context).getApiLink();
    super.initState();
  }

  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ChatWithAISuccessState) {
          setState(() {});
        }
        if (state is ChatWithAIErrorState) {
          setState(() {});
        }
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetApiLinkLoadingState,
          child: Scaffold(
            appBar: buildAppBar(
              context,
              title: 'Chat GPT',
              showBackButton: false,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      reverse: true,
                      itemBuilder: (context, index) {
                        if (index == cubit.messages.length) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                messageController.text =
                                    'What type of exercises can I do to help lower my blood sugar ? ';
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColor.lightGrayColor,
                                      width: .5),
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
                          );
                        } else if (index == cubit.messages.length + 1) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                messageController.text =
                                    'How can I quickly reduce high blood sugar levels if they spike?';
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColor.lightGrayColor,
                                      width: .5),
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
                          );
                        } else {
                          var message = cubit.messages.reversed.toList()[index];
                          if (!message.isGPT) {
                            return buildSenderMessage(context, message);
                          } else {
                            return buildReceiverMessage(context, message);
                          }
                        }
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: cubit.messages.length + 2),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          maxLines: null,
                          style: Styles.regular16,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                if(messageController.text.isNotEmpty){
                                  cubit.chatWithAI(messageController.text);
                                  setState(() {
                                    messageController.clear();
                                  });
                                }
                              },
                              icon: state is ChatWithAILoadingState
                                  ? SizedBox(
                                      width: 25,
                                      height: 25,
                                    child: CircularProgressIndicator(
                                        color: AppColor.primaryColor,
                                      ),
                                  )
                                  : Icon(
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
                            hintStyle: Styles.regular16
                                .copyWith(color: AppColor.lightGrayColor),
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
          ),
        );
      },
    );
  }
}
