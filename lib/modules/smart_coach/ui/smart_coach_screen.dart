import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/smart_coach/ui/widgets/custom_chat_message_container.dart';

class SmartCoachScreen extends StatefulWidget {
  const SmartCoachScreen({super.key});

  @override
  State<SmartCoachScreen> createState() => _SmartCoachScreenState();
}

class _SmartCoachScreenState extends BaseStatefulWidgetState<SmartCoachScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late UserEntity? userLoginInfo;

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
            child: ListView(
              children: [
                CustomChatMessageContainer(
                  imagePath: AssetsPaths.geminiIcon,
                  message: "Hello How Can I Assist You Today ?",
                  messageBackgroundColor: AppColors.black.withAlpha(126),
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
        ),
      ),
    );
  }
}
