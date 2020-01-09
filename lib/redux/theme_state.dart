import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ThemeState extends Equatable {
  final ThemeData theme;

  ThemeState({
    @required this.theme,
  }) : assert(
          theme != null,
        );

  factory ThemeState.initial() => ThemeState(
        theme: ThemeData.dark(),
      );

  @override
  List<Object> get props => [theme];
}
