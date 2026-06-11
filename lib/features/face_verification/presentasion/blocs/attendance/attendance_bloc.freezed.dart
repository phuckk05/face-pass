// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceState()';
}


}

/// @nodoc
class $AttendanceStateCopyWith<$Res>  {
$AttendanceStateCopyWith(AttendanceState _, $Res Function(AttendanceState) __);
}


/// Adds pattern-matching-related methods to [AttendanceState].
extension AttendanceStatePatterns on AttendanceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AttendanceInitial value)?  initial,TResult Function( AttendanceLoading value)?  loading,TResult Function( AttendanceSuccess value)?  success,TResult Function( AttendanceSuccessHasData value)?  successHasData,TResult Function( AttendanceFailed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AttendanceInitial() when initial != null:
return initial(_that);case AttendanceLoading() when loading != null:
return loading(_that);case AttendanceSuccess() when success != null:
return success(_that);case AttendanceSuccessHasData() when successHasData != null:
return successHasData(_that);case AttendanceFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AttendanceInitial value)  initial,required TResult Function( AttendanceLoading value)  loading,required TResult Function( AttendanceSuccess value)  success,required TResult Function( AttendanceSuccessHasData value)  successHasData,required TResult Function( AttendanceFailed value)  failed,}){
final _that = this;
switch (_that) {
case AttendanceInitial():
return initial(_that);case AttendanceLoading():
return loading(_that);case AttendanceSuccess():
return success(_that);case AttendanceSuccessHasData():
return successHasData(_that);case AttendanceFailed():
return failed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AttendanceInitial value)?  initial,TResult? Function( AttendanceLoading value)?  loading,TResult? Function( AttendanceSuccess value)?  success,TResult? Function( AttendanceSuccessHasData value)?  successHasData,TResult? Function( AttendanceFailed value)?  failed,}){
final _that = this;
switch (_that) {
case AttendanceInitial() when initial != null:
return initial(_that);case AttendanceLoading() when loading != null:
return loading(_that);case AttendanceSuccess() when success != null:
return success(_that);case AttendanceSuccessHasData() when successHasData != null:
return successHasData(_that);case AttendanceFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message)?  initial,TResult Function( String message)?  loading,TResult Function( String message)?  success,TResult Function( List<Attendance> attendances)?  successHasData,TResult Function( String message)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AttendanceInitial() when initial != null:
return initial(_that.message);case AttendanceLoading() when loading != null:
return loading(_that.message);case AttendanceSuccess() when success != null:
return success(_that.message);case AttendanceSuccessHasData() when successHasData != null:
return successHasData(_that.attendances);case AttendanceFailed() when failed != null:
return failed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message)  initial,required TResult Function( String message)  loading,required TResult Function( String message)  success,required TResult Function( List<Attendance> attendances)  successHasData,required TResult Function( String message)  failed,}) {final _that = this;
switch (_that) {
case AttendanceInitial():
return initial(_that.message);case AttendanceLoading():
return loading(_that.message);case AttendanceSuccess():
return success(_that.message);case AttendanceSuccessHasData():
return successHasData(_that.attendances);case AttendanceFailed():
return failed(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message)?  initial,TResult? Function( String message)?  loading,TResult? Function( String message)?  success,TResult? Function( List<Attendance> attendances)?  successHasData,TResult? Function( String message)?  failed,}) {final _that = this;
switch (_that) {
case AttendanceInitial() when initial != null:
return initial(_that.message);case AttendanceLoading() when loading != null:
return loading(_that.message);case AttendanceSuccess() when success != null:
return success(_that.message);case AttendanceSuccessHasData() when successHasData != null:
return successHasData(_that.attendances);case AttendanceFailed() when failed != null:
return failed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AttendanceInitial implements AttendanceState {
  const AttendanceInitial({required this.message});
  

 final  String? message;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceInitialCopyWith<AttendanceInitial> get copyWith => _$AttendanceInitialCopyWithImpl<AttendanceInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceInitial&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AttendanceState.initial(message: $message)';
}


}

/// @nodoc
abstract mixin class $AttendanceInitialCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $AttendanceInitialCopyWith(AttendanceInitial value, $Res Function(AttendanceInitial) _then) = _$AttendanceInitialCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$AttendanceInitialCopyWithImpl<$Res>
    implements $AttendanceInitialCopyWith<$Res> {
  _$AttendanceInitialCopyWithImpl(this._self, this._then);

  final AttendanceInitial _self;
  final $Res Function(AttendanceInitial) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(AttendanceInitial(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AttendanceLoading implements AttendanceState {
  const AttendanceLoading({required this.message});
  

 final  String message;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceLoadingCopyWith<AttendanceLoading> get copyWith => _$AttendanceLoadingCopyWithImpl<AttendanceLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceLoading&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AttendanceState.loading(message: $message)';
}


}

/// @nodoc
abstract mixin class $AttendanceLoadingCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $AttendanceLoadingCopyWith(AttendanceLoading value, $Res Function(AttendanceLoading) _then) = _$AttendanceLoadingCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AttendanceLoadingCopyWithImpl<$Res>
    implements $AttendanceLoadingCopyWith<$Res> {
  _$AttendanceLoadingCopyWithImpl(this._self, this._then);

  final AttendanceLoading _self;
  final $Res Function(AttendanceLoading) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AttendanceLoading(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AttendanceSuccess implements AttendanceState {
  const AttendanceSuccess({required this.message});
  

 final  String message;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceSuccessCopyWith<AttendanceSuccess> get copyWith => _$AttendanceSuccessCopyWithImpl<AttendanceSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AttendanceState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class $AttendanceSuccessCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $AttendanceSuccessCopyWith(AttendanceSuccess value, $Res Function(AttendanceSuccess) _then) = _$AttendanceSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AttendanceSuccessCopyWithImpl<$Res>
    implements $AttendanceSuccessCopyWith<$Res> {
  _$AttendanceSuccessCopyWithImpl(this._self, this._then);

  final AttendanceSuccess _self;
  final $Res Function(AttendanceSuccess) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AttendanceSuccess(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AttendanceSuccessHasData implements AttendanceState {
  const AttendanceSuccessHasData({required final  List<Attendance> attendances}): _attendances = attendances;
  

 final  List<Attendance> _attendances;
 List<Attendance> get attendances {
  if (_attendances is EqualUnmodifiableListView) return _attendances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attendances);
}


/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceSuccessHasDataCopyWith<AttendanceSuccessHasData> get copyWith => _$AttendanceSuccessHasDataCopyWithImpl<AttendanceSuccessHasData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceSuccessHasData&&const DeepCollectionEquality().equals(other._attendances, _attendances));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_attendances));

@override
String toString() {
  return 'AttendanceState.successHasData(attendances: $attendances)';
}


}

/// @nodoc
abstract mixin class $AttendanceSuccessHasDataCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $AttendanceSuccessHasDataCopyWith(AttendanceSuccessHasData value, $Res Function(AttendanceSuccessHasData) _then) = _$AttendanceSuccessHasDataCopyWithImpl;
@useResult
$Res call({
 List<Attendance> attendances
});




}
/// @nodoc
class _$AttendanceSuccessHasDataCopyWithImpl<$Res>
    implements $AttendanceSuccessHasDataCopyWith<$Res> {
  _$AttendanceSuccessHasDataCopyWithImpl(this._self, this._then);

  final AttendanceSuccessHasData _self;
  final $Res Function(AttendanceSuccessHasData) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? attendances = null,}) {
  return _then(AttendanceSuccessHasData(
attendances: null == attendances ? _self._attendances : attendances // ignore: cast_nullable_to_non_nullable
as List<Attendance>,
  ));
}


}

/// @nodoc


class AttendanceFailed implements AttendanceState {
  const AttendanceFailed({required this.message});
  

 final  String message;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceFailedCopyWith<AttendanceFailed> get copyWith => _$AttendanceFailedCopyWithImpl<AttendanceFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AttendanceState.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class $AttendanceFailedCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $AttendanceFailedCopyWith(AttendanceFailed value, $Res Function(AttendanceFailed) _then) = _$AttendanceFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AttendanceFailedCopyWithImpl<$Res>
    implements $AttendanceFailedCopyWith<$Res> {
  _$AttendanceFailedCopyWithImpl(this._self, this._then);

  final AttendanceFailed _self;
  final $Res Function(AttendanceFailed) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AttendanceFailed(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
