import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/smart_coach/ui/view_model/smart_coach_screen_view_model.dart';
import 'package:super_fitness/modules/smart_coach/ui/widgets/custom_chat_message_container.dart';

class SmartCoachScreen extends StatefulWidget {
  const SmartCoachScreen({super.key});

  @override
  State<SmartCoachScreen> createState() => _SmartCoachScreenState();
}

class _SmartCoachScreenState extends BaseStatefulWidgetState<SmartCoachScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late UserEntity? userLoginInfo;
  final FocusNode textFieldFocusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  ValueNotifier<bool> hasFocusNotifier = ValueNotifier(false);
  ValueNotifier<bool> hasText = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    textFieldFocusNode.addListener(() {
      hasFocusNotifier.value = textFieldFocusNode.hasFocus;
      print("========= ${hasFocusNotifier.value}");
    });
    textEditingController.addListener(() {
      hasText.value = textEditingController.text.trim().isNotEmpty;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userLoginInfo = Provider.of<UserProvider>(context).userLoginInfo?.user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.aiChatBg),
          fit: BoxFit.cover,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                "Smart Coach",
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              centerTitle: true,
              actionsPadding: const EdgeInsets.only(right: 4),
              actions: [
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: const ImageIcon(AssetImage(AssetsPaths.threeLinesIcon)),
                ),
              ],
              leading: IconButton(
                color: AppColors.white,
                constraints: const BoxConstraints(maxHeight: 25, maxWidth: 25),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.mainColorLight,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Transform.flip(
                  flipX: !localizationManager.isEnglish,
                  child: const ImageIcon(AssetImage(AssetsPaths.backIcon)),
                ),
              ),
            ),
            endDrawer: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Drawer(
                  width: screenWidth * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Previous Conversations",
                          textAlign: TextAlign.end,
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView.separated(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                minTileHeight: 35,
                                minVerticalPadding: 0,
                                onTap: () {},
                                leading: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Lorem ipsum dolor sit amet",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  style: theme.textTheme.titleSmall,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(color: AppColors.black[70]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      children: [
                        CustomChatMessageContainer(
                          imagePath: AssetsPaths.geminiIcon,
                          message: "Hello How Can I Assist You Today ?",
                          messageBackgroundColor: AppColors.black.withAlpha(
                            126,
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomChatMessageContainer(
                          flipX: true,
                          imagePath: userLoginInfo?.photo ?? "",
                          message: "Lorem ipsum dolor sit amet consectetur.",
                          messageBackgroundColor: AppColors.mainColorLight[80]!
                              .withAlpha(126),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder(
                    valueListenable: hasFocusNotifier,
                    builder: (context, isFocused, child) {
                      return AnimatedContainer(
                        duration: const Duration(seconds: 1000),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                                  isFocused
                                      ? AppColors.mainColorDark
                                      : AppColors.white,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: TextField(
                                  controller: textEditingController,
                                  maxLines: 5,
                                  minLines: isFocused ? 2 : 1,
                                  focusNode: textFieldFocusNode,
                                  decoration: InputDecoration(
                                    hoverColor: Colors.transparent,
                                    border: InputBorder.none,
                                    hintText: "Message Gemini",
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    fillColor: AppColors.black,
                                    filled: true,
                                  ),
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: hasText,
                                builder: (context, hasText, child) {
                                  return Row(
                                    children: [
                                      const Spacer(),
                                      IconButton(
                                        onPressed:
                                            hasText
                                                ? () {
                                                }
                                                : null,
                                        icon: const Icon(Icons.send),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    textFieldFocusNode.dispose();
    textEditingController.dispose();
  }
}
