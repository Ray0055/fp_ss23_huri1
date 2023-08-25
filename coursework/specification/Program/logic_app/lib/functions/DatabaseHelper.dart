import 'package:logic_app/functions/QuestionsCard.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'dart:convert';
class DatabaseHelper extends ChangeNotifier {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('quiz_app.db');
    return _database!;
  }
  
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE questions (
  id INTEGER,
  question_content TEXT,
  options TEXT,
  answer INTEGER,
  created_time TEXT,
  modified_time TEXT
)
''');
    await db.execute('''
CREATE TABLE users (
  id INTEGER,
  username TEXT,
  total_done INTEGER,
  total_correct INTEGER
)
''');
  }

  Future<void> addQuestions(QuestionCard question) async{
    final db = await database;
    await db.insert('questions', question.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);

  }

  Future<void> clearTable() async {
    final db = await database;
    await db.delete('questions');
  }

  Future<QuestionCard?> getQuestionById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'questions', // table name
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final map = maps.first;
      return QuestionCard(
        id: map['id'],
        question: map['question_content'],
        options: (jsonDecode(map['options']) as List).cast<String>(),
        correctIndex: map['answer'],
        createdTime: map['created_time'],
        modifiedTime: map['modified_time'],
      );
    }

  }



}


