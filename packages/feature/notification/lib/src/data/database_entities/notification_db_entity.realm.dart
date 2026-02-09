// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_db_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class NotificationDbEntity extends _NotificationDbEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  NotificationDbEntity(
    String key,
    String title,
    String description,
    DateTime created,
    bool seen,
  ) {
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'seen', seen);
  }

  NotificationDbEntity._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;
  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  bool get seen => RealmObjectBase.get<bool>(this, 'seen') as bool;
  @override
  set seen(bool value) => RealmObjectBase.set(this, 'seen', value);

  @override
  Stream<RealmObjectChanges<NotificationDbEntity>> get changes =>
      RealmObjectBase.getChanges<NotificationDbEntity>(this);

  @override
  Stream<RealmObjectChanges<NotificationDbEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<NotificationDbEntity>(this, keyPaths);

  @override
  NotificationDbEntity freeze() =>
      RealmObjectBase.freezeObject<NotificationDbEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'key': key.toEJson(),
      'title': title.toEJson(),
      'description': description.toEJson(),
      'created': created.toEJson(),
      'seen': seen.toEJson(),
    };
  }

  static EJsonValue _toEJson(NotificationDbEntity value) => value.toEJson();
  static NotificationDbEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'key': EJsonValue key,
        'title': EJsonValue title,
        'description': EJsonValue description,
        'created': EJsonValue created,
        'seen': EJsonValue seen,
      } =>
        NotificationDbEntity(
          fromEJson(key),
          fromEJson(title),
          fromEJson(description),
          fromEJson(created),
          fromEJson(seen),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(NotificationDbEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, NotificationDbEntity, 'NotificationDbEntity', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('created', RealmPropertyType.timestamp),
      SchemaProperty('seen', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
