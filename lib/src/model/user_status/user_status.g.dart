// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserStatusCollection on Isar {
  IsarCollection<UserStatus> get userStatus => this.collection();
}

const UserStatusSchema = CollectionSchema(
  name: r'UserStatus',
  id: 4963325340625490452,
  properties: {
    r'isUserLoggedIn': PropertySchema(
      id: 0,
      name: r'isUserLoggedIn',
      type: IsarType.bool,
    ),
    r'isVolunteer': PropertySchema(
      id: 1,
      name: r'isVolunteer',
      type: IsarType.bool,
    )
  },
  estimateSize: _userStatusEstimateSize,
  serialize: _userStatusSerialize,
  deserialize: _userStatusDeserialize,
  deserializeProp: _userStatusDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userStatusGetId,
  getLinks: _userStatusGetLinks,
  attach: _userStatusAttach,
  version: '3.1.0+1',
);

int _userStatusEstimateSize(
  UserStatus object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _userStatusSerialize(
  UserStatus object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isUserLoggedIn);
  writer.writeBool(offsets[1], object.isVolunteer);
}

UserStatus _userStatusDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserStatus();
  object.id = id;
  object.isUserLoggedIn = reader.readBool(offsets[0]);
  object.isVolunteer = reader.readBool(offsets[1]);
  return object;
}

P _userStatusDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userStatusGetId(UserStatus object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userStatusGetLinks(UserStatus object) {
  return [];
}

void _userStatusAttach(IsarCollection<dynamic> col, Id id, UserStatus object) {
  object.id = id;
}

extension UserStatusQueryWhereSort
    on QueryBuilder<UserStatus, UserStatus, QWhere> {
  QueryBuilder<UserStatus, UserStatus, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserStatusQueryWhere
    on QueryBuilder<UserStatus, UserStatus, QWhereClause> {
  QueryBuilder<UserStatus, UserStatus, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserStatusQueryFilter
    on QueryBuilder<UserStatus, UserStatus, QFilterCondition> {
  QueryBuilder<UserStatus, UserStatus, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterFilterCondition>
      isUserLoggedInEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUserLoggedIn',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterFilterCondition>
      isVolunteerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVolunteer',
        value: value,
      ));
    });
  }
}

extension UserStatusQueryObject
    on QueryBuilder<UserStatus, UserStatus, QFilterCondition> {}

extension UserStatusQueryLinks
    on QueryBuilder<UserStatus, UserStatus, QFilterCondition> {}

extension UserStatusQuerySortBy
    on QueryBuilder<UserStatus, UserStatus, QSortBy> {
  QueryBuilder<UserStatus, UserStatus, QAfterSortBy> sortByIsUserLoggedIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserLoggedIn', Sort.asc);
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterSortBy>
      sortByIsUserLoggedInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserLoggedIn', Sort.desc);
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterSortBy> sortByIsVolunteer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVolunteer', Sort.asc);
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterSortBy> sortByIsVolunteerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVolunteer', Sort.desc);
    });
  }
}

extension UserStatusQuerySortThenBy
    on QueryBuilder<UserStatus, UserStatus, QSortThenBy> {
  QueryBuilder<UserStatus, UserStatus, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterSortBy> thenByIsUserLoggedIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserLoggedIn', Sort.asc);
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterSortBy>
      thenByIsUserLoggedInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserLoggedIn', Sort.desc);
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterSortBy> thenByIsVolunteer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVolunteer', Sort.asc);
    });
  }

  QueryBuilder<UserStatus, UserStatus, QAfterSortBy> thenByIsVolunteerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVolunteer', Sort.desc);
    });
  }
}

extension UserStatusQueryWhereDistinct
    on QueryBuilder<UserStatus, UserStatus, QDistinct> {
  QueryBuilder<UserStatus, UserStatus, QDistinct> distinctByIsUserLoggedIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUserLoggedIn');
    });
  }

  QueryBuilder<UserStatus, UserStatus, QDistinct> distinctByIsVolunteer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isVolunteer');
    });
  }
}

extension UserStatusQueryProperty
    on QueryBuilder<UserStatus, UserStatus, QQueryProperty> {
  QueryBuilder<UserStatus, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserStatus, bool, QQueryOperations> isUserLoggedInProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUserLoggedIn');
    });
  }

  QueryBuilder<UserStatus, bool, QQueryOperations> isVolunteerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVolunteer');
    });
  }
}
