import '../apis/model/request/chat_completions_body.dart';
import '../apis/model/response/chat_completions_stream_result.dart';
import '../apis/siliconflow_api.dart';
import '../model/chat_info.dart';

class ChatService {
  static Future<List<ChatInfo>> getChatAnswer(String qustion) async {
    var param = ChatCompletionsBody(
      model: "deepseek-ai/DeepSeek-R1-Distill-Qwen-7B",
      messages: [
        Message(
          role: "user",
          content: qustion,
        ),
      ],
      stream: false,
    );
    var result = await SiliconFlowApi.chatCompletions(param);
    List<ChatInfo> chatList = [];
    result.choices?.forEach((choice){
      chatList.add(
        ChatInfo(
          role: choice.message?.role,
          content: choice.message?.content,
          reasoningContent: choice.message?.reasoningContent,
        )
      );
    });
    return chatList;
  }

  static Future<void> getChatAnswerStream({
    required String qustion,
    required Function(ChatCompletionsStreamResult) onReceive,
    Function()? onFinished
  }) async {
    var param = ChatCompletionsBody(
      model: "deepseek-ai/DeepSeek-R1-Distill-Qwen-7B",
      messages: [
        Message(
          role: "user",
          content: qustion,
        ),
      ],
      maxTokens: 2000,
      stream: true,
    );
    SiliconFlowApi.getChatCompletionsStream(
      body: param,
      onReceive: onReceive,
      onFinished: onFinished
    );
  }
}