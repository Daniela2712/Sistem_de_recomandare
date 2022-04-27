// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_manager.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String mail;
  final String country;
  final String language;
  User(
      {@required this.id,
      @required this.username,
      @required this.mail,
      @required this.country,
      @required this.language});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      mail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mail']),
      country: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}country']),
      language: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || mail != null) {
      map['mail'] = Variable<String>(mail);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      mail: mail == null && nullToAbsent ? const Value.absent() : Value(mail),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      mail: serializer.fromJson<String>(json['mail']),
      country: serializer.fromJson<String>(json['country']),
      language: serializer.fromJson<String>(json['language']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'mail': serializer.toJson<String>(mail),
      'country': serializer.toJson<String>(country),
      'language': serializer.toJson<String>(language),
    };
  }

  User copyWith(
          {int id,
          String username,
          String mail,
          String country,
          String language}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        mail: mail ?? this.mail,
        country: country ?? this.country,
        language: language ?? this.language,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('mail: $mail, ')
          ..write('country: $country, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, mail, country, language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.mail == this.mail &&
          other.country == this.country &&
          other.language == this.language);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> mail;
  final Value<String> country;
  final Value<String> language;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.mail = const Value.absent(),
    this.country = const Value.absent(),
    this.language = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    @required String username,
    @required String mail,
    @required String country,
    @required String language,
  })  : username = Value(username),
        mail = Value(mail),
        country = Value(country),
        language = Value(language);
  static Insertable<User> custom({
    Expression<int> id,
    Expression<String> username,
    Expression<String> mail,
    Expression<String> country,
    Expression<String> language,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (mail != null) 'mail': mail,
      if (country != null) 'country': country,
      if (language != null) 'language': language,
    });
  }

  UsersCompanion copyWith(
      {Value<int> id,
      Value<String> username,
      Value<String> mail,
      Value<String> country,
      Value<String> language}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      mail: mail ?? this.mail,
      country: country ?? this.country,
      language: language ?? this.language,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (mail.present) {
      map['mail'] = Variable<String>(mail.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('mail: $mail, ')
          ..write('country: $country, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  GeneratedColumn<String> _username;
  @override
  GeneratedColumn<String> get username =>
      _username ??= GeneratedColumn<String>('username', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _mailMeta = const VerificationMeta('mail');
  GeneratedColumn<String> _mail;
  @override
  GeneratedColumn<String> get mail =>
      _mail ??= GeneratedColumn<String>('mail', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  GeneratedColumn<String> _country;
  @override
  GeneratedColumn<String> get country =>
      _country ??= GeneratedColumn<String>('country', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _languageMeta = const VerificationMeta('language');
  GeneratedColumn<String> _language;
  @override
  GeneratedColumn<String> get language =>
      _language ??= GeneratedColumn<String>('language', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, username, mail, country, language];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username'], _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('mail')) {
      context.handle(
          _mailMeta, mail.isAcceptableOrUnknown(data['mail'], _mailMeta));
    } else if (isInserting) {
      context.missing(_mailMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country'], _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language'], _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    return User.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

abstract class _$UserDatabase extends GeneratedDatabase {
  _$UserDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}

class Tronson extends DataClass implements Insertable<Tronson> {
  final int id;
  final String origin;
  final String destination;
  final String duration;
  final String distance;
  final String cost;
  Tronson(
      {@required this.id,
      @required this.origin,
      @required this.destination,
      @required this.duration,
      @required this.distance,
      @required this.cost});
  factory Tronson.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Tronson(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      origin: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}origin']),
      destination: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}destination']),
      duration: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration']),
      distance: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}distance']),
      cost: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cost']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || origin != null) {
      map['origin'] = Variable<String>(origin);
    }
    if (!nullToAbsent || destination != null) {
      map['destination'] = Variable<String>(destination);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<String>(duration);
    }
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<String>(distance);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<String>(cost);
    }
    return map;
  }

  TronsonsCompanion toCompanion(bool nullToAbsent) {
    return TronsonsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      origin:
          origin == null && nullToAbsent ? const Value.absent() : Value(origin),
      destination: destination == null && nullToAbsent
          ? const Value.absent()
          : Value(destination),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
    );
  }

  factory Tronson.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tronson(
      id: serializer.fromJson<int>(json['id']),
      origin: serializer.fromJson<String>(json['origin']),
      destination: serializer.fromJson<String>(json['destination']),
      duration: serializer.fromJson<String>(json['duration']),
      distance: serializer.fromJson<String>(json['distance']),
      cost: serializer.fromJson<String>(json['cost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'origin': serializer.toJson<String>(origin),
      'destination': serializer.toJson<String>(destination),
      'duration': serializer.toJson<String>(duration),
      'distance': serializer.toJson<String>(distance),
      'cost': serializer.toJson<String>(cost),
    };
  }

  Tronson copyWith(
          {int id,
          String origin,
          String destination,
          String duration,
          String distance,
          String cost}) =>
      Tronson(
        id: id ?? this.id,
        origin: origin ?? this.origin,
        destination: destination ?? this.destination,
        duration: duration ?? this.duration,
        distance: distance ?? this.distance,
        cost: cost ?? this.cost,
      );
  @override
  String toString() {
    return (StringBuffer('Tronson(')
          ..write('id: $id, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('duration: $duration, ')
          ..write('distance: $distance, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, origin, destination, duration, distance, cost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tronson &&
          other.id == this.id &&
          other.origin == this.origin &&
          other.destination == this.destination &&
          other.duration == this.duration &&
          other.distance == this.distance &&
          other.cost == this.cost);
}

class TronsonsCompanion extends UpdateCompanion<Tronson> {
  final Value<int> id;
  final Value<String> origin;
  final Value<String> destination;
  final Value<String> duration;
  final Value<String> distance;
  final Value<String> cost;
  const TronsonsCompanion({
    this.id = const Value.absent(),
    this.origin = const Value.absent(),
    this.destination = const Value.absent(),
    this.duration = const Value.absent(),
    this.distance = const Value.absent(),
    this.cost = const Value.absent(),
  });
  TronsonsCompanion.insert({
    this.id = const Value.absent(),
    @required String origin,
    @required String destination,
    @required String duration,
    @required String distance,
    @required String cost,
  })  : origin = Value(origin),
        destination = Value(destination),
        duration = Value(duration),
        distance = Value(distance),
        cost = Value(cost);
  static Insertable<Tronson> custom({
    Expression<int> id,
    Expression<String> origin,
    Expression<String> destination,
    Expression<String> duration,
    Expression<String> distance,
    Expression<String> cost,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (origin != null) 'origin': origin,
      if (destination != null) 'destination': destination,
      if (duration != null) 'duration': duration,
      if (distance != null) 'distance': distance,
      if (cost != null) 'cost': cost,
    });
  }

  TronsonsCompanion copyWith(
      {Value<int> id,
      Value<String> origin,
      Value<String> destination,
      Value<String> duration,
      Value<String> distance,
      Value<String> cost}) {
    return TronsonsCompanion(
      id: id ?? this.id,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      cost: cost ?? this.cost,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (destination.present) {
      map['destination'] = Variable<String>(destination.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (distance.present) {
      map['distance'] = Variable<String>(distance.value);
    }
    if (cost.present) {
      map['cost'] = Variable<String>(cost.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TronsonsCompanion(')
          ..write('id: $id, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('duration: $duration, ')
          ..write('distance: $distance, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }
}

class $TronsonsTable extends Tronsons with TableInfo<$TronsonsTable, Tronson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $TronsonsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _originMeta = const VerificationMeta('origin');
  GeneratedColumn<String> _origin;
  @override
  GeneratedColumn<String> get origin =>
      _origin ??= GeneratedColumn<String>('origin', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _destinationMeta =
      const VerificationMeta('destination');
  GeneratedColumn<String> _destination;
  @override
  GeneratedColumn<String> get destination => _destination ??=
      GeneratedColumn<String>('destination', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  GeneratedColumn<String> _duration;
  @override
  GeneratedColumn<String> get duration =>
      _duration ??= GeneratedColumn<String>('duration', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _distanceMeta = const VerificationMeta('distance');
  GeneratedColumn<String> _distance;
  @override
  GeneratedColumn<String> get distance =>
      _distance ??= GeneratedColumn<String>('distance', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _costMeta = const VerificationMeta('cost');
  GeneratedColumn<String> _cost;
  @override
  GeneratedColumn<String> get cost =>
      _cost ??= GeneratedColumn<String>('cost', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, origin, destination, duration, distance, cost];
  @override
  String get aliasedName => _alias ?? 'tronsons';
  @override
  String get actualTableName => 'tronsons';
  @override
  VerificationContext validateIntegrity(Insertable<Tronson> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin'], _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('destination')) {
      context.handle(
          _destinationMeta,
          destination.isAcceptableOrUnknown(
              data['destination'], _destinationMeta));
    } else if (isInserting) {
      context.missing(_destinationMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration'], _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance'], _distanceMeta));
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost'], _costMeta));
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tronson map(Map<String, dynamic> data, {String tablePrefix}) {
    return Tronson.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TronsonsTable createAlias(String alias) {
    return $TronsonsTable(attachedDatabase, alias);
  }
}

abstract class _$TronsonDatabase extends GeneratedDatabase {
  _$TronsonDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TronsonsTable _tronsons;
  $TronsonsTable get tronsons => _tronsons ??= $TronsonsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tronsons];
}

class Route extends DataClass implements Insertable<Route> {
  final int id;
  final String origin;
  final String destination;
  final String duration;
  final String distance;
  final String cost;
  Route(
      {@required this.id,
      @required this.origin,
      @required this.destination,
      @required this.duration,
      @required this.distance,
      @required this.cost});
  factory Route.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Route(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      origin: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}origin']),
      destination: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}destination']),
      duration: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration']),
      distance: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}distance']),
      cost: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cost']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || origin != null) {
      map['origin'] = Variable<String>(origin);
    }
    if (!nullToAbsent || destination != null) {
      map['destination'] = Variable<String>(destination);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<String>(duration);
    }
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<String>(distance);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<String>(cost);
    }
    return map;
  }

  RoutesCompanion toCompanion(bool nullToAbsent) {
    return RoutesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      origin:
          origin == null && nullToAbsent ? const Value.absent() : Value(origin),
      destination: destination == null && nullToAbsent
          ? const Value.absent()
          : Value(destination),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
    );
  }

  factory Route.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Route(
      id: serializer.fromJson<int>(json['id']),
      origin: serializer.fromJson<String>(json['origin']),
      destination: serializer.fromJson<String>(json['destination']),
      duration: serializer.fromJson<String>(json['duration']),
      distance: serializer.fromJson<String>(json['distance']),
      cost: serializer.fromJson<String>(json['cost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'origin': serializer.toJson<String>(origin),
      'destination': serializer.toJson<String>(destination),
      'duration': serializer.toJson<String>(duration),
      'distance': serializer.toJson<String>(distance),
      'cost': serializer.toJson<String>(cost),
    };
  }

  Route copyWith(
          {int id,
          String origin,
          String destination,
          String duration,
          String distance,
          String cost}) =>
      Route(
        id: id ?? this.id,
        origin: origin ?? this.origin,
        destination: destination ?? this.destination,
        duration: duration ?? this.duration,
        distance: distance ?? this.distance,
        cost: cost ?? this.cost,
      );
  @override
  String toString() {
    return (StringBuffer('Route(')
          ..write('id: $id, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('duration: $duration, ')
          ..write('distance: $distance, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, origin, destination, duration, distance, cost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Route &&
          other.id == this.id &&
          other.origin == this.origin &&
          other.destination == this.destination &&
          other.duration == this.duration &&
          other.distance == this.distance &&
          other.cost == this.cost);
}

class RoutesCompanion extends UpdateCompanion<Route> {
  final Value<int> id;
  final Value<String> origin;
  final Value<String> destination;
  final Value<String> duration;
  final Value<String> distance;
  final Value<String> cost;
  const RoutesCompanion({
    this.id = const Value.absent(),
    this.origin = const Value.absent(),
    this.destination = const Value.absent(),
    this.duration = const Value.absent(),
    this.distance = const Value.absent(),
    this.cost = const Value.absent(),
  });
  RoutesCompanion.insert({
    this.id = const Value.absent(),
    @required String origin,
    @required String destination,
    @required String duration,
    @required String distance,
    @required String cost,
  })  : origin = Value(origin),
        destination = Value(destination),
        duration = Value(duration),
        distance = Value(distance),
        cost = Value(cost);
  static Insertable<Route> custom({
    Expression<int> id,
    Expression<String> origin,
    Expression<String> destination,
    Expression<String> duration,
    Expression<String> distance,
    Expression<String> cost,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (origin != null) 'origin': origin,
      if (destination != null) 'destination': destination,
      if (duration != null) 'duration': duration,
      if (distance != null) 'distance': distance,
      if (cost != null) 'cost': cost,
    });
  }

  RoutesCompanion copyWith(
      {Value<int> id,
      Value<String> origin,
      Value<String> destination,
      Value<String> duration,
      Value<String> distance,
      Value<String> cost}) {
    return RoutesCompanion(
      id: id ?? this.id,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      cost: cost ?? this.cost,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (destination.present) {
      map['destination'] = Variable<String>(destination.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (distance.present) {
      map['distance'] = Variable<String>(distance.value);
    }
    if (cost.present) {
      map['cost'] = Variable<String>(cost.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutesCompanion(')
          ..write('id: $id, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('duration: $duration, ')
          ..write('distance: $distance, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }
}

class $RoutesTable extends Routes with TableInfo<$RoutesTable, Route> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $RoutesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _originMeta = const VerificationMeta('origin');
  GeneratedColumn<String> _origin;
  @override
  GeneratedColumn<String> get origin =>
      _origin ??= GeneratedColumn<String>('origin', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _destinationMeta =
      const VerificationMeta('destination');
  GeneratedColumn<String> _destination;
  @override
  GeneratedColumn<String> get destination => _destination ??=
      GeneratedColumn<String>('destination', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  GeneratedColumn<String> _duration;
  @override
  GeneratedColumn<String> get duration =>
      _duration ??= GeneratedColumn<String>('duration', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _distanceMeta = const VerificationMeta('distance');
  GeneratedColumn<String> _distance;
  @override
  GeneratedColumn<String> get distance =>
      _distance ??= GeneratedColumn<String>('distance', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _costMeta = const VerificationMeta('cost');
  GeneratedColumn<String> _cost;
  @override
  GeneratedColumn<String> get cost =>
      _cost ??= GeneratedColumn<String>('cost', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, origin, destination, duration, distance, cost];
  @override
  String get aliasedName => _alias ?? 'routes';
  @override
  String get actualTableName => 'routes';
  @override
  VerificationContext validateIntegrity(Insertable<Route> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin'], _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('destination')) {
      context.handle(
          _destinationMeta,
          destination.isAcceptableOrUnknown(
              data['destination'], _destinationMeta));
    } else if (isInserting) {
      context.missing(_destinationMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration'], _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance'], _distanceMeta));
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost'], _costMeta));
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Route map(Map<String, dynamic> data, {String tablePrefix}) {
    return Route.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RoutesTable createAlias(String alias) {
    return $RoutesTable(attachedDatabase, alias);
  }
}

abstract class _$RouteDatabase extends GeneratedDatabase {
  _$RouteDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $RoutesTable _routes;
  $RoutesTable get routes => _routes ??= $RoutesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [routes];
}

class Hotel extends DataClass implements Insertable<Hotel> {
  final int id;
  final String name;
  final String description;
  final String location;
  final String cost;
  Hotel(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.location,
      @required this.cost});
  factory Hotel.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Hotel(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      location: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
      cost: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cost']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<String>(cost);
    }
    return map;
  }

  HotelsCompanion toCompanion(bool nullToAbsent) {
    return HotelsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
    );
  }

  factory Hotel.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Hotel(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      location: serializer.fromJson<String>(json['location']),
      cost: serializer.fromJson<String>(json['cost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'location': serializer.toJson<String>(location),
      'cost': serializer.toJson<String>(cost),
    };
  }

  Hotel copyWith(
          {int id,
          String name,
          String description,
          String location,
          String cost}) =>
      Hotel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        location: location ?? this.location,
        cost: cost ?? this.cost,
      );
  @override
  String toString() {
    return (StringBuffer('Hotel(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, location, cost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hotel &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.location == this.location &&
          other.cost == this.cost);
}

class HotelsCompanion extends UpdateCompanion<Hotel> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> location;
  final Value<String> cost;
  const HotelsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    this.cost = const Value.absent(),
  });
  HotelsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String description,
    @required String location,
    @required String cost,
  })  : name = Value(name),
        description = Value(description),
        location = Value(location),
        cost = Value(cost);
  static Insertable<Hotel> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> description,
    Expression<String> location,
    Expression<String> cost,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (cost != null) 'cost': cost,
    });
  }

  HotelsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String> location,
      Value<String> cost}) {
    return HotelsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      cost: cost ?? this.cost,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (cost.present) {
      map['cost'] = Variable<String>(cost.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HotelsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }
}

class $HotelsTable extends Hotels with TableInfo<$HotelsTable, Hotel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $HotelsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      _name ??= GeneratedColumn<String>('name', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedColumn<String> _description;
  @override
  GeneratedColumn<String> get description => _description ??=
      GeneratedColumn<String>('description', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _locationMeta = const VerificationMeta('location');
  GeneratedColumn<String> _location;
  @override
  GeneratedColumn<String> get location =>
      _location ??= GeneratedColumn<String>('location', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _costMeta = const VerificationMeta('cost');
  GeneratedColumn<String> _cost;
  @override
  GeneratedColumn<String> get cost =>
      _cost ??= GeneratedColumn<String>('cost', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, description, location, cost];
  @override
  String get aliasedName => _alias ?? 'hotels';
  @override
  String get actualTableName => 'hotels';
  @override
  VerificationContext validateIntegrity(Insertable<Hotel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location'], _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost'], _costMeta));
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hotel map(Map<String, dynamic> data, {String tablePrefix}) {
    return Hotel.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HotelsTable createAlias(String alias) {
    return $HotelsTable(attachedDatabase, alias);
  }
}

abstract class _$HotelDatabase extends GeneratedDatabase {
  _$HotelDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $HotelsTable _hotels;
  $HotelsTable get hotels => _hotels ??= $HotelsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [hotels];
}

class Airport extends DataClass implements Insertable<Airport> {
  final int id;
  final String name;
  final String distance;
  final String city;
  final String country;
  final String iataCode;
  Airport(
      {@required this.id,
      @required this.name,
      @required this.distance,
      @required this.city,
      @required this.country,
      @required this.iataCode});
  factory Airport.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Airport(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      distance: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}distance']),
      city: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city']),
      country: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}country']),
      iataCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}iata_code']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<String>(distance);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || iataCode != null) {
      map['iata_code'] = Variable<String>(iataCode);
    }
    return map;
  }

  AirportsCompanion toCompanion(bool nullToAbsent) {
    return AirportsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      iataCode: iataCode == null && nullToAbsent
          ? const Value.absent()
          : Value(iataCode),
    );
  }

  factory Airport.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Airport(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      distance: serializer.fromJson<String>(json['distance']),
      city: serializer.fromJson<String>(json['city']),
      country: serializer.fromJson<String>(json['country']),
      iataCode: serializer.fromJson<String>(json['iataCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'distance': serializer.toJson<String>(distance),
      'city': serializer.toJson<String>(city),
      'country': serializer.toJson<String>(country),
      'iataCode': serializer.toJson<String>(iataCode),
    };
  }

  Airport copyWith(
          {int id,
          String name,
          String distance,
          String city,
          String country,
          String iataCode}) =>
      Airport(
        id: id ?? this.id,
        name: name ?? this.name,
        distance: distance ?? this.distance,
        city: city ?? this.city,
        country: country ?? this.country,
        iataCode: iataCode ?? this.iataCode,
      );
  @override
  String toString() {
    return (StringBuffer('Airport(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('distance: $distance, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('iataCode: $iataCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, distance, city, country, iataCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Airport &&
          other.id == this.id &&
          other.name == this.name &&
          other.distance == this.distance &&
          other.city == this.city &&
          other.country == this.country &&
          other.iataCode == this.iataCode);
}

class AirportsCompanion extends UpdateCompanion<Airport> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> distance;
  final Value<String> city;
  final Value<String> country;
  final Value<String> iataCode;
  const AirportsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.distance = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.iataCode = const Value.absent(),
  });
  AirportsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String distance,
    @required String city,
    @required String country,
    @required String iataCode,
  })  : name = Value(name),
        distance = Value(distance),
        city = Value(city),
        country = Value(country),
        iataCode = Value(iataCode);
  static Insertable<Airport> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> distance,
    Expression<String> city,
    Expression<String> country,
    Expression<String> iataCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (distance != null) 'distance': distance,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (iataCode != null) 'iata_code': iataCode,
    });
  }

  AirportsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> distance,
      Value<String> city,
      Value<String> country,
      Value<String> iataCode}) {
    return AirportsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      distance: distance ?? this.distance,
      city: city ?? this.city,
      country: country ?? this.country,
      iataCode: iataCode ?? this.iataCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (distance.present) {
      map['distance'] = Variable<String>(distance.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (iataCode.present) {
      map['iata_code'] = Variable<String>(iataCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AirportsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('distance: $distance, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('iataCode: $iataCode')
          ..write(')'))
        .toString();
  }
}

class $AirportsTable extends Airports with TableInfo<$AirportsTable, Airport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $AirportsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      _name ??= GeneratedColumn<String>('name', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _distanceMeta = const VerificationMeta('distance');
  GeneratedColumn<String> _distance;
  @override
  GeneratedColumn<String> get distance =>
      _distance ??= GeneratedColumn<String>('distance', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _cityMeta = const VerificationMeta('city');
  GeneratedColumn<String> _city;
  @override
  GeneratedColumn<String> get city =>
      _city ??= GeneratedColumn<String>('city', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  GeneratedColumn<String> _country;
  @override
  GeneratedColumn<String> get country =>
      _country ??= GeneratedColumn<String>('country', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _iataCodeMeta = const VerificationMeta('iataCode');
  GeneratedColumn<String> _iataCode;
  @override
  GeneratedColumn<String> get iataCode =>
      _iataCode ??= GeneratedColumn<String>('iata_code', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, distance, city, country, iataCode];
  @override
  String get aliasedName => _alias ?? 'airports';
  @override
  String get actualTableName => 'airports';
  @override
  VerificationContext validateIntegrity(Insertable<Airport> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance'], _distanceMeta));
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city'], _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country'], _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('iata_code')) {
      context.handle(_iataCodeMeta,
          iataCode.isAcceptableOrUnknown(data['iata_code'], _iataCodeMeta));
    } else if (isInserting) {
      context.missing(_iataCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Airport map(Map<String, dynamic> data, {String tablePrefix}) {
    return Airport.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AirportsTable createAlias(String alias) {
    return $AirportsTable(attachedDatabase, alias);
  }
}

abstract class _$AirportsDatabase extends GeneratedDatabase {
  _$AirportsDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AirportsTable _airports;
  $AirportsTable get airports => _airports ??= $AirportsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [airports];
}
