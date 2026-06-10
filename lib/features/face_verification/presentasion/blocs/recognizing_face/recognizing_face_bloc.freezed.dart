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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecognizingFaceInitial value)?  initial,TResult Function( RecognizingFaceProcessing value)?  processing,TResult Function( RecognizingFaceFailed value)?  failed,TResult Function( RecognizingFaceProcessingErrol value)?  processingErrol,TResult Function( RecognizingFaceProcessingUpdate value)?  processingUpdate,TResult Function( RecognizingFaceSuccess value)?  success,TResult Function( RecognizingFaceSimilaritySuccess value)?  similaritySuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecognizingFaceInitial() when initial != null:
return initial(_that);case RecognizingFaceProcessing() when processing != null:
return processing(_that);case RecognizingFaceFailed() when failed != null:
return failed(_that);case RecognizingFaceProcessingErrol() when processingErrol != null:
return processingErrol(_that);case RecognizingFaceProcessingUpdate() when processingUpdate != null:
return processingUpdate(_that);case RecognizingFaceSuccess() when success != null:
return success(_that);case RecognizingFaceSimilaritySuccess() when similaritySuccess != null:
return similaritySuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecognizingFaceInitial value)  initial,required TResult Function( RecognizingFaceProcessing value)  processing,required TResult Function( RecognizingFaceFailed value)  failed,required TResult Function( RecognizingFaceProcessingErrol value)  processingErrol,required TResult Function( RecognizingFaceProcessingUpdate value)  processingUpdate,required TResult Function( RecognizingFaceSuccess value)  success,required TResult Function( RecognizingFaceSimilaritySuccess value)  similaritySuccess,}){
final _that = this;
switch (_that) {
case RecognizingFaceInitial():
return initial(_that);case RecognizingFaceProcessing():
return processing(_that);case RecognizingFaceFailed():
return failed(_that);case RecognizingFaceProcessingErrol():
return processingErrol(_that);case RecognizingFaceProcessingUpdate():
return processingUpdate(_that);case RecognizingFaceSuccess():
return success(_that);case RecognizingFaceSimilaritySuccess():
return similaritySuccess(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecognizingFaceInitial value)?  initial,TResult? Function( RecognizingFaceProcessing value)?  processing,TResult? Function( RecognizingFaceFailed value)?  failed,TResult? Function( RecognizingFaceProcessingErrol value)?  processingErrol,TResult? Function( RecognizingFaceProcessingUpdate value)?  processingUpdate,TResult? Function( RecognizingFaceSuccess value)?  success,TResult? Function( RecognizingFaceSimilaritySuccess value)?  similaritySuccess,}){
final _that = this;
switch (_that) {
case RecognizingFaceInitial() when initial != null:
return initial(_that);case RecognizingFaceProcessing() when processing != null:
return processing(_that);case RecognizingFaceFailed() when failed != null:
return failed(_that);case RecognizingFaceProcessingErrol() when processingErrol != null:
return processingErrol(_that);case RecognizingFaceProcessingUpdate() when processingUpdate != null:
return processingUpdate(_that);case RecognizingFaceSuccess() when success != null:
return success(_that);case RecognizingFaceSimilaritySuccess() when similaritySuccess != null:
return similaritySuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? messge)?  initial,TResult Function( String messge)?  processing,TResult Function( String message)?  failed,TResult Function( String message)?  processingErrol,TResult Function( FaceEmbedding embedding,  String? message)?  processingUpdate,TResult Function( FaceEmbedding embedding,  String? messge)?  success,TResult Function( FaceEmbedding embedding,  String? messge)?  similaritySuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecognizingFaceInitial() when initial != null:
return initial(_that.messge);case RecognizingFaceProcessing() when processing != null:
return processing(_that.messge);case RecognizingFaceFailed() when failed != null:
return failed(_that.message);case RecognizingFaceProcessingErrol() when processingErrol != null:
return processingErrol(_that.message);case RecognizingFaceProcessingUpdate() when processingUpdate != null:
return processingUpdate(_that.embedding,_that.message);case RecognizingFaceSuccess() when success != null:
return success(_that.embedding,_that.messge);case RecognizingFaceSimilaritySuccess() when similaritySuccess != null:
return similaritySuccess(_that.embedding,_that.messge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? messge)  initial,required TResult Function( String messge)  processing,required TResult Function( String message)  failed,required TResult Function( String message)  processingErrol,required TResult Function( FaceEmbedding embedding,  String? message)  processingUpdate,required TResult Function( FaceEmbedding embedding,  String? messge)  success,required TResult Function( FaceEmbedding embedding,  String? messge)  similaritySuccess,}) {final _that = this;
switch (_that) {
case RecognizingFaceInitial():
return initial(_that.messge);case RecognizingFaceProcessing():
return processing(_that.messge);case RecognizingFaceFailed():
return failed(_that.message);case RecognizingFaceProcessingErrol():
return processingErrol(_that.message);case RecognizingFaceProcessingUpdate():
return processingUpdate(_that.embedding,_that.message);case RecognizingFaceSuccess():
return success(_that.embedding,_that.messge);case RecognizingFaceSimilaritySuccess():
return similaritySuccess(_that.embedding,_that.messge);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? messge)?  initial,TResult? Function( String messge)?  processing,TResult? Function( String message)?  failed,TResult? Function( String message)?  processingErrol,TResult? Function( FaceEmbedding embedding,  String? message)?  processingUpdate,TResult? Function( FaceEmbedding embedding,  String? messge)?  success,TResult? Function( FaceEmbedding embedding,  String? messge)?  similaritySuccess,}) {final _that = this;
switch (_that) {
case RecognizingFaceInitial() when initial != null:
return initial(_that.messge);case RecognizingFaceProcessing() when processing != null:
return processing(_that.messge);case RecognizingFaceFailed() when failed != null:
return failed(_that.message);case RecognizingFaceProcessingErrol() when processingErrol != null:
return processingErrol(_that.message);case RecognizingFaceProcessingUpdate() when processingUpdate != null:
return processingUpdate(_that.embedding,_that.message);case RecognizingFaceSuccess() when success != null:
return success(_that.embedding,_that.messge);case RecognizingFaceSimilaritySuccess() when similaritySuccess != null:
return similaritySuccess(_that.embedding,_that.messge);case _:
  return null;

}
}

}

/// @nodoc


class RecognizingFaceInitial implements RecognizingFaceState {
  const RecognizingFaceInitial({required this.messge});
  

 final  String? messge;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizingFaceInitialCopyWith<RecognizingFaceInitial> get copyWith => _$RecognizingFaceInitialCopyWithImpl<RecognizingFaceInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizingFaceInitial&&(identical(other.messge, messge) || other.messge == messge));
}


@override
int get hashCode => Object.hash(runtimeType,messge);

@override
String toString() {
  return 'RecognizingFaceState.initial(messge: $messge)';
}


}

/// @nodoc
abstract mixin class $RecognizingFaceInitialCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory $RecognizingFaceInitialCopyWith(RecognizingFaceInitial value, $Res Function(RecognizingFaceInitial) _then) = _$RecognizingFaceInitialCopyWithImpl;
@useResult
$Res call({
 String? messge
});




}
/// @nodoc
class _$RecognizingFaceInitialCopyWithImpl<$Res>
    implements $RecognizingFaceInitialCopyWith<$Res> {
  _$RecognizingFaceInitialCopyWithImpl(this._self, this._then);

  final RecognizingFaceInitial _self;
  final $Res Function(RecognizingFaceInitial) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messge = freezed,}) {
  return _then(RecognizingFaceInitial(
messge: freezed == messge ? _self.messge : messge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class RecognizingFaceProcessing implements RecognizingFaceState {
  const RecognizingFaceProcessing({required this.messge});
  

 final  String messge;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizingFaceProcessingCopyWith<RecognizingFaceProcessing> get copyWith => _$RecognizingFaceProcessingCopyWithImpl<RecognizingFaceProcessing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizingFaceProcessing&&(identical(other.messge, messge) || other.messge == messge));
}


@override
int get hashCode => Object.hash(runtimeType,messge);

@override
String toString() {
  return 'RecognizingFaceState.processing(messge: $messge)';
}


}

/// @nodoc
abstract mixin class $RecognizingFaceProcessingCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory $RecognizingFaceProcessingCopyWith(RecognizingFaceProcessing value, $Res Function(RecognizingFaceProcessing) _then) = _$RecognizingFaceProcessingCopyWithImpl;
@useResult
$Res call({
 String messge
});




}
/// @nodoc
class _$RecognizingFaceProcessingCopyWithImpl<$Res>
    implements $RecognizingFaceProcessingCopyWith<$Res> {
  _$RecognizingFaceProcessingCopyWithImpl(this._self, this._then);

  final RecognizingFaceProcessing _self;
  final $Res Function(RecognizingFaceProcessing) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messge = null,}) {
  return _then(RecognizingFaceProcessing(
messge: null == messge ? _self.messge : messge // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RecognizingFaceFailed implements RecognizingFaceState {
  const RecognizingFaceFailed({required this.message});
  

 final  String message;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizingFaceFailedCopyWith<RecognizingFaceFailed> get copyWith => _$RecognizingFaceFailedCopyWithImpl<RecognizingFaceFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizingFaceFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RecognizingFaceState.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class $RecognizingFaceFailedCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory $RecognizingFaceFailedCopyWith(RecognizingFaceFailed value, $Res Function(RecognizingFaceFailed) _then) = _$RecognizingFaceFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RecognizingFaceFailedCopyWithImpl<$Res>
    implements $RecognizingFaceFailedCopyWith<$Res> {
  _$RecognizingFaceFailedCopyWithImpl(this._self, this._then);

  final RecognizingFaceFailed _self;
  final $Res Function(RecognizingFaceFailed) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RecognizingFaceFailed(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RecognizingFaceProcessingErrol implements RecognizingFaceState {
  const RecognizingFaceProcessingErrol({required this.message});
  

 final  String message;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizingFaceProcessingErrolCopyWith<RecognizingFaceProcessingErrol> get copyWith => _$RecognizingFaceProcessingErrolCopyWithImpl<RecognizingFaceProcessingErrol>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizingFaceProcessingErrol&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RecognizingFaceState.processingErrol(message: $message)';
}


}

/// @nodoc
abstract mixin class $RecognizingFaceProcessingErrolCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory $RecognizingFaceProcessingErrolCopyWith(RecognizingFaceProcessingErrol value, $Res Function(RecognizingFaceProcessingErrol) _then) = _$RecognizingFaceProcessingErrolCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RecognizingFaceProcessingErrolCopyWithImpl<$Res>
    implements $RecognizingFaceProcessingErrolCopyWith<$Res> {
  _$RecognizingFaceProcessingErrolCopyWithImpl(this._self, this._then);

  final RecognizingFaceProcessingErrol _self;
  final $Res Function(RecognizingFaceProcessingErrol) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RecognizingFaceProcessingErrol(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RecognizingFaceProcessingUpdate implements RecognizingFaceState {
  const RecognizingFaceProcessingUpdate({required this.embedding, required this.message});
  

 final  FaceEmbedding embedding;
 final  String? message;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizingFaceProcessingUpdateCopyWith<RecognizingFaceProcessingUpdate> get copyWith => _$RecognizingFaceProcessingUpdateCopyWithImpl<RecognizingFaceProcessingUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizingFaceProcessingUpdate&&(identical(other.embedding, embedding) || other.embedding == embedding)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,embedding,message);

@override
String toString() {
  return 'RecognizingFaceState.processingUpdate(embedding: $embedding, message: $message)';
}


}

/// @nodoc
abstract mixin class $RecognizingFaceProcessingUpdateCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory $RecognizingFaceProcessingUpdateCopyWith(RecognizingFaceProcessingUpdate value, $Res Function(RecognizingFaceProcessingUpdate) _then) = _$RecognizingFaceProcessingUpdateCopyWithImpl;
@useResult
$Res call({
 FaceEmbedding embedding, String? message
});




}
/// @nodoc
class _$RecognizingFaceProcessingUpdateCopyWithImpl<$Res>
    implements $RecognizingFaceProcessingUpdateCopyWith<$Res> {
  _$RecognizingFaceProcessingUpdateCopyWithImpl(this._self, this._then);

  final RecognizingFaceProcessingUpdate _self;
  final $Res Function(RecognizingFaceProcessingUpdate) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? embedding = null,Object? message = freezed,}) {
  return _then(RecognizingFaceProcessingUpdate(
embedding: null == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as FaceEmbedding,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class RecognizingFaceSuccess implements RecognizingFaceState {
  const RecognizingFaceSuccess({required this.embedding, required this.messge});
  

 final  FaceEmbedding embedding;
 final  String? messge;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizingFaceSuccessCopyWith<RecognizingFaceSuccess> get copyWith => _$RecognizingFaceSuccessCopyWithImpl<RecognizingFaceSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizingFaceSuccess&&(identical(other.embedding, embedding) || other.embedding == embedding)&&(identical(other.messge, messge) || other.messge == messge));
}


@override
int get hashCode => Object.hash(runtimeType,embedding,messge);

@override
String toString() {
  return 'RecognizingFaceState.success(embedding: $embedding, messge: $messge)';
}


}

/// @nodoc
abstract mixin class $RecognizingFaceSuccessCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory $RecognizingFaceSuccessCopyWith(RecognizingFaceSuccess value, $Res Function(RecognizingFaceSuccess) _then) = _$RecognizingFaceSuccessCopyWithImpl;
@useResult
$Res call({
 FaceEmbedding embedding, String? messge
});




}
/// @nodoc
class _$RecognizingFaceSuccessCopyWithImpl<$Res>
    implements $RecognizingFaceSuccessCopyWith<$Res> {
  _$RecognizingFaceSuccessCopyWithImpl(this._self, this._then);

  final RecognizingFaceSuccess _self;
  final $Res Function(RecognizingFaceSuccess) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? embedding = null,Object? messge = freezed,}) {
  return _then(RecognizingFaceSuccess(
embedding: null == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as FaceEmbedding,messge: freezed == messge ? _self.messge : messge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class RecognizingFaceSimilaritySuccess implements RecognizingFaceState {
  const RecognizingFaceSimilaritySuccess({required this.embedding, required this.messge});
  

 final  FaceEmbedding embedding;
 final  String? messge;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizingFaceSimilaritySuccessCopyWith<RecognizingFaceSimilaritySuccess> get copyWith => _$RecognizingFaceSimilaritySuccessCopyWithImpl<RecognizingFaceSimilaritySuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizingFaceSimilaritySuccess&&(identical(other.embedding, embedding) || other.embedding == embedding)&&(identical(other.messge, messge) || other.messge == messge));
}


@override
int get hashCode => Object.hash(runtimeType,embedding,messge);

@override
String toString() {
  return 'RecognizingFaceState.similaritySuccess(embedding: $embedding, messge: $messge)';
}


}

/// @nodoc
abstract mixin class $RecognizingFaceSimilaritySuccessCopyWith<$Res> implements $RecognizingFaceStateCopyWith<$Res> {
  factory $RecognizingFaceSimilaritySuccessCopyWith(RecognizingFaceSimilaritySuccess value, $Res Function(RecognizingFaceSimilaritySuccess) _then) = _$RecognizingFaceSimilaritySuccessCopyWithImpl;
@useResult
$Res call({
 FaceEmbedding embedding, String? messge
});




}
/// @nodoc
class _$RecognizingFaceSimilaritySuccessCopyWithImpl<$Res>
    implements $RecognizingFaceSimilaritySuccessCopyWith<$Res> {
  _$RecognizingFaceSimilaritySuccessCopyWithImpl(this._self, this._then);

  final RecognizingFaceSimilaritySuccess _self;
  final $Res Function(RecognizingFaceSimilaritySuccess) _then;

/// Create a copy of RecognizingFaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? embedding = null,Object? messge = freezed,}) {
  return _then(RecognizingFaceSimilaritySuccess(
embedding: null == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as FaceEmbedding,messge: freezed == messge ? _self.messge : messge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
