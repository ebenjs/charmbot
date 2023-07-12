import 'package:json_annotation/json_annotation.dart';
part 'quote.g.dart';

@JsonSerializable()
class Quote {
  final String phrase;
  final String author;

  Quote({required this.phrase, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
