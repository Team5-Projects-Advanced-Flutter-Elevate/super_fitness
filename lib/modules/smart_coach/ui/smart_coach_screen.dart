import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/apis/api_error/api_error_handler.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/core/widgets/error_state_widget.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/ui/view_model/smart_coach_screen_view_model.dart';
import 'package:super_fitness/modules/smart_coach/ui/view_model/smart_coach_state.dart';
import 'package:super_fitness/modules/smart_coach/ui/widgets/custom_chat_message_container.dart';

class SmartCoachScreen extends StatefulWidget {
  final ChatHistoryModel? chatHistoryModel;

  const SmartCoachScreen({super.key, this.chatHistoryModel});

  @override
  State<SmartCoachScreen> createState() => _SmartCoachScreenState();
}

class _SmartCoachScreenState extends BaseStatefulWidgetState<SmartCoachScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late UserEntity? userLoginInfo;
  final FocusNode textFieldFocusNode = FocusNode();
  ValueNotifier<bool> hasFocusNotifier = ValueNotifier(false);
  ValueNotifier<bool> hasText = ValueNotifier(false);

  final SmartCoachScreenViewModel smartCoachScreenViewModel =
      getIt.get<SmartCoachScreenViewModel>();

  @override
  void initState() {
    super.initState();
    if (widget.chatHistoryModel != null) {
      smartCoachScreenViewModel.doIntent(
        InitViewModel(chatHistoryModel: widget.chatHistoryModel!),
      );
    } else {
      smartCoachScreenViewModel.doIntent(PromptAiToWelcomeUser());
    }
    smartCoachScreenViewModel.doIntent(GetAllChats());
    textFieldFocusNode.addListener(() {
      hasFocusNotifier.value = textFieldFocusNode.hasFocus;
    });
    smartCoachScreenViewModel.textFieldController.addListener(() {
      hasText.value =
          smartCoachScreenViewModel.textFieldController.text.trim().isNotEmpty;
      smartCoachScreenViewModel.doIntent(UpdateTextFieldTextDirection());
    });
    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pop(
      context,
      smartCoachScreenViewModel.makeAiChatPageReloadPreviousConversations,
    );
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userLoginInfo = Provider.of<UserProvider>(context).userLoginInfo?.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => smartCoachScreenViewModel,
      child: Container(
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
                appLocalizations.smartCoach,
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              centerTitle: true,
              actionsPadding: const EdgeInsets.only(right: 4),
              actions: [
                IconButton(
                  onPressed: () {
                    if (smartCoachScreenViewModel
                        .makeThisScreenReloadPreviousConversations) {
                      smartCoachScreenViewModel.doIntent(GetAllChats());
                      smartCoachScreenViewModel
                          .makeThisScreenReloadPreviousConversations = false;
                    }
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: ImageIcon(
                    const AssetImage(AssetsPaths.threeLinesIcon),
                    color: AppColors.mainColorDark,
                  ),
                ),
              ],
              leading: IconButton(
                color: AppColors.white,
                constraints: const BoxConstraints(maxHeight: 25, maxWidth: 25),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.mainColorLight,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    smartCoachScreenViewModel
                        .makeAiChatPageReloadPreviousConversations,
                  );
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
                          appLocalizations.previousConversations,
                          textAlign: TextAlign.end,
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: BlocBuilder<
                            SmartCoachScreenViewModel,
                            SmartCoachScreenState
                          >(
                            builder: (context, state) {
                              switch (state.getAllChatsStatus) {
                                case Status.idle:
                                  return const SizedBox();
                                case Status.loading:
                                  return const LoadingStateWidget();
                                case Status.success:
                                  var chats = state.previousChats;
                                  return chats.isEmpty
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
                                              if (chats[index].id ==
                                                  smartCoachScreenViewModel
                                                      .chatHistoryModel
                                                      .id) {
                                                scaffoldKey.currentState!
                                                    .closeEndDrawer();
                                              } else {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  DefinedRoutes
                                                      .smartCoachScreenRoute,
                                                  arguments: chats[index],
                                                );
                                              }
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
                                              textDirection:
                                                  smartCoachScreenViewModel
                                                      .determineTextDirectionBasedOnFirstLetter(
                                                        chats[index]
                                                                .title
                                                                .isNotEmpty
                                                            ? chats[index]
                                                                .title[0]
                                                            : "",
                                                      ),
                                              style: theme.textTheme.titleSmall,
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            color: AppColors.black[70],
                                          );
                                        },
                                      );
                                case Status.error:
                                  return ErrorStateWidget(
                                    error: state.getAllChatsError!,
                                  );
                              }
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
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable:
                        smartCoachScreenViewModel.conversationTitleNotifier,
                    builder: (context, title, child) {
                      return Text(
                        title.isEmpty ? appLocalizations.untitledChat : title,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: BlocConsumer<
                        SmartCoachScreenViewModel,
                        SmartCoachScreenState
                      >(
                        listenWhen: (previous, current) {
                          if (current.promptAiModelStatus == Status.error) {
                            return true;
                          }
                          return false;
                        },
                        listener: (context, state) {
                          if (state.promptAiModelStatus == Status.error) {
                            displaySnackBar(
                              contentType: ContentType.failure,
                              title: appLocalizations.error,
                              message: getIt.get<ApiErrorHandler>().handle(
                                state.promptAiModelError!,
                              ),
                              durationInSeconds: 5,
                            );
                          }
                        },
                        builder: (context, state) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.messageItems.length - 2,
                            controller:
                                smartCoachScreenViewModel
                                    .listViewOfChatsController,
                            itemBuilder: (context, index) {
                              if (state.promptAiModelStatus == Status.loading &&
                                  index + 2 == state.messageItems.length - 1) {
                                return CustomChatMessageContainer(
                                  imagePath: AssetsPaths.geminiIcon,
                                  message: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Center(
                                          child:
                                              LoadingAnimationWidget.staggeredDotsWave(
                                                color: AppColors.white,
                                                size: 30,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  messageBackgroundColor: AppColors.black
                                      .withAlpha(150),
                                );
                              } else {
                                String firstChar =
                                    state
                                            .messageItems[index + 2]
                                            .message
                                            .isNotEmpty
                                        ? state
                                            .messageItems[index + 2]
                                            .message[0]
                                        : "";
                                var textDirection = smartCoachScreenViewModel
                                    .determineTextDirectionBasedOnFirstLetter(
                                      firstChar,
                                    );
                                return state.messageItems[index + 2].role ==
                                        MessageRoles.user
                                    ? Center(
                                      child: CustomChatMessageContainer(
                                        flipX: true,
                                        imagePath: userLoginInfo?.photo ?? "",
                                        message: Text(
                                          state.messageItems[index + 2].message,
                                          textDirection: textDirection,
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        messageBackgroundColor: AppColors
                                            .mainColorLight[80]!
                                            .withAlpha(126),
                                      ),
                                    )
                                    : AnimatedContainer(
                                      duration: const Duration(seconds: 4),
                                      child: CustomChatMessageContainer(
                                        imagePath: AssetsPaths.geminiIcon,
                                        message: Text(
                                          state.messageItems[index + 2].message,
                                          textDirection: textDirection,
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        messageBackgroundColor: AppColors.black
                                            .withAlpha(150),
                                      ),
                                    );
                              }
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 24);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder(
                    valueListenable: smartCoachScreenViewModel.tokenNotifier,
                    builder: (context, value, child) {
                      return Text(value, style: theme.textTheme.titleSmall);
                    },
                  ),
                  const SizedBox(height: 4),
                  ValueListenableBuilder(
                    valueListenable: hasFocusNotifier,
                    builder: (context, isFocused, child) {
                      return AnimatedContainer(
                        duration: const Duration(seconds: 1000),
                        child: ValueListenableBuilder(
                          valueListenable:
                              smartCoachScreenViewModel.chatEndedNotifier,
                          builder: (context, didChatEnd, child) {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      didChatEnd
                                          ? AppColors.black[60]!
                                          : isFocused
                                          ? AppColors.mainColorDark
                                          : AppColors.white,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: ValueListenableBuilder(
                                      valueListenable:
                                          smartCoachScreenViewModel
                                              .textFieldTextDirectionNotifier,
                                      builder: (context, direction, child) {
                                        return TextField(
                                          enabled: !didChatEnd,
                                          controller:
                                              smartCoachScreenViewModel
                                                  .textFieldController,
                                          textDirection: direction,
                                          maxLines: 5,
                                          minLines: 1,
                                          focusNode: textFieldFocusNode,
                                          decoration: InputDecoration(
                                            hoverColor: Colors.transparent,
                                            border: InputBorder.none,
                                            hintText:
                                                appLocalizations.messageGemini,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            fillColor: AppColors.black,
                                            filled: true,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: hasText,
                                    builder: (context, hasText, child) {
                                      return ValueListenableBuilder(
                                        valueListenable:
                                            smartCoachScreenViewModel
                                                .takeAnotherMessageNotifier,
                                        builder: (
                                          context,
                                          takeAnotherMessage,
                                          child,
                                        ) {
                                          return Row(
                                            children: [
                                              const Spacer(),
                                              IconButton(
                                                onPressed:
                                                    hasText &&
                                                            takeAnotherMessage
                                                        ? () {
                                                          smartCoachScreenViewModel.doIntent(
                                                            PromptAiToAnswerUser(
                                                              message:
                                                                  smartCoachScreenViewModel
                                                                      .textFieldController
                                                                      .text,
                                                            ),
                                                          );
                                                          smartCoachScreenViewModel
                                                              .textFieldController
                                                              .clear();
                                                          FocusManager
                                                              .instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        }
                                                        : null,
                                                icon: const Icon(Icons.send),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
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
    smartCoachScreenViewModel.textFieldController.dispose();
    BackButtonInterceptor.remove(myInterceptor);
  }
}
