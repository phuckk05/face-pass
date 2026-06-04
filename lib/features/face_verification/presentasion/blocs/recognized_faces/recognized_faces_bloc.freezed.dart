// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recognized_faces_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecognizedFacesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizedFacesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecognizedFacesState()';
}


}

/// @nodoc
class $RecognizedFacesStateCopyWith<$Res>  {
$RecognizedFacesStateCopyWith(RecognizedFacesState _, $Res Function(RecognizedFacesState) __);
}


/// Adds pattern-matching-related methods to [RecognizedFacesState].
extension RecognizedFacesStatePatterns on RecognizedFacesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RecognizedFacesInitialState value)?  initial,TResult Function( _RecognizedFacesHasDataState value)?  hasData,TResult Function( _RecognizedFacesErrorState value)?  error,TResult Function( _RecognizedFacesLoadingState value)?  loading,TResult Function( _RecognizedFacesEmptyState value)?  empty,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecognizedFacesInitialState() when initial != null:
return initial(_that);case _RecognizedFacesHasDataState() when hasData != null:
return hasData(_that);case _RecognizedFacesErrorState() when error != null:
return error(_that);case _RecognizedFacesLoadingState() when loading != null:
return loading(_that);case _RecognizedFacesEmptyState() when empty != null:
return empty(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RecognizedFacesInitialState value)  initial,required TResult Function( _RecognizedFacesHasDataState value)  hasData,required TResult Function( _RecognizedFacesErrorState value)  error,required TResult Function( _RecognizedFacesLoadingState value)  loading,required TResult Function( _RecognizedFacesEmptyState value)  empty,}){
final _that = this;
switch (_that) {
case _RecognizedFacesInitialState():
return initial(_that);case _RecognizedFacesHasDataState():
return hasData(_that);case _RecognizedFacesErrorState():
return error(_that);case _RecognizedFacesLoadingState():
return loading(_that);case _RecognizedFacesEmptyState():
return empty(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RecognizedFacesInitialState value)?  initial,TResult? Function( _RecognizedFacesHasDataState value)?  hasData,TResult? Function( _RecognizedFacesErrorState value)?  error,TResult? Function( _RecognizedFacesLoadingState value)?  loading,TResult? Function( _RecognizedFacesEmptyState value)?  empty,}){
final _that = this;
switch (_that) {
case _RecognizedFacesInitialState() when initial != null:
return initial(_that);case _RecognizedFacesHasDataState() when hasData != null:
return hasData(_that);case _RecognizedFacesErrorState() when error != null:
return error(_that);case _RecognizedFacesLoadingState() when loading != null:
return loading(_that);case _RecognizedFacesEmptyState() when empty != null:
return empty(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<List<double>> recognizedFaces)?  hasData,TResult Function( String? message,  List<List<double>> faces)?  error,TResult Function( List<List<double>> faces)?  loading,TResult Function()?  empty,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecognizedFacesInitialState() when initial != null:
return initial();case _RecognizedFacesHasDataState() when hasData != null:
return hasData(_that.recognizedFaces);case _RecognizedFacesErrorState() when error != null:
return error(_that.message,_that.faces);case _RecognizedFacesLoadingState() when loading != null:
return loading(_that.faces);case _RecognizedFacesEmptyState() when empty != null:
return empty();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<List<double>> recognizedFaces)  hasData,required TResult Function( String? message,  List<List<double>> faces)  error,required TResult Function( List<List<double>> faces)  loading,required TResult Function()  empty,}) {final _that = this;
switch (_that) {
case _RecognizedFacesInitialState():
return initial();case _RecognizedFacesHasDataState():
return hasData(_that.recognizedFaces);case _RecognizedFacesErrorState():
return error(_that.message,_that.faces);case _RecognizedFacesLoadingState():
return loading(_that.faces);case _RecognizedFacesEmptyState():
return empty();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<List<double>> recognizedFaces)?  hasData,TResult? Function( String? message,  List<List<double>> faces)?  error,TResult? Function( List<List<double>> faces)?  loading,TResult? Function()?  empty,}) {final _that = this;
switch (_that) {
case _RecognizedFacesInitialState() when initial != null:
return initial();case _RecognizedFacesHasDataState() when hasData != null:
return hasData(_that.recognizedFaces);case _RecognizedFacesErrorState() when error != null:
return error(_that.message,_that.faces);case _RecognizedFacesLoadingState() when loading != null:
return loading(_that.faces);case _RecognizedFacesEmptyState() when empty != null:
return empty();case _:
  return null;

}
}

}

/// @nodoc


class _RecognizedFacesInitialState implements RecognizedFacesState {
  const _RecognizedFacesInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognizedFacesInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecognizedFacesState.initial()';
}


}




/// @nodoc


class _RecognizedFacesHasDataState implements RecognizedFacesState {
  const _RecognizedFacesHasDataState({required final  List<List<double>> recognizedFaces}): _recognizedFaces = recognizedFaces;
  

 final  List<List<double>> _recognizedFaces;
 List<List<double>> get recognizedFaces {
  if (_recognizedFaces is EqualUnmodifiableListView) return _recognizedFaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recognizedFaces);
}


/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecognizedFacesHasDataStateCopyWith<_RecognizedFacesHasDataState> get copyWith => __$RecognizedFacesHasDataStateCopyWithImpl<_RecognizedFacesHasDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognizedFacesHasDataState&&const DeepCollectionEquality().equals(other._recognizedFaces, _recognizedFaces));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_recognizedFaces));

@override
String toString() {
  return 'RecognizedFacesState.hasData(recognizedFaces: $recognizedFaces)';
}


}

/// @nodoc
abstract mixin class _$RecognizedFacesHasDataStateCopyWith<$Res> implements $RecognizedFacesStateCopyWith<$Res> {
  factory _$RecognizedFacesHasDataStateCopyWith(_RecognizedFacesHasDataState value, $Res Function(_RecognizedFacesHasDataState) _then) = __$RecognizedFacesHasDataStateCopyWithImpl;
@useResult
$Res call({
 List<List<double>> recognizedFaces
});




}
/// @nodoc
class __$RecognizedFacesHasDataStateCopyWithImpl<$Res>
    implements _$RecognizedFacesHasDataStateCopyWith<$Res> {
  __$RecognizedFacesHasDataStateCopyWithImpl(this._self, this._then);

  final _RecognizedFacesHasDataState _self;
  final $Res Function(_RecognizedFacesHasDataState) _then;

/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recognizedFaces = null,}) {
  return _then(_RecognizedFacesHasDataState(
recognizedFaces: null == recognizedFaces ? _self._recognizedFaces : recognizedFaces // ignore: cast_nullable_to_non_nullable
as List<List<double>>,
  ));
}


}

/// @nodoc


class _RecognizedFacesErrorState implements RecognizedFacesState {
  const _RecognizedFacesErrorState({this.message, final  List<List<double>> faces = const []}): _faces = faces;
  

 final  String? message;
 final  List<List<double>> _faces;
@JsonKey() List<List<double>> get faces {
  if (_faces is EqualUnmodifiableListView) return _faces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faces);
}


/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecognizedFacesErrorStateCopyWith<_RecognizedFacesErrorState> get copyWith => __$RecognizedFacesErrorStateCopyWithImpl<_RecognizedFacesErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognizedFacesErrorState&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._faces, _faces));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_faces));

@override
String toString() {
  return 'RecognizedFacesState.error(message: $message, faces: $faces)';
}


}

/// @nodoc
abstract mixin class _$RecognizedFacesErrorStateCopyWith<$Res> implements $RecognizedFacesStateCopyWith<$Res> {
  factory _$RecognizedFacesErrorStateCopyWith(_RecognizedFacesErrorState value, $Res Function(_RecognizedFacesErrorState) _then) = __$RecognizedFacesErrorStateCopyWithImpl;
@useResult
$Res call({
 String? message, List<List<double>> faces
});




}
/// @nodoc
class __$RecognizedFacesErrorStateCopyWithImpl<$Res>
    implements _$RecognizedFacesErrorStateCopyWith<$Res> {
  __$RecognizedFacesErrorStateCopyWithImpl(this._self, this._then);

  final _RecognizedFacesErrorState _self;
  final $Res Function(_RecognizedFacesErrorState) _then;

/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? faces = null,}) {
  return _then(_RecognizedFacesErrorState(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,faces: null == faces ? _self._faces : faces // ignore: cast_nullable_to_non_nullable
as List<List<double>>,
  ));
}


}

/// @nodoc


class _RecognizedFacesLoadingState implements RecognizedFacesState {
  const _RecognizedFacesLoadingState({final  List<List<double>> faces = const []}): _faces = faces;
  

 final  List<List<double>> _faces;
@JsonKey() List<List<double>> get faces {
  if (_faces is EqualUnmodifiableListView) return _faces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faces);
}


/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecognizedFacesLoadingStateCopyWith<_RecognizedFacesLoadingState> get copyWith => __$RecognizedFacesLoadingStateCopyWithImpl<_RecognizedFacesLoadingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognizedFacesLoadingState&&const DeepCollectionEquality().equals(other._faces, _faces));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_faces));

@override
String toString() {
  return 'RecognizedFacesState.loading(faces: $faces)';
}


}

/// @nodoc
abstract mixin class _$RecognizedFacesLoadingStateCopyWith<$Res> implements $RecognizedFacesStateCopyWith<$Res> {
  factory _$RecognizedFacesLoadingStateCopyWith(_RecognizedFacesLoadingState value, $Res Function(_RecognizedFacesLoadingState) _then) = __$RecognizedFacesLoadingStateCopyWithImpl;
@useResult
$Res call({
 List<List<double>> faces
});




}
/// @nodoc
class __$RecognizedFacesLoadingStateCopyWithImpl<$Res>
    implements _$RecognizedFacesLoadingStateCopyWith<$Res> {
  __$RecognizedFacesLoadingStateCopyWithImpl(this._self, this._then);

  final _RecognizedFacesLoadingState _self;
  final $Res Function(_RecognizedFacesLoadingState) _then;

/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? faces = null,}) {
  return _then(_RecognizedFacesLoadingState(
faces: null == faces ? _self._faces : faces // ignore: cast_nullable_to_non_nullable
as List<List<double>>,
  ));
}


}

/// @nodoc


class _RecognizedFacesEmptyState implements RecognizedFacesState {
  const _RecognizedFacesEmptyState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognizedFacesEmptyState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecognizedFacesState.empty()';
}


}




// dart format on
