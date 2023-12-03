// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appdb.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, UserEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _adminMeta = const VerificationMeta('admin');
  @override
  late final GeneratedColumn<int> admin = GeneratedColumn<int>(
      'admin', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _excludeAnsweredMeta =
      const VerificationMeta('excludeAnswered');
  @override
  late final GeneratedColumn<int> excludeAnswered = GeneratedColumn<int>(
      'exclude_answered', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [name, id, password, admin, excludeAnswered];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<UserEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('admin')) {
      context.handle(
          _adminMeta, admin.isAcceptableOrUnknown(data['admin']!, _adminMeta));
    } else if (isInserting) {
      context.missing(_adminMeta);
    }
    if (data.containsKey('exclude_answered')) {
      context.handle(
          _excludeAnsweredMeta,
          excludeAnswered.isAcceptableOrUnknown(
              data['exclude_answered']!, _excludeAnsweredMeta));
    } else if (isInserting) {
      context.missing(_excludeAnsweredMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  UserEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserEntry(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      admin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}admin'])!,
      excludeAnswered: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exclude_answered'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserEntry extends DataClass implements Insertable<UserEntry> {
  final String name;
  final int id;
  final String password;
  final int admin;
  final int excludeAnswered;
  const UserEntry(
      {required this.name,
      required this.id,
      required this.password,
      required this.admin,
      required this.excludeAnswered});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['id'] = Variable<int>(id);
    map['password'] = Variable<String>(password);
    map['admin'] = Variable<int>(admin);
    map['exclude_answered'] = Variable<int>(excludeAnswered);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      name: Value(name),
      id: Value(id),
      password: Value(password),
      admin: Value(admin),
      excludeAnswered: Value(excludeAnswered),
    );
  }

  factory UserEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserEntry(
      name: serializer.fromJson<String>(json['name']),
      id: serializer.fromJson<int>(json['id']),
      password: serializer.fromJson<String>(json['password']),
      admin: serializer.fromJson<int>(json['admin']),
      excludeAnswered: serializer.fromJson<int>(json['excludeAnswered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'id': serializer.toJson<int>(id),
      'password': serializer.toJson<String>(password),
      'admin': serializer.toJson<int>(admin),
      'excludeAnswered': serializer.toJson<int>(excludeAnswered),
    };
  }

  UserEntry copyWith(
          {String? name,
          int? id,
          String? password,
          int? admin,
          int? excludeAnswered}) =>
      UserEntry(
        name: name ?? this.name,
        id: id ?? this.id,
        password: password ?? this.password,
        admin: admin ?? this.admin,
        excludeAnswered: excludeAnswered ?? this.excludeAnswered,
      );
  @override
  String toString() {
    return (StringBuffer('UserEntry(')
          ..write('name: $name, ')
          ..write('id: $id, ')
          ..write('password: $password, ')
          ..write('admin: $admin, ')
          ..write('excludeAnswered: $excludeAnswered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, id, password, admin, excludeAnswered);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserEntry &&
          other.name == this.name &&
          other.id == this.id &&
          other.password == this.password &&
          other.admin == this.admin &&
          other.excludeAnswered == this.excludeAnswered);
}

class UsersCompanion extends UpdateCompanion<UserEntry> {
  final Value<String> name;
  final Value<int> id;
  final Value<String> password;
  final Value<int> admin;
  final Value<int> excludeAnswered;
  final Value<int> rowid;
  const UsersCompanion({
    this.name = const Value.absent(),
    this.id = const Value.absent(),
    this.password = const Value.absent(),
    this.admin = const Value.absent(),
    this.excludeAnswered = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String name,
    required int id,
    required String password,
    required int admin,
    required int excludeAnswered,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        id = Value(id),
        password = Value(password),
        admin = Value(admin),
        excludeAnswered = Value(excludeAnswered);
  static Insertable<UserEntry> custom({
    Expression<String>? name,
    Expression<int>? id,
    Expression<String>? password,
    Expression<int>? admin,
    Expression<int>? excludeAnswered,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (id != null) 'id': id,
      if (password != null) 'password': password,
      if (admin != null) 'admin': admin,
      if (excludeAnswered != null) 'exclude_answered': excludeAnswered,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? name,
      Value<int>? id,
      Value<String>? password,
      Value<int>? admin,
      Value<int>? excludeAnswered,
      Value<int>? rowid}) {
    return UsersCompanion(
      name: name ?? this.name,
      id: id ?? this.id,
      password: password ?? this.password,
      admin: admin ?? this.admin,
      excludeAnswered: excludeAnswered ?? this.excludeAnswered,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (admin.present) {
      map['admin'] = Variable<int>(admin.value);
    }
    if (excludeAnswered.present) {
      map['exclude_answered'] = Variable<int>(excludeAnswered.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('name: $name, ')
          ..write('id: $id, ')
          ..write('password: $password, ')
          ..write('admin: $admin, ')
          ..write('excludeAnswered: $excludeAnswered, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, QuestionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _examSemesterMeta =
      const VerificationMeta('examSemester');
  @override
  late final GeneratedColumn<String> examSemester = GeneratedColumn<String>(
      'exam_semester', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _examUnitMeta =
      const VerificationMeta('examUnit');
  @override
  late final GeneratedColumn<int> examUnit = GeneratedColumn<int>(
      'exam_unit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _questionNumMeta =
      const VerificationMeta('questionNum');
  @override
  late final GeneratedColumn<int> questionNum = GeneratedColumn<int>(
      'question_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _givenMeta = const VerificationMeta('given');
  @override
  late final GeneratedColumn<String> given = GeneratedColumn<String>(
      'given', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _explanationMeta =
      const VerificationMeta('explanation');
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
      'explanation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
      'answer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _possibleAnswersMeta =
      const VerificationMeta('possibleAnswers');
  @override
  late final GeneratedColumn<String> possibleAnswers = GeneratedColumn<String>(
      'possible_answers', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usersAnsweredMeta =
      const VerificationMeta('usersAnswered');
  @override
  late final GeneratedColumn<String> usersAnswered = GeneratedColumn<String>(
      'users_answered', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        examSemester,
        examUnit,
        questionNum,
        type,
        given,
        explanation,
        answer,
        possibleAnswers,
        usersAnswered
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exam_semester')) {
      context.handle(
          _examSemesterMeta,
          examSemester.isAcceptableOrUnknown(
              data['exam_semester']!, _examSemesterMeta));
    } else if (isInserting) {
      context.missing(_examSemesterMeta);
    }
    if (data.containsKey('exam_unit')) {
      context.handle(_examUnitMeta,
          examUnit.isAcceptableOrUnknown(data['exam_unit']!, _examUnitMeta));
    } else if (isInserting) {
      context.missing(_examUnitMeta);
    }
    if (data.containsKey('question_num')) {
      context.handle(
          _questionNumMeta,
          questionNum.isAcceptableOrUnknown(
              data['question_num']!, _questionNumMeta));
    } else if (isInserting) {
      context.missing(_questionNumMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('given')) {
      context.handle(
          _givenMeta, given.isAcceptableOrUnknown(data['given']!, _givenMeta));
    } else if (isInserting) {
      context.missing(_givenMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
          _explanationMeta,
          explanation.isAcceptableOrUnknown(
              data['explanation']!, _explanationMeta));
    } else if (isInserting) {
      context.missing(_explanationMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(_answerMeta,
          answer.isAcceptableOrUnknown(data['answer']!, _answerMeta));
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('possible_answers')) {
      context.handle(
          _possibleAnswersMeta,
          possibleAnswers.isAcceptableOrUnknown(
              data['possible_answers']!, _possibleAnswersMeta));
    } else if (isInserting) {
      context.missing(_possibleAnswersMeta);
    }
    if (data.containsKey('users_answered')) {
      context.handle(
          _usersAnsweredMeta,
          usersAnswered.isAcceptableOrUnknown(
              data['users_answered']!, _usersAnsweredMeta));
    } else if (isInserting) {
      context.missing(_usersAnsweredMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  QuestionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionEntry(
      examSemester: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exam_semester'])!,
      examUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exam_unit'])!,
      questionNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_num'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      given: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}given'])!,
      explanation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation'])!,
      answer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answer'])!,
      possibleAnswers: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}possible_answers'])!,
      usersAnswered: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}users_answered'])!,
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class QuestionEntry extends DataClass implements Insertable<QuestionEntry> {
  final String examSemester;
  final int examUnit;
  final int questionNum;
  final String type;
  final String given;
  final String explanation;
  final String answer;
  final String possibleAnswers;
  final String usersAnswered;
  const QuestionEntry(
      {required this.examSemester,
      required this.examUnit,
      required this.questionNum,
      required this.type,
      required this.given,
      required this.explanation,
      required this.answer,
      required this.possibleAnswers,
      required this.usersAnswered});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exam_semester'] = Variable<String>(examSemester);
    map['exam_unit'] = Variable<int>(examUnit);
    map['question_num'] = Variable<int>(questionNum);
    map['type'] = Variable<String>(type);
    map['given'] = Variable<String>(given);
    map['explanation'] = Variable<String>(explanation);
    map['answer'] = Variable<String>(answer);
    map['possible_answers'] = Variable<String>(possibleAnswers);
    map['users_answered'] = Variable<String>(usersAnswered);
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      examSemester: Value(examSemester),
      examUnit: Value(examUnit),
      questionNum: Value(questionNum),
      type: Value(type),
      given: Value(given),
      explanation: Value(explanation),
      answer: Value(answer),
      possibleAnswers: Value(possibleAnswers),
      usersAnswered: Value(usersAnswered),
    );
  }

  factory QuestionEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionEntry(
      examSemester: serializer.fromJson<String>(json['examSemester']),
      examUnit: serializer.fromJson<int>(json['examUnit']),
      questionNum: serializer.fromJson<int>(json['questionNum']),
      type: serializer.fromJson<String>(json['type']),
      given: serializer.fromJson<String>(json['given']),
      explanation: serializer.fromJson<String>(json['explanation']),
      answer: serializer.fromJson<String>(json['answer']),
      possibleAnswers: serializer.fromJson<String>(json['possibleAnswers']),
      usersAnswered: serializer.fromJson<String>(json['usersAnswered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'examSemester': serializer.toJson<String>(examSemester),
      'examUnit': serializer.toJson<int>(examUnit),
      'questionNum': serializer.toJson<int>(questionNum),
      'type': serializer.toJson<String>(type),
      'given': serializer.toJson<String>(given),
      'explanation': serializer.toJson<String>(explanation),
      'answer': serializer.toJson<String>(answer),
      'possibleAnswers': serializer.toJson<String>(possibleAnswers),
      'usersAnswered': serializer.toJson<String>(usersAnswered),
    };
  }

  QuestionEntry copyWith(
          {String? examSemester,
          int? examUnit,
          int? questionNum,
          String? type,
          String? given,
          String? explanation,
          String? answer,
          String? possibleAnswers,
          String? usersAnswered}) =>
      QuestionEntry(
        examSemester: examSemester ?? this.examSemester,
        examUnit: examUnit ?? this.examUnit,
        questionNum: questionNum ?? this.questionNum,
        type: type ?? this.type,
        given: given ?? this.given,
        explanation: explanation ?? this.explanation,
        answer: answer ?? this.answer,
        possibleAnswers: possibleAnswers ?? this.possibleAnswers,
        usersAnswered: usersAnswered ?? this.usersAnswered,
      );
  @override
  String toString() {
    return (StringBuffer('QuestionEntry(')
          ..write('examSemester: $examSemester, ')
          ..write('examUnit: $examUnit, ')
          ..write('questionNum: $questionNum, ')
          ..write('type: $type, ')
          ..write('given: $given, ')
          ..write('explanation: $explanation, ')
          ..write('answer: $answer, ')
          ..write('possibleAnswers: $possibleAnswers, ')
          ..write('usersAnswered: $usersAnswered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(examSemester, examUnit, questionNum, type,
      given, explanation, answer, possibleAnswers, usersAnswered);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionEntry &&
          other.examSemester == this.examSemester &&
          other.examUnit == this.examUnit &&
          other.questionNum == this.questionNum &&
          other.type == this.type &&
          other.given == this.given &&
          other.explanation == this.explanation &&
          other.answer == this.answer &&
          other.possibleAnswers == this.possibleAnswers &&
          other.usersAnswered == this.usersAnswered);
}

class QuestionsCompanion extends UpdateCompanion<QuestionEntry> {
  final Value<String> examSemester;
  final Value<int> examUnit;
  final Value<int> questionNum;
  final Value<String> type;
  final Value<String> given;
  final Value<String> explanation;
  final Value<String> answer;
  final Value<String> possibleAnswers;
  final Value<String> usersAnswered;
  final Value<int> rowid;
  const QuestionsCompanion({
    this.examSemester = const Value.absent(),
    this.examUnit = const Value.absent(),
    this.questionNum = const Value.absent(),
    this.type = const Value.absent(),
    this.given = const Value.absent(),
    this.explanation = const Value.absent(),
    this.answer = const Value.absent(),
    this.possibleAnswers = const Value.absent(),
    this.usersAnswered = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsCompanion.insert({
    required String examSemester,
    required int examUnit,
    required int questionNum,
    required String type,
    required String given,
    required String explanation,
    required String answer,
    required String possibleAnswers,
    required String usersAnswered,
    this.rowid = const Value.absent(),
  })  : examSemester = Value(examSemester),
        examUnit = Value(examUnit),
        questionNum = Value(questionNum),
        type = Value(type),
        given = Value(given),
        explanation = Value(explanation),
        answer = Value(answer),
        possibleAnswers = Value(possibleAnswers),
        usersAnswered = Value(usersAnswered);
  static Insertable<QuestionEntry> custom({
    Expression<String>? examSemester,
    Expression<int>? examUnit,
    Expression<int>? questionNum,
    Expression<String>? type,
    Expression<String>? given,
    Expression<String>? explanation,
    Expression<String>? answer,
    Expression<String>? possibleAnswers,
    Expression<String>? usersAnswered,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (examSemester != null) 'exam_semester': examSemester,
      if (examUnit != null) 'exam_unit': examUnit,
      if (questionNum != null) 'question_num': questionNum,
      if (type != null) 'type': type,
      if (given != null) 'given': given,
      if (explanation != null) 'explanation': explanation,
      if (answer != null) 'answer': answer,
      if (possibleAnswers != null) 'possible_answers': possibleAnswers,
      if (usersAnswered != null) 'users_answered': usersAnswered,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsCompanion copyWith(
      {Value<String>? examSemester,
      Value<int>? examUnit,
      Value<int>? questionNum,
      Value<String>? type,
      Value<String>? given,
      Value<String>? explanation,
      Value<String>? answer,
      Value<String>? possibleAnswers,
      Value<String>? usersAnswered,
      Value<int>? rowid}) {
    return QuestionsCompanion(
      examSemester: examSemester ?? this.examSemester,
      examUnit: examUnit ?? this.examUnit,
      questionNum: questionNum ?? this.questionNum,
      type: type ?? this.type,
      given: given ?? this.given,
      explanation: explanation ?? this.explanation,
      answer: answer ?? this.answer,
      possibleAnswers: possibleAnswers ?? this.possibleAnswers,
      usersAnswered: usersAnswered ?? this.usersAnswered,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (examSemester.present) {
      map['exam_semester'] = Variable<String>(examSemester.value);
    }
    if (examUnit.present) {
      map['exam_unit'] = Variable<int>(examUnit.value);
    }
    if (questionNum.present) {
      map['question_num'] = Variable<int>(questionNum.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (given.present) {
      map['given'] = Variable<String>(given.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (possibleAnswers.present) {
      map['possible_answers'] = Variable<String>(possibleAnswers.value);
    }
    if (usersAnswered.present) {
      map['users_answered'] = Variable<String>(usersAnswered.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('examSemester: $examSemester, ')
          ..write('examUnit: $examUnit, ')
          ..write('questionNum: $questionNum, ')
          ..write('type: $type, ')
          ..write('given: $given, ')
          ..write('explanation: $explanation, ')
          ..write('answer: $answer, ')
          ..write('possibleAnswers: $possibleAnswers, ')
          ..write('usersAnswered: $usersAnswered, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, questions];
}
