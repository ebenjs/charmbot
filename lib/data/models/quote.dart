import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'quote.g.dart';

@JsonSerializable()
@collection
class Quote {
  Id id;
  final String phrase;
  final String author;

  Quote({this.id = 0, required this.phrase, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
