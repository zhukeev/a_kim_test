// To parse this JSON data, do
//
//     final flight = flightFromJson(jsonString);

import 'dart:convert';

import 'package:a_kim_test/util/constants.dart';
import 'package:flutter/widgets.dart';

Flight flightFromJson(String str) => Flight.fromJson(json.decode(str));

String flightToJson(Flight data) => json.encode(data.toJson());

enum Tip { GREAT_VALUE, BELOW_AVERAGE, FREE_WIFI }

class Flight {
  Flight({
    this.name,
    this.abbr,
    this.timeFrom,
    this.duration,
    this.stopsType,
    this.price,
    this.discount,
    this.tip,
  });

  final String name;
  final String abbr;
  final int timeFrom;
  final int duration;
  final String stopsType;
  final double price;
  final int discount;
  final Tip tip;

  Flight copyWith({
    String name,
    String abbr,
    int timeFrom,
    int duration,
    String stopsType,
    double price,
    int discount,
    Tip tip,
  }) =>
      Flight(
        name: name ?? this.name,
        abbr: abbr ?? this.abbr,
        timeFrom: timeFrom ?? this.timeFrom,
        duration: duration ?? this.duration,
        stopsType: stopsType ?? this.stopsType,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        tip: tip ?? this.tip,
      );

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        name: json["name"] == null ? null : json["name"],
        abbr: json["abbr"] == null ? null : json["abbr"],
        timeFrom: json["time_from"] == null ? null : json["time_from"],
        duration: json["duration"] == null ? null : json["duration"],
        stopsType: json["stops_type"] == null ? null : json["stops_type"],
        price: json["price"] == null ? null : json["price"],
        discount: json["discount"] == null ? null : json["discount"],
        tip: json["tip"] == null ? null : Tip.values[json["tip"]],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "abbr": abbr == null ? null : abbr,
        "time_from": timeFrom == null ? null : timeFrom,
        "duration": duration == null ? null : duration,
        "stops_type": stopsType == null ? null : stopsType,
        "price": price == null ? null : price,
        "discount": discount == null ? null : discount,
        "tip": tip == null ? null : tip,
      };
}

extension TipExtension on Tip {
  String get name {
    switch (this) {
      case Tip.BELOW_AVERAGE:
        return 'BELOW AVERAGE';
      case Tip.GREAT_VALUE:
        return 'GREAT VALUE';
      case Tip.FREE_WIFI:
        return 'FREE_WIFI';
      default:
        return null;
    }
  }

  Color get color {
    switch (this) {
      case Tip.BELOW_AVERAGE:
        return Palette.electricViolet;
      case Tip.GREAT_VALUE:
        return Palette.cyanAqua;
      case Tip.FREE_WIFI:
        return Palette.rose;
      default:
        return null;
    }
  }
}
