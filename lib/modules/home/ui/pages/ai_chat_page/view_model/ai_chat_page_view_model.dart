import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/modules/home/ui/pages/ai_chat_page/view_model/ai_chat_page_state.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/use_cases/get_all_chats_use_case.dart';

import '../../../../../../core/di/injectable_initializer.dart';

@injectable
class AiChatPageViewModel extends Cubit<AiChatPageState> {
  final GetAllChatsUseCase _getAllChatsUseCase;

  AiChatPageViewModel(this._getAllChatsUseCase)
    : super(const AiChatPageState());

  void doIntent(AiChatPageIntent intent) {
    switch (intent) {
      case GetAllChats():
        _getAllChats();
        break;
    }
  }

  void _getAllChats() async {
    var userInfo = getIt.get<UserProvider>().userLoginInfo?.user;
    var useCaseResult = await _getAllChatsUseCase.call(userInfo?.id ?? "");
    switch (useCaseResult) {
      case Success<List<ChatHistoryModel>>():
        emit(
          AiChatPageState(
            gatAllChatsStatus: Status.success,
            chats: useCaseResult.data,
          ),
        );
      case Error<List<ChatHistoryModel>>():
        emit(
          AiChatPageState(
            gatAllChatsStatus: Status.error,
            gatAllChatsError: useCaseResult.error,
          ),
        );
    }
  }
}

sealed class AiChatPageIntent {}

class GetAllChats extends AiChatPageIntent {}
