// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
  by: json['by'] as String?,
  descendants: (json['descendants'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
  kids: (json['kids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  score: (json['score'] as num?)?.toInt(),
  time: (json['time'] as num?)?.toInt(),
  title: json['title'] as String?,
  type: json['type'] as String?,
  url: json['url'] as String?,
  text: json['text'] as String?,
);

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
  'by': instance.by,
  'descendants': instance.descendants,
  'id': instance.id,
  'kids': instance.kids,
  'score': instance.score,
  'time': instance.time,
  'title': instance.title,
  'type': instance.type,
  'url': instance.url,
  'text': instance.text,
};
