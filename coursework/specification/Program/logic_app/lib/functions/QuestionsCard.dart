import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

class QuestionCard  {
  final int id ;
  final String question ;
  final List<String> options ;
  final int correctIndex ;
  final String createdTime ;
  final String modifiedTime ;


  QuestionCard({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.createdTime,
    required this.modifiedTime,
  });

  Map<String, Object> toMap() {
    return {
      'id': id,
      'question_content': question,
      'options': jsonEncode(options),
      'answer': correctIndex,
      'created_time': createdTime,
      'modified_time': modifiedTime,
    };
  }
}

