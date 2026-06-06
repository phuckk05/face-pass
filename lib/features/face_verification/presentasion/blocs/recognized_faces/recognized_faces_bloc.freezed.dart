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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecognizedFacesInitialState value)?  initial,TResult Function( RecognizedFacesHasDataState value)?  hasData,TResult Function( RecognizedFacesErrorState value)?  error,TResult Function( RecognizedFacesLoadingState value)?  loading,TResult Function( _RecognizedFacesEmptyState value)?  empty,TResult Function( RecognizedFacesSuccessState value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecognizedFacesInitialState() when initial != null:
return initial(_that);case RecognizedFacesHasDataState() when hasData != null:
return hasData(_that);case RecognizedFacesErrorState() when error != null:
return error(_that);case RecognizedFacesLoadingState() when loading != null:
return loading(_that);case _RecognizedFacesEmptyState() when empty != null:
return empty(_that);case RecognizedFacesSuccessState() when success != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecognizedFacesInitialState value)  initial,required TResult Function( RecognizedFacesHasDataState value)  hasData,required TResult Function( RecognizedFacesErrorState value)  error,required TResult Function( RecognizedFacesLoadingState value)  loading,required TResult Function( _RecognizedFacesEmptyState value)  empty,required TResult Function( RecognizedFacesSuccessState value)  success,}){
final _that = this;
switch (_that) {
case RecognizedFacesInitialState():
return initial(_that);case RecognizedFacesHasDataState():
return hasData(_that);case RecognizedFacesErrorState():
return error(_that);case RecognizedFacesLoadingState():
return loading(_that);case _RecognizedFacesEmptyState():
return empty(_that);case RecognizedFacesSuccessState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecognizedFacesInitialState value)?  initial,TResult? Function( RecognizedFacesHasDataState value)?  hasData,TResult? Function( RecognizedFacesErrorState value)?  error,TResult? Function( RecognizedFacesLoadingState value)?  loading,TResult? Function( _RecognizedFacesEmptyState value)?  empty,TResult? Function( RecognizedFacesSuccessState value)?  success,}){
final _that = this;
switch (_that) {
case RecognizedFacesInitialState() when initial != null:
return initial(_that);case RecognizedFacesHasDataState() when hasData != null:
return hasData(_that);case RecognizedFacesErrorState() when error != null:
return error(_that);case RecognizedFacesLoadingState() when loading != null:
return loading(_that);case _RecognizedFacesEmptyState() when empty != null:
return empty(_that);case RecognizedFacesSuccessState() when success != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<FaceEmbedding> recognizedFaces)?  hasData,TResult Function( String? message,  List<FaceEmbedding> faces)?  error,TResult Function( List<FaceEmbedding> faces)?  loading,TResult Function()?  empty,TResult Function( FaceEmbedding embedding)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecognizedFacesInitialState() when initial != null:
return initial();case RecognizedFacesHasDataState() when hasData != null:
return hasData(_that.recognizedFaces);case RecognizedFacesErrorState() when error != null:
return error(_that.message,_that.faces);case RecognizedFacesLoadingState() when loading != null:
return loading(_that.faces);case _RecognizedFacesEmptyState() when empty != null:
return empty();case RecognizedFacesSuccessState() when success != null:
return success(_that.embedding);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<FaceEmbedding> recognizedFaces)  hasData,required TResult Function( String? message,  List<FaceEmbedding> faces)  error,required TResult Function( List<FaceEmbedding> faces)  loading,required TResult Function()  empty,required TResult Function( FaceEmbedding embedding)  success,}) {final _that = this;
switch (_that) {
case RecognizedFacesInitialState():
return initial();case RecognizedFacesHasDataState():
return hasData(_that.recognizedFaces);case RecognizedFacesErrorState():
return error(_that.message,_that.faces);case RecognizedFacesLoadingState():
return loading(_that.faces);case _RecognizedFacesEmptyState():
return empty();case RecognizedFacesSuccessState():
return success(_that.embedding);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<FaceEmbedding> recognizedFaces)?  hasData,TResult? Function( String? message,  List<FaceEmbedding> faces)?  error,TResult? Function( List<FaceEmbedding> faces)?  loading,TResult? Function()?  empty,TResult? Function( FaceEmbedding embedding)?  success,}) {final _that = this;
switch (_that) {
case RecognizedFacesInitialState() when initial != null:
return initial();case RecognizedFacesHasDataState() when hasData != null:
return hasData(_that.recognizedFaces);case RecognizedFacesErrorState() when error != null:
return error(_that.message,_that.faces);case RecognizedFacesLoadingState() when loading != null:
return loading(_that.faces);case _RecognizedFacesEmptyState() when empty != null:
return empty();case RecognizedFacesSuccessState() when success != null:
return success(_that.embedding);case _:
  return null;

}
}

}

/// @nodoc


class RecognizedFacesInitialState implements RecognizedFacesState {
  const RecognizedFacesInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizedFacesInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecognizedFacesState.initial()';
}


}




/// @nodoc


class RecognizedFacesHasDataState implements RecognizedFacesState {
  const RecognizedFacesHasDataState({required final  List<FaceEmbedding> recognizedFaces}): _recognizedFaces = recognizedFaces;
  

 final  List<FaceEmbedding> _recognizedFaces;
 List<FaceEmbedding> get recognizedFaces {
  if (_recognizedFaces is EqualUnmodifiableListView) return _recognizedFaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recognizedFaces);
}


/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizedFacesHasDataStateCopyWith<RecognizedFacesHasDataState> get copyWith => _$RecognizedFacesHasDataStateCopyWithImpl<RecognizedFacesHasDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizedFacesHasDataState&&const DeepCollectionEquality().equals(other._recognizedFaces, _recognizedFaces));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_recognizedFaces));

@override
String toString() {
  return 'RecognizedFacesState.hasData(recognizedFaces: $recognizedFaces)';
}


}

/// @nodoc
abstract mixin class $RecognizedFacesHasDataStateCopyWith<$Res> implements $RecognizedFacesStateCopyWith<$Res> {
  factory $RecognizedFacesHasDataStateCopyWith(RecognizedFacesHasDataState value, $Res Function(RecognizedFacesHasDataState) _then) = _$RecognizedFacesHasDataStateCopyWithImpl;
@useResult
$Res call({
 List<FaceEmbedding> recognizedFaces
});




}
/// @nodoc
class _$RecognizedFacesHasDataStateCopyWithImpl<$Res>
    implements $RecognizedFacesHasDataStateCopyWith<$Res> {
  _$RecognizedFacesHasDataStateCopyWithImpl(this._self, this._then);

  final RecognizedFacesHasDataState _self;
  final $Res Function(RecognizedFacesHasDataState) _then;

/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recognizedFaces = null,}) {
  return _then(RecognizedFacesHasDataState(
recognizedFaces: null == recognizedFaces ? _self._recognizedFaces : recognizedFaces // ignore: cast_nullable_to_non_nullable
as List<FaceEmbedding>,
  ));
}


}

/// @nodoc


class RecognizedFacesErrorState implements RecognizedFacesState {
  const RecognizedFacesErrorState({this.message, final  List<FaceEmbedding> faces = const []}): _faces = faces;
  

 final  String? message;
 final  List<FaceEmbedding> _faces;
@JsonKey() List<FaceEmbedding> get faces {
  if (_faces is EqualUnmodifiableListView) return _faces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faces);
}


/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizedFacesErrorStateCopyWith<RecognizedFacesErrorState> get copyWith => _$RecognizedFacesErrorStateCopyWithImpl<RecognizedFacesErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizedFacesErrorState&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._faces, _faces));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_faces));

@override
String toString() {
  return 'RecognizedFacesState.error(message: $message, faces: $faces)';
}


}

/// @nodoc
abstract mixin class $RecognizedFacesErrorStateCopyWith<$Res> implements $RecognizedFacesStateCopyWith<$Res> {
  factory $RecognizedFacesErrorStateCopyWith(RecognizedFacesErrorState value, $Res Function(RecognizedFacesErrorState) _then) = _$RecognizedFacesErrorStateCopyWithImpl;
@useResult
$Res call({
 String? message, List<FaceEmbedding> faces
});




}
/// @nodoc
class _$RecognizedFacesErrorStateCopyWithImpl<$Res>
    implements $RecognizedFacesErrorStateCopyWith<$Res> {
  _$RecognizedFacesErrorStateCopyWithImpl(this._self, this._then);

  final RecognizedFacesErrorState _self;
  final $Res Function(RecognizedFacesErrorState) _then;

/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? faces = null,}) {
  return _then(RecognizedFacesErrorState(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,faces: null == faces ? _self._faces : faces // ignore: cast_nullable_to_non_nullable
as List<FaceEmbedding>,
  ));
}


}

/// @nodoc


class RecognizedFacesLoadingState implements RecognizedFacesState {
  const RecognizedFacesLoadingState({final  List<FaceEmbedding> faces = const []}): _faces = faces;
  

 final  List<FaceEmbedding> _faces;
@JsonKey() List<FaceEmbedding> get faces {
  if (_faces is EqualUnmodifiableListView) return _faces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faces);
}


/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizedFacesLoadingStateCopyWith<RecognizedFacesLoadingState> get copyWith => _$RecognizedFacesLoadingStateCopyWithImpl<RecognizedFacesLoadingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizedFacesLoadingState&&const DeepCollectionEquality().equals(other._faces, _faces));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_faces));

@override
String toString() {
  return 'RecognizedFacesState.loading(faces: $faces)';
}


}

/// @nodoc
abstract mixin class $RecognizedFacesLoadingStateCopyWith<$Res> implements $RecognizedFacesStateCopyWith<$Res> {
  factory $RecognizedFacesLoadingStateCopyWith(RecognizedFacesLoadingState value, $Res Function(RecognizedFacesLoadingState) _then) = _$RecognizedFacesLoadingStateCopyWithImpl;
@useResult
$Res call({
 List<FaceEmbedding> faces
});




}
/// @nodoc
class _$RecognizedFacesLoadingStateCopyWithImpl<$Res>
    implements $RecognizedFacesLoadingStateCopyWith<$Res> {
  _$RecognizedFacesLoadingStateCopyWithImpl(this._self, this._then);

  final RecognizedFacesLoadingState _self;
  final $Res Function(RecognizedFacesLoadingState) _then;

/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? faces = null,}) {
  return _then(RecognizedFacesLoadingState(
faces: null == faces ? _self._faces : faces // ignore: cast_nullable_to_non_nullable
as List<FaceEmbedding>,
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




/// @nodoc


class RecognizedFacesSuccessState implements RecognizedFacesState {
  const RecognizedFacesSuccessState({required this.embedding});
  

 final  FaceEmbedding embedding;

/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizedFacesSuccessStateCopyWith<RecognizedFacesSuccessState> get copyWith => _$RecognizedFacesSuccessStateCopyWithImpl<RecognizedFacesSuccessState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizedFacesSuccessState&&(identical(other.embedding, embedding) || other.embedding == embedding));
}


@override
int get hashCode => Object.hash(runtimeType,embedding);

@override
String toString() {
  return 'RecognizedFacesState.success(embedding: $embedding)';
}


}

/// @nodoc
abstract mixin class $RecognizedFacesSuccessStateCopyWith<$Res> implements $RecognizedFacesStateCopyWith<$Res> {
  factory $RecognizedFacesSuccessStateCopyWith(RecognizedFacesSuccessState value, $Res Function(RecognizedFacesSuccessState) _then) = _$RecognizedFacesSuccessStateCopyWithImpl;
@useResult
$Res call({
 FaceEmbedding embedding
});




}
/// @nodoc
class _$RecognizedFacesSuccessStateCopyWithImpl<$Res>
    implements $RecognizedFacesSuccessStateCopyWith<$Res> {
  _$RecognizedFacesSuccessStateCopyWithImpl(this._self, this._then);

  final RecognizedFacesSuccessState _self;
  final $Res Function(RecognizedFacesSuccessState) _then;

/// Create a copy of RecognizedFacesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? embedding = null,}) {
  return _then(RecognizedFacesSuccessState(
embedding: null == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as FaceEmbedding,
  ));
}


}

// dart format on
