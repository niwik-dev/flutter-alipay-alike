class ChatInfo{
  String? role;
  String? content;
  String? reasoningContent;

  ChatInfo({
    this.role,
    this.content,
    this.reasoningContent
  });

  ChatInfo copyWith({
    String? role,
    String? content,
    String? reasoningContent
  }){
    return ChatInfo(
      role: role ?? this.role,
      content: content ?? this.content,
      reasoningContent: reasoningContent ?? this.reasoningContent
    );
  }
}