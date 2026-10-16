// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserAccountsTable extends UserAccounts
    with TableInfo<$UserAccountsTable, UserAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Local'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, displayName, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAccount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserAccountsTable createAlias(String alias) {
    return $UserAccountsTable(attachedDatabase, alias);
  }
}

class UserAccount extends DataClass implements Insertable<UserAccount> {
  final String id;
  final String displayName;
  final DateTime createdAt;
  const UserAccount({
    required this.id,
    required this.displayName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserAccountsCompanion toCompanion(bool nullToAbsent) {
    return UserAccountsCompanion(
      id: Value(id),
      displayName: Value(displayName),
      createdAt: Value(createdAt),
    );
  }

  factory UserAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAccount(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserAccount copyWith({
    String? id,
    String? displayName,
    DateTime? createdAt,
  }) => UserAccount(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    createdAt: createdAt ?? this.createdAt,
  );
  UserAccount copyWithCompanion(UserAccountsCompanion data) {
    return UserAccount(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAccount(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, displayName, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAccount &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.createdAt == this.createdAt);
}

class UserAccountsCompanion extends UpdateCompanion<UserAccount> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UserAccountsCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserAccountsCompanion.insert({
    required String id,
    this.displayName = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt);
  static Insertable<UserAccount> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserAccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UserAccountsCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAccountsCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LinkedIdentitiesTable extends LinkedIdentities
    with TableInfo<$LinkedIdentitiesTable, LinkedIdentity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LinkedIdentitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerUserIdMeta = const VerificationMeta(
    'providerUserId',
  );
  @override
  late final GeneratedColumn<String> providerUserId = GeneratedColumn<String>(
    'provider_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkedAtMeta = const VerificationMeta(
    'linkedAt',
  );
  @override
  late final GeneratedColumn<DateTime> linkedAt = GeneratedColumn<DateTime>(
    'linked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    provider,
    providerUserId,
    email,
    displayName,
    linkedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'linked_identities';
  @override
  VerificationContext validateIntegrity(
    Insertable<LinkedIdentity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('provider_user_id')) {
      context.handle(
        _providerUserIdMeta,
        providerUserId.isAcceptableOrUnknown(
          data['provider_user_id']!,
          _providerUserIdMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('linked_at')) {
      context.handle(
        _linkedAtMeta,
        linkedAt.isAcceptableOrUnknown(data['linked_at']!, _linkedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_linkedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LinkedIdentity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LinkedIdentity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      providerUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_user_id'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      linkedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}linked_at'],
      )!,
    );
  }

  @override
  $LinkedIdentitiesTable createAlias(String alias) {
    return $LinkedIdentitiesTable(attachedDatabase, alias);
  }
}

class LinkedIdentity extends DataClass implements Insertable<LinkedIdentity> {
  final String id;
  final String accountId;
  final String provider;
  final String? providerUserId;
  final String? email;
  final String? displayName;
  final DateTime linkedAt;
  const LinkedIdentity({
    required this.id,
    required this.accountId,
    required this.provider,
    this.providerUserId,
    this.email,
    this.displayName,
    required this.linkedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['provider'] = Variable<String>(provider);
    if (!nullToAbsent || providerUserId != null) {
      map['provider_user_id'] = Variable<String>(providerUserId);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    map['linked_at'] = Variable<DateTime>(linkedAt);
    return map;
  }

  LinkedIdentitiesCompanion toCompanion(bool nullToAbsent) {
    return LinkedIdentitiesCompanion(
      id: Value(id),
      accountId: Value(accountId),
      provider: Value(provider),
      providerUserId: providerUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerUserId),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      linkedAt: Value(linkedAt),
    );
  }

  factory LinkedIdentity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LinkedIdentity(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      provider: serializer.fromJson<String>(json['provider']),
      providerUserId: serializer.fromJson<String?>(json['providerUserId']),
      email: serializer.fromJson<String?>(json['email']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      linkedAt: serializer.fromJson<DateTime>(json['linkedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'provider': serializer.toJson<String>(provider),
      'providerUserId': serializer.toJson<String?>(providerUserId),
      'email': serializer.toJson<String?>(email),
      'displayName': serializer.toJson<String?>(displayName),
      'linkedAt': serializer.toJson<DateTime>(linkedAt),
    };
  }

  LinkedIdentity copyWith({
    String? id,
    String? accountId,
    String? provider,
    Value<String?> providerUserId = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> displayName = const Value.absent(),
    DateTime? linkedAt,
  }) => LinkedIdentity(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    provider: provider ?? this.provider,
    providerUserId: providerUserId.present
        ? providerUserId.value
        : this.providerUserId,
    email: email.present ? email.value : this.email,
    displayName: displayName.present ? displayName.value : this.displayName,
    linkedAt: linkedAt ?? this.linkedAt,
  );
  LinkedIdentity copyWithCompanion(LinkedIdentitiesCompanion data) {
    return LinkedIdentity(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      provider: data.provider.present ? data.provider.value : this.provider,
      providerUserId: data.providerUserId.present
          ? data.providerUserId.value
          : this.providerUserId,
      email: data.email.present ? data.email.value : this.email,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      linkedAt: data.linkedAt.present ? data.linkedAt.value : this.linkedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LinkedIdentity(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('provider: $provider, ')
          ..write('providerUserId: $providerUserId, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('linkedAt: $linkedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    provider,
    providerUserId,
    email,
    displayName,
    linkedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LinkedIdentity &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.provider == this.provider &&
          other.providerUserId == this.providerUserId &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.linkedAt == this.linkedAt);
}

class LinkedIdentitiesCompanion extends UpdateCompanion<LinkedIdentity> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> provider;
  final Value<String?> providerUserId;
  final Value<String?> email;
  final Value<String?> displayName;
  final Value<DateTime> linkedAt;
  final Value<int> rowid;
  const LinkedIdentitiesCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.provider = const Value.absent(),
    this.providerUserId = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.linkedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LinkedIdentitiesCompanion.insert({
    required String id,
    required String accountId,
    required String provider,
    this.providerUserId = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    required DateTime linkedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       provider = Value(provider),
       linkedAt = Value(linkedAt);
  static Insertable<LinkedIdentity> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? provider,
    Expression<String>? providerUserId,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<DateTime>? linkedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (provider != null) 'provider': provider,
      if (providerUserId != null) 'provider_user_id': providerUserId,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (linkedAt != null) 'linked_at': linkedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LinkedIdentitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? provider,
    Value<String?>? providerUserId,
    Value<String?>? email,
    Value<String?>? displayName,
    Value<DateTime>? linkedAt,
    Value<int>? rowid,
  }) {
    return LinkedIdentitiesCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      provider: provider ?? this.provider,
      providerUserId: providerUserId ?? this.providerUserId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      linkedAt: linkedAt ?? this.linkedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (providerUserId.present) {
      map['provider_user_id'] = Variable<String>(providerUserId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (linkedAt.present) {
      map['linked_at'] = Variable<DateTime>(linkedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LinkedIdentitiesCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('provider: $provider, ')
          ..write('providerUserId: $providerUserId, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('linkedAt: $linkedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, type, isDefault];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String name;
  final String type;
  final bool isDefault;
  const UserProfile({
    required this.id,
    required this.name,
    required this.type,
    required this.isDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      isDefault: Value(isDefault),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  UserProfile copyWith({
    String? id,
    String? name,
    String? type,
    bool? isDefault,
  }) => UserProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    isDefault: isDefault ?? this.isDefault,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, isDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.isDefault == this.isDefault);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<bool> isDefault;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.isDefault = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? isDefault,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (isDefault != null) 'is_default': isDefault,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<bool>? isDefault,
    Value<int>? rowid,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isDefault: $isDefault, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, slug, name, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String slug;
  final String name;
  final int sortOrder;
  const Category({
    required this.id,
    required this.slug,
    required this.name,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Category copyWith({String? id, String? slug, String? name, int? sortOrder}) =>
      Category(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> slug;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String slug,
    required String name,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       slug = Value(slug),
       name = Value(name),
       sortOrder = Value(sortOrder);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? slug,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? slug,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServicesTable extends Services with TableInfo<$ServicesTable, Service> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoKeyMeta = const VerificationMeta(
    'logoKey',
  );
  @override
  late final GeneratedColumn<String> logoKey = GeneratedColumn<String>(
    'logo_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _officialWebsiteUrlMeta =
      const VerificationMeta('officialWebsiteUrl');
  @override
  late final GeneratedColumn<String> officialWebsiteUrl =
      GeneratedColumn<String>(
        'official_website_url',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _manageSubscriptionUrlMeta =
      const VerificationMeta('manageSubscriptionUrl');
  @override
  late final GeneratedColumn<String> manageSubscriptionUrl =
      GeneratedColumn<String>(
        'manage_subscription_url',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isBuiltinMeta = const VerificationMeta(
    'isBuiltin',
  );
  @override
  late final GeneratedColumn<bool> isBuiltin = GeneratedColumn<bool>(
    'is_builtin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_builtin" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    categoryId,
    logoKey,
    officialWebsiteUrl,
    manageSubscriptionUrl,
    isCustom,
    isBuiltin,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services';
  @override
  VerificationContext validateIntegrity(
    Insertable<Service> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('logo_key')) {
      context.handle(
        _logoKeyMeta,
        logoKey.isAcceptableOrUnknown(data['logo_key']!, _logoKeyMeta),
      );
    }
    if (data.containsKey('official_website_url')) {
      context.handle(
        _officialWebsiteUrlMeta,
        officialWebsiteUrl.isAcceptableOrUnknown(
          data['official_website_url']!,
          _officialWebsiteUrlMeta,
        ),
      );
    }
    if (data.containsKey('manage_subscription_url')) {
      context.handle(
        _manageSubscriptionUrlMeta,
        manageSubscriptionUrl.isAcceptableOrUnknown(
          data['manage_subscription_url']!,
          _manageSubscriptionUrlMeta,
        ),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('is_builtin')) {
      context.handle(
        _isBuiltinMeta,
        isBuiltin.isAcceptableOrUnknown(data['is_builtin']!, _isBuiltinMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Service map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Service(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      logoKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_key'],
      ),
      officialWebsiteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}official_website_url'],
      ),
      manageSubscriptionUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manage_subscription_url'],
      ),
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
      isBuiltin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_builtin'],
      )!,
    );
  }

  @override
  $ServicesTable createAlias(String alias) {
    return $ServicesTable(attachedDatabase, alias);
  }
}

class Service extends DataClass implements Insertable<Service> {
  final String id;
  final String name;
  final String categoryId;
  final String? logoKey;
  final String? officialWebsiteUrl;
  final String? manageSubscriptionUrl;
  final bool isCustom;
  final bool isBuiltin;
  const Service({
    required this.id,
    required this.name,
    required this.categoryId,
    this.logoKey,
    this.officialWebsiteUrl,
    this.manageSubscriptionUrl,
    required this.isCustom,
    required this.isBuiltin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || logoKey != null) {
      map['logo_key'] = Variable<String>(logoKey);
    }
    if (!nullToAbsent || officialWebsiteUrl != null) {
      map['official_website_url'] = Variable<String>(officialWebsiteUrl);
    }
    if (!nullToAbsent || manageSubscriptionUrl != null) {
      map['manage_subscription_url'] = Variable<String>(manageSubscriptionUrl);
    }
    map['is_custom'] = Variable<bool>(isCustom);
    map['is_builtin'] = Variable<bool>(isBuiltin);
    return map;
  }

  ServicesCompanion toCompanion(bool nullToAbsent) {
    return ServicesCompanion(
      id: Value(id),
      name: Value(name),
      categoryId: Value(categoryId),
      logoKey: logoKey == null && nullToAbsent
          ? const Value.absent()
          : Value(logoKey),
      officialWebsiteUrl: officialWebsiteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(officialWebsiteUrl),
      manageSubscriptionUrl: manageSubscriptionUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(manageSubscriptionUrl),
      isCustom: Value(isCustom),
      isBuiltin: Value(isBuiltin),
    );
  }

  factory Service.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Service(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      logoKey: serializer.fromJson<String?>(json['logoKey']),
      officialWebsiteUrl: serializer.fromJson<String?>(
        json['officialWebsiteUrl'],
      ),
      manageSubscriptionUrl: serializer.fromJson<String?>(
        json['manageSubscriptionUrl'],
      ),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      isBuiltin: serializer.fromJson<bool>(json['isBuiltin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<String>(categoryId),
      'logoKey': serializer.toJson<String?>(logoKey),
      'officialWebsiteUrl': serializer.toJson<String?>(officialWebsiteUrl),
      'manageSubscriptionUrl': serializer.toJson<String?>(
        manageSubscriptionUrl,
      ),
      'isCustom': serializer.toJson<bool>(isCustom),
      'isBuiltin': serializer.toJson<bool>(isBuiltin),
    };
  }

  Service copyWith({
    String? id,
    String? name,
    String? categoryId,
    Value<String?> logoKey = const Value.absent(),
    Value<String?> officialWebsiteUrl = const Value.absent(),
    Value<String?> manageSubscriptionUrl = const Value.absent(),
    bool? isCustom,
    bool? isBuiltin,
  }) => Service(
    id: id ?? this.id,
    name: name ?? this.name,
    categoryId: categoryId ?? this.categoryId,
    logoKey: logoKey.present ? logoKey.value : this.logoKey,
    officialWebsiteUrl: officialWebsiteUrl.present
        ? officialWebsiteUrl.value
        : this.officialWebsiteUrl,
    manageSubscriptionUrl: manageSubscriptionUrl.present
        ? manageSubscriptionUrl.value
        : this.manageSubscriptionUrl,
    isCustom: isCustom ?? this.isCustom,
    isBuiltin: isBuiltin ?? this.isBuiltin,
  );
  Service copyWithCompanion(ServicesCompanion data) {
    return Service(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      logoKey: data.logoKey.present ? data.logoKey.value : this.logoKey,
      officialWebsiteUrl: data.officialWebsiteUrl.present
          ? data.officialWebsiteUrl.value
          : this.officialWebsiteUrl,
      manageSubscriptionUrl: data.manageSubscriptionUrl.present
          ? data.manageSubscriptionUrl.value
          : this.manageSubscriptionUrl,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      isBuiltin: data.isBuiltin.present ? data.isBuiltin.value : this.isBuiltin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Service(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('logoKey: $logoKey, ')
          ..write('officialWebsiteUrl: $officialWebsiteUrl, ')
          ..write('manageSubscriptionUrl: $manageSubscriptionUrl, ')
          ..write('isCustom: $isCustom, ')
          ..write('isBuiltin: $isBuiltin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    categoryId,
    logoKey,
    officialWebsiteUrl,
    manageSubscriptionUrl,
    isCustom,
    isBuiltin,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Service &&
          other.id == this.id &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.logoKey == this.logoKey &&
          other.officialWebsiteUrl == this.officialWebsiteUrl &&
          other.manageSubscriptionUrl == this.manageSubscriptionUrl &&
          other.isCustom == this.isCustom &&
          other.isBuiltin == this.isBuiltin);
}

class ServicesCompanion extends UpdateCompanion<Service> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> categoryId;
  final Value<String?> logoKey;
  final Value<String?> officialWebsiteUrl;
  final Value<String?> manageSubscriptionUrl;
  final Value<bool> isCustom;
  final Value<bool> isBuiltin;
  final Value<int> rowid;
  const ServicesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.logoKey = const Value.absent(),
    this.officialWebsiteUrl = const Value.absent(),
    this.manageSubscriptionUrl = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.isBuiltin = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServicesCompanion.insert({
    required String id,
    required String name,
    required String categoryId,
    this.logoKey = const Value.absent(),
    this.officialWebsiteUrl = const Value.absent(),
    this.manageSubscriptionUrl = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.isBuiltin = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       categoryId = Value(categoryId);
  static Insertable<Service> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? categoryId,
    Expression<String>? logoKey,
    Expression<String>? officialWebsiteUrl,
    Expression<String>? manageSubscriptionUrl,
    Expression<bool>? isCustom,
    Expression<bool>? isBuiltin,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (logoKey != null) 'logo_key': logoKey,
      if (officialWebsiteUrl != null)
        'official_website_url': officialWebsiteUrl,
      if (manageSubscriptionUrl != null)
        'manage_subscription_url': manageSubscriptionUrl,
      if (isCustom != null) 'is_custom': isCustom,
      if (isBuiltin != null) 'is_builtin': isBuiltin,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServicesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? categoryId,
    Value<String?>? logoKey,
    Value<String?>? officialWebsiteUrl,
    Value<String?>? manageSubscriptionUrl,
    Value<bool>? isCustom,
    Value<bool>? isBuiltin,
    Value<int>? rowid,
  }) {
    return ServicesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      logoKey: logoKey ?? this.logoKey,
      officialWebsiteUrl: officialWebsiteUrl ?? this.officialWebsiteUrl,
      manageSubscriptionUrl:
          manageSubscriptionUrl ?? this.manageSubscriptionUrl,
      isCustom: isCustom ?? this.isCustom,
      isBuiltin: isBuiltin ?? this.isBuiltin,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (logoKey.present) {
      map['logo_key'] = Variable<String>(logoKey.value);
    }
    if (officialWebsiteUrl.present) {
      map['official_website_url'] = Variable<String>(officialWebsiteUrl.value);
    }
    if (manageSubscriptionUrl.present) {
      map['manage_subscription_url'] = Variable<String>(
        manageSubscriptionUrl.value,
      );
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (isBuiltin.present) {
      map['is_builtin'] = Variable<bool>(isBuiltin.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('logoKey: $logoKey, ')
          ..write('officialWebsiteUrl: $officialWebsiteUrl, ')
          ..write('manageSubscriptionUrl: $manageSubscriptionUrl, ')
          ..write('isCustom: $isCustom, ')
          ..write('isBuiltin: $isBuiltin, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlansTable extends Plans with TableInfo<$PlansTable, Plan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceIdMeta = const VerificationMeta(
    'serviceId',
  );
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
    'service_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billingCycleMeta = const VerificationMeta(
    'billingCycle',
  );
  @override
  late final GeneratedColumn<String> billingCycle = GeneratedColumn<String>(
    'billing_cycle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _suggestedPriceMeta = const VerificationMeta(
    'suggestedPrice',
  );
  @override
  late final GeneratedColumn<double> suggestedPrice = GeneratedColumn<double>(
    'suggested_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _suggestedCurrencyMeta = const VerificationMeta(
    'suggestedCurrency',
  );
  @override
  late final GeneratedColumn<String> suggestedCurrency =
      GeneratedColumn<String>(
        'suggested_currency',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serviceId,
    name,
    billingCycle,
    suggestedPrice,
    suggestedCurrency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Plan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(
        _serviceIdMeta,
        serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('billing_cycle')) {
      context.handle(
        _billingCycleMeta,
        billingCycle.isAcceptableOrUnknown(
          data['billing_cycle']!,
          _billingCycleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingCycleMeta);
    }
    if (data.containsKey('suggested_price')) {
      context.handle(
        _suggestedPriceMeta,
        suggestedPrice.isAcceptableOrUnknown(
          data['suggested_price']!,
          _suggestedPriceMeta,
        ),
      );
    }
    if (data.containsKey('suggested_currency')) {
      context.handle(
        _suggestedCurrencyMeta,
        suggestedCurrency.isAcceptableOrUnknown(
          data['suggested_currency']!,
          _suggestedCurrencyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Plan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      billingCycle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_cycle'],
      )!,
      suggestedPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}suggested_price'],
      ),
      suggestedCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suggested_currency'],
      ),
    );
  }

  @override
  $PlansTable createAlias(String alias) {
    return $PlansTable(attachedDatabase, alias);
  }
}

class Plan extends DataClass implements Insertable<Plan> {
  final String id;
  final String serviceId;
  final String name;
  final String billingCycle;
  final double? suggestedPrice;
  final String? suggestedCurrency;
  const Plan({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.billingCycle,
    this.suggestedPrice,
    this.suggestedCurrency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['service_id'] = Variable<String>(serviceId);
    map['name'] = Variable<String>(name);
    map['billing_cycle'] = Variable<String>(billingCycle);
    if (!nullToAbsent || suggestedPrice != null) {
      map['suggested_price'] = Variable<double>(suggestedPrice);
    }
    if (!nullToAbsent || suggestedCurrency != null) {
      map['suggested_currency'] = Variable<String>(suggestedCurrency);
    }
    return map;
  }

  PlansCompanion toCompanion(bool nullToAbsent) {
    return PlansCompanion(
      id: Value(id),
      serviceId: Value(serviceId),
      name: Value(name),
      billingCycle: Value(billingCycle),
      suggestedPrice: suggestedPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(suggestedPrice),
      suggestedCurrency: suggestedCurrency == null && nullToAbsent
          ? const Value.absent()
          : Value(suggestedCurrency),
    );
  }

  factory Plan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plan(
      id: serializer.fromJson<String>(json['id']),
      serviceId: serializer.fromJson<String>(json['serviceId']),
      name: serializer.fromJson<String>(json['name']),
      billingCycle: serializer.fromJson<String>(json['billingCycle']),
      suggestedPrice: serializer.fromJson<double?>(json['suggestedPrice']),
      suggestedCurrency: serializer.fromJson<String?>(
        json['suggestedCurrency'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serviceId': serializer.toJson<String>(serviceId),
      'name': serializer.toJson<String>(name),
      'billingCycle': serializer.toJson<String>(billingCycle),
      'suggestedPrice': serializer.toJson<double?>(suggestedPrice),
      'suggestedCurrency': serializer.toJson<String?>(suggestedCurrency),
    };
  }

  Plan copyWith({
    String? id,
    String? serviceId,
    String? name,
    String? billingCycle,
    Value<double?> suggestedPrice = const Value.absent(),
    Value<String?> suggestedCurrency = const Value.absent(),
  }) => Plan(
    id: id ?? this.id,
    serviceId: serviceId ?? this.serviceId,
    name: name ?? this.name,
    billingCycle: billingCycle ?? this.billingCycle,
    suggestedPrice: suggestedPrice.present
        ? suggestedPrice.value
        : this.suggestedPrice,
    suggestedCurrency: suggestedCurrency.present
        ? suggestedCurrency.value
        : this.suggestedCurrency,
  );
  Plan copyWithCompanion(PlansCompanion data) {
    return Plan(
      id: data.id.present ? data.id.value : this.id,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      name: data.name.present ? data.name.value : this.name,
      billingCycle: data.billingCycle.present
          ? data.billingCycle.value
          : this.billingCycle,
      suggestedPrice: data.suggestedPrice.present
          ? data.suggestedPrice.value
          : this.suggestedPrice,
      suggestedCurrency: data.suggestedCurrency.present
          ? data.suggestedCurrency.value
          : this.suggestedCurrency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Plan(')
          ..write('id: $id, ')
          ..write('serviceId: $serviceId, ')
          ..write('name: $name, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('suggestedPrice: $suggestedPrice, ')
          ..write('suggestedCurrency: $suggestedCurrency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serviceId,
    name,
    billingCycle,
    suggestedPrice,
    suggestedCurrency,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plan &&
          other.id == this.id &&
          other.serviceId == this.serviceId &&
          other.name == this.name &&
          other.billingCycle == this.billingCycle &&
          other.suggestedPrice == this.suggestedPrice &&
          other.suggestedCurrency == this.suggestedCurrency);
}

class PlansCompanion extends UpdateCompanion<Plan> {
  final Value<String> id;
  final Value<String> serviceId;
  final Value<String> name;
  final Value<String> billingCycle;
  final Value<double?> suggestedPrice;
  final Value<String?> suggestedCurrency;
  final Value<int> rowid;
  const PlansCompanion({
    this.id = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.name = const Value.absent(),
    this.billingCycle = const Value.absent(),
    this.suggestedPrice = const Value.absent(),
    this.suggestedCurrency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlansCompanion.insert({
    required String id,
    required String serviceId,
    required String name,
    required String billingCycle,
    this.suggestedPrice = const Value.absent(),
    this.suggestedCurrency = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       serviceId = Value(serviceId),
       name = Value(name),
       billingCycle = Value(billingCycle);
  static Insertable<Plan> custom({
    Expression<String>? id,
    Expression<String>? serviceId,
    Expression<String>? name,
    Expression<String>? billingCycle,
    Expression<double>? suggestedPrice,
    Expression<String>? suggestedCurrency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serviceId != null) 'service_id': serviceId,
      if (name != null) 'name': name,
      if (billingCycle != null) 'billing_cycle': billingCycle,
      if (suggestedPrice != null) 'suggested_price': suggestedPrice,
      if (suggestedCurrency != null) 'suggested_currency': suggestedCurrency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlansCompanion copyWith({
    Value<String>? id,
    Value<String>? serviceId,
    Value<String>? name,
    Value<String>? billingCycle,
    Value<double?>? suggestedPrice,
    Value<String?>? suggestedCurrency,
    Value<int>? rowid,
  }) {
    return PlansCompanion(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      name: name ?? this.name,
      billingCycle: billingCycle ?? this.billingCycle,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
      suggestedCurrency: suggestedCurrency ?? this.suggestedCurrency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (billingCycle.present) {
      map['billing_cycle'] = Variable<String>(billingCycle.value);
    }
    if (suggestedPrice.present) {
      map['suggested_price'] = Variable<double>(suggestedPrice.value);
    }
    if (suggestedCurrency.present) {
      map['suggested_currency'] = Variable<String>(suggestedCurrency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlansCompanion(')
          ..write('id: $id, ')
          ..write('serviceId: $serviceId, ')
          ..write('name: $name, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('suggestedPrice: $suggestedPrice, ')
          ..write('suggestedCurrency: $suggestedCurrency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentMethodsTable extends PaymentMethods
    with TableInfo<$PaymentMethodsTable, PaymentMethod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentMethodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _last4Meta = const VerificationMeta('last4');
  @override
  late final GeneratedColumn<String> last4 = GeneratedColumn<String>(
    'last4',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryMeta = const VerificationMeta('expiry');
  @override
  late final GeneratedColumn<DateTime> expiry = GeneratedColumn<DateTime>(
    'expiry',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, label, type, brand, last4, expiry];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_methods';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentMethod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('last4')) {
      context.handle(
        _last4Meta,
        last4.isAcceptableOrUnknown(data['last4']!, _last4Meta),
      );
    }
    if (data.containsKey('expiry')) {
      context.handle(
        _expiryMeta,
        expiry.isAcceptableOrUnknown(data['expiry']!, _expiryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentMethod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentMethod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      last4: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last4'],
      ),
      expiry: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry'],
      ),
    );
  }

  @override
  $PaymentMethodsTable createAlias(String alias) {
    return $PaymentMethodsTable(attachedDatabase, alias);
  }
}

class PaymentMethod extends DataClass implements Insertable<PaymentMethod> {
  final String id;
  final String label;
  final String type;
  final String brand;
  final String? last4;
  final DateTime? expiry;
  const PaymentMethod({
    required this.id,
    required this.label,
    required this.type,
    required this.brand,
    this.last4,
    this.expiry,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['type'] = Variable<String>(type);
    map['brand'] = Variable<String>(brand);
    if (!nullToAbsent || last4 != null) {
      map['last4'] = Variable<String>(last4);
    }
    if (!nullToAbsent || expiry != null) {
      map['expiry'] = Variable<DateTime>(expiry);
    }
    return map;
  }

  PaymentMethodsCompanion toCompanion(bool nullToAbsent) {
    return PaymentMethodsCompanion(
      id: Value(id),
      label: Value(label),
      type: Value(type),
      brand: Value(brand),
      last4: last4 == null && nullToAbsent
          ? const Value.absent()
          : Value(last4),
      expiry: expiry == null && nullToAbsent
          ? const Value.absent()
          : Value(expiry),
    );
  }

  factory PaymentMethod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentMethod(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      type: serializer.fromJson<String>(json['type']),
      brand: serializer.fromJson<String>(json['brand']),
      last4: serializer.fromJson<String?>(json['last4']),
      expiry: serializer.fromJson<DateTime?>(json['expiry']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'type': serializer.toJson<String>(type),
      'brand': serializer.toJson<String>(brand),
      'last4': serializer.toJson<String?>(last4),
      'expiry': serializer.toJson<DateTime?>(expiry),
    };
  }

  PaymentMethod copyWith({
    String? id,
    String? label,
    String? type,
    String? brand,
    Value<String?> last4 = const Value.absent(),
    Value<DateTime?> expiry = const Value.absent(),
  }) => PaymentMethod(
    id: id ?? this.id,
    label: label ?? this.label,
    type: type ?? this.type,
    brand: brand ?? this.brand,
    last4: last4.present ? last4.value : this.last4,
    expiry: expiry.present ? expiry.value : this.expiry,
  );
  PaymentMethod copyWithCompanion(PaymentMethodsCompanion data) {
    return PaymentMethod(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      type: data.type.present ? data.type.value : this.type,
      brand: data.brand.present ? data.brand.value : this.brand,
      last4: data.last4.present ? data.last4.value : this.last4,
      expiry: data.expiry.present ? data.expiry.value : this.expiry,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethod(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('type: $type, ')
          ..write('brand: $brand, ')
          ..write('last4: $last4, ')
          ..write('expiry: $expiry')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, type, brand, last4, expiry);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentMethod &&
          other.id == this.id &&
          other.label == this.label &&
          other.type == this.type &&
          other.brand == this.brand &&
          other.last4 == this.last4 &&
          other.expiry == this.expiry);
}

class PaymentMethodsCompanion extends UpdateCompanion<PaymentMethod> {
  final Value<String> id;
  final Value<String> label;
  final Value<String> type;
  final Value<String> brand;
  final Value<String?> last4;
  final Value<DateTime?> expiry;
  final Value<int> rowid;
  const PaymentMethodsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.type = const Value.absent(),
    this.brand = const Value.absent(),
    this.last4 = const Value.absent(),
    this.expiry = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentMethodsCompanion.insert({
    required String id,
    required String label,
    required String type,
    required String brand,
    this.last4 = const Value.absent(),
    this.expiry = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       label = Value(label),
       type = Value(type),
       brand = Value(brand);
  static Insertable<PaymentMethod> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? type,
    Expression<String>? brand,
    Expression<String>? last4,
    Expression<DateTime>? expiry,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (type != null) 'type': type,
      if (brand != null) 'brand': brand,
      if (last4 != null) 'last4': last4,
      if (expiry != null) 'expiry': expiry,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentMethodsCompanion copyWith({
    Value<String>? id,
    Value<String>? label,
    Value<String>? type,
    Value<String>? brand,
    Value<String?>? last4,
    Value<DateTime?>? expiry,
    Value<int>? rowid,
  }) {
    return PaymentMethodsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      brand: brand ?? this.brand,
      last4: last4 ?? this.last4,
      expiry: expiry ?? this.expiry,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (last4.present) {
      map['last4'] = Variable<String>(last4.value);
    }
    if (expiry.present) {
      map['expiry'] = Variable<DateTime>(expiry.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethodsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('type: $type, ')
          ..write('brand: $brand, ')
          ..write('last4: $last4, ')
          ..write('expiry: $expiry, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, Subscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceIdMeta = const VerificationMeta(
    'serviceId',
  );
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
    'service_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextBillingDateMeta = const VerificationMeta(
    'nextBillingDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextBillingDate =
      GeneratedColumn<DateTime>(
        'next_billing_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _accessEndDateMeta = const VerificationMeta(
    'accessEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> accessEndDate =
      GeneratedColumn<DateTime>(
        'access_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _autoRenewMeta = const VerificationMeta(
    'autoRenew',
  );
  @override
  late final GeneratedColumn<bool> autoRenew = GeneratedColumn<bool>(
    'auto_renew',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_renew" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentPriceMeta = const VerificationMeta(
    'currentPrice',
  );
  @override
  late final GeneratedColumn<double> currentPrice = GeneratedColumn<double>(
    'current_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billingCycleMeta = const VerificationMeta(
    'billingCycle',
  );
  @override
  late final GeneratedColumn<String> billingCycle = GeneratedColumn<String>(
    'billing_cycle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customCycleDaysMeta = const VerificationMeta(
    'customCycleDays',
  );
  @override
  late final GeneratedColumn<int> customCycleDays = GeneratedColumn<int>(
    'custom_cycle_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodIdMeta = const VerificationMeta(
    'paymentMethodId',
  );
  @override
  late final GeneratedColumn<String> paymentMethodId = GeneratedColumn<String>(
    'payment_method_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _renewalIntentMeta = const VerificationMeta(
    'renewalIntent',
  );
  @override
  late final GeneratedColumn<String> renewalIntent = GeneratedColumn<String>(
    'renewal_intent',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usageFrequencyMeta = const VerificationMeta(
    'usageFrequency',
  );
  @override
  late final GeneratedColumn<String> usageFrequency = GeneratedColumn<String>(
    'usage_frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usageCountPerMonthMeta =
      const VerificationMeta('usageCountPerMonth');
  @override
  late final GeneratedColumn<int> usageCountPerMonth = GeneratedColumn<int>(
    'usage_count_per_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _officialWebsiteUrlMeta =
      const VerificationMeta('officialWebsiteUrl');
  @override
  late final GeneratedColumn<String> officialWebsiteUrl =
      GeneratedColumn<String>(
        'official_website_url',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _manageSubscriptionUrlMeta =
      const VerificationMeta('manageSubscriptionUrl');
  @override
  late final GeneratedColumn<String> manageSubscriptionUrl =
      GeneratedColumn<String>(
        'manage_subscription_url',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDemoMeta = const VerificationMeta('isDemo');
  @override
  late final GeneratedColumn<bool> isDemo = GeneratedColumn<bool>(
    'is_demo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_demo" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serviceId,
    planId,
    categoryId,
    profileId,
    status,
    active,
    startDate,
    nextBillingDate,
    accessEndDate,
    autoRenew,
    currency,
    currentPrice,
    billingCycle,
    customCycleDays,
    paymentMethodId,
    renewalIntent,
    usageFrequency,
    usageCountPerMonth,
    officialWebsiteUrl,
    manageSubscriptionUrl,
    notes,
    createdAt,
    updatedAt,
    isDemo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subscription> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(
        _serviceIdMeta,
        serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('next_billing_date')) {
      context.handle(
        _nextBillingDateMeta,
        nextBillingDate.isAcceptableOrUnknown(
          data['next_billing_date']!,
          _nextBillingDateMeta,
        ),
      );
    }
    if (data.containsKey('access_end_date')) {
      context.handle(
        _accessEndDateMeta,
        accessEndDate.isAcceptableOrUnknown(
          data['access_end_date']!,
          _accessEndDateMeta,
        ),
      );
    }
    if (data.containsKey('auto_renew')) {
      context.handle(
        _autoRenewMeta,
        autoRenew.isAcceptableOrUnknown(data['auto_renew']!, _autoRenewMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('current_price')) {
      context.handle(
        _currentPriceMeta,
        currentPrice.isAcceptableOrUnknown(
          data['current_price']!,
          _currentPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentPriceMeta);
    }
    if (data.containsKey('billing_cycle')) {
      context.handle(
        _billingCycleMeta,
        billingCycle.isAcceptableOrUnknown(
          data['billing_cycle']!,
          _billingCycleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingCycleMeta);
    }
    if (data.containsKey('custom_cycle_days')) {
      context.handle(
        _customCycleDaysMeta,
        customCycleDays.isAcceptableOrUnknown(
          data['custom_cycle_days']!,
          _customCycleDaysMeta,
        ),
      );
    }
    if (data.containsKey('payment_method_id')) {
      context.handle(
        _paymentMethodIdMeta,
        paymentMethodId.isAcceptableOrUnknown(
          data['payment_method_id']!,
          _paymentMethodIdMeta,
        ),
      );
    }
    if (data.containsKey('renewal_intent')) {
      context.handle(
        _renewalIntentMeta,
        renewalIntent.isAcceptableOrUnknown(
          data['renewal_intent']!,
          _renewalIntentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_renewalIntentMeta);
    }
    if (data.containsKey('usage_frequency')) {
      context.handle(
        _usageFrequencyMeta,
        usageFrequency.isAcceptableOrUnknown(
          data['usage_frequency']!,
          _usageFrequencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_usageFrequencyMeta);
    }
    if (data.containsKey('usage_count_per_month')) {
      context.handle(
        _usageCountPerMonthMeta,
        usageCountPerMonth.isAcceptableOrUnknown(
          data['usage_count_per_month']!,
          _usageCountPerMonthMeta,
        ),
      );
    }
    if (data.containsKey('official_website_url')) {
      context.handle(
        _officialWebsiteUrlMeta,
        officialWebsiteUrl.isAcceptableOrUnknown(
          data['official_website_url']!,
          _officialWebsiteUrlMeta,
        ),
      );
    }
    if (data.containsKey('manage_subscription_url')) {
      context.handle(
        _manageSubscriptionUrlMeta,
        manageSubscriptionUrl.isAcceptableOrUnknown(
          data['manage_subscription_url']!,
          _manageSubscriptionUrlMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_demo')) {
      context.handle(
        _isDemoMeta,
        isDemo.isAcceptableOrUnknown(data['is_demo']!, _isDemoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subscription(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      nextBillingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_billing_date'],
      ),
      accessEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}access_end_date'],
      ),
      autoRenew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_renew'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      currentPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_price'],
      )!,
      billingCycle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_cycle'],
      )!,
      customCycleDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}custom_cycle_days'],
      ),
      paymentMethodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method_id'],
      ),
      renewalIntent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}renewal_intent'],
      )!,
      usageFrequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage_frequency'],
      )!,
      usageCountPerMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count_per_month'],
      ),
      officialWebsiteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}official_website_url'],
      ),
      manageSubscriptionUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manage_subscription_url'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDemo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_demo'],
      )!,
    );
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(attachedDatabase, alias);
  }
}

class Subscription extends DataClass implements Insertable<Subscription> {
  final String id;
  final String serviceId;
  final String? planId;
  final String categoryId;
  final String profileId;
  final String status;
  final bool active;
  final DateTime startDate;
  final DateTime? nextBillingDate;
  final DateTime? accessEndDate;
  final bool autoRenew;
  final String currency;
  final double currentPrice;
  final String billingCycle;
  final int? customCycleDays;
  final String? paymentMethodId;
  final String renewalIntent;
  final String usageFrequency;
  final int? usageCountPerMonth;
  final String? officialWebsiteUrl;
  final String? manageSubscriptionUrl;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDemo;
  const Subscription({
    required this.id,
    required this.serviceId,
    this.planId,
    required this.categoryId,
    required this.profileId,
    required this.status,
    required this.active,
    required this.startDate,
    this.nextBillingDate,
    this.accessEndDate,
    required this.autoRenew,
    required this.currency,
    required this.currentPrice,
    required this.billingCycle,
    this.customCycleDays,
    this.paymentMethodId,
    required this.renewalIntent,
    required this.usageFrequency,
    this.usageCountPerMonth,
    this.officialWebsiteUrl,
    this.manageSubscriptionUrl,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.isDemo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['service_id'] = Variable<String>(serviceId);
    if (!nullToAbsent || planId != null) {
      map['plan_id'] = Variable<String>(planId);
    }
    map['category_id'] = Variable<String>(categoryId);
    map['profile_id'] = Variable<String>(profileId);
    map['status'] = Variable<String>(status);
    map['active'] = Variable<bool>(active);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || nextBillingDate != null) {
      map['next_billing_date'] = Variable<DateTime>(nextBillingDate);
    }
    if (!nullToAbsent || accessEndDate != null) {
      map['access_end_date'] = Variable<DateTime>(accessEndDate);
    }
    map['auto_renew'] = Variable<bool>(autoRenew);
    map['currency'] = Variable<String>(currency);
    map['current_price'] = Variable<double>(currentPrice);
    map['billing_cycle'] = Variable<String>(billingCycle);
    if (!nullToAbsent || customCycleDays != null) {
      map['custom_cycle_days'] = Variable<int>(customCycleDays);
    }
    if (!nullToAbsent || paymentMethodId != null) {
      map['payment_method_id'] = Variable<String>(paymentMethodId);
    }
    map['renewal_intent'] = Variable<String>(renewalIntent);
    map['usage_frequency'] = Variable<String>(usageFrequency);
    if (!nullToAbsent || usageCountPerMonth != null) {
      map['usage_count_per_month'] = Variable<int>(usageCountPerMonth);
    }
    if (!nullToAbsent || officialWebsiteUrl != null) {
      map['official_website_url'] = Variable<String>(officialWebsiteUrl);
    }
    if (!nullToAbsent || manageSubscriptionUrl != null) {
      map['manage_subscription_url'] = Variable<String>(manageSubscriptionUrl);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_demo'] = Variable<bool>(isDemo);
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      id: Value(id),
      serviceId: Value(serviceId),
      planId: planId == null && nullToAbsent
          ? const Value.absent()
          : Value(planId),
      categoryId: Value(categoryId),
      profileId: Value(profileId),
      status: Value(status),
      active: Value(active),
      startDate: Value(startDate),
      nextBillingDate: nextBillingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextBillingDate),
      accessEndDate: accessEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(accessEndDate),
      autoRenew: Value(autoRenew),
      currency: Value(currency),
      currentPrice: Value(currentPrice),
      billingCycle: Value(billingCycle),
      customCycleDays: customCycleDays == null && nullToAbsent
          ? const Value.absent()
          : Value(customCycleDays),
      paymentMethodId: paymentMethodId == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethodId),
      renewalIntent: Value(renewalIntent),
      usageFrequency: Value(usageFrequency),
      usageCountPerMonth: usageCountPerMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(usageCountPerMonth),
      officialWebsiteUrl: officialWebsiteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(officialWebsiteUrl),
      manageSubscriptionUrl: manageSubscriptionUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(manageSubscriptionUrl),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDemo: Value(isDemo),
    );
  }

  factory Subscription.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subscription(
      id: serializer.fromJson<String>(json['id']),
      serviceId: serializer.fromJson<String>(json['serviceId']),
      planId: serializer.fromJson<String?>(json['planId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      profileId: serializer.fromJson<String>(json['profileId']),
      status: serializer.fromJson<String>(json['status']),
      active: serializer.fromJson<bool>(json['active']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      nextBillingDate: serializer.fromJson<DateTime?>(json['nextBillingDate']),
      accessEndDate: serializer.fromJson<DateTime?>(json['accessEndDate']),
      autoRenew: serializer.fromJson<bool>(json['autoRenew']),
      currency: serializer.fromJson<String>(json['currency']),
      currentPrice: serializer.fromJson<double>(json['currentPrice']),
      billingCycle: serializer.fromJson<String>(json['billingCycle']),
      customCycleDays: serializer.fromJson<int?>(json['customCycleDays']),
      paymentMethodId: serializer.fromJson<String?>(json['paymentMethodId']),
      renewalIntent: serializer.fromJson<String>(json['renewalIntent']),
      usageFrequency: serializer.fromJson<String>(json['usageFrequency']),
      usageCountPerMonth: serializer.fromJson<int?>(json['usageCountPerMonth']),
      officialWebsiteUrl: serializer.fromJson<String?>(
        json['officialWebsiteUrl'],
      ),
      manageSubscriptionUrl: serializer.fromJson<String?>(
        json['manageSubscriptionUrl'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDemo: serializer.fromJson<bool>(json['isDemo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serviceId': serializer.toJson<String>(serviceId),
      'planId': serializer.toJson<String?>(planId),
      'categoryId': serializer.toJson<String>(categoryId),
      'profileId': serializer.toJson<String>(profileId),
      'status': serializer.toJson<String>(status),
      'active': serializer.toJson<bool>(active),
      'startDate': serializer.toJson<DateTime>(startDate),
      'nextBillingDate': serializer.toJson<DateTime?>(nextBillingDate),
      'accessEndDate': serializer.toJson<DateTime?>(accessEndDate),
      'autoRenew': serializer.toJson<bool>(autoRenew),
      'currency': serializer.toJson<String>(currency),
      'currentPrice': serializer.toJson<double>(currentPrice),
      'billingCycle': serializer.toJson<String>(billingCycle),
      'customCycleDays': serializer.toJson<int?>(customCycleDays),
      'paymentMethodId': serializer.toJson<String?>(paymentMethodId),
      'renewalIntent': serializer.toJson<String>(renewalIntent),
      'usageFrequency': serializer.toJson<String>(usageFrequency),
      'usageCountPerMonth': serializer.toJson<int?>(usageCountPerMonth),
      'officialWebsiteUrl': serializer.toJson<String?>(officialWebsiteUrl),
      'manageSubscriptionUrl': serializer.toJson<String?>(
        manageSubscriptionUrl,
      ),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDemo': serializer.toJson<bool>(isDemo),
    };
  }

  Subscription copyWith({
    String? id,
    String? serviceId,
    Value<String?> planId = const Value.absent(),
    String? categoryId,
    String? profileId,
    String? status,
    bool? active,
    DateTime? startDate,
    Value<DateTime?> nextBillingDate = const Value.absent(),
    Value<DateTime?> accessEndDate = const Value.absent(),
    bool? autoRenew,
    String? currency,
    double? currentPrice,
    String? billingCycle,
    Value<int?> customCycleDays = const Value.absent(),
    Value<String?> paymentMethodId = const Value.absent(),
    String? renewalIntent,
    String? usageFrequency,
    Value<int?> usageCountPerMonth = const Value.absent(),
    Value<String?> officialWebsiteUrl = const Value.absent(),
    Value<String?> manageSubscriptionUrl = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDemo,
  }) => Subscription(
    id: id ?? this.id,
    serviceId: serviceId ?? this.serviceId,
    planId: planId.present ? planId.value : this.planId,
    categoryId: categoryId ?? this.categoryId,
    profileId: profileId ?? this.profileId,
    status: status ?? this.status,
    active: active ?? this.active,
    startDate: startDate ?? this.startDate,
    nextBillingDate: nextBillingDate.present
        ? nextBillingDate.value
        : this.nextBillingDate,
    accessEndDate: accessEndDate.present
        ? accessEndDate.value
        : this.accessEndDate,
    autoRenew: autoRenew ?? this.autoRenew,
    currency: currency ?? this.currency,
    currentPrice: currentPrice ?? this.currentPrice,
    billingCycle: billingCycle ?? this.billingCycle,
    customCycleDays: customCycleDays.present
        ? customCycleDays.value
        : this.customCycleDays,
    paymentMethodId: paymentMethodId.present
        ? paymentMethodId.value
        : this.paymentMethodId,
    renewalIntent: renewalIntent ?? this.renewalIntent,
    usageFrequency: usageFrequency ?? this.usageFrequency,
    usageCountPerMonth: usageCountPerMonth.present
        ? usageCountPerMonth.value
        : this.usageCountPerMonth,
    officialWebsiteUrl: officialWebsiteUrl.present
        ? officialWebsiteUrl.value
        : this.officialWebsiteUrl,
    manageSubscriptionUrl: manageSubscriptionUrl.present
        ? manageSubscriptionUrl.value
        : this.manageSubscriptionUrl,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDemo: isDemo ?? this.isDemo,
  );
  Subscription copyWithCompanion(SubscriptionsCompanion data) {
    return Subscription(
      id: data.id.present ? data.id.value : this.id,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      planId: data.planId.present ? data.planId.value : this.planId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      status: data.status.present ? data.status.value : this.status,
      active: data.active.present ? data.active.value : this.active,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      nextBillingDate: data.nextBillingDate.present
          ? data.nextBillingDate.value
          : this.nextBillingDate,
      accessEndDate: data.accessEndDate.present
          ? data.accessEndDate.value
          : this.accessEndDate,
      autoRenew: data.autoRenew.present ? data.autoRenew.value : this.autoRenew,
      currency: data.currency.present ? data.currency.value : this.currency,
      currentPrice: data.currentPrice.present
          ? data.currentPrice.value
          : this.currentPrice,
      billingCycle: data.billingCycle.present
          ? data.billingCycle.value
          : this.billingCycle,
      customCycleDays: data.customCycleDays.present
          ? data.customCycleDays.value
          : this.customCycleDays,
      paymentMethodId: data.paymentMethodId.present
          ? data.paymentMethodId.value
          : this.paymentMethodId,
      renewalIntent: data.renewalIntent.present
          ? data.renewalIntent.value
          : this.renewalIntent,
      usageFrequency: data.usageFrequency.present
          ? data.usageFrequency.value
          : this.usageFrequency,
      usageCountPerMonth: data.usageCountPerMonth.present
          ? data.usageCountPerMonth.value
          : this.usageCountPerMonth,
      officialWebsiteUrl: data.officialWebsiteUrl.present
          ? data.officialWebsiteUrl.value
          : this.officialWebsiteUrl,
      manageSubscriptionUrl: data.manageSubscriptionUrl.present
          ? data.manageSubscriptionUrl.value
          : this.manageSubscriptionUrl,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDemo: data.isDemo.present ? data.isDemo.value : this.isDemo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subscription(')
          ..write('id: $id, ')
          ..write('serviceId: $serviceId, ')
          ..write('planId: $planId, ')
          ..write('categoryId: $categoryId, ')
          ..write('profileId: $profileId, ')
          ..write('status: $status, ')
          ..write('active: $active, ')
          ..write('startDate: $startDate, ')
          ..write('nextBillingDate: $nextBillingDate, ')
          ..write('accessEndDate: $accessEndDate, ')
          ..write('autoRenew: $autoRenew, ')
          ..write('currency: $currency, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('customCycleDays: $customCycleDays, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('renewalIntent: $renewalIntent, ')
          ..write('usageFrequency: $usageFrequency, ')
          ..write('usageCountPerMonth: $usageCountPerMonth, ')
          ..write('officialWebsiteUrl: $officialWebsiteUrl, ')
          ..write('manageSubscriptionUrl: $manageSubscriptionUrl, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDemo: $isDemo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    serviceId,
    planId,
    categoryId,
    profileId,
    status,
    active,
    startDate,
    nextBillingDate,
    accessEndDate,
    autoRenew,
    currency,
    currentPrice,
    billingCycle,
    customCycleDays,
    paymentMethodId,
    renewalIntent,
    usageFrequency,
    usageCountPerMonth,
    officialWebsiteUrl,
    manageSubscriptionUrl,
    notes,
    createdAt,
    updatedAt,
    isDemo,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subscription &&
          other.id == this.id &&
          other.serviceId == this.serviceId &&
          other.planId == this.planId &&
          other.categoryId == this.categoryId &&
          other.profileId == this.profileId &&
          other.status == this.status &&
          other.active == this.active &&
          other.startDate == this.startDate &&
          other.nextBillingDate == this.nextBillingDate &&
          other.accessEndDate == this.accessEndDate &&
          other.autoRenew == this.autoRenew &&
          other.currency == this.currency &&
          other.currentPrice == this.currentPrice &&
          other.billingCycle == this.billingCycle &&
          other.customCycleDays == this.customCycleDays &&
          other.paymentMethodId == this.paymentMethodId &&
          other.renewalIntent == this.renewalIntent &&
          other.usageFrequency == this.usageFrequency &&
          other.usageCountPerMonth == this.usageCountPerMonth &&
          other.officialWebsiteUrl == this.officialWebsiteUrl &&
          other.manageSubscriptionUrl == this.manageSubscriptionUrl &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDemo == this.isDemo);
}

class SubscriptionsCompanion extends UpdateCompanion<Subscription> {
  final Value<String> id;
  final Value<String> serviceId;
  final Value<String?> planId;
  final Value<String> categoryId;
  final Value<String> profileId;
  final Value<String> status;
  final Value<bool> active;
  final Value<DateTime> startDate;
  final Value<DateTime?> nextBillingDate;
  final Value<DateTime?> accessEndDate;
  final Value<bool> autoRenew;
  final Value<String> currency;
  final Value<double> currentPrice;
  final Value<String> billingCycle;
  final Value<int?> customCycleDays;
  final Value<String?> paymentMethodId;
  final Value<String> renewalIntent;
  final Value<String> usageFrequency;
  final Value<int?> usageCountPerMonth;
  final Value<String?> officialWebsiteUrl;
  final Value<String?> manageSubscriptionUrl;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDemo;
  final Value<int> rowid;
  const SubscriptionsCompanion({
    this.id = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.planId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.profileId = const Value.absent(),
    this.status = const Value.absent(),
    this.active = const Value.absent(),
    this.startDate = const Value.absent(),
    this.nextBillingDate = const Value.absent(),
    this.accessEndDate = const Value.absent(),
    this.autoRenew = const Value.absent(),
    this.currency = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.billingCycle = const Value.absent(),
    this.customCycleDays = const Value.absent(),
    this.paymentMethodId = const Value.absent(),
    this.renewalIntent = const Value.absent(),
    this.usageFrequency = const Value.absent(),
    this.usageCountPerMonth = const Value.absent(),
    this.officialWebsiteUrl = const Value.absent(),
    this.manageSubscriptionUrl = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDemo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    required String id,
    required String serviceId,
    this.planId = const Value.absent(),
    required String categoryId,
    required String profileId,
    required String status,
    this.active = const Value.absent(),
    required DateTime startDate,
    this.nextBillingDate = const Value.absent(),
    this.accessEndDate = const Value.absent(),
    this.autoRenew = const Value.absent(),
    required String currency,
    required double currentPrice,
    required String billingCycle,
    this.customCycleDays = const Value.absent(),
    this.paymentMethodId = const Value.absent(),
    required String renewalIntent,
    required String usageFrequency,
    this.usageCountPerMonth = const Value.absent(),
    this.officialWebsiteUrl = const Value.absent(),
    this.manageSubscriptionUrl = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isDemo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       serviceId = Value(serviceId),
       categoryId = Value(categoryId),
       profileId = Value(profileId),
       status = Value(status),
       startDate = Value(startDate),
       currency = Value(currency),
       currentPrice = Value(currentPrice),
       billingCycle = Value(billingCycle),
       renewalIntent = Value(renewalIntent),
       usageFrequency = Value(usageFrequency),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Subscription> custom({
    Expression<String>? id,
    Expression<String>? serviceId,
    Expression<String>? planId,
    Expression<String>? categoryId,
    Expression<String>? profileId,
    Expression<String>? status,
    Expression<bool>? active,
    Expression<DateTime>? startDate,
    Expression<DateTime>? nextBillingDate,
    Expression<DateTime>? accessEndDate,
    Expression<bool>? autoRenew,
    Expression<String>? currency,
    Expression<double>? currentPrice,
    Expression<String>? billingCycle,
    Expression<int>? customCycleDays,
    Expression<String>? paymentMethodId,
    Expression<String>? renewalIntent,
    Expression<String>? usageFrequency,
    Expression<int>? usageCountPerMonth,
    Expression<String>? officialWebsiteUrl,
    Expression<String>? manageSubscriptionUrl,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDemo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serviceId != null) 'service_id': serviceId,
      if (planId != null) 'plan_id': planId,
      if (categoryId != null) 'category_id': categoryId,
      if (profileId != null) 'profile_id': profileId,
      if (status != null) 'status': status,
      if (active != null) 'active': active,
      if (startDate != null) 'start_date': startDate,
      if (nextBillingDate != null) 'next_billing_date': nextBillingDate,
      if (accessEndDate != null) 'access_end_date': accessEndDate,
      if (autoRenew != null) 'auto_renew': autoRenew,
      if (currency != null) 'currency': currency,
      if (currentPrice != null) 'current_price': currentPrice,
      if (billingCycle != null) 'billing_cycle': billingCycle,
      if (customCycleDays != null) 'custom_cycle_days': customCycleDays,
      if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      if (renewalIntent != null) 'renewal_intent': renewalIntent,
      if (usageFrequency != null) 'usage_frequency': usageFrequency,
      if (usageCountPerMonth != null)
        'usage_count_per_month': usageCountPerMonth,
      if (officialWebsiteUrl != null)
        'official_website_url': officialWebsiteUrl,
      if (manageSubscriptionUrl != null)
        'manage_subscription_url': manageSubscriptionUrl,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDemo != null) 'is_demo': isDemo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubscriptionsCompanion copyWith({
    Value<String>? id,
    Value<String>? serviceId,
    Value<String?>? planId,
    Value<String>? categoryId,
    Value<String>? profileId,
    Value<String>? status,
    Value<bool>? active,
    Value<DateTime>? startDate,
    Value<DateTime?>? nextBillingDate,
    Value<DateTime?>? accessEndDate,
    Value<bool>? autoRenew,
    Value<String>? currency,
    Value<double>? currentPrice,
    Value<String>? billingCycle,
    Value<int?>? customCycleDays,
    Value<String?>? paymentMethodId,
    Value<String>? renewalIntent,
    Value<String>? usageFrequency,
    Value<int?>? usageCountPerMonth,
    Value<String?>? officialWebsiteUrl,
    Value<String?>? manageSubscriptionUrl,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isDemo,
    Value<int>? rowid,
  }) {
    return SubscriptionsCompanion(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      planId: planId ?? this.planId,
      categoryId: categoryId ?? this.categoryId,
      profileId: profileId ?? this.profileId,
      status: status ?? this.status,
      active: active ?? this.active,
      startDate: startDate ?? this.startDate,
      nextBillingDate: nextBillingDate ?? this.nextBillingDate,
      accessEndDate: accessEndDate ?? this.accessEndDate,
      autoRenew: autoRenew ?? this.autoRenew,
      currency: currency ?? this.currency,
      currentPrice: currentPrice ?? this.currentPrice,
      billingCycle: billingCycle ?? this.billingCycle,
      customCycleDays: customCycleDays ?? this.customCycleDays,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      renewalIntent: renewalIntent ?? this.renewalIntent,
      usageFrequency: usageFrequency ?? this.usageFrequency,
      usageCountPerMonth: usageCountPerMonth ?? this.usageCountPerMonth,
      officialWebsiteUrl: officialWebsiteUrl ?? this.officialWebsiteUrl,
      manageSubscriptionUrl:
          manageSubscriptionUrl ?? this.manageSubscriptionUrl,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDemo: isDemo ?? this.isDemo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (nextBillingDate.present) {
      map['next_billing_date'] = Variable<DateTime>(nextBillingDate.value);
    }
    if (accessEndDate.present) {
      map['access_end_date'] = Variable<DateTime>(accessEndDate.value);
    }
    if (autoRenew.present) {
      map['auto_renew'] = Variable<bool>(autoRenew.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (currentPrice.present) {
      map['current_price'] = Variable<double>(currentPrice.value);
    }
    if (billingCycle.present) {
      map['billing_cycle'] = Variable<String>(billingCycle.value);
    }
    if (customCycleDays.present) {
      map['custom_cycle_days'] = Variable<int>(customCycleDays.value);
    }
    if (paymentMethodId.present) {
      map['payment_method_id'] = Variable<String>(paymentMethodId.value);
    }
    if (renewalIntent.present) {
      map['renewal_intent'] = Variable<String>(renewalIntent.value);
    }
    if (usageFrequency.present) {
      map['usage_frequency'] = Variable<String>(usageFrequency.value);
    }
    if (usageCountPerMonth.present) {
      map['usage_count_per_month'] = Variable<int>(usageCountPerMonth.value);
    }
    if (officialWebsiteUrl.present) {
      map['official_website_url'] = Variable<String>(officialWebsiteUrl.value);
    }
    if (manageSubscriptionUrl.present) {
      map['manage_subscription_url'] = Variable<String>(
        manageSubscriptionUrl.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDemo.present) {
      map['is_demo'] = Variable<bool>(isDemo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('id: $id, ')
          ..write('serviceId: $serviceId, ')
          ..write('planId: $planId, ')
          ..write('categoryId: $categoryId, ')
          ..write('profileId: $profileId, ')
          ..write('status: $status, ')
          ..write('active: $active, ')
          ..write('startDate: $startDate, ')
          ..write('nextBillingDate: $nextBillingDate, ')
          ..write('accessEndDate: $accessEndDate, ')
          ..write('autoRenew: $autoRenew, ')
          ..write('currency: $currency, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('customCycleDays: $customCycleDays, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('renewalIntent: $renewalIntent, ')
          ..write('usageFrequency: $usageFrequency, ')
          ..write('usageCountPerMonth: $usageCountPerMonth, ')
          ..write('officialWebsiteUrl: $officialWebsiteUrl, ')
          ..write('manageSubscriptionUrl: $manageSubscriptionUrl, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDemo: $isDemo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PricePhasesTable extends PricePhases
    with TableInfo<$PricePhasesTable, PricePhase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PricePhasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<String> subscriptionId = GeneratedColumn<String>(
    'subscription_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billingCycleMeta = const VerificationMeta(
    'billingCycle',
  );
  @override
  late final GeneratedColumn<String> billingCycle = GeneratedColumn<String>(
    'billing_cycle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regularPriceMeta = const VerificationMeta(
    'regularPrice',
  );
  @override
  late final GeneratedColumn<double> regularPrice = GeneratedColumn<double>(
    'regular_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regularCurrencyMeta = const VerificationMeta(
    'regularCurrency',
  );
  @override
  late final GeneratedColumn<String> regularCurrency = GeneratedColumn<String>(
    'regular_currency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promotionNameMeta = const VerificationMeta(
    'promotionName',
  );
  @override
  late final GeneratedColumn<String> promotionName = GeneratedColumn<String>(
    'promotion_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cancelDeadlineMeta = const VerificationMeta(
    'cancelDeadline',
  );
  @override
  late final GeneratedColumn<DateTime> cancelDeadline =
      GeneratedColumn<DateTime>(
        'cancel_deadline',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _firstChargeDateMeta = const VerificationMeta(
    'firstChargeDate',
  );
  @override
  late final GeneratedColumn<DateTime> firstChargeDate =
      GeneratedColumn<DateTime>(
        'first_charge_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _trialEndDateMeta = const VerificationMeta(
    'trialEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> trialEndDate = GeneratedColumn<DateTime>(
    'trial_end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderDateMeta = const VerificationMeta(
    'reminderDate',
  );
  @override
  late final GeneratedColumn<DateTime> reminderDate = GeneratedColumn<DateTime>(
    'reminder_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autoRenewMeta = const VerificationMeta(
    'autoRenew',
  );
  @override
  late final GeneratedColumn<bool> autoRenew = GeneratedColumn<bool>(
    'auto_renew',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_renew" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subscriptionId,
    type,
    startDate,
    endDate,
    price,
    currency,
    billingCycle,
    regularPrice,
    regularCurrency,
    promotionName,
    cancelDeadline,
    firstChargeDate,
    trialEndDate,
    reminderDate,
    autoRenew,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_phases';
  @override
  VerificationContext validateIntegrity(
    Insertable<PricePhase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subscriptionIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('billing_cycle')) {
      context.handle(
        _billingCycleMeta,
        billingCycle.isAcceptableOrUnknown(
          data['billing_cycle']!,
          _billingCycleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingCycleMeta);
    }
    if (data.containsKey('regular_price')) {
      context.handle(
        _regularPriceMeta,
        regularPrice.isAcceptableOrUnknown(
          data['regular_price']!,
          _regularPriceMeta,
        ),
      );
    }
    if (data.containsKey('regular_currency')) {
      context.handle(
        _regularCurrencyMeta,
        regularCurrency.isAcceptableOrUnknown(
          data['regular_currency']!,
          _regularCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('promotion_name')) {
      context.handle(
        _promotionNameMeta,
        promotionName.isAcceptableOrUnknown(
          data['promotion_name']!,
          _promotionNameMeta,
        ),
      );
    }
    if (data.containsKey('cancel_deadline')) {
      context.handle(
        _cancelDeadlineMeta,
        cancelDeadline.isAcceptableOrUnknown(
          data['cancel_deadline']!,
          _cancelDeadlineMeta,
        ),
      );
    }
    if (data.containsKey('first_charge_date')) {
      context.handle(
        _firstChargeDateMeta,
        firstChargeDate.isAcceptableOrUnknown(
          data['first_charge_date']!,
          _firstChargeDateMeta,
        ),
      );
    }
    if (data.containsKey('trial_end_date')) {
      context.handle(
        _trialEndDateMeta,
        trialEndDate.isAcceptableOrUnknown(
          data['trial_end_date']!,
          _trialEndDateMeta,
        ),
      );
    }
    if (data.containsKey('reminder_date')) {
      context.handle(
        _reminderDateMeta,
        reminderDate.isAcceptableOrUnknown(
          data['reminder_date']!,
          _reminderDateMeta,
        ),
      );
    }
    if (data.containsKey('auto_renew')) {
      context.handle(
        _autoRenewMeta,
        autoRenew.isAcceptableOrUnknown(data['auto_renew']!, _autoRenewMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PricePhase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PricePhase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subscription_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      billingCycle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_cycle'],
      )!,
      regularPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}regular_price'],
      ),
      regularCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}regular_currency'],
      ),
      promotionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}promotion_name'],
      ),
      cancelDeadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cancel_deadline'],
      ),
      firstChargeDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_charge_date'],
      ),
      trialEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}trial_end_date'],
      ),
      reminderDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reminder_date'],
      ),
      autoRenew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_renew'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $PricePhasesTable createAlias(String alias) {
    return $PricePhasesTable(attachedDatabase, alias);
  }
}

class PricePhase extends DataClass implements Insertable<PricePhase> {
  final String id;
  final String subscriptionId;
  final String type;
  final DateTime startDate;
  final DateTime? endDate;
  final double price;
  final String currency;
  final String billingCycle;
  final double? regularPrice;
  final String? regularCurrency;
  final String? promotionName;
  final DateTime? cancelDeadline;
  final DateTime? firstChargeDate;
  final DateTime? trialEndDate;
  final DateTime? reminderDate;
  final bool autoRenew;
  final int sortOrder;
  const PricePhase({
    required this.id,
    required this.subscriptionId,
    required this.type,
    required this.startDate,
    this.endDate,
    required this.price,
    required this.currency,
    required this.billingCycle,
    this.regularPrice,
    this.regularCurrency,
    this.promotionName,
    this.cancelDeadline,
    this.firstChargeDate,
    this.trialEndDate,
    this.reminderDate,
    required this.autoRenew,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subscription_id'] = Variable<String>(subscriptionId);
    map['type'] = Variable<String>(type);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['price'] = Variable<double>(price);
    map['currency'] = Variable<String>(currency);
    map['billing_cycle'] = Variable<String>(billingCycle);
    if (!nullToAbsent || regularPrice != null) {
      map['regular_price'] = Variable<double>(regularPrice);
    }
    if (!nullToAbsent || regularCurrency != null) {
      map['regular_currency'] = Variable<String>(regularCurrency);
    }
    if (!nullToAbsent || promotionName != null) {
      map['promotion_name'] = Variable<String>(promotionName);
    }
    if (!nullToAbsent || cancelDeadline != null) {
      map['cancel_deadline'] = Variable<DateTime>(cancelDeadline);
    }
    if (!nullToAbsent || firstChargeDate != null) {
      map['first_charge_date'] = Variable<DateTime>(firstChargeDate);
    }
    if (!nullToAbsent || trialEndDate != null) {
      map['trial_end_date'] = Variable<DateTime>(trialEndDate);
    }
    if (!nullToAbsent || reminderDate != null) {
      map['reminder_date'] = Variable<DateTime>(reminderDate);
    }
    map['auto_renew'] = Variable<bool>(autoRenew);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  PricePhasesCompanion toCompanion(bool nullToAbsent) {
    return PricePhasesCompanion(
      id: Value(id),
      subscriptionId: Value(subscriptionId),
      type: Value(type),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      price: Value(price),
      currency: Value(currency),
      billingCycle: Value(billingCycle),
      regularPrice: regularPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(regularPrice),
      regularCurrency: regularCurrency == null && nullToAbsent
          ? const Value.absent()
          : Value(regularCurrency),
      promotionName: promotionName == null && nullToAbsent
          ? const Value.absent()
          : Value(promotionName),
      cancelDeadline: cancelDeadline == null && nullToAbsent
          ? const Value.absent()
          : Value(cancelDeadline),
      firstChargeDate: firstChargeDate == null && nullToAbsent
          ? const Value.absent()
          : Value(firstChargeDate),
      trialEndDate: trialEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(trialEndDate),
      reminderDate: reminderDate == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDate),
      autoRenew: Value(autoRenew),
      sortOrder: Value(sortOrder),
    );
  }

  factory PricePhase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PricePhase(
      id: serializer.fromJson<String>(json['id']),
      subscriptionId: serializer.fromJson<String>(json['subscriptionId']),
      type: serializer.fromJson<String>(json['type']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      price: serializer.fromJson<double>(json['price']),
      currency: serializer.fromJson<String>(json['currency']),
      billingCycle: serializer.fromJson<String>(json['billingCycle']),
      regularPrice: serializer.fromJson<double?>(json['regularPrice']),
      regularCurrency: serializer.fromJson<String?>(json['regularCurrency']),
      promotionName: serializer.fromJson<String?>(json['promotionName']),
      cancelDeadline: serializer.fromJson<DateTime?>(json['cancelDeadline']),
      firstChargeDate: serializer.fromJson<DateTime?>(json['firstChargeDate']),
      trialEndDate: serializer.fromJson<DateTime?>(json['trialEndDate']),
      reminderDate: serializer.fromJson<DateTime?>(json['reminderDate']),
      autoRenew: serializer.fromJson<bool>(json['autoRenew']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subscriptionId': serializer.toJson<String>(subscriptionId),
      'type': serializer.toJson<String>(type),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'price': serializer.toJson<double>(price),
      'currency': serializer.toJson<String>(currency),
      'billingCycle': serializer.toJson<String>(billingCycle),
      'regularPrice': serializer.toJson<double?>(regularPrice),
      'regularCurrency': serializer.toJson<String?>(regularCurrency),
      'promotionName': serializer.toJson<String?>(promotionName),
      'cancelDeadline': serializer.toJson<DateTime?>(cancelDeadline),
      'firstChargeDate': serializer.toJson<DateTime?>(firstChargeDate),
      'trialEndDate': serializer.toJson<DateTime?>(trialEndDate),
      'reminderDate': serializer.toJson<DateTime?>(reminderDate),
      'autoRenew': serializer.toJson<bool>(autoRenew),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  PricePhase copyWith({
    String? id,
    String? subscriptionId,
    String? type,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    double? price,
    String? currency,
    String? billingCycle,
    Value<double?> regularPrice = const Value.absent(),
    Value<String?> regularCurrency = const Value.absent(),
    Value<String?> promotionName = const Value.absent(),
    Value<DateTime?> cancelDeadline = const Value.absent(),
    Value<DateTime?> firstChargeDate = const Value.absent(),
    Value<DateTime?> trialEndDate = const Value.absent(),
    Value<DateTime?> reminderDate = const Value.absent(),
    bool? autoRenew,
    int? sortOrder,
  }) => PricePhase(
    id: id ?? this.id,
    subscriptionId: subscriptionId ?? this.subscriptionId,
    type: type ?? this.type,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    price: price ?? this.price,
    currency: currency ?? this.currency,
    billingCycle: billingCycle ?? this.billingCycle,
    regularPrice: regularPrice.present ? regularPrice.value : this.regularPrice,
    regularCurrency: regularCurrency.present
        ? regularCurrency.value
        : this.regularCurrency,
    promotionName: promotionName.present
        ? promotionName.value
        : this.promotionName,
    cancelDeadline: cancelDeadline.present
        ? cancelDeadline.value
        : this.cancelDeadline,
    firstChargeDate: firstChargeDate.present
        ? firstChargeDate.value
        : this.firstChargeDate,
    trialEndDate: trialEndDate.present ? trialEndDate.value : this.trialEndDate,
    reminderDate: reminderDate.present ? reminderDate.value : this.reminderDate,
    autoRenew: autoRenew ?? this.autoRenew,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  PricePhase copyWithCompanion(PricePhasesCompanion data) {
    return PricePhase(
      id: data.id.present ? data.id.value : this.id,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
      type: data.type.present ? data.type.value : this.type,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      price: data.price.present ? data.price.value : this.price,
      currency: data.currency.present ? data.currency.value : this.currency,
      billingCycle: data.billingCycle.present
          ? data.billingCycle.value
          : this.billingCycle,
      regularPrice: data.regularPrice.present
          ? data.regularPrice.value
          : this.regularPrice,
      regularCurrency: data.regularCurrency.present
          ? data.regularCurrency.value
          : this.regularCurrency,
      promotionName: data.promotionName.present
          ? data.promotionName.value
          : this.promotionName,
      cancelDeadline: data.cancelDeadline.present
          ? data.cancelDeadline.value
          : this.cancelDeadline,
      firstChargeDate: data.firstChargeDate.present
          ? data.firstChargeDate.value
          : this.firstChargeDate,
      trialEndDate: data.trialEndDate.present
          ? data.trialEndDate.value
          : this.trialEndDate,
      reminderDate: data.reminderDate.present
          ? data.reminderDate.value
          : this.reminderDate,
      autoRenew: data.autoRenew.present ? data.autoRenew.value : this.autoRenew,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PricePhase(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('regularPrice: $regularPrice, ')
          ..write('regularCurrency: $regularCurrency, ')
          ..write('promotionName: $promotionName, ')
          ..write('cancelDeadline: $cancelDeadline, ')
          ..write('firstChargeDate: $firstChargeDate, ')
          ..write('trialEndDate: $trialEndDate, ')
          ..write('reminderDate: $reminderDate, ')
          ..write('autoRenew: $autoRenew, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subscriptionId,
    type,
    startDate,
    endDate,
    price,
    currency,
    billingCycle,
    regularPrice,
    regularCurrency,
    promotionName,
    cancelDeadline,
    firstChargeDate,
    trialEndDate,
    reminderDate,
    autoRenew,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PricePhase &&
          other.id == this.id &&
          other.subscriptionId == this.subscriptionId &&
          other.type == this.type &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.price == this.price &&
          other.currency == this.currency &&
          other.billingCycle == this.billingCycle &&
          other.regularPrice == this.regularPrice &&
          other.regularCurrency == this.regularCurrency &&
          other.promotionName == this.promotionName &&
          other.cancelDeadline == this.cancelDeadline &&
          other.firstChargeDate == this.firstChargeDate &&
          other.trialEndDate == this.trialEndDate &&
          other.reminderDate == this.reminderDate &&
          other.autoRenew == this.autoRenew &&
          other.sortOrder == this.sortOrder);
}

class PricePhasesCompanion extends UpdateCompanion<PricePhase> {
  final Value<String> id;
  final Value<String> subscriptionId;
  final Value<String> type;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<double> price;
  final Value<String> currency;
  final Value<String> billingCycle;
  final Value<double?> regularPrice;
  final Value<String?> regularCurrency;
  final Value<String?> promotionName;
  final Value<DateTime?> cancelDeadline;
  final Value<DateTime?> firstChargeDate;
  final Value<DateTime?> trialEndDate;
  final Value<DateTime?> reminderDate;
  final Value<bool> autoRenew;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const PricePhasesCompanion({
    this.id = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.type = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.price = const Value.absent(),
    this.currency = const Value.absent(),
    this.billingCycle = const Value.absent(),
    this.regularPrice = const Value.absent(),
    this.regularCurrency = const Value.absent(),
    this.promotionName = const Value.absent(),
    this.cancelDeadline = const Value.absent(),
    this.firstChargeDate = const Value.absent(),
    this.trialEndDate = const Value.absent(),
    this.reminderDate = const Value.absent(),
    this.autoRenew = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PricePhasesCompanion.insert({
    required String id,
    required String subscriptionId,
    required String type,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required double price,
    required String currency,
    required String billingCycle,
    this.regularPrice = const Value.absent(),
    this.regularCurrency = const Value.absent(),
    this.promotionName = const Value.absent(),
    this.cancelDeadline = const Value.absent(),
    this.firstChargeDate = const Value.absent(),
    this.trialEndDate = const Value.absent(),
    this.reminderDate = const Value.absent(),
    this.autoRenew = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subscriptionId = Value(subscriptionId),
       type = Value(type),
       startDate = Value(startDate),
       price = Value(price),
       currency = Value(currency),
       billingCycle = Value(billingCycle);
  static Insertable<PricePhase> custom({
    Expression<String>? id,
    Expression<String>? subscriptionId,
    Expression<String>? type,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<double>? price,
    Expression<String>? currency,
    Expression<String>? billingCycle,
    Expression<double>? regularPrice,
    Expression<String>? regularCurrency,
    Expression<String>? promotionName,
    Expression<DateTime>? cancelDeadline,
    Expression<DateTime>? firstChargeDate,
    Expression<DateTime>? trialEndDate,
    Expression<DateTime>? reminderDate,
    Expression<bool>? autoRenew,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (type != null) 'type': type,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (price != null) 'price': price,
      if (currency != null) 'currency': currency,
      if (billingCycle != null) 'billing_cycle': billingCycle,
      if (regularPrice != null) 'regular_price': regularPrice,
      if (regularCurrency != null) 'regular_currency': regularCurrency,
      if (promotionName != null) 'promotion_name': promotionName,
      if (cancelDeadline != null) 'cancel_deadline': cancelDeadline,
      if (firstChargeDate != null) 'first_charge_date': firstChargeDate,
      if (trialEndDate != null) 'trial_end_date': trialEndDate,
      if (reminderDate != null) 'reminder_date': reminderDate,
      if (autoRenew != null) 'auto_renew': autoRenew,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PricePhasesCompanion copyWith({
    Value<String>? id,
    Value<String>? subscriptionId,
    Value<String>? type,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<double>? price,
    Value<String>? currency,
    Value<String>? billingCycle,
    Value<double?>? regularPrice,
    Value<String?>? regularCurrency,
    Value<String?>? promotionName,
    Value<DateTime?>? cancelDeadline,
    Value<DateTime?>? firstChargeDate,
    Value<DateTime?>? trialEndDate,
    Value<DateTime?>? reminderDate,
    Value<bool>? autoRenew,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return PricePhasesCompanion(
      id: id ?? this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      billingCycle: billingCycle ?? this.billingCycle,
      regularPrice: regularPrice ?? this.regularPrice,
      regularCurrency: regularCurrency ?? this.regularCurrency,
      promotionName: promotionName ?? this.promotionName,
      cancelDeadline: cancelDeadline ?? this.cancelDeadline,
      firstChargeDate: firstChargeDate ?? this.firstChargeDate,
      trialEndDate: trialEndDate ?? this.trialEndDate,
      reminderDate: reminderDate ?? this.reminderDate,
      autoRenew: autoRenew ?? this.autoRenew,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<String>(subscriptionId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (billingCycle.present) {
      map['billing_cycle'] = Variable<String>(billingCycle.value);
    }
    if (regularPrice.present) {
      map['regular_price'] = Variable<double>(regularPrice.value);
    }
    if (regularCurrency.present) {
      map['regular_currency'] = Variable<String>(regularCurrency.value);
    }
    if (promotionName.present) {
      map['promotion_name'] = Variable<String>(promotionName.value);
    }
    if (cancelDeadline.present) {
      map['cancel_deadline'] = Variable<DateTime>(cancelDeadline.value);
    }
    if (firstChargeDate.present) {
      map['first_charge_date'] = Variable<DateTime>(firstChargeDate.value);
    }
    if (trialEndDate.present) {
      map['trial_end_date'] = Variable<DateTime>(trialEndDate.value);
    }
    if (reminderDate.present) {
      map['reminder_date'] = Variable<DateTime>(reminderDate.value);
    }
    if (autoRenew.present) {
      map['auto_renew'] = Variable<bool>(autoRenew.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PricePhasesCompanion(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('regularPrice: $regularPrice, ')
          ..write('regularCurrency: $regularCurrency, ')
          ..write('promotionName: $promotionName, ')
          ..write('cancelDeadline: $cancelDeadline, ')
          ..write('firstChargeDate: $firstChargeDate, ')
          ..write('trialEndDate: $trialEndDate, ')
          ..write('reminderDate: $reminderDate, ')
          ..write('autoRenew: $autoRenew, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentRecordsTable extends PaymentRecords
    with TableInfo<$PaymentRecordsTable, PaymentRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<String> subscriptionId = GeneratedColumn<String>(
    'subscription_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalAmountMeta = const VerificationMeta(
    'originalAmount',
  );
  @override
  late final GeneratedColumn<double> originalAmount = GeneratedColumn<double>(
    'original_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalCurrencyMeta = const VerificationMeta(
    'originalCurrency',
  );
  @override
  late final GeneratedColumn<String> originalCurrency = GeneratedColumn<String>(
    'original_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exchangeRateMeta = const VerificationMeta(
    'exchangeRate',
  );
  @override
  late final GeneratedColumn<double> exchangeRate = GeneratedColumn<double>(
    'exchange_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _convertedAmountMeta = const VerificationMeta(
    'convertedAmount',
  );
  @override
  late final GeneratedColumn<double> convertedAmount = GeneratedColumn<double>(
    'converted_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foreignFeeMeta = const VerificationMeta(
    'foreignFee',
  );
  @override
  late final GeneratedColumn<double> foreignFee = GeneratedColumn<double>(
    'foreign_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualChargedAmountMeta =
      const VerificationMeta('actualChargedAmount');
  @override
  late final GeneratedColumn<double> actualChargedAmount =
      GeneratedColumn<double>(
        'actual_charged_amount',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _paymentMethodIdMeta = const VerificationMeta(
    'paymentMethodId',
  );
  @override
  late final GeneratedColumn<String> paymentMethodId = GeneratedColumn<String>(
    'payment_method_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subscriptionId,
    date,
    originalAmount,
    originalCurrency,
    exchangeRate,
    convertedAmount,
    baseCurrency,
    foreignFee,
    actualChargedAmount,
    paymentMethodId,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subscriptionIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('original_amount')) {
      context.handle(
        _originalAmountMeta,
        originalAmount.isAcceptableOrUnknown(
          data['original_amount']!,
          _originalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalAmountMeta);
    }
    if (data.containsKey('original_currency')) {
      context.handle(
        _originalCurrencyMeta,
        originalCurrency.isAcceptableOrUnknown(
          data['original_currency']!,
          _originalCurrencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalCurrencyMeta);
    }
    if (data.containsKey('exchange_rate')) {
      context.handle(
        _exchangeRateMeta,
        exchangeRate.isAcceptableOrUnknown(
          data['exchange_rate']!,
          _exchangeRateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exchangeRateMeta);
    }
    if (data.containsKey('converted_amount')) {
      context.handle(
        _convertedAmountMeta,
        convertedAmount.isAcceptableOrUnknown(
          data['converted_amount']!,
          _convertedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_convertedAmountMeta);
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseCurrencyMeta);
    }
    if (data.containsKey('foreign_fee')) {
      context.handle(
        _foreignFeeMeta,
        foreignFee.isAcceptableOrUnknown(data['foreign_fee']!, _foreignFeeMeta),
      );
    } else if (isInserting) {
      context.missing(_foreignFeeMeta);
    }
    if (data.containsKey('actual_charged_amount')) {
      context.handle(
        _actualChargedAmountMeta,
        actualChargedAmount.isAcceptableOrUnknown(
          data['actual_charged_amount']!,
          _actualChargedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualChargedAmountMeta);
    }
    if (data.containsKey('payment_method_id')) {
      context.handle(
        _paymentMethodIdMeta,
        paymentMethodId.isAcceptableOrUnknown(
          data['payment_method_id']!,
          _paymentMethodIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subscription_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      originalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_amount'],
      )!,
      originalCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_currency'],
      )!,
      exchangeRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exchange_rate'],
      )!,
      convertedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}converted_amount'],
      )!,
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
      foreignFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}foreign_fee'],
      )!,
      actualChargedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_charged_amount'],
      )!,
      paymentMethodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $PaymentRecordsTable createAlias(String alias) {
    return $PaymentRecordsTable(attachedDatabase, alias);
  }
}

class PaymentRecord extends DataClass implements Insertable<PaymentRecord> {
  final String id;
  final String subscriptionId;
  final DateTime date;
  final double originalAmount;
  final String originalCurrency;
  final double exchangeRate;
  final double convertedAmount;
  final String baseCurrency;
  final double foreignFee;
  final double actualChargedAmount;
  final String? paymentMethodId;
  final String? note;
  const PaymentRecord({
    required this.id,
    required this.subscriptionId,
    required this.date,
    required this.originalAmount,
    required this.originalCurrency,
    required this.exchangeRate,
    required this.convertedAmount,
    required this.baseCurrency,
    required this.foreignFee,
    required this.actualChargedAmount,
    this.paymentMethodId,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subscription_id'] = Variable<String>(subscriptionId);
    map['date'] = Variable<DateTime>(date);
    map['original_amount'] = Variable<double>(originalAmount);
    map['original_currency'] = Variable<String>(originalCurrency);
    map['exchange_rate'] = Variable<double>(exchangeRate);
    map['converted_amount'] = Variable<double>(convertedAmount);
    map['base_currency'] = Variable<String>(baseCurrency);
    map['foreign_fee'] = Variable<double>(foreignFee);
    map['actual_charged_amount'] = Variable<double>(actualChargedAmount);
    if (!nullToAbsent || paymentMethodId != null) {
      map['payment_method_id'] = Variable<String>(paymentMethodId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PaymentRecordsCompanion toCompanion(bool nullToAbsent) {
    return PaymentRecordsCompanion(
      id: Value(id),
      subscriptionId: Value(subscriptionId),
      date: Value(date),
      originalAmount: Value(originalAmount),
      originalCurrency: Value(originalCurrency),
      exchangeRate: Value(exchangeRate),
      convertedAmount: Value(convertedAmount),
      baseCurrency: Value(baseCurrency),
      foreignFee: Value(foreignFee),
      actualChargedAmount: Value(actualChargedAmount),
      paymentMethodId: paymentMethodId == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethodId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory PaymentRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentRecord(
      id: serializer.fromJson<String>(json['id']),
      subscriptionId: serializer.fromJson<String>(json['subscriptionId']),
      date: serializer.fromJson<DateTime>(json['date']),
      originalAmount: serializer.fromJson<double>(json['originalAmount']),
      originalCurrency: serializer.fromJson<String>(json['originalCurrency']),
      exchangeRate: serializer.fromJson<double>(json['exchangeRate']),
      convertedAmount: serializer.fromJson<double>(json['convertedAmount']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      foreignFee: serializer.fromJson<double>(json['foreignFee']),
      actualChargedAmount: serializer.fromJson<double>(
        json['actualChargedAmount'],
      ),
      paymentMethodId: serializer.fromJson<String?>(json['paymentMethodId']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subscriptionId': serializer.toJson<String>(subscriptionId),
      'date': serializer.toJson<DateTime>(date),
      'originalAmount': serializer.toJson<double>(originalAmount),
      'originalCurrency': serializer.toJson<String>(originalCurrency),
      'exchangeRate': serializer.toJson<double>(exchangeRate),
      'convertedAmount': serializer.toJson<double>(convertedAmount),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'foreignFee': serializer.toJson<double>(foreignFee),
      'actualChargedAmount': serializer.toJson<double>(actualChargedAmount),
      'paymentMethodId': serializer.toJson<String?>(paymentMethodId),
      'note': serializer.toJson<String?>(note),
    };
  }

  PaymentRecord copyWith({
    String? id,
    String? subscriptionId,
    DateTime? date,
    double? originalAmount,
    String? originalCurrency,
    double? exchangeRate,
    double? convertedAmount,
    String? baseCurrency,
    double? foreignFee,
    double? actualChargedAmount,
    Value<String?> paymentMethodId = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => PaymentRecord(
    id: id ?? this.id,
    subscriptionId: subscriptionId ?? this.subscriptionId,
    date: date ?? this.date,
    originalAmount: originalAmount ?? this.originalAmount,
    originalCurrency: originalCurrency ?? this.originalCurrency,
    exchangeRate: exchangeRate ?? this.exchangeRate,
    convertedAmount: convertedAmount ?? this.convertedAmount,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    foreignFee: foreignFee ?? this.foreignFee,
    actualChargedAmount: actualChargedAmount ?? this.actualChargedAmount,
    paymentMethodId: paymentMethodId.present
        ? paymentMethodId.value
        : this.paymentMethodId,
    note: note.present ? note.value : this.note,
  );
  PaymentRecord copyWithCompanion(PaymentRecordsCompanion data) {
    return PaymentRecord(
      id: data.id.present ? data.id.value : this.id,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
      date: data.date.present ? data.date.value : this.date,
      originalAmount: data.originalAmount.present
          ? data.originalAmount.value
          : this.originalAmount,
      originalCurrency: data.originalCurrency.present
          ? data.originalCurrency.value
          : this.originalCurrency,
      exchangeRate: data.exchangeRate.present
          ? data.exchangeRate.value
          : this.exchangeRate,
      convertedAmount: data.convertedAmount.present
          ? data.convertedAmount.value
          : this.convertedAmount,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      foreignFee: data.foreignFee.present
          ? data.foreignFee.value
          : this.foreignFee,
      actualChargedAmount: data.actualChargedAmount.present
          ? data.actualChargedAmount.value
          : this.actualChargedAmount,
      paymentMethodId: data.paymentMethodId.present
          ? data.paymentMethodId.value
          : this.paymentMethodId,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentRecord(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('date: $date, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('originalCurrency: $originalCurrency, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('convertedAmount: $convertedAmount, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('foreignFee: $foreignFee, ')
          ..write('actualChargedAmount: $actualChargedAmount, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subscriptionId,
    date,
    originalAmount,
    originalCurrency,
    exchangeRate,
    convertedAmount,
    baseCurrency,
    foreignFee,
    actualChargedAmount,
    paymentMethodId,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentRecord &&
          other.id == this.id &&
          other.subscriptionId == this.subscriptionId &&
          other.date == this.date &&
          other.originalAmount == this.originalAmount &&
          other.originalCurrency == this.originalCurrency &&
          other.exchangeRate == this.exchangeRate &&
          other.convertedAmount == this.convertedAmount &&
          other.baseCurrency == this.baseCurrency &&
          other.foreignFee == this.foreignFee &&
          other.actualChargedAmount == this.actualChargedAmount &&
          other.paymentMethodId == this.paymentMethodId &&
          other.note == this.note);
}

class PaymentRecordsCompanion extends UpdateCompanion<PaymentRecord> {
  final Value<String> id;
  final Value<String> subscriptionId;
  final Value<DateTime> date;
  final Value<double> originalAmount;
  final Value<String> originalCurrency;
  final Value<double> exchangeRate;
  final Value<double> convertedAmount;
  final Value<String> baseCurrency;
  final Value<double> foreignFee;
  final Value<double> actualChargedAmount;
  final Value<String?> paymentMethodId;
  final Value<String?> note;
  final Value<int> rowid;
  const PaymentRecordsCompanion({
    this.id = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.date = const Value.absent(),
    this.originalAmount = const Value.absent(),
    this.originalCurrency = const Value.absent(),
    this.exchangeRate = const Value.absent(),
    this.convertedAmount = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.foreignFee = const Value.absent(),
    this.actualChargedAmount = const Value.absent(),
    this.paymentMethodId = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentRecordsCompanion.insert({
    required String id,
    required String subscriptionId,
    required DateTime date,
    required double originalAmount,
    required String originalCurrency,
    required double exchangeRate,
    required double convertedAmount,
    required String baseCurrency,
    required double foreignFee,
    required double actualChargedAmount,
    this.paymentMethodId = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subscriptionId = Value(subscriptionId),
       date = Value(date),
       originalAmount = Value(originalAmount),
       originalCurrency = Value(originalCurrency),
       exchangeRate = Value(exchangeRate),
       convertedAmount = Value(convertedAmount),
       baseCurrency = Value(baseCurrency),
       foreignFee = Value(foreignFee),
       actualChargedAmount = Value(actualChargedAmount);
  static Insertable<PaymentRecord> custom({
    Expression<String>? id,
    Expression<String>? subscriptionId,
    Expression<DateTime>? date,
    Expression<double>? originalAmount,
    Expression<String>? originalCurrency,
    Expression<double>? exchangeRate,
    Expression<double>? convertedAmount,
    Expression<String>? baseCurrency,
    Expression<double>? foreignFee,
    Expression<double>? actualChargedAmount,
    Expression<String>? paymentMethodId,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (date != null) 'date': date,
      if (originalAmount != null) 'original_amount': originalAmount,
      if (originalCurrency != null) 'original_currency': originalCurrency,
      if (exchangeRate != null) 'exchange_rate': exchangeRate,
      if (convertedAmount != null) 'converted_amount': convertedAmount,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (foreignFee != null) 'foreign_fee': foreignFee,
      if (actualChargedAmount != null)
        'actual_charged_amount': actualChargedAmount,
      if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? subscriptionId,
    Value<DateTime>? date,
    Value<double>? originalAmount,
    Value<String>? originalCurrency,
    Value<double>? exchangeRate,
    Value<double>? convertedAmount,
    Value<String>? baseCurrency,
    Value<double>? foreignFee,
    Value<double>? actualChargedAmount,
    Value<String?>? paymentMethodId,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return PaymentRecordsCompanion(
      id: id ?? this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      date: date ?? this.date,
      originalAmount: originalAmount ?? this.originalAmount,
      originalCurrency: originalCurrency ?? this.originalCurrency,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      foreignFee: foreignFee ?? this.foreignFee,
      actualChargedAmount: actualChargedAmount ?? this.actualChargedAmount,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<String>(subscriptionId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (originalAmount.present) {
      map['original_amount'] = Variable<double>(originalAmount.value);
    }
    if (originalCurrency.present) {
      map['original_currency'] = Variable<String>(originalCurrency.value);
    }
    if (exchangeRate.present) {
      map['exchange_rate'] = Variable<double>(exchangeRate.value);
    }
    if (convertedAmount.present) {
      map['converted_amount'] = Variable<double>(convertedAmount.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (foreignFee.present) {
      map['foreign_fee'] = Variable<double>(foreignFee.value);
    }
    if (actualChargedAmount.present) {
      map['actual_charged_amount'] = Variable<double>(
        actualChargedAmount.value,
      );
    }
    if (paymentMethodId.present) {
      map['payment_method_id'] = Variable<String>(paymentMethodId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentRecordsCompanion(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('date: $date, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('originalCurrency: $originalCurrency, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('convertedAmount: $convertedAmount, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('foreignFee: $foreignFee, ')
          ..write('actualChargedAmount: $actualChargedAmount, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PriceHistoryTable extends PriceHistory
    with TableInfo<$PriceHistoryTable, PriceHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<String> subscriptionId = GeneratedColumn<String>(
    'subscription_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oldPriceMeta = const VerificationMeta(
    'oldPrice',
  );
  @override
  late final GeneratedColumn<double> oldPrice = GeneratedColumn<double>(
    'old_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newPriceMeta = const VerificationMeta(
    'newPrice',
  );
  @override
  late final GeneratedColumn<double> newPrice = GeneratedColumn<double>(
    'new_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveDateMeta = const VerificationMeta(
    'effectiveDate',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveDate =
      GeneratedColumn<DateTime>(
        'effective_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subscriptionId,
    oldPrice,
    newPrice,
    currency,
    effectiveDate,
    reason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<PriceHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subscriptionIdMeta);
    }
    if (data.containsKey('old_price')) {
      context.handle(
        _oldPriceMeta,
        oldPrice.isAcceptableOrUnknown(data['old_price']!, _oldPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_oldPriceMeta);
    }
    if (data.containsKey('new_price')) {
      context.handle(
        _newPriceMeta,
        newPrice.isAcceptableOrUnknown(data['new_price']!, _newPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_newPriceMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('effective_date')) {
      context.handle(
        _effectiveDateMeta,
        effectiveDate.isAcceptableOrUnknown(
          data['effective_date']!,
          _effectiveDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveDateMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subscription_id'],
      )!,
      oldPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}old_price'],
      )!,
      newPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}new_price'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      effectiveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_date'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
    );
  }

  @override
  $PriceHistoryTable createAlias(String alias) {
    return $PriceHistoryTable(attachedDatabase, alias);
  }
}

class PriceHistoryData extends DataClass
    implements Insertable<PriceHistoryData> {
  final String id;
  final String subscriptionId;
  final double oldPrice;
  final double newPrice;
  final String currency;
  final DateTime effectiveDate;
  final String reason;
  const PriceHistoryData({
    required this.id,
    required this.subscriptionId,
    required this.oldPrice,
    required this.newPrice,
    required this.currency,
    required this.effectiveDate,
    required this.reason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subscription_id'] = Variable<String>(subscriptionId);
    map['old_price'] = Variable<double>(oldPrice);
    map['new_price'] = Variable<double>(newPrice);
    map['currency'] = Variable<String>(currency);
    map['effective_date'] = Variable<DateTime>(effectiveDate);
    map['reason'] = Variable<String>(reason);
    return map;
  }

  PriceHistoryCompanion toCompanion(bool nullToAbsent) {
    return PriceHistoryCompanion(
      id: Value(id),
      subscriptionId: Value(subscriptionId),
      oldPrice: Value(oldPrice),
      newPrice: Value(newPrice),
      currency: Value(currency),
      effectiveDate: Value(effectiveDate),
      reason: Value(reason),
    );
  }

  factory PriceHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceHistoryData(
      id: serializer.fromJson<String>(json['id']),
      subscriptionId: serializer.fromJson<String>(json['subscriptionId']),
      oldPrice: serializer.fromJson<double>(json['oldPrice']),
      newPrice: serializer.fromJson<double>(json['newPrice']),
      currency: serializer.fromJson<String>(json['currency']),
      effectiveDate: serializer.fromJson<DateTime>(json['effectiveDate']),
      reason: serializer.fromJson<String>(json['reason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subscriptionId': serializer.toJson<String>(subscriptionId),
      'oldPrice': serializer.toJson<double>(oldPrice),
      'newPrice': serializer.toJson<double>(newPrice),
      'currency': serializer.toJson<String>(currency),
      'effectiveDate': serializer.toJson<DateTime>(effectiveDate),
      'reason': serializer.toJson<String>(reason),
    };
  }

  PriceHistoryData copyWith({
    String? id,
    String? subscriptionId,
    double? oldPrice,
    double? newPrice,
    String? currency,
    DateTime? effectiveDate,
    String? reason,
  }) => PriceHistoryData(
    id: id ?? this.id,
    subscriptionId: subscriptionId ?? this.subscriptionId,
    oldPrice: oldPrice ?? this.oldPrice,
    newPrice: newPrice ?? this.newPrice,
    currency: currency ?? this.currency,
    effectiveDate: effectiveDate ?? this.effectiveDate,
    reason: reason ?? this.reason,
  );
  PriceHistoryData copyWithCompanion(PriceHistoryCompanion data) {
    return PriceHistoryData(
      id: data.id.present ? data.id.value : this.id,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
      oldPrice: data.oldPrice.present ? data.oldPrice.value : this.oldPrice,
      newPrice: data.newPrice.present ? data.newPrice.value : this.newPrice,
      currency: data.currency.present ? data.currency.value : this.currency,
      effectiveDate: data.effectiveDate.present
          ? data.effectiveDate.value
          : this.effectiveDate,
      reason: data.reason.present ? data.reason.value : this.reason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceHistoryData(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('oldPrice: $oldPrice, ')
          ..write('newPrice: $newPrice, ')
          ..write('currency: $currency, ')
          ..write('effectiveDate: $effectiveDate, ')
          ..write('reason: $reason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subscriptionId,
    oldPrice,
    newPrice,
    currency,
    effectiveDate,
    reason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceHistoryData &&
          other.id == this.id &&
          other.subscriptionId == this.subscriptionId &&
          other.oldPrice == this.oldPrice &&
          other.newPrice == this.newPrice &&
          other.currency == this.currency &&
          other.effectiveDate == this.effectiveDate &&
          other.reason == this.reason);
}

class PriceHistoryCompanion extends UpdateCompanion<PriceHistoryData> {
  final Value<String> id;
  final Value<String> subscriptionId;
  final Value<double> oldPrice;
  final Value<double> newPrice;
  final Value<String> currency;
  final Value<DateTime> effectiveDate;
  final Value<String> reason;
  final Value<int> rowid;
  const PriceHistoryCompanion({
    this.id = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.oldPrice = const Value.absent(),
    this.newPrice = const Value.absent(),
    this.currency = const Value.absent(),
    this.effectiveDate = const Value.absent(),
    this.reason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceHistoryCompanion.insert({
    required String id,
    required String subscriptionId,
    required double oldPrice,
    required double newPrice,
    required String currency,
    required DateTime effectiveDate,
    required String reason,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subscriptionId = Value(subscriptionId),
       oldPrice = Value(oldPrice),
       newPrice = Value(newPrice),
       currency = Value(currency),
       effectiveDate = Value(effectiveDate),
       reason = Value(reason);
  static Insertable<PriceHistoryData> custom({
    Expression<String>? id,
    Expression<String>? subscriptionId,
    Expression<double>? oldPrice,
    Expression<double>? newPrice,
    Expression<String>? currency,
    Expression<DateTime>? effectiveDate,
    Expression<String>? reason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (oldPrice != null) 'old_price': oldPrice,
      if (newPrice != null) 'new_price': newPrice,
      if (currency != null) 'currency': currency,
      if (effectiveDate != null) 'effective_date': effectiveDate,
      if (reason != null) 'reason': reason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceHistoryCompanion copyWith({
    Value<String>? id,
    Value<String>? subscriptionId,
    Value<double>? oldPrice,
    Value<double>? newPrice,
    Value<String>? currency,
    Value<DateTime>? effectiveDate,
    Value<String>? reason,
    Value<int>? rowid,
  }) {
    return PriceHistoryCompanion(
      id: id ?? this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      oldPrice: oldPrice ?? this.oldPrice,
      newPrice: newPrice ?? this.newPrice,
      currency: currency ?? this.currency,
      effectiveDate: effectiveDate ?? this.effectiveDate,
      reason: reason ?? this.reason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<String>(subscriptionId.value);
    }
    if (oldPrice.present) {
      map['old_price'] = Variable<double>(oldPrice.value);
    }
    if (newPrice.present) {
      map['new_price'] = Variable<double>(newPrice.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (effectiveDate.present) {
      map['effective_date'] = Variable<DateTime>(effectiveDate.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceHistoryCompanion(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('oldPrice: $oldPrice, ')
          ..write('newPrice: $newPrice, ')
          ..write('currency: $currency, ')
          ..write('effectiveDate: $effectiveDate, ')
          ..write('reason: $reason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionEventsTable extends SubscriptionEvents
    with TableInfo<$SubscriptionEventsTable, SubscriptionEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<String> subscriptionId = GeneratedColumn<String>(
    'subscription_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subscriptionId,
    type,
    at,
    title,
    detail,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscription_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubscriptionEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subscriptionIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubscriptionEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubscriptionEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subscription_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      ),
    );
  }

  @override
  $SubscriptionEventsTable createAlias(String alias) {
    return $SubscriptionEventsTable(attachedDatabase, alias);
  }
}

class SubscriptionEvent extends DataClass
    implements Insertable<SubscriptionEvent> {
  final String id;
  final String subscriptionId;
  final String type;
  final DateTime at;
  final String title;
  final String? detail;
  const SubscriptionEvent({
    required this.id,
    required this.subscriptionId,
    required this.type,
    required this.at,
    required this.title,
    this.detail,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subscription_id'] = Variable<String>(subscriptionId);
    map['type'] = Variable<String>(type);
    map['at'] = Variable<DateTime>(at);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    return map;
  }

  SubscriptionEventsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionEventsCompanion(
      id: Value(id),
      subscriptionId: Value(subscriptionId),
      type: Value(type),
      at: Value(at),
      title: Value(title),
      detail: detail == null && nullToAbsent
          ? const Value.absent()
          : Value(detail),
    );
  }

  factory SubscriptionEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubscriptionEvent(
      id: serializer.fromJson<String>(json['id']),
      subscriptionId: serializer.fromJson<String>(json['subscriptionId']),
      type: serializer.fromJson<String>(json['type']),
      at: serializer.fromJson<DateTime>(json['at']),
      title: serializer.fromJson<String>(json['title']),
      detail: serializer.fromJson<String?>(json['detail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subscriptionId': serializer.toJson<String>(subscriptionId),
      'type': serializer.toJson<String>(type),
      'at': serializer.toJson<DateTime>(at),
      'title': serializer.toJson<String>(title),
      'detail': serializer.toJson<String?>(detail),
    };
  }

  SubscriptionEvent copyWith({
    String? id,
    String? subscriptionId,
    String? type,
    DateTime? at,
    String? title,
    Value<String?> detail = const Value.absent(),
  }) => SubscriptionEvent(
    id: id ?? this.id,
    subscriptionId: subscriptionId ?? this.subscriptionId,
    type: type ?? this.type,
    at: at ?? this.at,
    title: title ?? this.title,
    detail: detail.present ? detail.value : this.detail,
  );
  SubscriptionEvent copyWithCompanion(SubscriptionEventsCompanion data) {
    return SubscriptionEvent(
      id: data.id.present ? data.id.value : this.id,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
      type: data.type.present ? data.type.value : this.type,
      at: data.at.present ? data.at.value : this.at,
      title: data.title.present ? data.title.value : this.title,
      detail: data.detail.present ? data.detail.value : this.detail,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionEvent(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('type: $type, ')
          ..write('at: $at, ')
          ..write('title: $title, ')
          ..write('detail: $detail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, subscriptionId, type, at, title, detail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubscriptionEvent &&
          other.id == this.id &&
          other.subscriptionId == this.subscriptionId &&
          other.type == this.type &&
          other.at == this.at &&
          other.title == this.title &&
          other.detail == this.detail);
}

class SubscriptionEventsCompanion extends UpdateCompanion<SubscriptionEvent> {
  final Value<String> id;
  final Value<String> subscriptionId;
  final Value<String> type;
  final Value<DateTime> at;
  final Value<String> title;
  final Value<String?> detail;
  final Value<int> rowid;
  const SubscriptionEventsCompanion({
    this.id = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.type = const Value.absent(),
    this.at = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubscriptionEventsCompanion.insert({
    required String id,
    required String subscriptionId,
    required String type,
    required DateTime at,
    required String title,
    this.detail = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subscriptionId = Value(subscriptionId),
       type = Value(type),
       at = Value(at),
       title = Value(title);
  static Insertable<SubscriptionEvent> custom({
    Expression<String>? id,
    Expression<String>? subscriptionId,
    Expression<String>? type,
    Expression<DateTime>? at,
    Expression<String>? title,
    Expression<String>? detail,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (type != null) 'type': type,
      if (at != null) 'at': at,
      if (title != null) 'title': title,
      if (detail != null) 'detail': detail,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubscriptionEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? subscriptionId,
    Value<String>? type,
    Value<DateTime>? at,
    Value<String>? title,
    Value<String?>? detail,
    Value<int>? rowid,
  }) {
    return SubscriptionEventsCompanion(
      id: id ?? this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      type: type ?? this.type,
      at: at ?? this.at,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<String>(subscriptionId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionEventsCompanion(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('type: $type, ')
          ..write('at: $at, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<String> subscriptionId = GeneratedColumn<String>(
    'subscription_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _offsetKindMeta = const VerificationMeta(
    'offsetKind',
  );
  @override
  late final GeneratedColumn<String> offsetKind = GeneratedColumn<String>(
    'offset_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customDaysMeta = const VerificationMeta(
    'customDays',
  );
  @override
  late final GeneratedColumn<int> customDays = GeneratedColumn<int>(
    'custom_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fireAtMeta = const VerificationMeta('fireAt');
  @override
  late final GeneratedColumn<DateTime> fireAt = GeneratedColumn<DateTime>(
    'fire_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
    'notification_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subscriptionId,
    kind,
    offsetKind,
    customDays,
    fireAt,
    enabled,
    notificationId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subscriptionIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('offset_kind')) {
      context.handle(
        _offsetKindMeta,
        offsetKind.isAcceptableOrUnknown(data['offset_kind']!, _offsetKindMeta),
      );
    } else if (isInserting) {
      context.missing(_offsetKindMeta);
    }
    if (data.containsKey('custom_days')) {
      context.handle(
        _customDaysMeta,
        customDays.isAcceptableOrUnknown(data['custom_days']!, _customDaysMeta),
      );
    }
    if (data.containsKey('fire_at')) {
      context.handle(
        _fireAtMeta,
        fireAt.isAcceptableOrUnknown(data['fire_at']!, _fireAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fireAtMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subscription_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      offsetKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}offset_kind'],
      )!,
      customDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}custom_days'],
      ),
      fireAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fire_at'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_id'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final String id;
  final String subscriptionId;
  final String kind;
  final String offsetKind;
  final int? customDays;
  final DateTime fireAt;
  final bool enabled;
  final int notificationId;
  const Reminder({
    required this.id,
    required this.subscriptionId,
    required this.kind,
    required this.offsetKind,
    this.customDays,
    required this.fireAt,
    required this.enabled,
    required this.notificationId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subscription_id'] = Variable<String>(subscriptionId);
    map['kind'] = Variable<String>(kind);
    map['offset_kind'] = Variable<String>(offsetKind);
    if (!nullToAbsent || customDays != null) {
      map['custom_days'] = Variable<int>(customDays);
    }
    map['fire_at'] = Variable<DateTime>(fireAt);
    map['enabled'] = Variable<bool>(enabled);
    map['notification_id'] = Variable<int>(notificationId);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      subscriptionId: Value(subscriptionId),
      kind: Value(kind),
      offsetKind: Value(offsetKind),
      customDays: customDays == null && nullToAbsent
          ? const Value.absent()
          : Value(customDays),
      fireAt: Value(fireAt),
      enabled: Value(enabled),
      notificationId: Value(notificationId),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      subscriptionId: serializer.fromJson<String>(json['subscriptionId']),
      kind: serializer.fromJson<String>(json['kind']),
      offsetKind: serializer.fromJson<String>(json['offsetKind']),
      customDays: serializer.fromJson<int?>(json['customDays']),
      fireAt: serializer.fromJson<DateTime>(json['fireAt']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subscriptionId': serializer.toJson<String>(subscriptionId),
      'kind': serializer.toJson<String>(kind),
      'offsetKind': serializer.toJson<String>(offsetKind),
      'customDays': serializer.toJson<int?>(customDays),
      'fireAt': serializer.toJson<DateTime>(fireAt),
      'enabled': serializer.toJson<bool>(enabled),
      'notificationId': serializer.toJson<int>(notificationId),
    };
  }

  Reminder copyWith({
    String? id,
    String? subscriptionId,
    String? kind,
    String? offsetKind,
    Value<int?> customDays = const Value.absent(),
    DateTime? fireAt,
    bool? enabled,
    int? notificationId,
  }) => Reminder(
    id: id ?? this.id,
    subscriptionId: subscriptionId ?? this.subscriptionId,
    kind: kind ?? this.kind,
    offsetKind: offsetKind ?? this.offsetKind,
    customDays: customDays.present ? customDays.value : this.customDays,
    fireAt: fireAt ?? this.fireAt,
    enabled: enabled ?? this.enabled,
    notificationId: notificationId ?? this.notificationId,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
      kind: data.kind.present ? data.kind.value : this.kind,
      offsetKind: data.offsetKind.present
          ? data.offsetKind.value
          : this.offsetKind,
      customDays: data.customDays.present
          ? data.customDays.value
          : this.customDays,
      fireAt: data.fireAt.present ? data.fireAt.value : this.fireAt,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('kind: $kind, ')
          ..write('offsetKind: $offsetKind, ')
          ..write('customDays: $customDays, ')
          ..write('fireAt: $fireAt, ')
          ..write('enabled: $enabled, ')
          ..write('notificationId: $notificationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subscriptionId,
    kind,
    offsetKind,
    customDays,
    fireAt,
    enabled,
    notificationId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.subscriptionId == this.subscriptionId &&
          other.kind == this.kind &&
          other.offsetKind == this.offsetKind &&
          other.customDays == this.customDays &&
          other.fireAt == this.fireAt &&
          other.enabled == this.enabled &&
          other.notificationId == this.notificationId);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<String> subscriptionId;
  final Value<String> kind;
  final Value<String> offsetKind;
  final Value<int?> customDays;
  final Value<DateTime> fireAt;
  final Value<bool> enabled;
  final Value<int> notificationId;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.kind = const Value.absent(),
    this.offsetKind = const Value.absent(),
    this.customDays = const Value.absent(),
    this.fireAt = const Value.absent(),
    this.enabled = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String subscriptionId,
    required String kind,
    required String offsetKind,
    this.customDays = const Value.absent(),
    required DateTime fireAt,
    this.enabled = const Value.absent(),
    required int notificationId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subscriptionId = Value(subscriptionId),
       kind = Value(kind),
       offsetKind = Value(offsetKind),
       fireAt = Value(fireAt),
       notificationId = Value(notificationId);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<String>? subscriptionId,
    Expression<String>? kind,
    Expression<String>? offsetKind,
    Expression<int>? customDays,
    Expression<DateTime>? fireAt,
    Expression<bool>? enabled,
    Expression<int>? notificationId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (kind != null) 'kind': kind,
      if (offsetKind != null) 'offset_kind': offsetKind,
      if (customDays != null) 'custom_days': customDays,
      if (fireAt != null) 'fire_at': fireAt,
      if (enabled != null) 'enabled': enabled,
      if (notificationId != null) 'notification_id': notificationId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<String>? subscriptionId,
    Value<String>? kind,
    Value<String>? offsetKind,
    Value<int?>? customDays,
    Value<DateTime>? fireAt,
    Value<bool>? enabled,
    Value<int>? notificationId,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      kind: kind ?? this.kind,
      offsetKind: offsetKind ?? this.offsetKind,
      customDays: customDays ?? this.customDays,
      fireAt: fireAt ?? this.fireAt,
      enabled: enabled ?? this.enabled,
      notificationId: notificationId ?? this.notificationId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<String>(subscriptionId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (offsetKind.present) {
      map['offset_kind'] = Variable<String>(offsetKind.value);
    }
    if (customDays.present) {
      map['custom_days'] = Variable<int>(customDays.value);
    }
    if (fireAt.present) {
      map['fire_at'] = Variable<DateTime>(fireAt.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('kind: $kind, ')
          ..write('offsetKind: $offsetKind, ')
          ..write('customDays: $customDays, ')
          ..write('fireAt: $fireAt, ')
          ..write('enabled: $enabled, ')
          ..write('notificationId: $notificationId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CurrencyRatesTable extends CurrencyRates
    with TableInfo<$CurrencyRatesTable, CurrencyRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrencyRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitsPerUsdMeta = const VerificationMeta(
    'unitsPerUsd',
  );
  @override
  late final GeneratedColumn<double> unitsPerUsd = GeneratedColumn<double>(
    'units_per_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isManualMeta = const VerificationMeta(
    'isManual',
  );
  @override
  late final GeneratedColumn<bool> isManual = GeneratedColumn<bool>(
    'is_manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_manual" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    code,
    unitsPerUsd,
    updatedAt,
    isManual,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currency_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<CurrencyRate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('units_per_usd')) {
      context.handle(
        _unitsPerUsdMeta,
        unitsPerUsd.isAcceptableOrUnknown(
          data['units_per_usd']!,
          _unitsPerUsdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitsPerUsdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_manual')) {
      context.handle(
        _isManualMeta,
        isManual.isAcceptableOrUnknown(data['is_manual']!, _isManualMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  CurrencyRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrencyRate(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      unitsPerUsd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}units_per_usd'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isManual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_manual'],
      )!,
    );
  }

  @override
  $CurrencyRatesTable createAlias(String alias) {
    return $CurrencyRatesTable(attachedDatabase, alias);
  }
}

class CurrencyRate extends DataClass implements Insertable<CurrencyRate> {
  final String code;
  final double unitsPerUsd;
  final DateTime updatedAt;
  final bool isManual;
  const CurrencyRate({
    required this.code,
    required this.unitsPerUsd,
    required this.updatedAt,
    required this.isManual,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['units_per_usd'] = Variable<double>(unitsPerUsd);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_manual'] = Variable<bool>(isManual);
    return map;
  }

  CurrencyRatesCompanion toCompanion(bool nullToAbsent) {
    return CurrencyRatesCompanion(
      code: Value(code),
      unitsPerUsd: Value(unitsPerUsd),
      updatedAt: Value(updatedAt),
      isManual: Value(isManual),
    );
  }

  factory CurrencyRate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrencyRate(
      code: serializer.fromJson<String>(json['code']),
      unitsPerUsd: serializer.fromJson<double>(json['unitsPerUsd']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isManual: serializer.fromJson<bool>(json['isManual']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'unitsPerUsd': serializer.toJson<double>(unitsPerUsd),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isManual': serializer.toJson<bool>(isManual),
    };
  }

  CurrencyRate copyWith({
    String? code,
    double? unitsPerUsd,
    DateTime? updatedAt,
    bool? isManual,
  }) => CurrencyRate(
    code: code ?? this.code,
    unitsPerUsd: unitsPerUsd ?? this.unitsPerUsd,
    updatedAt: updatedAt ?? this.updatedAt,
    isManual: isManual ?? this.isManual,
  );
  CurrencyRate copyWithCompanion(CurrencyRatesCompanion data) {
    return CurrencyRate(
      code: data.code.present ? data.code.value : this.code,
      unitsPerUsd: data.unitsPerUsd.present
          ? data.unitsPerUsd.value
          : this.unitsPerUsd,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isManual: data.isManual.present ? data.isManual.value : this.isManual,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyRate(')
          ..write('code: $code, ')
          ..write('unitsPerUsd: $unitsPerUsd, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isManual: $isManual')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, unitsPerUsd, updatedAt, isManual);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrencyRate &&
          other.code == this.code &&
          other.unitsPerUsd == this.unitsPerUsd &&
          other.updatedAt == this.updatedAt &&
          other.isManual == this.isManual);
}

class CurrencyRatesCompanion extends UpdateCompanion<CurrencyRate> {
  final Value<String> code;
  final Value<double> unitsPerUsd;
  final Value<DateTime> updatedAt;
  final Value<bool> isManual;
  final Value<int> rowid;
  const CurrencyRatesCompanion({
    this.code = const Value.absent(),
    this.unitsPerUsd = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isManual = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrencyRatesCompanion.insert({
    required String code,
    required double unitsPerUsd,
    required DateTime updatedAt,
    this.isManual = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       unitsPerUsd = Value(unitsPerUsd),
       updatedAt = Value(updatedAt);
  static Insertable<CurrencyRate> custom({
    Expression<String>? code,
    Expression<double>? unitsPerUsd,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isManual,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (unitsPerUsd != null) 'units_per_usd': unitsPerUsd,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isManual != null) 'is_manual': isManual,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrencyRatesCompanion copyWith({
    Value<String>? code,
    Value<double>? unitsPerUsd,
    Value<DateTime>? updatedAt,
    Value<bool>? isManual,
    Value<int>? rowid,
  }) {
    return CurrencyRatesCompanion(
      code: code ?? this.code,
      unitsPerUsd: unitsPerUsd ?? this.unitsPerUsd,
      updatedAt: updatedAt ?? this.updatedAt,
      isManual: isManual ?? this.isManual,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (unitsPerUsd.present) {
      map['units_per_usd'] = Variable<double>(unitsPerUsd.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isManual.present) {
      map['is_manual'] = Variable<bool>(isManual.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyRatesCompanion(')
          ..write('code: $code, ')
          ..write('unitsPerUsd: $unitsPerUsd, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isManual: $isManual, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTable extends Budgets with TableInfo<$BudgetsTable, Budget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monthlyAmountMeta = const VerificationMeta(
    'monthlyAmount',
  );
  @override
  late final GeneratedColumn<double> monthlyAmount = GeneratedColumn<double>(
    'monthly_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scope,
    categoryId,
    profileId,
    monthlyAmount,
    currency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Budget> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('monthly_amount')) {
      context.handle(
        _monthlyAmountMeta,
        monthlyAmount.isAcceptableOrUnknown(
          data['monthly_amount']!,
          _monthlyAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monthlyAmountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Budget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Budget(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      ),
      monthlyAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
    );
  }

  @override
  $BudgetsTable createAlias(String alias) {
    return $BudgetsTable(attachedDatabase, alias);
  }
}

class Budget extends DataClass implements Insertable<Budget> {
  final String id;
  final String scope;
  final String? categoryId;
  final String? profileId;
  final double monthlyAmount;
  final String currency;
  const Budget({
    required this.id,
    required this.scope,
    this.categoryId,
    this.profileId,
    required this.monthlyAmount,
    required this.currency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['scope'] = Variable<String>(scope);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || profileId != null) {
      map['profile_id'] = Variable<String>(profileId);
    }
    map['monthly_amount'] = Variable<double>(monthlyAmount);
    map['currency'] = Variable<String>(currency);
    return map;
  }

  BudgetsCompanion toCompanion(bool nullToAbsent) {
    return BudgetsCompanion(
      id: Value(id),
      scope: Value(scope),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      profileId: profileId == null && nullToAbsent
          ? const Value.absent()
          : Value(profileId),
      monthlyAmount: Value(monthlyAmount),
      currency: Value(currency),
    );
  }

  factory Budget.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Budget(
      id: serializer.fromJson<String>(json['id']),
      scope: serializer.fromJson<String>(json['scope']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      profileId: serializer.fromJson<String?>(json['profileId']),
      monthlyAmount: serializer.fromJson<double>(json['monthlyAmount']),
      currency: serializer.fromJson<String>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'scope': serializer.toJson<String>(scope),
      'categoryId': serializer.toJson<String?>(categoryId),
      'profileId': serializer.toJson<String?>(profileId),
      'monthlyAmount': serializer.toJson<double>(monthlyAmount),
      'currency': serializer.toJson<String>(currency),
    };
  }

  Budget copyWith({
    String? id,
    String? scope,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> profileId = const Value.absent(),
    double? monthlyAmount,
    String? currency,
  }) => Budget(
    id: id ?? this.id,
    scope: scope ?? this.scope,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    profileId: profileId.present ? profileId.value : this.profileId,
    monthlyAmount: monthlyAmount ?? this.monthlyAmount,
    currency: currency ?? this.currency,
  );
  Budget copyWithCompanion(BudgetsCompanion data) {
    return Budget(
      id: data.id.present ? data.id.value : this.id,
      scope: data.scope.present ? data.scope.value : this.scope,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      monthlyAmount: data.monthlyAmount.present
          ? data.monthlyAmount.value
          : this.monthlyAmount,
      currency: data.currency.present ? data.currency.value : this.currency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Budget(')
          ..write('id: $id, ')
          ..write('scope: $scope, ')
          ..write('categoryId: $categoryId, ')
          ..write('profileId: $profileId, ')
          ..write('monthlyAmount: $monthlyAmount, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, scope, categoryId, profileId, monthlyAmount, currency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Budget &&
          other.id == this.id &&
          other.scope == this.scope &&
          other.categoryId == this.categoryId &&
          other.profileId == this.profileId &&
          other.monthlyAmount == this.monthlyAmount &&
          other.currency == this.currency);
}

class BudgetsCompanion extends UpdateCompanion<Budget> {
  final Value<String> id;
  final Value<String> scope;
  final Value<String?> categoryId;
  final Value<String?> profileId;
  final Value<double> monthlyAmount;
  final Value<String> currency;
  final Value<int> rowid;
  const BudgetsCompanion({
    this.id = const Value.absent(),
    this.scope = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.profileId = const Value.absent(),
    this.monthlyAmount = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetsCompanion.insert({
    required String id,
    required String scope,
    this.categoryId = const Value.absent(),
    this.profileId = const Value.absent(),
    required double monthlyAmount,
    required String currency,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       scope = Value(scope),
       monthlyAmount = Value(monthlyAmount),
       currency = Value(currency);
  static Insertable<Budget> custom({
    Expression<String>? id,
    Expression<String>? scope,
    Expression<String>? categoryId,
    Expression<String>? profileId,
    Expression<double>? monthlyAmount,
    Expression<String>? currency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scope != null) 'scope': scope,
      if (categoryId != null) 'category_id': categoryId,
      if (profileId != null) 'profile_id': profileId,
      if (monthlyAmount != null) 'monthly_amount': monthlyAmount,
      if (currency != null) 'currency': currency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetsCompanion copyWith({
    Value<String>? id,
    Value<String>? scope,
    Value<String?>? categoryId,
    Value<String?>? profileId,
    Value<double>? monthlyAmount,
    Value<String>? currency,
    Value<int>? rowid,
  }) {
    return BudgetsCompanion(
      id: id ?? this.id,
      scope: scope ?? this.scope,
      categoryId: categoryId ?? this.categoryId,
      profileId: profileId ?? this.profileId,
      monthlyAmount: monthlyAmount ?? this.monthlyAmount,
      currency: currency ?? this.currency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (monthlyAmount.present) {
      map['monthly_amount'] = Variable<double>(monthlyAmount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsCompanion(')
          ..write('id: $id, ')
          ..write('scope: $scope, ')
          ..write('categoryId: $categoryId, ')
          ..write('profileId: $profileId, ')
          ..write('monthlyAmount: $monthlyAmount, ')
          ..write('currency: $currency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foreignFeePercentMeta = const VerificationMeta(
    'foreignFeePercent',
  );
  @override
  late final GeneratedColumn<double> foreignFeePercent =
      GeneratedColumn<double>(
        'foreign_fee_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _themePresetMeta = const VerificationMeta(
    'themePreset',
  );
  @override
  late final GeneratedColumn<String> themePreset = GeneratedColumn<String>(
    'theme_preset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customThemeJsonMeta = const VerificationMeta(
    'customThemeJson',
  );
  @override
  late final GeneratedColumn<String> customThemeJson = GeneratedColumn<String>(
    'custom_theme_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reduceMotionMeta = const VerificationMeta(
    'reduceMotion',
  );
  @override
  late final GeneratedColumn<bool> reduceMotion = GeneratedColumn<bool>(
    'reduce_motion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reduce_motion" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _biometricLockMeta = const VerificationMeta(
    'biometricLock',
  );
  @override
  late final GeneratedColumn<bool> biometricLock = GeneratedColumn<bool>(
    'biometric_lock',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("biometric_lock" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hideAmountsMeta = const VerificationMeta(
    'hideAmounts',
  );
  @override
  late final GeneratedColumn<bool> hideAmounts = GeneratedColumn<bool>(
    'hide_amounts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hide_amounts" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _cancelSafetyBufferDaysMeta =
      const VerificationMeta('cancelSafetyBufferDays');
  @override
  late final GeneratedColumn<int> cancelSafetyBufferDays = GeneratedColumn<int>(
    'cancel_safety_buffer_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _demoSeedEnabledMeta = const VerificationMeta(
    'demoSeedEnabled',
  );
  @override
  late final GeneratedColumn<bool> demoSeedEnabled = GeneratedColumn<bool>(
    'demo_seed_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("demo_seed_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _activeProfileIdMeta = const VerificationMeta(
    'activeProfileId',
  );
  @override
  late final GeneratedColumn<String> activeProfileId = GeneratedColumn<String>(
    'active_profile_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratesUpdatedAtMeta = const VerificationMeta(
    'ratesUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> ratesUpdatedAt =
      GeneratedColumn<DateTime>(
        'rates_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastFxErrorMeta = const VerificationMeta(
    'lastFxError',
  );
  @override
  late final GeneratedColumn<String> lastFxError = GeneratedColumn<String>(
    'last_fx_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localeCodeMeta = const VerificationMeta(
    'localeCode',
  );
  @override
  late final GeneratedColumn<String> localeCode = GeneratedColumn<String>(
    'locale_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    baseCurrency,
    foreignFeePercent,
    themePreset,
    customThemeJson,
    reduceMotion,
    biometricLock,
    hideAmounts,
    cancelSafetyBufferDays,
    onboardingComplete,
    demoSeedEnabled,
    activeProfileId,
    ratesUpdatedAt,
    lastFxError,
    localeCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseCurrencyMeta);
    }
    if (data.containsKey('foreign_fee_percent')) {
      context.handle(
        _foreignFeePercentMeta,
        foreignFeePercent.isAcceptableOrUnknown(
          data['foreign_fee_percent']!,
          _foreignFeePercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_foreignFeePercentMeta);
    }
    if (data.containsKey('theme_preset')) {
      context.handle(
        _themePresetMeta,
        themePreset.isAcceptableOrUnknown(
          data['theme_preset']!,
          _themePresetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_themePresetMeta);
    }
    if (data.containsKey('custom_theme_json')) {
      context.handle(
        _customThemeJsonMeta,
        customThemeJson.isAcceptableOrUnknown(
          data['custom_theme_json']!,
          _customThemeJsonMeta,
        ),
      );
    }
    if (data.containsKey('reduce_motion')) {
      context.handle(
        _reduceMotionMeta,
        reduceMotion.isAcceptableOrUnknown(
          data['reduce_motion']!,
          _reduceMotionMeta,
        ),
      );
    }
    if (data.containsKey('biometric_lock')) {
      context.handle(
        _biometricLockMeta,
        biometricLock.isAcceptableOrUnknown(
          data['biometric_lock']!,
          _biometricLockMeta,
        ),
      );
    }
    if (data.containsKey('hide_amounts')) {
      context.handle(
        _hideAmountsMeta,
        hideAmounts.isAcceptableOrUnknown(
          data['hide_amounts']!,
          _hideAmountsMeta,
        ),
      );
    }
    if (data.containsKey('cancel_safety_buffer_days')) {
      context.handle(
        _cancelSafetyBufferDaysMeta,
        cancelSafetyBufferDays.isAcceptableOrUnknown(
          data['cancel_safety_buffer_days']!,
          _cancelSafetyBufferDaysMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('demo_seed_enabled')) {
      context.handle(
        _demoSeedEnabledMeta,
        demoSeedEnabled.isAcceptableOrUnknown(
          data['demo_seed_enabled']!,
          _demoSeedEnabledMeta,
        ),
      );
    }
    if (data.containsKey('active_profile_id')) {
      context.handle(
        _activeProfileIdMeta,
        activeProfileId.isAcceptableOrUnknown(
          data['active_profile_id']!,
          _activeProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('rates_updated_at')) {
      context.handle(
        _ratesUpdatedAtMeta,
        ratesUpdatedAt.isAcceptableOrUnknown(
          data['rates_updated_at']!,
          _ratesUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_fx_error')) {
      context.handle(
        _lastFxErrorMeta,
        lastFxError.isAcceptableOrUnknown(
          data['last_fx_error']!,
          _lastFxErrorMeta,
        ),
      );
    }
    if (data.containsKey('locale_code')) {
      context.handle(
        _localeCodeMeta,
        localeCode.isAcceptableOrUnknown(data['locale_code']!, _localeCodeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
      foreignFeePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}foreign_fee_percent'],
      )!,
      themePreset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_preset'],
      )!,
      customThemeJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_theme_json'],
      ),
      reduceMotion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reduce_motion'],
      )!,
      biometricLock: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}biometric_lock'],
      )!,
      hideAmounts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hide_amounts'],
      )!,
      cancelSafetyBufferDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cancel_safety_buffer_days'],
      )!,
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
      demoSeedEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}demo_seed_enabled'],
      )!,
      activeProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_profile_id'],
      ),
      ratesUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}rates_updated_at'],
      ),
      lastFxError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_fx_error'],
      ),
      localeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale_code'],
      )!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreference extends DataClass implements Insertable<UserPreference> {
  final String id;
  final String baseCurrency;
  final double foreignFeePercent;
  final String themePreset;
  final String? customThemeJson;
  final bool reduceMotion;
  final bool biometricLock;
  final bool hideAmounts;
  final int cancelSafetyBufferDays;
  final bool onboardingComplete;
  final bool demoSeedEnabled;
  final String? activeProfileId;
  final DateTime? ratesUpdatedAt;
  final String? lastFxError;

  /// system | en | zh_TW | ja
  final String localeCode;
  const UserPreference({
    required this.id,
    required this.baseCurrency,
    required this.foreignFeePercent,
    required this.themePreset,
    this.customThemeJson,
    required this.reduceMotion,
    required this.biometricLock,
    required this.hideAmounts,
    required this.cancelSafetyBufferDays,
    required this.onboardingComplete,
    required this.demoSeedEnabled,
    this.activeProfileId,
    this.ratesUpdatedAt,
    this.lastFxError,
    required this.localeCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['base_currency'] = Variable<String>(baseCurrency);
    map['foreign_fee_percent'] = Variable<double>(foreignFeePercent);
    map['theme_preset'] = Variable<String>(themePreset);
    if (!nullToAbsent || customThemeJson != null) {
      map['custom_theme_json'] = Variable<String>(customThemeJson);
    }
    map['reduce_motion'] = Variable<bool>(reduceMotion);
    map['biometric_lock'] = Variable<bool>(biometricLock);
    map['hide_amounts'] = Variable<bool>(hideAmounts);
    map['cancel_safety_buffer_days'] = Variable<int>(cancelSafetyBufferDays);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['demo_seed_enabled'] = Variable<bool>(demoSeedEnabled);
    if (!nullToAbsent || activeProfileId != null) {
      map['active_profile_id'] = Variable<String>(activeProfileId);
    }
    if (!nullToAbsent || ratesUpdatedAt != null) {
      map['rates_updated_at'] = Variable<DateTime>(ratesUpdatedAt);
    }
    if (!nullToAbsent || lastFxError != null) {
      map['last_fx_error'] = Variable<String>(lastFxError);
    }
    map['locale_code'] = Variable<String>(localeCode);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      id: Value(id),
      baseCurrency: Value(baseCurrency),
      foreignFeePercent: Value(foreignFeePercent),
      themePreset: Value(themePreset),
      customThemeJson: customThemeJson == null && nullToAbsent
          ? const Value.absent()
          : Value(customThemeJson),
      reduceMotion: Value(reduceMotion),
      biometricLock: Value(biometricLock),
      hideAmounts: Value(hideAmounts),
      cancelSafetyBufferDays: Value(cancelSafetyBufferDays),
      onboardingComplete: Value(onboardingComplete),
      demoSeedEnabled: Value(demoSeedEnabled),
      activeProfileId: activeProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(activeProfileId),
      ratesUpdatedAt: ratesUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(ratesUpdatedAt),
      lastFxError: lastFxError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFxError),
      localeCode: Value(localeCode),
    );
  }

  factory UserPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreference(
      id: serializer.fromJson<String>(json['id']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      foreignFeePercent: serializer.fromJson<double>(json['foreignFeePercent']),
      themePreset: serializer.fromJson<String>(json['themePreset']),
      customThemeJson: serializer.fromJson<String?>(json['customThemeJson']),
      reduceMotion: serializer.fromJson<bool>(json['reduceMotion']),
      biometricLock: serializer.fromJson<bool>(json['biometricLock']),
      hideAmounts: serializer.fromJson<bool>(json['hideAmounts']),
      cancelSafetyBufferDays: serializer.fromJson<int>(
        json['cancelSafetyBufferDays'],
      ),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      demoSeedEnabled: serializer.fromJson<bool>(json['demoSeedEnabled']),
      activeProfileId: serializer.fromJson<String?>(json['activeProfileId']),
      ratesUpdatedAt: serializer.fromJson<DateTime?>(json['ratesUpdatedAt']),
      lastFxError: serializer.fromJson<String?>(json['lastFxError']),
      localeCode: serializer.fromJson<String>(json['localeCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'foreignFeePercent': serializer.toJson<double>(foreignFeePercent),
      'themePreset': serializer.toJson<String>(themePreset),
      'customThemeJson': serializer.toJson<String?>(customThemeJson),
      'reduceMotion': serializer.toJson<bool>(reduceMotion),
      'biometricLock': serializer.toJson<bool>(biometricLock),
      'hideAmounts': serializer.toJson<bool>(hideAmounts),
      'cancelSafetyBufferDays': serializer.toJson<int>(cancelSafetyBufferDays),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'demoSeedEnabled': serializer.toJson<bool>(demoSeedEnabled),
      'activeProfileId': serializer.toJson<String?>(activeProfileId),
      'ratesUpdatedAt': serializer.toJson<DateTime?>(ratesUpdatedAt),
      'lastFxError': serializer.toJson<String?>(lastFxError),
      'localeCode': serializer.toJson<String>(localeCode),
    };
  }

  UserPreference copyWith({
    String? id,
    String? baseCurrency,
    double? foreignFeePercent,
    String? themePreset,
    Value<String?> customThemeJson = const Value.absent(),
    bool? reduceMotion,
    bool? biometricLock,
    bool? hideAmounts,
    int? cancelSafetyBufferDays,
    bool? onboardingComplete,
    bool? demoSeedEnabled,
    Value<String?> activeProfileId = const Value.absent(),
    Value<DateTime?> ratesUpdatedAt = const Value.absent(),
    Value<String?> lastFxError = const Value.absent(),
    String? localeCode,
  }) => UserPreference(
    id: id ?? this.id,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    foreignFeePercent: foreignFeePercent ?? this.foreignFeePercent,
    themePreset: themePreset ?? this.themePreset,
    customThemeJson: customThemeJson.present
        ? customThemeJson.value
        : this.customThemeJson,
    reduceMotion: reduceMotion ?? this.reduceMotion,
    biometricLock: biometricLock ?? this.biometricLock,
    hideAmounts: hideAmounts ?? this.hideAmounts,
    cancelSafetyBufferDays:
        cancelSafetyBufferDays ?? this.cancelSafetyBufferDays,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    demoSeedEnabled: demoSeedEnabled ?? this.demoSeedEnabled,
    activeProfileId: activeProfileId.present
        ? activeProfileId.value
        : this.activeProfileId,
    ratesUpdatedAt: ratesUpdatedAt.present
        ? ratesUpdatedAt.value
        : this.ratesUpdatedAt,
    lastFxError: lastFxError.present ? lastFxError.value : this.lastFxError,
    localeCode: localeCode ?? this.localeCode,
  );
  UserPreference copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreference(
      id: data.id.present ? data.id.value : this.id,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      foreignFeePercent: data.foreignFeePercent.present
          ? data.foreignFeePercent.value
          : this.foreignFeePercent,
      themePreset: data.themePreset.present
          ? data.themePreset.value
          : this.themePreset,
      customThemeJson: data.customThemeJson.present
          ? data.customThemeJson.value
          : this.customThemeJson,
      reduceMotion: data.reduceMotion.present
          ? data.reduceMotion.value
          : this.reduceMotion,
      biometricLock: data.biometricLock.present
          ? data.biometricLock.value
          : this.biometricLock,
      hideAmounts: data.hideAmounts.present
          ? data.hideAmounts.value
          : this.hideAmounts,
      cancelSafetyBufferDays: data.cancelSafetyBufferDays.present
          ? data.cancelSafetyBufferDays.value
          : this.cancelSafetyBufferDays,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      demoSeedEnabled: data.demoSeedEnabled.present
          ? data.demoSeedEnabled.value
          : this.demoSeedEnabled,
      activeProfileId: data.activeProfileId.present
          ? data.activeProfileId.value
          : this.activeProfileId,
      ratesUpdatedAt: data.ratesUpdatedAt.present
          ? data.ratesUpdatedAt.value
          : this.ratesUpdatedAt,
      lastFxError: data.lastFxError.present
          ? data.lastFxError.value
          : this.lastFxError,
      localeCode: data.localeCode.present
          ? data.localeCode.value
          : this.localeCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreference(')
          ..write('id: $id, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('foreignFeePercent: $foreignFeePercent, ')
          ..write('themePreset: $themePreset, ')
          ..write('customThemeJson: $customThemeJson, ')
          ..write('reduceMotion: $reduceMotion, ')
          ..write('biometricLock: $biometricLock, ')
          ..write('hideAmounts: $hideAmounts, ')
          ..write('cancelSafetyBufferDays: $cancelSafetyBufferDays, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('demoSeedEnabled: $demoSeedEnabled, ')
          ..write('activeProfileId: $activeProfileId, ')
          ..write('ratesUpdatedAt: $ratesUpdatedAt, ')
          ..write('lastFxError: $lastFxError, ')
          ..write('localeCode: $localeCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    baseCurrency,
    foreignFeePercent,
    themePreset,
    customThemeJson,
    reduceMotion,
    biometricLock,
    hideAmounts,
    cancelSafetyBufferDays,
    onboardingComplete,
    demoSeedEnabled,
    activeProfileId,
    ratesUpdatedAt,
    lastFxError,
    localeCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreference &&
          other.id == this.id &&
          other.baseCurrency == this.baseCurrency &&
          other.foreignFeePercent == this.foreignFeePercent &&
          other.themePreset == this.themePreset &&
          other.customThemeJson == this.customThemeJson &&
          other.reduceMotion == this.reduceMotion &&
          other.biometricLock == this.biometricLock &&
          other.hideAmounts == this.hideAmounts &&
          other.cancelSafetyBufferDays == this.cancelSafetyBufferDays &&
          other.onboardingComplete == this.onboardingComplete &&
          other.demoSeedEnabled == this.demoSeedEnabled &&
          other.activeProfileId == this.activeProfileId &&
          other.ratesUpdatedAt == this.ratesUpdatedAt &&
          other.lastFxError == this.lastFxError &&
          other.localeCode == this.localeCode);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreference> {
  final Value<String> id;
  final Value<String> baseCurrency;
  final Value<double> foreignFeePercent;
  final Value<String> themePreset;
  final Value<String?> customThemeJson;
  final Value<bool> reduceMotion;
  final Value<bool> biometricLock;
  final Value<bool> hideAmounts;
  final Value<int> cancelSafetyBufferDays;
  final Value<bool> onboardingComplete;
  final Value<bool> demoSeedEnabled;
  final Value<String?> activeProfileId;
  final Value<DateTime?> ratesUpdatedAt;
  final Value<String?> lastFxError;
  final Value<String> localeCode;
  final Value<int> rowid;
  const UserPreferencesCompanion({
    this.id = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.foreignFeePercent = const Value.absent(),
    this.themePreset = const Value.absent(),
    this.customThemeJson = const Value.absent(),
    this.reduceMotion = const Value.absent(),
    this.biometricLock = const Value.absent(),
    this.hideAmounts = const Value.absent(),
    this.cancelSafetyBufferDays = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.demoSeedEnabled = const Value.absent(),
    this.activeProfileId = const Value.absent(),
    this.ratesUpdatedAt = const Value.absent(),
    this.lastFxError = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    required String id,
    required String baseCurrency,
    required double foreignFeePercent,
    required String themePreset,
    this.customThemeJson = const Value.absent(),
    this.reduceMotion = const Value.absent(),
    this.biometricLock = const Value.absent(),
    this.hideAmounts = const Value.absent(),
    this.cancelSafetyBufferDays = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.demoSeedEnabled = const Value.absent(),
    this.activeProfileId = const Value.absent(),
    this.ratesUpdatedAt = const Value.absent(),
    this.lastFxError = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       baseCurrency = Value(baseCurrency),
       foreignFeePercent = Value(foreignFeePercent),
       themePreset = Value(themePreset);
  static Insertable<UserPreference> custom({
    Expression<String>? id,
    Expression<String>? baseCurrency,
    Expression<double>? foreignFeePercent,
    Expression<String>? themePreset,
    Expression<String>? customThemeJson,
    Expression<bool>? reduceMotion,
    Expression<bool>? biometricLock,
    Expression<bool>? hideAmounts,
    Expression<int>? cancelSafetyBufferDays,
    Expression<bool>? onboardingComplete,
    Expression<bool>? demoSeedEnabled,
    Expression<String>? activeProfileId,
    Expression<DateTime>? ratesUpdatedAt,
    Expression<String>? lastFxError,
    Expression<String>? localeCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (foreignFeePercent != null) 'foreign_fee_percent': foreignFeePercent,
      if (themePreset != null) 'theme_preset': themePreset,
      if (customThemeJson != null) 'custom_theme_json': customThemeJson,
      if (reduceMotion != null) 'reduce_motion': reduceMotion,
      if (biometricLock != null) 'biometric_lock': biometricLock,
      if (hideAmounts != null) 'hide_amounts': hideAmounts,
      if (cancelSafetyBufferDays != null)
        'cancel_safety_buffer_days': cancelSafetyBufferDays,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (demoSeedEnabled != null) 'demo_seed_enabled': demoSeedEnabled,
      if (activeProfileId != null) 'active_profile_id': activeProfileId,
      if (ratesUpdatedAt != null) 'rates_updated_at': ratesUpdatedAt,
      if (lastFxError != null) 'last_fx_error': lastFxError,
      if (localeCode != null) 'locale_code': localeCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<String>? id,
    Value<String>? baseCurrency,
    Value<double>? foreignFeePercent,
    Value<String>? themePreset,
    Value<String?>? customThemeJson,
    Value<bool>? reduceMotion,
    Value<bool>? biometricLock,
    Value<bool>? hideAmounts,
    Value<int>? cancelSafetyBufferDays,
    Value<bool>? onboardingComplete,
    Value<bool>? demoSeedEnabled,
    Value<String?>? activeProfileId,
    Value<DateTime?>? ratesUpdatedAt,
    Value<String?>? lastFxError,
    Value<String>? localeCode,
    Value<int>? rowid,
  }) {
    return UserPreferencesCompanion(
      id: id ?? this.id,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      foreignFeePercent: foreignFeePercent ?? this.foreignFeePercent,
      themePreset: themePreset ?? this.themePreset,
      customThemeJson: customThemeJson ?? this.customThemeJson,
      reduceMotion: reduceMotion ?? this.reduceMotion,
      biometricLock: biometricLock ?? this.biometricLock,
      hideAmounts: hideAmounts ?? this.hideAmounts,
      cancelSafetyBufferDays:
          cancelSafetyBufferDays ?? this.cancelSafetyBufferDays,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      demoSeedEnabled: demoSeedEnabled ?? this.demoSeedEnabled,
      activeProfileId: activeProfileId ?? this.activeProfileId,
      ratesUpdatedAt: ratesUpdatedAt ?? this.ratesUpdatedAt,
      lastFxError: lastFxError ?? this.lastFxError,
      localeCode: localeCode ?? this.localeCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (foreignFeePercent.present) {
      map['foreign_fee_percent'] = Variable<double>(foreignFeePercent.value);
    }
    if (themePreset.present) {
      map['theme_preset'] = Variable<String>(themePreset.value);
    }
    if (customThemeJson.present) {
      map['custom_theme_json'] = Variable<String>(customThemeJson.value);
    }
    if (reduceMotion.present) {
      map['reduce_motion'] = Variable<bool>(reduceMotion.value);
    }
    if (biometricLock.present) {
      map['biometric_lock'] = Variable<bool>(biometricLock.value);
    }
    if (hideAmounts.present) {
      map['hide_amounts'] = Variable<bool>(hideAmounts.value);
    }
    if (cancelSafetyBufferDays.present) {
      map['cancel_safety_buffer_days'] = Variable<int>(
        cancelSafetyBufferDays.value,
      );
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (demoSeedEnabled.present) {
      map['demo_seed_enabled'] = Variable<bool>(demoSeedEnabled.value);
    }
    if (activeProfileId.present) {
      map['active_profile_id'] = Variable<String>(activeProfileId.value);
    }
    if (ratesUpdatedAt.present) {
      map['rates_updated_at'] = Variable<DateTime>(ratesUpdatedAt.value);
    }
    if (lastFxError.present) {
      map['last_fx_error'] = Variable<String>(lastFxError.value);
    }
    if (localeCode.present) {
      map['locale_code'] = Variable<String>(localeCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('foreignFeePercent: $foreignFeePercent, ')
          ..write('themePreset: $themePreset, ')
          ..write('customThemeJson: $customThemeJson, ')
          ..write('reduceMotion: $reduceMotion, ')
          ..write('biometricLock: $biometricLock, ')
          ..write('hideAmounts: $hideAmounts, ')
          ..write('cancelSafetyBufferDays: $cancelSafetyBufferDays, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('demoSeedEnabled: $demoSeedEnabled, ')
          ..write('activeProfileId: $activeProfileId, ')
          ..write('ratesUpdatedAt: $ratesUpdatedAt, ')
          ..write('lastFxError: $lastFxError, ')
          ..write('localeCode: $localeCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppThemeRowsTable extends AppThemeRows
    with TableInfo<$AppThemeRowsTable, AppThemeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppThemeRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, json];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_theme_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppThemeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('json')) {
      context.handle(
        _jsonMeta,
        json.isAcceptableOrUnknown(data['json']!, _jsonMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppThemeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppThemeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      json: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json'],
      )!,
    );
  }

  @override
  $AppThemeRowsTable createAlias(String alias) {
    return $AppThemeRowsTable(attachedDatabase, alias);
  }
}

class AppThemeRow extends DataClass implements Insertable<AppThemeRow> {
  final String id;
  final String name;
  final String json;
  const AppThemeRow({required this.id, required this.name, required this.json});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['json'] = Variable<String>(json);
    return map;
  }

  AppThemeRowsCompanion toCompanion(bool nullToAbsent) {
    return AppThemeRowsCompanion(
      id: Value(id),
      name: Value(name),
      json: Value(json),
    );
  }

  factory AppThemeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppThemeRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      json: serializer.fromJson<String>(json['json']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'json': serializer.toJson<String>(json),
    };
  }

  AppThemeRow copyWith({String? id, String? name, String? json}) => AppThemeRow(
    id: id ?? this.id,
    name: name ?? this.name,
    json: json ?? this.json,
  );
  AppThemeRow copyWithCompanion(AppThemeRowsCompanion data) {
    return AppThemeRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      json: data.json.present ? data.json.value : this.json,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppThemeRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('json: $json')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, json);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppThemeRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.json == this.json);
}

class AppThemeRowsCompanion extends UpdateCompanion<AppThemeRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> json;
  final Value<int> rowid;
  const AppThemeRowsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.json = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppThemeRowsCompanion.insert({
    required String id,
    required String name,
    required String json,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       json = Value(json);
  static Insertable<AppThemeRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? json,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (json != null) 'json': json,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppThemeRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? json,
    Value<int>? rowid,
  }) {
    return AppThemeRowsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      json: json ?? this.json,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppThemeRowsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('json: $json, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrdersTable extends PurchaseOrders
    with TableInfo<$PurchaseOrdersTable, PurchaseOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderedAtMeta = const VerificationMeta(
    'orderedAt',
  );
  @override
  late final GeneratedColumn<DateTime> orderedAt = GeneratedColumn<DateTime>(
    'ordered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedAtMeta = const VerificationMeta(
    'expectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> expectedAt = GeneratedColumn<DateTime>(
    'expected_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deliveredAtMeta = const VerificationMeta(
    'deliveredAt',
  );
  @override
  late final GeneratedColumn<DateTime> deliveredAt = GeneratedColumn<DateTime>(
    'delivered_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderAtMeta = const VerificationMeta(
    'reminderAt',
  );
  @override
  late final GeneratedColumn<DateTime> reminderAt = GeneratedColumn<DateTime>(
    'reminder_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackingUrlMeta = const VerificationMeta(
    'trackingUrl',
  );
  @override
  late final GeneratedColumn<String> trackingUrl = GeneratedColumn<String>(
    'tracking_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    platform,
    title,
    quantity,
    status,
    orderedAt,
    expectedAt,
    deliveredAt,
    reminderAt,
    price,
    currency,
    trackingUrl,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('ordered_at')) {
      context.handle(
        _orderedAtMeta,
        orderedAt.isAcceptableOrUnknown(data['ordered_at']!, _orderedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_orderedAtMeta);
    }
    if (data.containsKey('expected_at')) {
      context.handle(
        _expectedAtMeta,
        expectedAt.isAcceptableOrUnknown(data['expected_at']!, _expectedAtMeta),
      );
    }
    if (data.containsKey('delivered_at')) {
      context.handle(
        _deliveredAtMeta,
        deliveredAt.isAcceptableOrUnknown(
          data['delivered_at']!,
          _deliveredAtMeta,
        ),
      );
    }
    if (data.containsKey('reminder_at')) {
      context.handle(
        _reminderAtMeta,
        reminderAt.isAcceptableOrUnknown(data['reminder_at']!, _reminderAtMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('tracking_url')) {
      context.handle(
        _trackingUrlMeta,
        trackingUrl.isAcceptableOrUnknown(
          data['tracking_url']!,
          _trackingUrlMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      orderedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ordered_at'],
      )!,
      expectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_at'],
      ),
      deliveredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}delivered_at'],
      ),
      reminderAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reminder_at'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      ),
      trackingUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tracking_url'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PurchaseOrdersTable createAlias(String alias) {
    return $PurchaseOrdersTable(attachedDatabase, alias);
  }
}

class PurchaseOrder extends DataClass implements Insertable<PurchaseOrder> {
  final String id;
  final String profileId;

  /// Shop / platform display name (e.g. Taobao, PLUSHSHOP).
  final String platform;
  final String title;
  final int quantity;

  /// ordered | preorder | awaitingShipment | shipped | delivered | cancelled
  final String status;
  final DateTime orderedAt;
  final DateTime? expectedAt;
  final DateTime? deliveredAt;
  final DateTime? reminderAt;
  final double? price;
  final String? currency;
  final String? trackingUrl;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PurchaseOrder({
    required this.id,
    required this.profileId,
    required this.platform,
    required this.title,
    required this.quantity,
    required this.status,
    required this.orderedAt,
    this.expectedAt,
    this.deliveredAt,
    this.reminderAt,
    this.price,
    this.currency,
    this.trackingUrl,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['platform'] = Variable<String>(platform);
    map['title'] = Variable<String>(title);
    map['quantity'] = Variable<int>(quantity);
    map['status'] = Variable<String>(status);
    map['ordered_at'] = Variable<DateTime>(orderedAt);
    if (!nullToAbsent || expectedAt != null) {
      map['expected_at'] = Variable<DateTime>(expectedAt);
    }
    if (!nullToAbsent || deliveredAt != null) {
      map['delivered_at'] = Variable<DateTime>(deliveredAt);
    }
    if (!nullToAbsent || reminderAt != null) {
      map['reminder_at'] = Variable<DateTime>(reminderAt);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || currency != null) {
      map['currency'] = Variable<String>(currency);
    }
    if (!nullToAbsent || trackingUrl != null) {
      map['tracking_url'] = Variable<String>(trackingUrl);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PurchaseOrdersCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrdersCompanion(
      id: Value(id),
      profileId: Value(profileId),
      platform: Value(platform),
      title: Value(title),
      quantity: Value(quantity),
      status: Value(status),
      orderedAt: Value(orderedAt),
      expectedAt: expectedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedAt),
      deliveredAt: deliveredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveredAt),
      reminderAt: reminderAt == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderAt),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      trackingUrl: trackingUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(trackingUrl),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PurchaseOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrder(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      platform: serializer.fromJson<String>(json['platform']),
      title: serializer.fromJson<String>(json['title']),
      quantity: serializer.fromJson<int>(json['quantity']),
      status: serializer.fromJson<String>(json['status']),
      orderedAt: serializer.fromJson<DateTime>(json['orderedAt']),
      expectedAt: serializer.fromJson<DateTime?>(json['expectedAt']),
      deliveredAt: serializer.fromJson<DateTime?>(json['deliveredAt']),
      reminderAt: serializer.fromJson<DateTime?>(json['reminderAt']),
      price: serializer.fromJson<double?>(json['price']),
      currency: serializer.fromJson<String?>(json['currency']),
      trackingUrl: serializer.fromJson<String?>(json['trackingUrl']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'platform': serializer.toJson<String>(platform),
      'title': serializer.toJson<String>(title),
      'quantity': serializer.toJson<int>(quantity),
      'status': serializer.toJson<String>(status),
      'orderedAt': serializer.toJson<DateTime>(orderedAt),
      'expectedAt': serializer.toJson<DateTime?>(expectedAt),
      'deliveredAt': serializer.toJson<DateTime?>(deliveredAt),
      'reminderAt': serializer.toJson<DateTime?>(reminderAt),
      'price': serializer.toJson<double?>(price),
      'currency': serializer.toJson<String?>(currency),
      'trackingUrl': serializer.toJson<String?>(trackingUrl),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PurchaseOrder copyWith({
    String? id,
    String? profileId,
    String? platform,
    String? title,
    int? quantity,
    String? status,
    DateTime? orderedAt,
    Value<DateTime?> expectedAt = const Value.absent(),
    Value<DateTime?> deliveredAt = const Value.absent(),
    Value<DateTime?> reminderAt = const Value.absent(),
    Value<double?> price = const Value.absent(),
    Value<String?> currency = const Value.absent(),
    Value<String?> trackingUrl = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PurchaseOrder(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    platform: platform ?? this.platform,
    title: title ?? this.title,
    quantity: quantity ?? this.quantity,
    status: status ?? this.status,
    orderedAt: orderedAt ?? this.orderedAt,
    expectedAt: expectedAt.present ? expectedAt.value : this.expectedAt,
    deliveredAt: deliveredAt.present ? deliveredAt.value : this.deliveredAt,
    reminderAt: reminderAt.present ? reminderAt.value : this.reminderAt,
    price: price.present ? price.value : this.price,
    currency: currency.present ? currency.value : this.currency,
    trackingUrl: trackingUrl.present ? trackingUrl.value : this.trackingUrl,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PurchaseOrder copyWithCompanion(PurchaseOrdersCompanion data) {
    return PurchaseOrder(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      platform: data.platform.present ? data.platform.value : this.platform,
      title: data.title.present ? data.title.value : this.title,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      status: data.status.present ? data.status.value : this.status,
      orderedAt: data.orderedAt.present ? data.orderedAt.value : this.orderedAt,
      expectedAt: data.expectedAt.present
          ? data.expectedAt.value
          : this.expectedAt,
      deliveredAt: data.deliveredAt.present
          ? data.deliveredAt.value
          : this.deliveredAt,
      reminderAt: data.reminderAt.present
          ? data.reminderAt.value
          : this.reminderAt,
      price: data.price.present ? data.price.value : this.price,
      currency: data.currency.present ? data.currency.value : this.currency,
      trackingUrl: data.trackingUrl.present
          ? data.trackingUrl.value
          : this.trackingUrl,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrder(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('platform: $platform, ')
          ..write('title: $title, ')
          ..write('quantity: $quantity, ')
          ..write('status: $status, ')
          ..write('orderedAt: $orderedAt, ')
          ..write('expectedAt: $expectedAt, ')
          ..write('deliveredAt: $deliveredAt, ')
          ..write('reminderAt: $reminderAt, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('trackingUrl: $trackingUrl, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    platform,
    title,
    quantity,
    status,
    orderedAt,
    expectedAt,
    deliveredAt,
    reminderAt,
    price,
    currency,
    trackingUrl,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrder &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.platform == this.platform &&
          other.title == this.title &&
          other.quantity == this.quantity &&
          other.status == this.status &&
          other.orderedAt == this.orderedAt &&
          other.expectedAt == this.expectedAt &&
          other.deliveredAt == this.deliveredAt &&
          other.reminderAt == this.reminderAt &&
          other.price == this.price &&
          other.currency == this.currency &&
          other.trackingUrl == this.trackingUrl &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PurchaseOrdersCompanion extends UpdateCompanion<PurchaseOrder> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> platform;
  final Value<String> title;
  final Value<int> quantity;
  final Value<String> status;
  final Value<DateTime> orderedAt;
  final Value<DateTime?> expectedAt;
  final Value<DateTime?> deliveredAt;
  final Value<DateTime?> reminderAt;
  final Value<double?> price;
  final Value<String?> currency;
  final Value<String?> trackingUrl;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PurchaseOrdersCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.platform = const Value.absent(),
    this.title = const Value.absent(),
    this.quantity = const Value.absent(),
    this.status = const Value.absent(),
    this.orderedAt = const Value.absent(),
    this.expectedAt = const Value.absent(),
    this.deliveredAt = const Value.absent(),
    this.reminderAt = const Value.absent(),
    this.price = const Value.absent(),
    this.currency = const Value.absent(),
    this.trackingUrl = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseOrdersCompanion.insert({
    required String id,
    required String profileId,
    required String platform,
    required String title,
    this.quantity = const Value.absent(),
    required String status,
    required DateTime orderedAt,
    this.expectedAt = const Value.absent(),
    this.deliveredAt = const Value.absent(),
    this.reminderAt = const Value.absent(),
    this.price = const Value.absent(),
    this.currency = const Value.absent(),
    this.trackingUrl = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       platform = Value(platform),
       title = Value(title),
       status = Value(status),
       orderedAt = Value(orderedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PurchaseOrder> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? platform,
    Expression<String>? title,
    Expression<int>? quantity,
    Expression<String>? status,
    Expression<DateTime>? orderedAt,
    Expression<DateTime>? expectedAt,
    Expression<DateTime>? deliveredAt,
    Expression<DateTime>? reminderAt,
    Expression<double>? price,
    Expression<String>? currency,
    Expression<String>? trackingUrl,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (platform != null) 'platform': platform,
      if (title != null) 'title': title,
      if (quantity != null) 'quantity': quantity,
      if (status != null) 'status': status,
      if (orderedAt != null) 'ordered_at': orderedAt,
      if (expectedAt != null) 'expected_at': expectedAt,
      if (deliveredAt != null) 'delivered_at': deliveredAt,
      if (reminderAt != null) 'reminder_at': reminderAt,
      if (price != null) 'price': price,
      if (currency != null) 'currency': currency,
      if (trackingUrl != null) 'tracking_url': trackingUrl,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseOrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? platform,
    Value<String>? title,
    Value<int>? quantity,
    Value<String>? status,
    Value<DateTime>? orderedAt,
    Value<DateTime?>? expectedAt,
    Value<DateTime?>? deliveredAt,
    Value<DateTime?>? reminderAt,
    Value<double?>? price,
    Value<String?>? currency,
    Value<String?>? trackingUrl,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PurchaseOrdersCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      platform: platform ?? this.platform,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      orderedAt: orderedAt ?? this.orderedAt,
      expectedAt: expectedAt ?? this.expectedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      reminderAt: reminderAt ?? this.reminderAt,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      trackingUrl: trackingUrl ?? this.trackingUrl,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (orderedAt.present) {
      map['ordered_at'] = Variable<DateTime>(orderedAt.value);
    }
    if (expectedAt.present) {
      map['expected_at'] = Variable<DateTime>(expectedAt.value);
    }
    if (deliveredAt.present) {
      map['delivered_at'] = Variable<DateTime>(deliveredAt.value);
    }
    if (reminderAt.present) {
      map['reminder_at'] = Variable<DateTime>(reminderAt.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (trackingUrl.present) {
      map['tracking_url'] = Variable<String>(trackingUrl.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrdersCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('platform: $platform, ')
          ..write('title: $title, ')
          ..write('quantity: $quantity, ')
          ..write('status: $status, ')
          ..write('orderedAt: $orderedAt, ')
          ..write('expectedAt: $expectedAt, ')
          ..write('deliveredAt: $deliveredAt, ')
          ..write('reminderAt: $reminderAt, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('trackingUrl: $trackingUrl, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserAccountsTable userAccounts = $UserAccountsTable(this);
  late final $LinkedIdentitiesTable linkedIdentities = $LinkedIdentitiesTable(
    this,
  );
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ServicesTable services = $ServicesTable(this);
  late final $PlansTable plans = $PlansTable(this);
  late final $PaymentMethodsTable paymentMethods = $PaymentMethodsTable(this);
  late final $SubscriptionsTable subscriptions = $SubscriptionsTable(this);
  late final $PricePhasesTable pricePhases = $PricePhasesTable(this);
  late final $PaymentRecordsTable paymentRecords = $PaymentRecordsTable(this);
  late final $PriceHistoryTable priceHistory = $PriceHistoryTable(this);
  late final $SubscriptionEventsTable subscriptionEvents =
      $SubscriptionEventsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $CurrencyRatesTable currencyRates = $CurrencyRatesTable(this);
  late final $BudgetsTable budgets = $BudgetsTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $AppThemeRowsTable appThemeRows = $AppThemeRowsTable(this);
  late final $PurchaseOrdersTable purchaseOrders = $PurchaseOrdersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userAccounts,
    linkedIdentities,
    userProfiles,
    categories,
    services,
    plans,
    paymentMethods,
    subscriptions,
    pricePhases,
    paymentRecords,
    priceHistory,
    subscriptionEvents,
    reminders,
    currencyRates,
    budgets,
    userPreferences,
    appThemeRows,
    purchaseOrders,
  ];
}

typedef $$UserAccountsTableCreateCompanionBuilder =
    UserAccountsCompanion Function({
      required String id,
      Value<String> displayName,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$UserAccountsTableUpdateCompanionBuilder =
    UserAccountsCompanion Function({
      Value<String> id,
      Value<String> displayName,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$UserAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $UserAccountsTable> {
  $$UserAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAccountsTable> {
  $$UserAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAccountsTable> {
  $$UserAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAccountsTable,
          UserAccount,
          $$UserAccountsTableFilterComposer,
          $$UserAccountsTableOrderingComposer,
          $$UserAccountsTableAnnotationComposer,
          $$UserAccountsTableCreateCompanionBuilder,
          $$UserAccountsTableUpdateCompanionBuilder,
          (
            UserAccount,
            BaseReferences<_$AppDatabase, $UserAccountsTable, UserAccount>,
          ),
          UserAccount,
          PrefetchHooks Function()
        > {
  $$UserAccountsTableTableManager(_$AppDatabase db, $UserAccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAccountsCompanion(
                id: id,
                displayName: displayName,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> displayName = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UserAccountsCompanion.insert(
                id: id,
                displayName: displayName,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAccountsTable,
      UserAccount,
      $$UserAccountsTableFilterComposer,
      $$UserAccountsTableOrderingComposer,
      $$UserAccountsTableAnnotationComposer,
      $$UserAccountsTableCreateCompanionBuilder,
      $$UserAccountsTableUpdateCompanionBuilder,
      (
        UserAccount,
        BaseReferences<_$AppDatabase, $UserAccountsTable, UserAccount>,
      ),
      UserAccount,
      PrefetchHooks Function()
    >;
typedef $$LinkedIdentitiesTableCreateCompanionBuilder =
    LinkedIdentitiesCompanion Function({
      required String id,
      required String accountId,
      required String provider,
      Value<String?> providerUserId,
      Value<String?> email,
      Value<String?> displayName,
      required DateTime linkedAt,
      Value<int> rowid,
    });
typedef $$LinkedIdentitiesTableUpdateCompanionBuilder =
    LinkedIdentitiesCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> provider,
      Value<String?> providerUserId,
      Value<String?> email,
      Value<String?> displayName,
      Value<DateTime> linkedAt,
      Value<int> rowid,
    });

class $$LinkedIdentitiesTableFilterComposer
    extends Composer<_$AppDatabase, $LinkedIdentitiesTable> {
  $$LinkedIdentitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerUserId => $composableBuilder(
    column: $table.providerUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get linkedAt => $composableBuilder(
    column: $table.linkedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LinkedIdentitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $LinkedIdentitiesTable> {
  $$LinkedIdentitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerUserId => $composableBuilder(
    column: $table.providerUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get linkedAt => $composableBuilder(
    column: $table.linkedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LinkedIdentitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LinkedIdentitiesTable> {
  $$LinkedIdentitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get providerUserId => $composableBuilder(
    column: $table.providerUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get linkedAt =>
      $composableBuilder(column: $table.linkedAt, builder: (column) => column);
}

class $$LinkedIdentitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LinkedIdentitiesTable,
          LinkedIdentity,
          $$LinkedIdentitiesTableFilterComposer,
          $$LinkedIdentitiesTableOrderingComposer,
          $$LinkedIdentitiesTableAnnotationComposer,
          $$LinkedIdentitiesTableCreateCompanionBuilder,
          $$LinkedIdentitiesTableUpdateCompanionBuilder,
          (
            LinkedIdentity,
            BaseReferences<
              _$AppDatabase,
              $LinkedIdentitiesTable,
              LinkedIdentity
            >,
          ),
          LinkedIdentity,
          PrefetchHooks Function()
        > {
  $$LinkedIdentitiesTableTableManager(
    _$AppDatabase db,
    $LinkedIdentitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LinkedIdentitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LinkedIdentitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LinkedIdentitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<String?> providerUserId = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<DateTime> linkedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LinkedIdentitiesCompanion(
                id: id,
                accountId: accountId,
                provider: provider,
                providerUserId: providerUserId,
                email: email,
                displayName: displayName,
                linkedAt: linkedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String provider,
                Value<String?> providerUserId = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                required DateTime linkedAt,
                Value<int> rowid = const Value.absent(),
              }) => LinkedIdentitiesCompanion.insert(
                id: id,
                accountId: accountId,
                provider: provider,
                providerUserId: providerUserId,
                email: email,
                displayName: displayName,
                linkedAt: linkedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LinkedIdentitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LinkedIdentitiesTable,
      LinkedIdentity,
      $$LinkedIdentitiesTableFilterComposer,
      $$LinkedIdentitiesTableOrderingComposer,
      $$LinkedIdentitiesTableAnnotationComposer,
      $$LinkedIdentitiesTableCreateCompanionBuilder,
      $$LinkedIdentitiesTableUpdateCompanionBuilder,
      (
        LinkedIdentity,
        BaseReferences<_$AppDatabase, $LinkedIdentitiesTable, LinkedIdentity>,
      ),
      LinkedIdentity,
      PrefetchHooks Function()
    >;
typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<bool> isDefault,
      Value<int> rowid,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<bool> isDefault,
      Value<int> rowid,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                name: name,
                type: type,
                isDefault: isDefault,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<bool> isDefault = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                name: name,
                type: type,
                isDefault: isDefault,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      required String slug,
      required String name,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> slug,
      Value<String> name,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                slug: slug,
                name: name,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String slug,
                required String name,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                slug: slug,
                name: name,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$ServicesTableCreateCompanionBuilder =
    ServicesCompanion Function({
      required String id,
      required String name,
      required String categoryId,
      Value<String?> logoKey,
      Value<String?> officialWebsiteUrl,
      Value<String?> manageSubscriptionUrl,
      Value<bool> isCustom,
      Value<bool> isBuiltin,
      Value<int> rowid,
    });
typedef $$ServicesTableUpdateCompanionBuilder =
    ServicesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> categoryId,
      Value<String?> logoKey,
      Value<String?> officialWebsiteUrl,
      Value<String?> manageSubscriptionUrl,
      Value<bool> isCustom,
      Value<bool> isBuiltin,
      Value<int> rowid,
    });

class $$ServicesTableFilterComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoKey => $composableBuilder(
    column: $table.logoKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get officialWebsiteUrl => $composableBuilder(
    column: $table.officialWebsiteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manageSubscriptionUrl => $composableBuilder(
    column: $table.manageSubscriptionUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServicesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoKey => $composableBuilder(
    column: $table.logoKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get officialWebsiteUrl => $composableBuilder(
    column: $table.officialWebsiteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manageSubscriptionUrl => $composableBuilder(
    column: $table.manageSubscriptionUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logoKey =>
      $composableBuilder(column: $table.logoKey, builder: (column) => column);

  GeneratedColumn<String> get officialWebsiteUrl => $composableBuilder(
    column: $table.officialWebsiteUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get manageSubscriptionUrl => $composableBuilder(
    column: $table.manageSubscriptionUrl,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltin =>
      $composableBuilder(column: $table.isBuiltin, builder: (column) => column);
}

class $$ServicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServicesTable,
          Service,
          $$ServicesTableFilterComposer,
          $$ServicesTableOrderingComposer,
          $$ServicesTableAnnotationComposer,
          $$ServicesTableCreateCompanionBuilder,
          $$ServicesTableUpdateCompanionBuilder,
          (Service, BaseReferences<_$AppDatabase, $ServicesTable, Service>),
          Service,
          PrefetchHooks Function()
        > {
  $$ServicesTableTableManager(_$AppDatabase db, $ServicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String?> logoKey = const Value.absent(),
                Value<String?> officialWebsiteUrl = const Value.absent(),
                Value<String?> manageSubscriptionUrl = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServicesCompanion(
                id: id,
                name: name,
                categoryId: categoryId,
                logoKey: logoKey,
                officialWebsiteUrl: officialWebsiteUrl,
                manageSubscriptionUrl: manageSubscriptionUrl,
                isCustom: isCustom,
                isBuiltin: isBuiltin,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String categoryId,
                Value<String?> logoKey = const Value.absent(),
                Value<String?> officialWebsiteUrl = const Value.absent(),
                Value<String?> manageSubscriptionUrl = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServicesCompanion.insert(
                id: id,
                name: name,
                categoryId: categoryId,
                logoKey: logoKey,
                officialWebsiteUrl: officialWebsiteUrl,
                manageSubscriptionUrl: manageSubscriptionUrl,
                isCustom: isCustom,
                isBuiltin: isBuiltin,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServicesTable,
      Service,
      $$ServicesTableFilterComposer,
      $$ServicesTableOrderingComposer,
      $$ServicesTableAnnotationComposer,
      $$ServicesTableCreateCompanionBuilder,
      $$ServicesTableUpdateCompanionBuilder,
      (Service, BaseReferences<_$AppDatabase, $ServicesTable, Service>),
      Service,
      PrefetchHooks Function()
    >;
typedef $$PlansTableCreateCompanionBuilder =
    PlansCompanion Function({
      required String id,
      required String serviceId,
      required String name,
      required String billingCycle,
      Value<double?> suggestedPrice,
      Value<String?> suggestedCurrency,
      Value<int> rowid,
    });
typedef $$PlansTableUpdateCompanionBuilder =
    PlansCompanion Function({
      Value<String> id,
      Value<String> serviceId,
      Value<String> name,
      Value<String> billingCycle,
      Value<double?> suggestedPrice,
      Value<String?> suggestedCurrency,
      Value<int> rowid,
    });

class $$PlansTableFilterComposer extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get suggestedPrice => $composableBuilder(
    column: $table.suggestedPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get suggestedCurrency => $composableBuilder(
    column: $table.suggestedCurrency,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlansTableOrderingComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get suggestedPrice => $composableBuilder(
    column: $table.suggestedPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get suggestedCurrency => $composableBuilder(
    column: $table.suggestedCurrency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serviceId =>
      $composableBuilder(column: $table.serviceId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => column,
  );

  GeneratedColumn<double> get suggestedPrice => $composableBuilder(
    column: $table.suggestedPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get suggestedCurrency => $composableBuilder(
    column: $table.suggestedCurrency,
    builder: (column) => column,
  );
}

class $$PlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlansTable,
          Plan,
          $$PlansTableFilterComposer,
          $$PlansTableOrderingComposer,
          $$PlansTableAnnotationComposer,
          $$PlansTableCreateCompanionBuilder,
          $$PlansTableUpdateCompanionBuilder,
          (Plan, BaseReferences<_$AppDatabase, $PlansTable, Plan>),
          Plan,
          PrefetchHooks Function()
        > {
  $$PlansTableTableManager(_$AppDatabase db, $PlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> serviceId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> billingCycle = const Value.absent(),
                Value<double?> suggestedPrice = const Value.absent(),
                Value<String?> suggestedCurrency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlansCompanion(
                id: id,
                serviceId: serviceId,
                name: name,
                billingCycle: billingCycle,
                suggestedPrice: suggestedPrice,
                suggestedCurrency: suggestedCurrency,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String serviceId,
                required String name,
                required String billingCycle,
                Value<double?> suggestedPrice = const Value.absent(),
                Value<String?> suggestedCurrency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlansCompanion.insert(
                id: id,
                serviceId: serviceId,
                name: name,
                billingCycle: billingCycle,
                suggestedPrice: suggestedPrice,
                suggestedCurrency: suggestedCurrency,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlansTable,
      Plan,
      $$PlansTableFilterComposer,
      $$PlansTableOrderingComposer,
      $$PlansTableAnnotationComposer,
      $$PlansTableCreateCompanionBuilder,
      $$PlansTableUpdateCompanionBuilder,
      (Plan, BaseReferences<_$AppDatabase, $PlansTable, Plan>),
      Plan,
      PrefetchHooks Function()
    >;
typedef $$PaymentMethodsTableCreateCompanionBuilder =
    PaymentMethodsCompanion Function({
      required String id,
      required String label,
      required String type,
      required String brand,
      Value<String?> last4,
      Value<DateTime?> expiry,
      Value<int> rowid,
    });
typedef $$PaymentMethodsTableUpdateCompanionBuilder =
    PaymentMethodsCompanion Function({
      Value<String> id,
      Value<String> label,
      Value<String> type,
      Value<String> brand,
      Value<String?> last4,
      Value<DateTime?> expiry,
      Value<int> rowid,
    });

class $$PaymentMethodsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get last4 => $composableBuilder(
    column: $table.last4,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiry => $composableBuilder(
    column: $table.expiry,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentMethodsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get last4 => $composableBuilder(
    column: $table.last4,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiry => $composableBuilder(
    column: $table.expiry,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentMethodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get last4 =>
      $composableBuilder(column: $table.last4, builder: (column) => column);

  GeneratedColumn<DateTime> get expiry =>
      $composableBuilder(column: $table.expiry, builder: (column) => column);
}

class $$PaymentMethodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentMethodsTable,
          PaymentMethod,
          $$PaymentMethodsTableFilterComposer,
          $$PaymentMethodsTableOrderingComposer,
          $$PaymentMethodsTableAnnotationComposer,
          $$PaymentMethodsTableCreateCompanionBuilder,
          $$PaymentMethodsTableUpdateCompanionBuilder,
          (
            PaymentMethod,
            BaseReferences<_$AppDatabase, $PaymentMethodsTable, PaymentMethod>,
          ),
          PaymentMethod,
          PrefetchHooks Function()
        > {
  $$PaymentMethodsTableTableManager(
    _$AppDatabase db,
    $PaymentMethodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentMethodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentMethodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentMethodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String?> last4 = const Value.absent(),
                Value<DateTime?> expiry = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentMethodsCompanion(
                id: id,
                label: label,
                type: type,
                brand: brand,
                last4: last4,
                expiry: expiry,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String label,
                required String type,
                required String brand,
                Value<String?> last4 = const Value.absent(),
                Value<DateTime?> expiry = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentMethodsCompanion.insert(
                id: id,
                label: label,
                type: type,
                brand: brand,
                last4: last4,
                expiry: expiry,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentMethodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentMethodsTable,
      PaymentMethod,
      $$PaymentMethodsTableFilterComposer,
      $$PaymentMethodsTableOrderingComposer,
      $$PaymentMethodsTableAnnotationComposer,
      $$PaymentMethodsTableCreateCompanionBuilder,
      $$PaymentMethodsTableUpdateCompanionBuilder,
      (
        PaymentMethod,
        BaseReferences<_$AppDatabase, $PaymentMethodsTable, PaymentMethod>,
      ),
      PaymentMethod,
      PrefetchHooks Function()
    >;
typedef $$SubscriptionsTableCreateCompanionBuilder =
    SubscriptionsCompanion Function({
      required String id,
      required String serviceId,
      Value<String?> planId,
      required String categoryId,
      required String profileId,
      required String status,
      Value<bool> active,
      required DateTime startDate,
      Value<DateTime?> nextBillingDate,
      Value<DateTime?> accessEndDate,
      Value<bool> autoRenew,
      required String currency,
      required double currentPrice,
      required String billingCycle,
      Value<int?> customCycleDays,
      Value<String?> paymentMethodId,
      required String renewalIntent,
      required String usageFrequency,
      Value<int?> usageCountPerMonth,
      Value<String?> officialWebsiteUrl,
      Value<String?> manageSubscriptionUrl,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isDemo,
      Value<int> rowid,
    });
typedef $$SubscriptionsTableUpdateCompanionBuilder =
    SubscriptionsCompanion Function({
      Value<String> id,
      Value<String> serviceId,
      Value<String?> planId,
      Value<String> categoryId,
      Value<String> profileId,
      Value<String> status,
      Value<bool> active,
      Value<DateTime> startDate,
      Value<DateTime?> nextBillingDate,
      Value<DateTime?> accessEndDate,
      Value<bool> autoRenew,
      Value<String> currency,
      Value<double> currentPrice,
      Value<String> billingCycle,
      Value<int?> customCycleDays,
      Value<String?> paymentMethodId,
      Value<String> renewalIntent,
      Value<String> usageFrequency,
      Value<int?> usageCountPerMonth,
      Value<String?> officialWebsiteUrl,
      Value<String?> manageSubscriptionUrl,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDemo,
      Value<int> rowid,
    });

class $$SubscriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextBillingDate => $composableBuilder(
    column: $table.nextBillingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get accessEndDate => $composableBuilder(
    column: $table.accessEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoRenew => $composableBuilder(
    column: $table.autoRenew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customCycleDays => $composableBuilder(
    column: $table.customCycleDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get renewalIntent => $composableBuilder(
    column: $table.renewalIntent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usageFrequency => $composableBuilder(
    column: $table.usageFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCountPerMonth => $composableBuilder(
    column: $table.usageCountPerMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get officialWebsiteUrl => $composableBuilder(
    column: $table.officialWebsiteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manageSubscriptionUrl => $composableBuilder(
    column: $table.manageSubscriptionUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubscriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextBillingDate => $composableBuilder(
    column: $table.nextBillingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get accessEndDate => $composableBuilder(
    column: $table.accessEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoRenew => $composableBuilder(
    column: $table.autoRenew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customCycleDays => $composableBuilder(
    column: $table.customCycleDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get renewalIntent => $composableBuilder(
    column: $table.renewalIntent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usageFrequency => $composableBuilder(
    column: $table.usageFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCountPerMonth => $composableBuilder(
    column: $table.usageCountPerMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get officialWebsiteUrl => $composableBuilder(
    column: $table.officialWebsiteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manageSubscriptionUrl => $composableBuilder(
    column: $table.manageSubscriptionUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubscriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serviceId =>
      $composableBuilder(column: $table.serviceId, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get nextBillingDate => $composableBuilder(
    column: $table.nextBillingDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get accessEndDate => $composableBuilder(
    column: $table.accessEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoRenew =>
      $composableBuilder(column: $table.autoRenew, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customCycleDays => $composableBuilder(
    column: $table.customCycleDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get renewalIntent => $composableBuilder(
    column: $table.renewalIntent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usageFrequency => $composableBuilder(
    column: $table.usageFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usageCountPerMonth => $composableBuilder(
    column: $table.usageCountPerMonth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get officialWebsiteUrl => $composableBuilder(
    column: $table.officialWebsiteUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get manageSubscriptionUrl => $composableBuilder(
    column: $table.manageSubscriptionUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDemo =>
      $composableBuilder(column: $table.isDemo, builder: (column) => column);
}

class $$SubscriptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubscriptionsTable,
          Subscription,
          $$SubscriptionsTableFilterComposer,
          $$SubscriptionsTableOrderingComposer,
          $$SubscriptionsTableAnnotationComposer,
          $$SubscriptionsTableCreateCompanionBuilder,
          $$SubscriptionsTableUpdateCompanionBuilder,
          (
            Subscription,
            BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>,
          ),
          Subscription,
          PrefetchHooks Function()
        > {
  $$SubscriptionsTableTableManager(_$AppDatabase db, $SubscriptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> serviceId = const Value.absent(),
                Value<String?> planId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> nextBillingDate = const Value.absent(),
                Value<DateTime?> accessEndDate = const Value.absent(),
                Value<bool> autoRenew = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> currentPrice = const Value.absent(),
                Value<String> billingCycle = const Value.absent(),
                Value<int?> customCycleDays = const Value.absent(),
                Value<String?> paymentMethodId = const Value.absent(),
                Value<String> renewalIntent = const Value.absent(),
                Value<String> usageFrequency = const Value.absent(),
                Value<int?> usageCountPerMonth = const Value.absent(),
                Value<String?> officialWebsiteUrl = const Value.absent(),
                Value<String?> manageSubscriptionUrl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion(
                id: id,
                serviceId: serviceId,
                planId: planId,
                categoryId: categoryId,
                profileId: profileId,
                status: status,
                active: active,
                startDate: startDate,
                nextBillingDate: nextBillingDate,
                accessEndDate: accessEndDate,
                autoRenew: autoRenew,
                currency: currency,
                currentPrice: currentPrice,
                billingCycle: billingCycle,
                customCycleDays: customCycleDays,
                paymentMethodId: paymentMethodId,
                renewalIntent: renewalIntent,
                usageFrequency: usageFrequency,
                usageCountPerMonth: usageCountPerMonth,
                officialWebsiteUrl: officialWebsiteUrl,
                manageSubscriptionUrl: manageSubscriptionUrl,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDemo: isDemo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String serviceId,
                Value<String?> planId = const Value.absent(),
                required String categoryId,
                required String profileId,
                required String status,
                Value<bool> active = const Value.absent(),
                required DateTime startDate,
                Value<DateTime?> nextBillingDate = const Value.absent(),
                Value<DateTime?> accessEndDate = const Value.absent(),
                Value<bool> autoRenew = const Value.absent(),
                required String currency,
                required double currentPrice,
                required String billingCycle,
                Value<int?> customCycleDays = const Value.absent(),
                Value<String?> paymentMethodId = const Value.absent(),
                required String renewalIntent,
                required String usageFrequency,
                Value<int?> usageCountPerMonth = const Value.absent(),
                Value<String?> officialWebsiteUrl = const Value.absent(),
                Value<String?> manageSubscriptionUrl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isDemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion.insert(
                id: id,
                serviceId: serviceId,
                planId: planId,
                categoryId: categoryId,
                profileId: profileId,
                status: status,
                active: active,
                startDate: startDate,
                nextBillingDate: nextBillingDate,
                accessEndDate: accessEndDate,
                autoRenew: autoRenew,
                currency: currency,
                currentPrice: currentPrice,
                billingCycle: billingCycle,
                customCycleDays: customCycleDays,
                paymentMethodId: paymentMethodId,
                renewalIntent: renewalIntent,
                usageFrequency: usageFrequency,
                usageCountPerMonth: usageCountPerMonth,
                officialWebsiteUrl: officialWebsiteUrl,
                manageSubscriptionUrl: manageSubscriptionUrl,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDemo: isDemo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubscriptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubscriptionsTable,
      Subscription,
      $$SubscriptionsTableFilterComposer,
      $$SubscriptionsTableOrderingComposer,
      $$SubscriptionsTableAnnotationComposer,
      $$SubscriptionsTableCreateCompanionBuilder,
      $$SubscriptionsTableUpdateCompanionBuilder,
      (
        Subscription,
        BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>,
      ),
      Subscription,
      PrefetchHooks Function()
    >;
typedef $$PricePhasesTableCreateCompanionBuilder =
    PricePhasesCompanion Function({
      required String id,
      required String subscriptionId,
      required String type,
      required DateTime startDate,
      Value<DateTime?> endDate,
      required double price,
      required String currency,
      required String billingCycle,
      Value<double?> regularPrice,
      Value<String?> regularCurrency,
      Value<String?> promotionName,
      Value<DateTime?> cancelDeadline,
      Value<DateTime?> firstChargeDate,
      Value<DateTime?> trialEndDate,
      Value<DateTime?> reminderDate,
      Value<bool> autoRenew,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$PricePhasesTableUpdateCompanionBuilder =
    PricePhasesCompanion Function({
      Value<String> id,
      Value<String> subscriptionId,
      Value<String> type,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<double> price,
      Value<String> currency,
      Value<String> billingCycle,
      Value<double?> regularPrice,
      Value<String?> regularCurrency,
      Value<String?> promotionName,
      Value<DateTime?> cancelDeadline,
      Value<DateTime?> firstChargeDate,
      Value<DateTime?> trialEndDate,
      Value<DateTime?> reminderDate,
      Value<bool> autoRenew,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$PricePhasesTableFilterComposer
    extends Composer<_$AppDatabase, $PricePhasesTable> {
  $$PricePhasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get regularPrice => $composableBuilder(
    column: $table.regularPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regularCurrency => $composableBuilder(
    column: $table.regularCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promotionName => $composableBuilder(
    column: $table.promotionName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cancelDeadline => $composableBuilder(
    column: $table.cancelDeadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstChargeDate => $composableBuilder(
    column: $table.firstChargeDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get trialEndDate => $composableBuilder(
    column: $table.trialEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoRenew => $composableBuilder(
    column: $table.autoRenew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PricePhasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PricePhasesTable> {
  $$PricePhasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get regularPrice => $composableBuilder(
    column: $table.regularPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regularCurrency => $composableBuilder(
    column: $table.regularCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promotionName => $composableBuilder(
    column: $table.promotionName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cancelDeadline => $composableBuilder(
    column: $table.cancelDeadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstChargeDate => $composableBuilder(
    column: $table.firstChargeDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get trialEndDate => $composableBuilder(
    column: $table.trialEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoRenew => $composableBuilder(
    column: $table.autoRenew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PricePhasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PricePhasesTable> {
  $$PricePhasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => column,
  );

  GeneratedColumn<double> get regularPrice => $composableBuilder(
    column: $table.regularPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get regularCurrency => $composableBuilder(
    column: $table.regularCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get promotionName => $composableBuilder(
    column: $table.promotionName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cancelDeadline => $composableBuilder(
    column: $table.cancelDeadline,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get firstChargeDate => $composableBuilder(
    column: $table.firstChargeDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get trialEndDate => $composableBuilder(
    column: $table.trialEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoRenew =>
      $composableBuilder(column: $table.autoRenew, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$PricePhasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PricePhasesTable,
          PricePhase,
          $$PricePhasesTableFilterComposer,
          $$PricePhasesTableOrderingComposer,
          $$PricePhasesTableAnnotationComposer,
          $$PricePhasesTableCreateCompanionBuilder,
          $$PricePhasesTableUpdateCompanionBuilder,
          (
            PricePhase,
            BaseReferences<_$AppDatabase, $PricePhasesTable, PricePhase>,
          ),
          PricePhase,
          PrefetchHooks Function()
        > {
  $$PricePhasesTableTableManager(_$AppDatabase db, $PricePhasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PricePhasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PricePhasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PricePhasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subscriptionId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> billingCycle = const Value.absent(),
                Value<double?> regularPrice = const Value.absent(),
                Value<String?> regularCurrency = const Value.absent(),
                Value<String?> promotionName = const Value.absent(),
                Value<DateTime?> cancelDeadline = const Value.absent(),
                Value<DateTime?> firstChargeDate = const Value.absent(),
                Value<DateTime?> trialEndDate = const Value.absent(),
                Value<DateTime?> reminderDate = const Value.absent(),
                Value<bool> autoRenew = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PricePhasesCompanion(
                id: id,
                subscriptionId: subscriptionId,
                type: type,
                startDate: startDate,
                endDate: endDate,
                price: price,
                currency: currency,
                billingCycle: billingCycle,
                regularPrice: regularPrice,
                regularCurrency: regularCurrency,
                promotionName: promotionName,
                cancelDeadline: cancelDeadline,
                firstChargeDate: firstChargeDate,
                trialEndDate: trialEndDate,
                reminderDate: reminderDate,
                autoRenew: autoRenew,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subscriptionId,
                required String type,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                required double price,
                required String currency,
                required String billingCycle,
                Value<double?> regularPrice = const Value.absent(),
                Value<String?> regularCurrency = const Value.absent(),
                Value<String?> promotionName = const Value.absent(),
                Value<DateTime?> cancelDeadline = const Value.absent(),
                Value<DateTime?> firstChargeDate = const Value.absent(),
                Value<DateTime?> trialEndDate = const Value.absent(),
                Value<DateTime?> reminderDate = const Value.absent(),
                Value<bool> autoRenew = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PricePhasesCompanion.insert(
                id: id,
                subscriptionId: subscriptionId,
                type: type,
                startDate: startDate,
                endDate: endDate,
                price: price,
                currency: currency,
                billingCycle: billingCycle,
                regularPrice: regularPrice,
                regularCurrency: regularCurrency,
                promotionName: promotionName,
                cancelDeadline: cancelDeadline,
                firstChargeDate: firstChargeDate,
                trialEndDate: trialEndDate,
                reminderDate: reminderDate,
                autoRenew: autoRenew,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PricePhasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PricePhasesTable,
      PricePhase,
      $$PricePhasesTableFilterComposer,
      $$PricePhasesTableOrderingComposer,
      $$PricePhasesTableAnnotationComposer,
      $$PricePhasesTableCreateCompanionBuilder,
      $$PricePhasesTableUpdateCompanionBuilder,
      (
        PricePhase,
        BaseReferences<_$AppDatabase, $PricePhasesTable, PricePhase>,
      ),
      PricePhase,
      PrefetchHooks Function()
    >;
typedef $$PaymentRecordsTableCreateCompanionBuilder =
    PaymentRecordsCompanion Function({
      required String id,
      required String subscriptionId,
      required DateTime date,
      required double originalAmount,
      required String originalCurrency,
      required double exchangeRate,
      required double convertedAmount,
      required String baseCurrency,
      required double foreignFee,
      required double actualChargedAmount,
      Value<String?> paymentMethodId,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$PaymentRecordsTableUpdateCompanionBuilder =
    PaymentRecordsCompanion Function({
      Value<String> id,
      Value<String> subscriptionId,
      Value<DateTime> date,
      Value<double> originalAmount,
      Value<String> originalCurrency,
      Value<double> exchangeRate,
      Value<double> convertedAmount,
      Value<String> baseCurrency,
      Value<double> foreignFee,
      Value<double> actualChargedAmount,
      Value<String?> paymentMethodId,
      Value<String?> note,
      Value<int> rowid,
    });

class $$PaymentRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentRecordsTable> {
  $$PaymentRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalAmount => $composableBuilder(
    column: $table.originalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalCurrency => $composableBuilder(
    column: $table.originalCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get convertedAmount => $composableBuilder(
    column: $table.convertedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get foreignFee => $composableBuilder(
    column: $table.foreignFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualChargedAmount => $composableBuilder(
    column: $table.actualChargedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentRecordsTable> {
  $$PaymentRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalAmount => $composableBuilder(
    column: $table.originalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalCurrency => $composableBuilder(
    column: $table.originalCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get convertedAmount => $composableBuilder(
    column: $table.convertedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get foreignFee => $composableBuilder(
    column: $table.foreignFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualChargedAmount => $composableBuilder(
    column: $table.actualChargedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentRecordsTable> {
  $$PaymentRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get originalAmount => $composableBuilder(
    column: $table.originalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalCurrency => $composableBuilder(
    column: $table.originalCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get convertedAmount => $composableBuilder(
    column: $table.convertedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get foreignFee => $composableBuilder(
    column: $table.foreignFee,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualChargedAmount => $composableBuilder(
    column: $table.actualChargedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$PaymentRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentRecordsTable,
          PaymentRecord,
          $$PaymentRecordsTableFilterComposer,
          $$PaymentRecordsTableOrderingComposer,
          $$PaymentRecordsTableAnnotationComposer,
          $$PaymentRecordsTableCreateCompanionBuilder,
          $$PaymentRecordsTableUpdateCompanionBuilder,
          (
            PaymentRecord,
            BaseReferences<_$AppDatabase, $PaymentRecordsTable, PaymentRecord>,
          ),
          PaymentRecord,
          PrefetchHooks Function()
        > {
  $$PaymentRecordsTableTableManager(
    _$AppDatabase db,
    $PaymentRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subscriptionId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> originalAmount = const Value.absent(),
                Value<String> originalCurrency = const Value.absent(),
                Value<double> exchangeRate = const Value.absent(),
                Value<double> convertedAmount = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<double> foreignFee = const Value.absent(),
                Value<double> actualChargedAmount = const Value.absent(),
                Value<String?> paymentMethodId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentRecordsCompanion(
                id: id,
                subscriptionId: subscriptionId,
                date: date,
                originalAmount: originalAmount,
                originalCurrency: originalCurrency,
                exchangeRate: exchangeRate,
                convertedAmount: convertedAmount,
                baseCurrency: baseCurrency,
                foreignFee: foreignFee,
                actualChargedAmount: actualChargedAmount,
                paymentMethodId: paymentMethodId,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subscriptionId,
                required DateTime date,
                required double originalAmount,
                required String originalCurrency,
                required double exchangeRate,
                required double convertedAmount,
                required String baseCurrency,
                required double foreignFee,
                required double actualChargedAmount,
                Value<String?> paymentMethodId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentRecordsCompanion.insert(
                id: id,
                subscriptionId: subscriptionId,
                date: date,
                originalAmount: originalAmount,
                originalCurrency: originalCurrency,
                exchangeRate: exchangeRate,
                convertedAmount: convertedAmount,
                baseCurrency: baseCurrency,
                foreignFee: foreignFee,
                actualChargedAmount: actualChargedAmount,
                paymentMethodId: paymentMethodId,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentRecordsTable,
      PaymentRecord,
      $$PaymentRecordsTableFilterComposer,
      $$PaymentRecordsTableOrderingComposer,
      $$PaymentRecordsTableAnnotationComposer,
      $$PaymentRecordsTableCreateCompanionBuilder,
      $$PaymentRecordsTableUpdateCompanionBuilder,
      (
        PaymentRecord,
        BaseReferences<_$AppDatabase, $PaymentRecordsTable, PaymentRecord>,
      ),
      PaymentRecord,
      PrefetchHooks Function()
    >;
typedef $$PriceHistoryTableCreateCompanionBuilder =
    PriceHistoryCompanion Function({
      required String id,
      required String subscriptionId,
      required double oldPrice,
      required double newPrice,
      required String currency,
      required DateTime effectiveDate,
      required String reason,
      Value<int> rowid,
    });
typedef $$PriceHistoryTableUpdateCompanionBuilder =
    PriceHistoryCompanion Function({
      Value<String> id,
      Value<String> subscriptionId,
      Value<double> oldPrice,
      Value<double> newPrice,
      Value<String> currency,
      Value<DateTime> effectiveDate,
      Value<String> reason,
      Value<int> rowid,
    });

class $$PriceHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $PriceHistoryTable> {
  $$PriceHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get oldPrice => $composableBuilder(
    column: $table.oldPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get newPrice => $composableBuilder(
    column: $table.newPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveDate => $composableBuilder(
    column: $table.effectiveDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PriceHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $PriceHistoryTable> {
  $$PriceHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get oldPrice => $composableBuilder(
    column: $table.oldPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get newPrice => $composableBuilder(
    column: $table.newPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveDate => $composableBuilder(
    column: $table.effectiveDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PriceHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $PriceHistoryTable> {
  $$PriceHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get oldPrice =>
      $composableBuilder(column: $table.oldPrice, builder: (column) => column);

  GeneratedColumn<double> get newPrice =>
      $composableBuilder(column: $table.newPrice, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveDate => $composableBuilder(
    column: $table.effectiveDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);
}

class $$PriceHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PriceHistoryTable,
          PriceHistoryData,
          $$PriceHistoryTableFilterComposer,
          $$PriceHistoryTableOrderingComposer,
          $$PriceHistoryTableAnnotationComposer,
          $$PriceHistoryTableCreateCompanionBuilder,
          $$PriceHistoryTableUpdateCompanionBuilder,
          (
            PriceHistoryData,
            BaseReferences<_$AppDatabase, $PriceHistoryTable, PriceHistoryData>,
          ),
          PriceHistoryData,
          PrefetchHooks Function()
        > {
  $$PriceHistoryTableTableManager(_$AppDatabase db, $PriceHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PriceHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PriceHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PriceHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subscriptionId = const Value.absent(),
                Value<double> oldPrice = const Value.absent(),
                Value<double> newPrice = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> effectiveDate = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PriceHistoryCompanion(
                id: id,
                subscriptionId: subscriptionId,
                oldPrice: oldPrice,
                newPrice: newPrice,
                currency: currency,
                effectiveDate: effectiveDate,
                reason: reason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subscriptionId,
                required double oldPrice,
                required double newPrice,
                required String currency,
                required DateTime effectiveDate,
                required String reason,
                Value<int> rowid = const Value.absent(),
              }) => PriceHistoryCompanion.insert(
                id: id,
                subscriptionId: subscriptionId,
                oldPrice: oldPrice,
                newPrice: newPrice,
                currency: currency,
                effectiveDate: effectiveDate,
                reason: reason,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PriceHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PriceHistoryTable,
      PriceHistoryData,
      $$PriceHistoryTableFilterComposer,
      $$PriceHistoryTableOrderingComposer,
      $$PriceHistoryTableAnnotationComposer,
      $$PriceHistoryTableCreateCompanionBuilder,
      $$PriceHistoryTableUpdateCompanionBuilder,
      (
        PriceHistoryData,
        BaseReferences<_$AppDatabase, $PriceHistoryTable, PriceHistoryData>,
      ),
      PriceHistoryData,
      PrefetchHooks Function()
    >;
typedef $$SubscriptionEventsTableCreateCompanionBuilder =
    SubscriptionEventsCompanion Function({
      required String id,
      required String subscriptionId,
      required String type,
      required DateTime at,
      required String title,
      Value<String?> detail,
      Value<int> rowid,
    });
typedef $$SubscriptionEventsTableUpdateCompanionBuilder =
    SubscriptionEventsCompanion Function({
      Value<String> id,
      Value<String> subscriptionId,
      Value<String> type,
      Value<DateTime> at,
      Value<String> title,
      Value<String?> detail,
      Value<int> rowid,
    });

class $$SubscriptionEventsTableFilterComposer
    extends Composer<_$AppDatabase, $SubscriptionEventsTable> {
  $$SubscriptionEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubscriptionEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubscriptionEventsTable> {
  $$SubscriptionEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubscriptionEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubscriptionEventsTable> {
  $$SubscriptionEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);
}

class $$SubscriptionEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubscriptionEventsTable,
          SubscriptionEvent,
          $$SubscriptionEventsTableFilterComposer,
          $$SubscriptionEventsTableOrderingComposer,
          $$SubscriptionEventsTableAnnotationComposer,
          $$SubscriptionEventsTableCreateCompanionBuilder,
          $$SubscriptionEventsTableUpdateCompanionBuilder,
          (
            SubscriptionEvent,
            BaseReferences<
              _$AppDatabase,
              $SubscriptionEventsTable,
              SubscriptionEvent
            >,
          ),
          SubscriptionEvent,
          PrefetchHooks Function()
        > {
  $$SubscriptionEventsTableTableManager(
    _$AppDatabase db,
    $SubscriptionEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subscriptionId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionEventsCompanion(
                id: id,
                subscriptionId: subscriptionId,
                type: type,
                at: at,
                title: title,
                detail: detail,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subscriptionId,
                required String type,
                required DateTime at,
                required String title,
                Value<String?> detail = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionEventsCompanion.insert(
                id: id,
                subscriptionId: subscriptionId,
                type: type,
                at: at,
                title: title,
                detail: detail,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubscriptionEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubscriptionEventsTable,
      SubscriptionEvent,
      $$SubscriptionEventsTableFilterComposer,
      $$SubscriptionEventsTableOrderingComposer,
      $$SubscriptionEventsTableAnnotationComposer,
      $$SubscriptionEventsTableCreateCompanionBuilder,
      $$SubscriptionEventsTableUpdateCompanionBuilder,
      (
        SubscriptionEvent,
        BaseReferences<
          _$AppDatabase,
          $SubscriptionEventsTable,
          SubscriptionEvent
        >,
      ),
      SubscriptionEvent,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      required String id,
      required String subscriptionId,
      required String kind,
      required String offsetKind,
      Value<int?> customDays,
      required DateTime fireAt,
      Value<bool> enabled,
      required int notificationId,
      Value<int> rowid,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<String> id,
      Value<String> subscriptionId,
      Value<String> kind,
      Value<String> offsetKind,
      Value<int?> customDays,
      Value<DateTime> fireAt,
      Value<bool> enabled,
      Value<int> notificationId,
      Value<int> rowid,
    });

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get offsetKind => $composableBuilder(
    column: $table.offsetKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customDays => $composableBuilder(
    column: $table.customDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get offsetKind => $composableBuilder(
    column: $table.offsetKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customDays => $composableBuilder(
    column: $table.customDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get offsetKind => $composableBuilder(
    column: $table.offsetKind,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customDays => $composableBuilder(
    column: $table.customDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fireAt =>
      $composableBuilder(column: $table.fireAt, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => column,
  );
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
          Reminder,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subscriptionId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> offsetKind = const Value.absent(),
                Value<int?> customDays = const Value.absent(),
                Value<DateTime> fireAt = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> notificationId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                subscriptionId: subscriptionId,
                kind: kind,
                offsetKind: offsetKind,
                customDays: customDays,
                fireAt: fireAt,
                enabled: enabled,
                notificationId: notificationId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subscriptionId,
                required String kind,
                required String offsetKind,
                Value<int?> customDays = const Value.absent(),
                required DateTime fireAt,
                Value<bool> enabled = const Value.absent(),
                required int notificationId,
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                subscriptionId: subscriptionId,
                kind: kind,
                offsetKind: offsetKind,
                customDays: customDays,
                fireAt: fireAt,
                enabled: enabled,
                notificationId: notificationId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
      Reminder,
      PrefetchHooks Function()
    >;
typedef $$CurrencyRatesTableCreateCompanionBuilder =
    CurrencyRatesCompanion Function({
      required String code,
      required double unitsPerUsd,
      required DateTime updatedAt,
      Value<bool> isManual,
      Value<int> rowid,
    });
typedef $$CurrencyRatesTableUpdateCompanionBuilder =
    CurrencyRatesCompanion Function({
      Value<String> code,
      Value<double> unitsPerUsd,
      Value<DateTime> updatedAt,
      Value<bool> isManual,
      Value<int> rowid,
    });

class $$CurrencyRatesTableFilterComposer
    extends Composer<_$AppDatabase, $CurrencyRatesTable> {
  $$CurrencyRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitsPerUsd => $composableBuilder(
    column: $table.unitsPerUsd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CurrencyRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CurrencyRatesTable> {
  $$CurrencyRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitsPerUsd => $composableBuilder(
    column: $table.unitsPerUsd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CurrencyRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurrencyRatesTable> {
  $$CurrencyRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<double> get unitsPerUsd => $composableBuilder(
    column: $table.unitsPerUsd,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isManual =>
      $composableBuilder(column: $table.isManual, builder: (column) => column);
}

class $$CurrencyRatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CurrencyRatesTable,
          CurrencyRate,
          $$CurrencyRatesTableFilterComposer,
          $$CurrencyRatesTableOrderingComposer,
          $$CurrencyRatesTableAnnotationComposer,
          $$CurrencyRatesTableCreateCompanionBuilder,
          $$CurrencyRatesTableUpdateCompanionBuilder,
          (
            CurrencyRate,
            BaseReferences<_$AppDatabase, $CurrencyRatesTable, CurrencyRate>,
          ),
          CurrencyRate,
          PrefetchHooks Function()
        > {
  $$CurrencyRatesTableTableManager(_$AppDatabase db, $CurrencyRatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurrencyRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurrencyRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurrencyRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<double> unitsPerUsd = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isManual = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrencyRatesCompanion(
                code: code,
                unitsPerUsd: unitsPerUsd,
                updatedAt: updatedAt,
                isManual: isManual,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required double unitsPerUsd,
                required DateTime updatedAt,
                Value<bool> isManual = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrencyRatesCompanion.insert(
                code: code,
                unitsPerUsd: unitsPerUsd,
                updatedAt: updatedAt,
                isManual: isManual,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CurrencyRatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CurrencyRatesTable,
      CurrencyRate,
      $$CurrencyRatesTableFilterComposer,
      $$CurrencyRatesTableOrderingComposer,
      $$CurrencyRatesTableAnnotationComposer,
      $$CurrencyRatesTableCreateCompanionBuilder,
      $$CurrencyRatesTableUpdateCompanionBuilder,
      (
        CurrencyRate,
        BaseReferences<_$AppDatabase, $CurrencyRatesTable, CurrencyRate>,
      ),
      CurrencyRate,
      PrefetchHooks Function()
    >;
typedef $$BudgetsTableCreateCompanionBuilder =
    BudgetsCompanion Function({
      required String id,
      required String scope,
      Value<String?> categoryId,
      Value<String?> profileId,
      required double monthlyAmount,
      required String currency,
      Value<int> rowid,
    });
typedef $$BudgetsTableUpdateCompanionBuilder =
    BudgetsCompanion Function({
      Value<String> id,
      Value<String> scope,
      Value<String?> categoryId,
      Value<String?> profileId,
      Value<double> monthlyAmount,
      Value<String> currency,
      Value<int> rowid,
    });

class $$BudgetsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlyAmount => $composableBuilder(
    column: $table.monthlyAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BudgetsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlyAmount => $composableBuilder(
    column: $table.monthlyAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<double> get monthlyAmount => $composableBuilder(
    column: $table.monthlyAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);
}

class $$BudgetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetsTable,
          Budget,
          $$BudgetsTableFilterComposer,
          $$BudgetsTableOrderingComposer,
          $$BudgetsTableAnnotationComposer,
          $$BudgetsTableCreateCompanionBuilder,
          $$BudgetsTableUpdateCompanionBuilder,
          (Budget, BaseReferences<_$AppDatabase, $BudgetsTable, Budget>),
          Budget,
          PrefetchHooks Function()
        > {
  $$BudgetsTableTableManager(_$AppDatabase db, $BudgetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> profileId = const Value.absent(),
                Value<double> monthlyAmount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetsCompanion(
                id: id,
                scope: scope,
                categoryId: categoryId,
                profileId: profileId,
                monthlyAmount: monthlyAmount,
                currency: currency,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String scope,
                Value<String?> categoryId = const Value.absent(),
                Value<String?> profileId = const Value.absent(),
                required double monthlyAmount,
                required String currency,
                Value<int> rowid = const Value.absent(),
              }) => BudgetsCompanion.insert(
                id: id,
                scope: scope,
                categoryId: categoryId,
                profileId: profileId,
                monthlyAmount: monthlyAmount,
                currency: currency,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BudgetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetsTable,
      Budget,
      $$BudgetsTableFilterComposer,
      $$BudgetsTableOrderingComposer,
      $$BudgetsTableAnnotationComposer,
      $$BudgetsTableCreateCompanionBuilder,
      $$BudgetsTableUpdateCompanionBuilder,
      (Budget, BaseReferences<_$AppDatabase, $BudgetsTable, Budget>),
      Budget,
      PrefetchHooks Function()
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      required String id,
      required String baseCurrency,
      required double foreignFeePercent,
      required String themePreset,
      Value<String?> customThemeJson,
      Value<bool> reduceMotion,
      Value<bool> biometricLock,
      Value<bool> hideAmounts,
      Value<int> cancelSafetyBufferDays,
      Value<bool> onboardingComplete,
      Value<bool> demoSeedEnabled,
      Value<String?> activeProfileId,
      Value<DateTime?> ratesUpdatedAt,
      Value<String?> lastFxError,
      Value<String> localeCode,
      Value<int> rowid,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<String> id,
      Value<String> baseCurrency,
      Value<double> foreignFeePercent,
      Value<String> themePreset,
      Value<String?> customThemeJson,
      Value<bool> reduceMotion,
      Value<bool> biometricLock,
      Value<bool> hideAmounts,
      Value<int> cancelSafetyBufferDays,
      Value<bool> onboardingComplete,
      Value<bool> demoSeedEnabled,
      Value<String?> activeProfileId,
      Value<DateTime?> ratesUpdatedAt,
      Value<String?> lastFxError,
      Value<String> localeCode,
      Value<int> rowid,
    });

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get foreignFeePercent => $composableBuilder(
    column: $table.foreignFeePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themePreset => $composableBuilder(
    column: $table.themePreset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customThemeJson => $composableBuilder(
    column: $table.customThemeJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reduceMotion => $composableBuilder(
    column: $table.reduceMotion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get biometricLock => $composableBuilder(
    column: $table.biometricLock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hideAmounts => $composableBuilder(
    column: $table.hideAmounts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cancelSafetyBufferDays => $composableBuilder(
    column: $table.cancelSafetyBufferDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get demoSeedEnabled => $composableBuilder(
    column: $table.demoSeedEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activeProfileId => $composableBuilder(
    column: $table.activeProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ratesUpdatedAt => $composableBuilder(
    column: $table.ratesUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastFxError => $composableBuilder(
    column: $table.lastFxError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get foreignFeePercent => $composableBuilder(
    column: $table.foreignFeePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themePreset => $composableBuilder(
    column: $table.themePreset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customThemeJson => $composableBuilder(
    column: $table.customThemeJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reduceMotion => $composableBuilder(
    column: $table.reduceMotion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get biometricLock => $composableBuilder(
    column: $table.biometricLock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hideAmounts => $composableBuilder(
    column: $table.hideAmounts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cancelSafetyBufferDays => $composableBuilder(
    column: $table.cancelSafetyBufferDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get demoSeedEnabled => $composableBuilder(
    column: $table.demoSeedEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activeProfileId => $composableBuilder(
    column: $table.activeProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ratesUpdatedAt => $composableBuilder(
    column: $table.ratesUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastFxError => $composableBuilder(
    column: $table.lastFxError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get foreignFeePercent => $composableBuilder(
    column: $table.foreignFeePercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themePreset => $composableBuilder(
    column: $table.themePreset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customThemeJson => $composableBuilder(
    column: $table.customThemeJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reduceMotion => $composableBuilder(
    column: $table.reduceMotion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get biometricLock => $composableBuilder(
    column: $table.biometricLock,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hideAmounts => $composableBuilder(
    column: $table.hideAmounts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cancelSafetyBufferDays => $composableBuilder(
    column: $table.cancelSafetyBufferDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get demoSeedEnabled => $composableBuilder(
    column: $table.demoSeedEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activeProfileId => $composableBuilder(
    column: $table.activeProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get ratesUpdatedAt => $composableBuilder(
    column: $table.ratesUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastFxError => $composableBuilder(
    column: $table.lastFxError,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => column,
  );
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreference,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (
            UserPreference,
            BaseReferences<
              _$AppDatabase,
              $UserPreferencesTable,
              UserPreference
            >,
          ),
          UserPreference,
          PrefetchHooks Function()
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<double> foreignFeePercent = const Value.absent(),
                Value<String> themePreset = const Value.absent(),
                Value<String?> customThemeJson = const Value.absent(),
                Value<bool> reduceMotion = const Value.absent(),
                Value<bool> biometricLock = const Value.absent(),
                Value<bool> hideAmounts = const Value.absent(),
                Value<int> cancelSafetyBufferDays = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<bool> demoSeedEnabled = const Value.absent(),
                Value<String?> activeProfileId = const Value.absent(),
                Value<DateTime?> ratesUpdatedAt = const Value.absent(),
                Value<String?> lastFxError = const Value.absent(),
                Value<String> localeCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion(
                id: id,
                baseCurrency: baseCurrency,
                foreignFeePercent: foreignFeePercent,
                themePreset: themePreset,
                customThemeJson: customThemeJson,
                reduceMotion: reduceMotion,
                biometricLock: biometricLock,
                hideAmounts: hideAmounts,
                cancelSafetyBufferDays: cancelSafetyBufferDays,
                onboardingComplete: onboardingComplete,
                demoSeedEnabled: demoSeedEnabled,
                activeProfileId: activeProfileId,
                ratesUpdatedAt: ratesUpdatedAt,
                lastFxError: lastFxError,
                localeCode: localeCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String baseCurrency,
                required double foreignFeePercent,
                required String themePreset,
                Value<String?> customThemeJson = const Value.absent(),
                Value<bool> reduceMotion = const Value.absent(),
                Value<bool> biometricLock = const Value.absent(),
                Value<bool> hideAmounts = const Value.absent(),
                Value<int> cancelSafetyBufferDays = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<bool> demoSeedEnabled = const Value.absent(),
                Value<String?> activeProfileId = const Value.absent(),
                Value<DateTime?> ratesUpdatedAt = const Value.absent(),
                Value<String?> lastFxError = const Value.absent(),
                Value<String> localeCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                id: id,
                baseCurrency: baseCurrency,
                foreignFeePercent: foreignFeePercent,
                themePreset: themePreset,
                customThemeJson: customThemeJson,
                reduceMotion: reduceMotion,
                biometricLock: biometricLock,
                hideAmounts: hideAmounts,
                cancelSafetyBufferDays: cancelSafetyBufferDays,
                onboardingComplete: onboardingComplete,
                demoSeedEnabled: demoSeedEnabled,
                activeProfileId: activeProfileId,
                ratesUpdatedAt: ratesUpdatedAt,
                lastFxError: lastFxError,
                localeCode: localeCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreference,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (
        UserPreference,
        BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreference>,
      ),
      UserPreference,
      PrefetchHooks Function()
    >;
typedef $$AppThemeRowsTableCreateCompanionBuilder =
    AppThemeRowsCompanion Function({
      required String id,
      required String name,
      required String json,
      Value<int> rowid,
    });
typedef $$AppThemeRowsTableUpdateCompanionBuilder =
    AppThemeRowsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> json,
      Value<int> rowid,
    });

class $$AppThemeRowsTableFilterComposer
    extends Composer<_$AppDatabase, $AppThemeRowsTable> {
  $$AppThemeRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppThemeRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppThemeRowsTable> {
  $$AppThemeRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppThemeRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppThemeRowsTable> {
  $$AppThemeRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => column);
}

class $$AppThemeRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppThemeRowsTable,
          AppThemeRow,
          $$AppThemeRowsTableFilterComposer,
          $$AppThemeRowsTableOrderingComposer,
          $$AppThemeRowsTableAnnotationComposer,
          $$AppThemeRowsTableCreateCompanionBuilder,
          $$AppThemeRowsTableUpdateCompanionBuilder,
          (
            AppThemeRow,
            BaseReferences<_$AppDatabase, $AppThemeRowsTable, AppThemeRow>,
          ),
          AppThemeRow,
          PrefetchHooks Function()
        > {
  $$AppThemeRowsTableTableManager(_$AppDatabase db, $AppThemeRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppThemeRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppThemeRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppThemeRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> json = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppThemeRowsCompanion(
                id: id,
                name: name,
                json: json,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String json,
                Value<int> rowid = const Value.absent(),
              }) => AppThemeRowsCompanion.insert(
                id: id,
                name: name,
                json: json,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppThemeRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppThemeRowsTable,
      AppThemeRow,
      $$AppThemeRowsTableFilterComposer,
      $$AppThemeRowsTableOrderingComposer,
      $$AppThemeRowsTableAnnotationComposer,
      $$AppThemeRowsTableCreateCompanionBuilder,
      $$AppThemeRowsTableUpdateCompanionBuilder,
      (
        AppThemeRow,
        BaseReferences<_$AppDatabase, $AppThemeRowsTable, AppThemeRow>,
      ),
      AppThemeRow,
      PrefetchHooks Function()
    >;
typedef $$PurchaseOrdersTableCreateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      required String id,
      required String profileId,
      required String platform,
      required String title,
      Value<int> quantity,
      required String status,
      required DateTime orderedAt,
      Value<DateTime?> expectedAt,
      Value<DateTime?> deliveredAt,
      Value<DateTime?> reminderAt,
      Value<double?> price,
      Value<String?> currency,
      Value<String?> trackingUrl,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PurchaseOrdersTableUpdateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> platform,
      Value<String> title,
      Value<int> quantity,
      Value<String> status,
      Value<DateTime> orderedAt,
      Value<DateTime?> expectedAt,
      Value<DateTime?> deliveredAt,
      Value<DateTime?> reminderAt,
      Value<double?> price,
      Value<String?> currency,
      Value<String?> trackingUrl,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PurchaseOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get orderedAt => $composableBuilder(
    column: $table.orderedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedAt => $composableBuilder(
    column: $table.expectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deliveredAt => $composableBuilder(
    column: $table.deliveredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reminderAt => $composableBuilder(
    column: $table.reminderAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackingUrl => $composableBuilder(
    column: $table.trackingUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get orderedAt => $composableBuilder(
    column: $table.orderedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedAt => $composableBuilder(
    column: $table.expectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deliveredAt => $composableBuilder(
    column: $table.deliveredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reminderAt => $composableBuilder(
    column: $table.reminderAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackingUrl => $composableBuilder(
    column: $table.trackingUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get orderedAt =>
      $composableBuilder(column: $table.orderedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expectedAt => $composableBuilder(
    column: $table.expectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deliveredAt => $composableBuilder(
    column: $table.deliveredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reminderAt => $composableBuilder(
    column: $table.reminderAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get trackingUrl => $composableBuilder(
    column: $table.trackingUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PurchaseOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrdersTable,
          PurchaseOrder,
          $$PurchaseOrdersTableFilterComposer,
          $$PurchaseOrdersTableOrderingComposer,
          $$PurchaseOrdersTableAnnotationComposer,
          $$PurchaseOrdersTableCreateCompanionBuilder,
          $$PurchaseOrdersTableUpdateCompanionBuilder,
          (
            PurchaseOrder,
            BaseReferences<_$AppDatabase, $PurchaseOrdersTable, PurchaseOrder>,
          ),
          PurchaseOrder,
          PrefetchHooks Function()
        > {
  $$PurchaseOrdersTableTableManager(
    _$AppDatabase db,
    $PurchaseOrdersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> platform = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> orderedAt = const Value.absent(),
                Value<DateTime?> expectedAt = const Value.absent(),
                Value<DateTime?> deliveredAt = const Value.absent(),
                Value<DateTime?> reminderAt = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<String?> trackingUrl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrdersCompanion(
                id: id,
                profileId: profileId,
                platform: platform,
                title: title,
                quantity: quantity,
                status: status,
                orderedAt: orderedAt,
                expectedAt: expectedAt,
                deliveredAt: deliveredAt,
                reminderAt: reminderAt,
                price: price,
                currency: currency,
                trackingUrl: trackingUrl,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String platform,
                required String title,
                Value<int> quantity = const Value.absent(),
                required String status,
                required DateTime orderedAt,
                Value<DateTime?> expectedAt = const Value.absent(),
                Value<DateTime?> deliveredAt = const Value.absent(),
                Value<DateTime?> reminderAt = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<String?> trackingUrl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrdersCompanion.insert(
                id: id,
                profileId: profileId,
                platform: platform,
                title: title,
                quantity: quantity,
                status: status,
                orderedAt: orderedAt,
                expectedAt: expectedAt,
                deliveredAt: deliveredAt,
                reminderAt: reminderAt,
                price: price,
                currency: currency,
                trackingUrl: trackingUrl,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrdersTable,
      PurchaseOrder,
      $$PurchaseOrdersTableFilterComposer,
      $$PurchaseOrdersTableOrderingComposer,
      $$PurchaseOrdersTableAnnotationComposer,
      $$PurchaseOrdersTableCreateCompanionBuilder,
      $$PurchaseOrdersTableUpdateCompanionBuilder,
      (
        PurchaseOrder,
        BaseReferences<_$AppDatabase, $PurchaseOrdersTable, PurchaseOrder>,
      ),
      PurchaseOrder,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserAccountsTableTableManager get userAccounts =>
      $$UserAccountsTableTableManager(_db, _db.userAccounts);
  $$LinkedIdentitiesTableTableManager get linkedIdentities =>
      $$LinkedIdentitiesTableTableManager(_db, _db.linkedIdentities);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ServicesTableTableManager get services =>
      $$ServicesTableTableManager(_db, _db.services);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db, _db.plans);
  $$PaymentMethodsTableTableManager get paymentMethods =>
      $$PaymentMethodsTableTableManager(_db, _db.paymentMethods);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db, _db.subscriptions);
  $$PricePhasesTableTableManager get pricePhases =>
      $$PricePhasesTableTableManager(_db, _db.pricePhases);
  $$PaymentRecordsTableTableManager get paymentRecords =>
      $$PaymentRecordsTableTableManager(_db, _db.paymentRecords);
  $$PriceHistoryTableTableManager get priceHistory =>
      $$PriceHistoryTableTableManager(_db, _db.priceHistory);
  $$SubscriptionEventsTableTableManager get subscriptionEvents =>
      $$SubscriptionEventsTableTableManager(_db, _db.subscriptionEvents);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$CurrencyRatesTableTableManager get currencyRates =>
      $$CurrencyRatesTableTableManager(_db, _db.currencyRates);
  $$BudgetsTableTableManager get budgets =>
      $$BudgetsTableTableManager(_db, _db.budgets);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$AppThemeRowsTableTableManager get appThemeRows =>
      $$AppThemeRowsTableTableManager(_db, _db.appThemeRows);
  $$PurchaseOrdersTableTableManager get purchaseOrders =>
      $$PurchaseOrdersTableTableManager(_db, _db.purchaseOrders);
}
