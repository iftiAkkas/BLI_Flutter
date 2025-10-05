import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_model.g.dart';

@JsonSerializable()
class Story extends Equatable {
  final String? by;
  final int? descendants;
  final int? id;
  final List<int>? kids;
  final int? score;
  final int? time;
  final String? title;
  final String? type;
  final String? url;
  final String? text; // Added for comments

  const Story({
    this.by,
    this.descendants,
    this.id,
    this.kids,
    this.score,
    this.time,
    this.title,
    this.type,
    this.url,
    this.text, // include in constructor
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);

  Story copyWith({
    String? by,
    int? descendants,
    int? id,
    List<int>? kids,
    int? score,
    int? time,
    String? title,
    String? type,
    String? url,
    String? text, // include in copyWith
  }) {
    return Story(
      by: by ?? this.by,
      descendants: descendants ?? this.descendants,
      id: id ?? this.id,
      kids: kids ?? this.kids,
      score: score ?? this.score,
      time: time ?? this.time,
      title: title ?? this.title,
      type: type ?? this.type,
      url: url ?? this.url,
      text: text ?? this.text,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        by,
        descendants,
        id,
        kids,
        score,
        time,
        title,
        type,
        url,
        text, // include in props
      ];
}
