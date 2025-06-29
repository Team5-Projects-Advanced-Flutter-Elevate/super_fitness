import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends BaseStatefulWidgetState<AiChatPage> {
  late UserEntity? userLoginInfo;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userLoginInfo = Provider.of<UserProvider>(context).userLoginInfo?.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: appLocalizations.hiUser(
                  userLoginInfo?.firstName ?? userLoginInfo?.lastName ?? "",
                ),
                style: theme.textTheme.titleMedium,
              ),
              TextSpan(
                text: "I Am Your Smart Coach",
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
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
                          leading: const Icon(Icons.arrow_back_ios, size: 20),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(AssetsPaths.robotImage),
            ),
            SizedBox(height: screenHeight * 0.05),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(50),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black.withAlpha(100),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "How Can I Assist You\nToday ?",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            DefinedRoutes.smartCoachScreenRoute,
                          );
                        },
                        child: const Text("Get Started"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.15),
          ],
        ),
      ),
    );
  }
}
