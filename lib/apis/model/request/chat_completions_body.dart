// To parse this JSON data, do
//
//     final chatParam = chatParamFromJson(jsonString);

import 'dart:convert';

ChatCompletionsBody chatParamFromJson(String str) => ChatCompletionsBody.fromJson(json.decode(str));

String chatParamToJson(ChatCompletionsBody data) => json.encode(data.toJson());

class ChatCompletionsBody {
  String? model;
  List<Message>? messages;
  bool? stream;
  int? maxTokens;
  dynamic stop;
  double? temperature;
  double? topP;
  int? topK;
  double? frequencyPenalty;
  int? n;

  ChatCompletionsBody({
    this.model,
    this.messages,
    this.stream,
    this.maxTokens,
    this.stop,
    this.temperature,
    this.topP,
    this.topK,
    this.frequencyPenalty,
    this.n,
  });

  factory ChatCompletionsBody.fromJson(Map<String, dynamic> json) => ChatCompletionsBody(
    model: json["model"],
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    stream: json["stream"],
    maxTokens: json["max_tokens"],
    stop: json["stop"],
    temperature: json["temperature"]?.toDouble(),
    topP: json["top_p"]?.toDouble(),
    topK: json["top_k"],
    frequencyPenalty: json["frequency_penalty"]?.toDouble(),
    n: json["n"],
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "stream": stream,
    "max_tokens": maxTokens,
    "stop": stop,
    "temperature": temperature,
    "top_p": topP,
    "top_k": topK,
    "frequency_penalty": frequencyPenalty,
    "n": n,
  };
}

class Message {
  String? role;
  String? content;

  Message({
    this.role,
    this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    role: json["role"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "content": content,
  };
}
