// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      phrase: json['phrase'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'phrase': instance.phrase,
      'author': instance.author,
    };
