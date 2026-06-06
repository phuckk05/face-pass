// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_embedding_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FaceEmbeddingModel {

 String get id; String get userId; List<double> get vector1; List<double> get vector2; List<double> get vector3; List<double> get vector4; List<double> get vector5; DateTime get registeredAt;
/// Create a copy of FaceEmbeddingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceEmbeddingModelCopyWith<FaceEmbeddingModel> get copyWith => _$FaceEmbeddingModelCopyWithImpl<FaceEmbeddingModel>(this as FaceEmbeddingModel, _$identity);

  /// Serializes this FaceEmbeddingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceEmbeddingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.vector1, vector1)&&const DeepCollectionEquality().equals(other.vector2, vector2)&&const DeepCollectionEquality().equals(other.vector3, vector3)&&const DeepCollectionEquality().equals(other.vector4, vector4)&&const DeepCollectionEquality().equals(other.vector5, vector5)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,const DeepCollectionEquality().hash(vector1),const DeepCollectionEquality().hash(vector2),const DeepCollectionEquality().hash(vector3),const DeepCollectionEquality().hash(vector4),const DeepCollectionEquality().hash(vector5),registeredAt);

@override
String toString() {
  return 'FaceEmbeddingModel(id: $id, userId: $userId, vector1: $vector1, vector2: $vector2, vector3: $vector3, vector4: $vector4, vector5: $vector5, registeredAt: $registeredAt)';
}


}

/// @nodoc
abstract mixin class $FaceEmbeddingModelCopyWith<$Res>  {
  factory $FaceEmbeddingModelCopyWith(FaceEmbeddingModel value, $Res Function(FaceEmbeddingModel) _then) = _$FaceEmbeddingModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, List<double> vector1, List<double> vector2, List<double> vector3, List<double> vector4, List<double> vector5, DateTime registeredAt
});




}
/// @nodoc
class _$FaceEmbeddingModelCopyWithImpl<$Res>
    implements $FaceEmbeddingModelCopyWith<$Res> {
  _$FaceEmbeddingModelCopyWithImpl(this._self, this._then);

  final FaceEmbeddingModel _self;
  final $Res Function(FaceEmbeddingModel) _then;

/// Create a copy of FaceEmbeddingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? vector1 = null,Object? vector2 = null,Object? vector3 = null,Object? vector4 = null,Object? vector5 = null,Object? registeredAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,vector1: null == vector1 ? _self.vector1 : vector1 // ignore: cast_nullable_to_non_nullable
as List<double>,vector2: null == vector2 ? _self.vector2 : vector2 // ignore: cast_nullable_to_non_nullable
as List<double>,vector3: null == vector3 ? _self.vector3 : vector3 // ignore: cast_nullable_to_non_nullable
as List<double>,vector4: null == vector4 ? _self.vector4 : vector4 // ignore: cast_nullable_to_non_nullable
as List<double>,vector5: null == vector5 ? _self.vector5 : vector5 // ignore: cast_nullable_to_non_nullable
as List<double>,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FaceEmbeddingModel].
extension FaceEmbeddingModelPatterns on FaceEmbeddingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaceEmbeddingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaceEmbeddingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaceEmbeddingModel value)  $default,){
final _that = this;
switch (_that) {
case _FaceEmbeddingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaceEmbeddingModel value)?  $default,){
final _that = this;
switch (_that) {
case _FaceEmbeddingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  List<double> vector1,  List<double> vector2,  List<double> vector3,  List<double> vector4,  List<double> vector5,  DateTime registeredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaceEmbeddingModel() when $default != null:
return $default(_that.id,_that.userId,_that.vector1,_that.vector2,_that.vector3,_that.vector4,_that.vector5,_that.registeredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  List<double> vector1,  List<double> vector2,  List<double> vector3,  List<double> vector4,  List<double> vector5,  DateTime registeredAt)  $default,) {final _that = this;
switch (_that) {
case _FaceEmbeddingModel():
return $default(_that.id,_that.userId,_that.vector1,_that.vector2,_that.vector3,_that.vector4,_that.vector5,_that.registeredAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  List<double> vector1,  List<double> vector2,  List<double> vector3,  List<double> vector4,  List<double> vector5,  DateTime registeredAt)?  $default,) {final _that = this;
switch (_that) {
case _FaceEmbeddingModel() when $default != null:
return $default(_that.id,_that.userId,_that.vector1,_that.vector2,_that.vector3,_that.vector4,_that.vector5,_that.registeredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FaceEmbeddingModel implements FaceEmbeddingModel {
  const _FaceEmbeddingModel({required this.id, required this.userId, required final  List<double> vector1, required final  List<double> vector2, required final  List<double> vector3, required final  List<double> vector4, required final  List<double> vector5, required this.registeredAt}): _vector1 = vector1,_vector2 = vector2,_vector3 = vector3,_vector4 = vector4,_vector5 = vector5;
  factory _FaceEmbeddingModel.fromJson(Map<String, dynamic> json) => _$FaceEmbeddingModelFromJson(json);

@override final  String id;
@override final  String userId;
 final  List<double> _vector1;
@override List<double> get vector1 {
  if (_vector1 is EqualUnmodifiableListView) return _vector1;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vector1);
}

 final  List<double> _vector2;
@override List<double> get vector2 {
  if (_vector2 is EqualUnmodifiableListView) return _vector2;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vector2);
}

 final  List<double> _vector3;
@override List<double> get vector3 {
  if (_vector3 is EqualUnmodifiableListView) return _vector3;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vector3);
}

 final  List<double> _vector4;
@override List<double> get vector4 {
  if (_vector4 is EqualUnmodifiableListView) return _vector4;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vector4);
}

 final  List<double> _vector5;
@override List<double> get vector5 {
  if (_vector5 is EqualUnmodifiableListView) return _vector5;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vector5);
}

@override final  DateTime registeredAt;

/// Create a copy of FaceEmbeddingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaceEmbeddingModelCopyWith<_FaceEmbeddingModel> get copyWith => __$FaceEmbeddingModelCopyWithImpl<_FaceEmbeddingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FaceEmbeddingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaceEmbeddingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._vector1, _vector1)&&const DeepCollectionEquality().equals(other._vector2, _vector2)&&const DeepCollectionEquality().equals(other._vector3, _vector3)&&const DeepCollectionEquality().equals(other._vector4, _vector4)&&const DeepCollectionEquality().equals(other._vector5, _vector5)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,const DeepCollectionEquality().hash(_vector1),const DeepCollectionEquality().hash(_vector2),const DeepCollectionEquality().hash(_vector3),const DeepCollectionEquality().hash(_vector4),const DeepCollectionEquality().hash(_vector5),registeredAt);

@override
String toString() {
  return 'FaceEmbeddingModel(id: $id, userId: $userId, vector1: $vector1, vector2: $vector2, vector3: $vector3, vector4: $vector4, vector5: $vector5, registeredAt: $registeredAt)';
}


}

/// @nodoc
abstract mixin class _$FaceEmbeddingModelCopyWith<$Res> implements $FaceEmbeddingModelCopyWith<$Res> {
  factory _$FaceEmbeddingModelCopyWith(_FaceEmbeddingModel value, $Res Function(_FaceEmbeddingModel) _then) = __$FaceEmbeddingModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, List<double> vector1, List<double> vector2, List<double> vector3, List<double> vector4, List<double> vector5, DateTime registeredAt
});




}
/// @nodoc
class __$FaceEmbeddingModelCopyWithImpl<$Res>
    implements _$FaceEmbeddingModelCopyWith<$Res> {
  __$FaceEmbeddingModelCopyWithImpl(this._self, this._then);

  final _FaceEmbeddingModel _self;
  final $Res Function(_FaceEmbeddingModel) _then;

/// Create a copy of FaceEmbeddingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? vector1 = null,Object? vector2 = null,Object? vector3 = null,Object? vector4 = null,Object? vector5 = null,Object? registeredAt = null,}) {
  return _then(_FaceEmbeddingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,vector1: null == vector1 ? _self._vector1 : vector1 // ignore: cast_nullable_to_non_nullable
as List<double>,vector2: null == vector2 ? _self._vector2 : vector2 // ignore: cast_nullable_to_non_nullable
as List<double>,vector3: null == vector3 ? _self._vector3 : vector3 // ignore: cast_nullable_to_non_nullable
as List<double>,vector4: null == vector4 ? _self._vector4 : vector4 // ignore: cast_nullable_to_non_nullable
as List<double>,vector5: null == vector5 ? _self._vector5 : vector5 // ignore: cast_nullable_to_non_nullable
as List<double>,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
