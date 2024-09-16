import 'dart:async';
import 'dart:async';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:test_visioad_app/core/local_db/error/excepetions.dart';

class StoriesServices {
  Database? _stories_db;

  List<DatabaseStories> _stories = [];

  final _storiesStreamController =
  StreamController<List<DatabaseStories>>.broadcast();

  Stream<List<DatabaseStories>> get allStories =>
      _storiesStreamController.stream;

  static final StoriesServices _shared = StoriesServices._sharedInstance();

  StoriesServices._sharedInstance();

  factory StoriesServices()=> _shared;

  Future<void> _cacheStories() async {
    final allStories = await getAllStories();
    _stories = allStories.toList();
    _storiesStreamController.add(_stories);
  }

  Future<List<DatabaseStories>> getAllTheSorties() async {
    final allStories = await getAllStories();
    _stories = allStories.toList();
    return _stories;
  }

  Future<void> open() async {
    if (_stories_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _stories_db = db;
      await db.execute(createStoryTable);

      await _cacheStories();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentDirectory();
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseAlreadyOpenException {

    }
  }

  Future<void> close() async {
    Database? _db;
    final db = _db;

    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      await db.close();
      _db = null;
    }
  }
  Database _getDatabaseOrThrow() {
    final db = _stories_db;

    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }



  Future<DatabaseStories> createStory({required String title,required String abstract,required String byline,required String publishedDate,}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    // final results = await db.query(
    //   storyTable,
    //   limit: 1,
    //   where: 'title = ?',
    //   whereArgs: [title],
    // );
    // if (results.isNotEmpty) {
    //   throw StoryAlreadyExists();
    // }
    final id =
    await db.insert(storyTable, {titleColumn: title,abstractColumn: abstract,bylineColumn: byline,publishedDateColumn: publishedDate,});

    return DatabaseStories(id:id,title: title, abstract: abstract,byline:byline,publishedDate:publishedDate);
  }



  Future<Iterable<DatabaseStories>> getAllStories() async {
    await _ensureDbIsOpen();

    final db = _getDatabaseOrThrow();
    final stories = await db.query(
      storyTable,
    );

    return stories.map((storyRow) => DatabaseStories.fromRow(storyRow));
  }


}
class DatabaseStories {
  final int id;
  final String title;
  final String abstract;
  final String byline;
  final String publishedDate;

  DatabaseStories(
      {required this.id,
        required this.title,
        required this.abstract,
        required this.byline,
        required this.publishedDate});

  DatabaseStories.fromRow(Map<String, Object?> map,)
      : id = map[idColumn] as int,
        title = map[titleColumn] as String,
        abstract = map[abstractColumn] as String,
        byline = map[bylineColumn] as String,
        publishedDate = map[publishedDateColumn] as String
  ;

  @override
  String toString() =>
      'Story, ID = $id,title = $title,abstract = $abstract, byline = $byline,publishedDate=$publishedDate ';

  @override
  bool operator ==(covariant DatabaseStories other) => title == other.title;

  @override
  get hashCode => title.hashCode;
}


const dbName = "stories.db";
const storyTable = "story";
const idColumn = "id";
const titleColumn = "title";
const bylineColumn = "byline";
const abstractColumn = "abstract";
// const imageColumn = "image";
const publishedDateColumn = "publishedDate";

const createStoryTable = '''CREATE TABLE IF NOT EXISTS "story" (
	"id"	INTEGER NOT NULL,
	"title"	TEXT NOT NULL ,
	"abstract"	TEXT NOT NULL ,
	"byline"	TEXT NOT NULL ,
	"publishedDate"	TEXT NOT NULL ,
	PRIMARY KEY("id" AUTOINCREMENT)
);      ''';
