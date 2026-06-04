// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recognizing_face_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecognizingFaceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizingFaceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecognizingFaceState()';
}


}

/// @nodoc
class $RecognizingFaceStateCopyWith<$Res>  {
$RecognizingFaceStateCopyWith(RecognizingFaceState _, $Res Function(RecognizingFaceState) __);
}


/// Adds pattern-matching-related methods to [RecognizingFaceState].
extension RecognizingFaceStatePatterns on RecognizingFaceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RecognizingFaceInitial value)?  initial,TResult Function( _RecognizingFaceProcessing value)?  processing,TResult Function( _RecognizingFaceFailed value)?  failed,TResult Function( _RecognizingFaceSuccess value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecognizingFaceInitial() when initial != null:
return initial(_that);case _RecognizingFaceProcessing() when processing != null:
return processing(_that);case _RecognizingFaceFailed() when failed != null:
return failed(_that);case _RecognizingFaceSuccess() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RecognizingFaceInitial value)  initial,required TResult Function( _RecognizingFaceProcessing value)  processing,required TResult Function( _RecognizingFaceFailed value)  failed,required TResult Function( _RecognizingFaceSuccess value)  success,}){
final _that = this;
switch (_that) {
case _RecognizingFaceInitial():
return initial(_that);case _RecognizingFaceProcessing():
return processing(_that);case _RecognizingFaceFailed():
return failed(_that);case _RecognizingFaceSuccess():
return success(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RecognizingFaceInitial value)?  initial,TResult? Function( _RecognizingFaceProcessing value)?  processing,TResult? Function( _RecognizingFaceFailed value)?  failed,TResult? Function( _RecognizingFaceSuccess value)?  success,}){
final _that = this;
switch (_that) {
case _RecognizingFaceInitial() when initial != null:
return initial(_that);case _RecognizingFaceProcessing() when processing != null:
return processing(_that);case _RecognizingFaceFailed() when failed != null:
return failed(_that);case _RecognizingFaceSuccess() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? messge)?  initial,TResult Function( String messge)?  processing,TResult Function( String message)?  failed,TResult Function( List<double> embedding,  String? messge)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecognizingFaceInitial() when initial != null:
return initial(_that.messge);case _RecognizingFaceProcessing() when processing != null:
return processing(_that.messge);case _RecognizingFaceFailed() when failed != null:
return failed(_that.message);case _RecognizingFaceSuccess() when success != null:
return success(_that.embedding,_that.messge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? messge)  initial,required TResult Function( String messge)  processing,required TResult Function( String message)  failed,required TResult Function( List<double> embedding,  String? messge)  success,}) {final _that = this;
switch (_that) {
case _RecognizingFaceInitial():
return initial(_that.messge);case _RecognizingFaceProcessing():
return processing(_that.messge);case _RecognizingFaceFailed():
return failed(_that.message);case _RecognizingFaceSuccess():
return success(_that.embedding,_that.messge);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? messge)?  initial,TResult? Function( String messge)?  processing,TResult? Function( String message)?  failed,TResult? Function( List<double> embedding,  String? messge)?  success,}) {final _that = this;
switch (_that) {
case _RecognizingFaceInitial() when initial != null:
return initial(_that.messge);case _RecognizingFaceProcessing() when processing != null:
return processing(_that.messge);case _RecognizingFaceFailed() when failed != null:
return failed(_that.message);case _RecognizingFaceSuccess() when success != null:
return success(_that.embedding,_that.messge);case _:
  return null;

}
}

}

/// @nodoc


class _RecognizingFaceInitial implements RecognizingFaceState {
  const _RecognizingFaceInitial({required this.messge});
  

 final  String? messge;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecognizingFaceInitialCopyWith<_RecognizingFaceInitial> get copyWith => __$RecognizingFaceInitialCopyWithImpl<_RecognizingFaceInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognizingFaceInitial&&(identical(other.messge, messge) || other.messge == messge));
}


@override
int get hashCode => Object.hash(runtimeType,messge);

@override
String toString() {
  return 'RecognizingFaceState.initial(messge: $messge)';
}


}

/// @nodoc
abstract mixin class _$RecognizingFaceInitialCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory _$RecognizingFaceInitialCopyWith(_RecognizingFaceInitial value, $Res Function(_RecognizingFaceInitial) _then) = __$RecognizingFaceInitialCopyWithImpl;
@useResult
$Res call({
 String? messge
});




}
/// @nodoc
class __$RecognizingFaceInitialCopyWithImpl<$Res>
    implements _$RecognizingFaceInitialCopyWith<$Res> {
  __$RecognizingFaceInitialCopyWithImpl(this._self, this._then);

  final _RecognizingFaceInitial _self;
  final $Res Function(_RecognizingFaceInitial) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messge = freezed,}) {
  return _then(_RecognizingFaceInitial(
messge: freezed == messge ? _self.messge : messge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RecognizingFaceProcessing implements RecognizingFaceState {
  const _RecognizingFaceProcessing({required this.messge});
  

 final  String messge;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecognizingFaceProcessingCopyWith<_RecognizingFaceProcessing> get copyWith => __$RecognizingFaceProcessingCopyWithImpl<_RecognizingFaceProcessing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognizingFaceProcessing&&(identical(other.messge, messge) || other.messge == messge));
}


@override
int get hashCode => Object.hash(runtimeType,messge);

@override
String toString() {
  return 'RecognizingFaceState.processing(messge: $messge)';
}


}

/// @nodoc
abstract mixin class _$RecognizingFaceProcessingCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory _$RecognizingFaceProcessingCopyWith(_RecognizingFaceProcessing value, $Res Function(_RecognizingFaceProcessing) _then) = __$RecognizingFaceProcessingCopyWithImpl;
@useResult
$Res call({
 String messge
});




}
/// @nodoc
class __$RecognizingFaceProcessingCopyWithImpl<$Res>
    implements _$RecognizingFaceProcessingCopyWith<$Res> {
  __$RecognizingFaceProcessingCopyWithImpl(this._self, this._then);

  final _RecognizingFaceProcessing _self;
  final $Res Function(_RecognizingFaceProcessing) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messge = null,}) {
  return _then(_RecognizingFaceProcessing(
messge: null == messge ? _self.messge : messge // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RecognizingFaceFailed implements RecognizingFaceState {
  const _RecognizingFaceFailed({required this.message});
  

 final  String message;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecognizingFaceFailedCopyWith<_RecognizingFaceFailed> get copyWith => __$RecognizingFaceFailedCopyWithImpl<_RecognizingFaceFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognizingFaceFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RecognizingFaceState.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$RecognizingFaceFailedCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory _$RecognizingFaceFailedCopyWith(_RecognizingFaceFailed value, $Res Function(_RecognizingFaceFailed) _then) = __$RecognizingFaceFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$RecognizingFaceFailedCopyWithImpl<$Res>
    implements _$RecognizingFaceFailedCopyWith<$Res> {
  __$RecognizingFaceFailedCopyWithImpl(this._self, this._then);

  final _RecognizingFaceFailed _self;
  final $Res Function(_RecognizingFaceFailed) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_RecognizingFaceFailed(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RecognizingFaceSuccess implements RecognizingFaceState {
  const _RecognizingFaceSuccess({required final  List<double> embedding, required this.messge}): _embedding = embedding;
  

 final  List<double> _embedding;
 List<double> get embedding {
  if (_embedding is EqualUnmodifiableListView) return _embedding;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_embedding);
}

 final  String? messge;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecognizingFaceSuccessCopyWith<_RecognizingFaceSuccess> get copyWith => __$RecognizingFaceSuccessCopyWithImpl<_RecognizingFaceSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognizingFaceSuccess&&const DeepCollectionEquality().equals(other._embedding, _embedding)&&(identical(other.messge, messge) || other.messge == messge));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_embedding),messge);

@override
String toString() {
  return 'RecognizingFaceState.success(embedding: $embedding, messge: $messge)';
}


}

/// @nodoc
abstract mixin class _$RecognizingFaceSuccessCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory _$RecognizingFaceSuccessCopyWith(_RecognizingFaceSuccess value, $Res Function(_RecognizingFaceSuccess) _then) = __$RecognizingFaceSuccessCopyWithImpl;
@useResult
$Res call({
 List<double> embedding, String? messge
});




}
/// @nodoc
class __$RecognizingFaceSuccessCopyWithImpl<$Res>
    implements _$RecognizingFaceSuccessCopyWith<$Res> {
  __$RecognizingFaceSuccessCopyWithImpl(this._self, this._then);

  final _RecognizingFaceSuccess _self;
  final $Res Function(_RecognizingFaceSuccess) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? embedding = null,Object? messge = freezed,}) {
  return _then(_RecognizingFaceSuccess(
embedding: null == embedding ? _self._embedding : embedding // ignore: cast_nullable_to_non_nullable
as List<double>,messge: freezed == messge ? _self.messge : messge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
