import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/home/ui/pages/ai_chat_page/view_model/ai_chat_page_state.dart';
import 'package:super_fitness/modules/home/ui/pages/ai_chat_page/view_model/ai_chat_page_view_model.dart';

import '../../../../../core/di/injectable_initializer.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends BaseStatefulWidgetState<AiChatPage> {
  late UserEntity? userLoginInfo;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final AiChatPageViewModel aiChatPageViewModel =
      getIt.get<AiChatPageViewModel>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userLoginInfo = Provider.of<UserProvider>(context).userLoginInfo?.user;
    aiChatPageViewModel.doIntent(GetAllChats());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => aiChatPageViewModel,
      child: Scaffold(
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
                  text: appLocalizations.iAmYourSmartCoach,
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
              icon: ImageIcon(
                const AssetImage(AssetsPaths.threeLinesIcon),
                color: AppColors.mainColorDark,
              ),
            ),
          ],
        ),

        endDrawer: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BlocBuilder<AiChatPageViewModel, AiChatPageState>(
              builder: (context, state) {
                switch (state.gatAllChatsStatus) {
                  case Status.idle:
                    return const SizedBox();
                  case Status.loading:
                    return const LoadingStateWidget();
                  case Status.success:
                    var chats = state.chats ?? [];
                    return Drawer(
                      width: screenWidth * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              appLocalizations.previousConversations,
                              textAlign: TextAlign.end,
                              style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child:
                                  chats.isEmpty
                                      ? Center(
                                        child: Text(
                                          appLocalizations.noData,
                                          style: theme.textTheme.titleMedium,
                                        ),
                                      )
                                      : ListView.separated(
                                        itemCount: chats.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            minTileHeight: 35,
                                            minVerticalPadding: 0,
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                DefinedRoutes
                                                    .smartCoachScreenRoute,
                                                arguments: chats[index],
                                              );
                                            },
                                            leading: const Icon(
                                              Icons.arrow_back_ios,
                                              size: 20,
                                            ),
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                              chats[index].title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: theme.textTheme.titleSmall,
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            color: AppColors.black[70],
                                          );
                                        },
                                      ),
                            ),
                          ],
                        ),
                      ),
                    );
                  case Status.error:
                    // TODO: Handle this case.
                    throw UnimplementedError();
                }
              },
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
                          appLocalizations.howCanIAssistYouToday,
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
                          child: Text(appLocalizations.getStarted),
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
      ),
    );
  }
}
