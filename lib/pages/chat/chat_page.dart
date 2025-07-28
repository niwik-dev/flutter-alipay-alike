import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';


import '../../../components/gradient/presets.dart';
import '../../../components/icons/gradient_icon.dart';
import '../../../model/chat_info.dart';
import '../../../service/chat_service.dart';

class TalkSubPage extends HookWidget {
  const TalkSubPage({
    super.key,
    this.chatResults = const [],
    required this.scrollController,
    required this.onNewTopic,
  });

  final List<ChatInfo> chatResults;

  final ScrollController scrollController;

  final dynamic Function(String) onNewTopic;

  @override
  Widget build(BuildContext context){
    final topicList = useState([
      '💴上个月我的支出总额是多少？',
      '☘今天我的幸运色是什么颜色',
      '👀起底DeepSeek爆火背后的推手',
      '🤔DeepSeek和ChatGPT的异同',
      '✍请帮我写一篇500字随笔文稿',
      '🍎万有引力公式是如何推导出来的？',
      '💻帮我描述一下深度优先遍历算法',
    ]);

    useEffect((){
      // 随机取其中的4个话题
      topicList.value.shuffle();
      topicList.value = topicList.value.sublist(0, 4);
      return null;
    },[]);

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 16
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(127),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child:  Column(
                children: [
                  const Row(
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          TDText(
                            '你好，',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(33, 57, 97, 1)
                            ),
                          ),
                          TDText(
                            '我是您的聊天助手',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(33, 57, 97, 1)
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GradientIcon(
                        Icons.emoji_objects,
                        size: 64,
                        gradient: IconGradientPresets.tech,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const TDText(
                    '我是一个AI智能助手，你可以向我提问任何问题，我尽量为你解决你的问题。',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(33, 57, 97, 1),
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (String topic in topicList.value)
                    ...[
                      GestureDetector(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(64),
                            ),
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8
                            ),
                            child: Row(
                              children: [
                                TDText(
                                  topic,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(33, 57, 97, 1),
                                  ),
                                ),
                              ],
                            )
                        ),
                        onTap: () {
                          onNewTopic(topic);
                        },
                      ),
                      if (topic != topicList.value.last)
                        const SizedBox(height: 8),
                    ]
                ],
              )
          ),
        ),

        for (var chatResult in chatResults)
          SliverToBoxAdapter(
            child: Wrap(
              alignment: chatResult.role == "user" ? WrapAlignment.end : WrapAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 16,right: 16,top: 16),
                    decoration: BoxDecoration(
                        color: chatResult.role == "user" ?
                        Colors.blueAccent.withAlpha((0.8*255).toInt()):
                        Colors.white.withAlpha((0.8*255).toInt()),
                        borderRadius: chatResult.role == "user" ?
                        const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ): const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        )
                    ),
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 12, bottom: 12
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        chatResult.reasoningContent!=null?
                        SelectableText(
                          chatResult.reasoningContent ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                          ),
                        ):const SizedBox.shrink(),
                        SelectableText(
                          (chatResult.role == "user" ? "" : "🤖：") + (chatResult.content!.isEmpty ? "思考中...": chatResult.content!),
                          style: TextStyle(
                            fontSize: 16,
                            color: chatResult.role == "user"? Colors.white:Colors.black,
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          )
      ],
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin{
  late TabController tabController;
  String chatInput = '';
  List<ChatInfo> chatResults = [
    ChatInfo(
      role: "assistant",
      content: "你好，我是您的智能助手。",
      reasoningContent: "我是一个AI智能助手，你可以向我提问任何问题，我尽量为你解决你的问题。"
    ),
  ];
  ScrollController chatScrollController = ScrollController();
  TextEditingController chatInputController = TextEditingController();

  @override
  void initState() {
    tabController = TabController(
        initialIndex: 1,length: 2, vsync: this
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    chatScrollController.dispose();
    super.dispose();
  }

  void newChat(String input) async{
    if (input.isNotEmpty) {
      setState(() {
        chatResults.add(ChatInfo(
          role: "user",
          content: input,
        ));

        chatResults.add(ChatInfo(
          role: "assistant",
          content: "",
        ));
      });

      Future.delayed(const Duration(milliseconds: 100), () {
        chatScrollController.animateTo(
            chatScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut
        );
      });

      await ChatService.getChatAnswerStream(
        qustion: input,
        onReceive: (result) {
          var newContent = result.choices?.first.delta?.content ?? '';
          var originContent = chatResults.last.content;
          if(newContent!= null && newContent.isNotEmpty){
            setState(() {
              chatResults.last.content = (originContent! + newContent).replaceFirst('\n', '');
              chatScrollController.jumpTo(
                chatScrollController.position.maxScrollExtent
              );
            });
          }
        },
      );
    }else{
      TDToast.showText(context: context, '输入内容不能为空哦');
    }
    chatInputController.clear();
  }

  void newChatFromInput() async {
    newChat(chatInput);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180,
              child: TDTabBar(
                controller: tabController,
                showIndicator: true,
                dividerColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                tabs: const [
                  TDTab(
                    text: '此刻',
                    size: TDTabSize.large,
                  ),
                  TDTab(
                      text: '对话',
                      size: TDTabSize.large
                  ),
                ],
              ),
            )
          ],
        ),
        Expanded(
          child: TDTabBarView(
            controller: tabController,
            isSlideSwitch: true,
            children: [
              const Placeholder(),
              TalkSubPage(
                chatResults: chatResults,
                scrollController: chatScrollController,
                onNewTopic: (String newTopic){
                  newChat(newTopic);
                },
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(64),
          ),
          height: 48,
          child: TDInput(
            controller: chatInputController,
            hintText: '有什么需要问我的吗~',
            needClear: false,
            onChanged: (value) {
              setState(() {
                chatInput = value;
              });
            },
            onSubmitted: (value) async => newChatFromInput(),
            leftIcon: const GradientIcon(
              Icons.search,
              size: 24,
              gradient: IconGradientPresets.tech,
            ),
            rightBtn: TDButton(
              onTap: () async => newChatFromInput(),
              type: TDButtonType.ghost,
              child: TDText(
                '发送',
                style: TextStyle(
                  color: TDTheme.of(context).brandColor7,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
