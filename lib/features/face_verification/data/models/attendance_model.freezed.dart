// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceModel {

 String get id; String get userId; DateTime get checkedAt; AttendanceType get type; AttendanceStatus get status; double get similarity;
/// Create a copy of AttendanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceModelCopyWith<AttendanceModel> get copyWith => _$AttendanceModelCopyWithImpl<AttendanceModel>(this as AttendanceModel, _$identity);

  /// Serializes this AttendanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.similarity, similarity) || other.similarity == similarity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,checkedAt,type,status,similarity);

@override
String toString() {
  return 'AttendanceModel(id: $id, userId: $userId, checkedAt: $checkedAt, type: $type, status: $status, similarity: $similarity)';
}


}

/// @nodoc
abstract mixin class $AttendanceModelCopyWith<$Res>  {
  factory $AttendanceModelCopyWith(AttendanceModel value, $Res Function(AttendanceModel) _then) = _$AttendanceModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, DateTime checkedAt, AttendanceType type, AttendanceStatus status, double similarity
});




}
/// @nodoc
class _$AttendanceModelCopyWithImpl<$Res>
    implements $AttendanceModelCopyWith<$Res> {
  _$AttendanceModelCopyWithImpl(this._self, this._then);

  final AttendanceModel _self;
  final $Res Function(AttendanceModel) _then;

/// Create a copy of AttendanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? checkedAt = null,Object? type = null,Object? status = null,Object? similarity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,checkedAt: null == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AttendanceType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceModel].
extension AttendanceModelPatterns on AttendanceModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime checkedAt,  AttendanceType type,  AttendanceStatus status,  double similarity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceModel() when $default != null:
return $default(_that.id,_that.userId,_that.checkedAt,_that.type,_that.status,_that.similarity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime checkedAt,  AttendanceType type,  AttendanceStatus status,  double similarity)  $default,) {final _that = this;
switch (_that) {
case _AttendanceModel():
return $default(_that.id,_that.userId,_that.checkedAt,_that.type,_that.status,_that.similarity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  DateTime checkedAt,  AttendanceType type,  AttendanceStatus status,  double similarity)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceModel() when $default != null:
return $default(_that.id,_that.userId,_that.checkedAt,_that.type,_that.status,_that.similarity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceModel implements AttendanceModel {
  const _AttendanceModel({required this.id, required this.userId, required this.checkedAt, required this.type, required this.status, required this.similarity});
  factory _AttendanceModel.fromJson(Map<String, dynamic> json) => _$AttendanceModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  DateTime checkedAt;
@override final  AttendanceType type;
@override final  AttendanceStatus status;
@override final  double similarity;

/// Create a copy of AttendanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceModelCopyWith<_AttendanceModel> get copyWith => __$AttendanceModelCopyWithImpl<_AttendanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.similarity, similarity) || other.similarity == similarity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,checkedAt,type,status,similarity);

@override
String toString() {
  return 'AttendanceModel(id: $id, userId: $userId, checkedAt: $checkedAt, type: $type, status: $status, similarity: $similarity)';
}


}

/// @nodoc
abstract mixin class _$AttendanceModelCopyWith<$Res> implements $AttendanceModelCopyWith<$Res> {
  factory _$AttendanceModelCopyWith(_AttendanceModel value, $Res Function(_AttendanceModel) _then) = __$AttendanceModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, DateTime checkedAt, AttendanceType type, AttendanceStatus status, double similarity
});




}
/// @nodoc
class __$AttendanceModelCopyWithImpl<$Res>
    implements _$AttendanceModelCopyWith<$Res> {
  __$AttendanceModelCopyWithImpl(this._self, this._then);

  final _AttendanceModel _self;
  final $Res Function(_AttendanceModel) _then;

/// Create a copy of AttendanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? checkedAt = null,Object? type = null,Object? status = null,Object? similarity = null,}) {
  return _then(_AttendanceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,checkedAt: null == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AttendanceType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
