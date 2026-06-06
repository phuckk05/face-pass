// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserState()';
}


}

/// @nodoc
class $UserStateCopyWith<$Res>  {
$UserStateCopyWith(UserState _, $Res Function(UserState) __);
}


/// Adds pattern-matching-related methods to [UserState].
extension UserStatePatterns on UserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserInitialState value)?  initial,TResult Function( UserLoadingState value)?  loading,TResult Function( UserSuccessState value)?  success,TResult Function( UserFailedState value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserInitialState() when initial != null:
return initial(_that);case UserLoadingState() when loading != null:
return loading(_that);case UserSuccessState() when success != null:
return success(_that);case UserFailedState() when failed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserInitialState value)  initial,required TResult Function( UserLoadingState value)  loading,required TResult Function( UserSuccessState value)  success,required TResult Function( UserFailedState value)  failed,}){
final _that = this;
switch (_that) {
case UserInitialState():
return initial(_that);case UserLoadingState():
return loading(_that);case UserSuccessState():
return success(_that);case UserFailedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserInitialState value)?  initial,TResult? Function( UserLoadingState value)?  loading,TResult? Function( UserSuccessState value)?  success,TResult? Function( UserFailedState value)?  failed,}){
final _that = this;
switch (_that) {
case UserInitialState() when initial != null:
return initial(_that);case UserLoadingState() when loading != null:
return loading(_that);case UserSuccessState() when success != null:
return success(_that);case UserFailedState() when failed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( User user)?  success,TResult Function( String message)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserInitialState() when initial != null:
return initial();case UserLoadingState() when loading != null:
return loading();case UserSuccessState() when success != null:
return success(_that.user);case UserFailedState() when failed != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( User user)  success,required TResult Function( String message)  failed,}) {final _that = this;
switch (_that) {
case UserInitialState():
return initial();case UserLoadingState():
return loading();case UserSuccessState():
return success(_that.user);case UserFailedState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( User user)?  success,TResult? Function( String message)?  failed,}) {final _that = this;
switch (_that) {
case UserInitialState() when initial != null:
return initial();case UserLoadingState() when loading != null:
return loading();case UserSuccessState() when success != null:
return success(_that.user);case UserFailedState() when failed != null:
return failed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class UserInitialState with DiagnosticableTreeMixin implements UserState {
  const UserInitialState();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserState.initial()';
}


}




/// @nodoc


class UserLoadingState with DiagnosticableTreeMixin implements UserState {
  const UserLoadingState();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserState.loading()';
}


}




/// @nodoc


class UserSuccessState with DiagnosticableTreeMixin implements UserState {
  const UserSuccessState({required this.user});
  

 final  User user;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSuccessStateCopyWith<UserSuccessState> get copyWith => _$UserSuccessStateCopyWithImpl<UserSuccessState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserState.success'))
    ..add(DiagnosticsProperty('user', user));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSuccessState&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserState.success(user: $user)';
}


}

/// @nodoc
abstract mixin class $UserSuccessStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory $UserSuccessStateCopyWith(UserSuccessState value, $Res Function(UserSuccessState) _then) = _$UserSuccessStateCopyWithImpl;
@useResult
$Res call({
 User user
});




}
/// @nodoc
class _$UserSuccessStateCopyWithImpl<$Res>
    implements $UserSuccessStateCopyWith<$Res> {
  _$UserSuccessStateCopyWithImpl(this._self, this._then);

  final UserSuccessState _self;
  final $Res Function(UserSuccessState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(UserSuccessState(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}


}

/// @nodoc


class UserFailedState with DiagnosticableTreeMixin implements UserState {
  const UserFailedState({required this.message});
  

 final  String message;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFailedStateCopyWith<UserFailedState> get copyWith => _$UserFailedStateCopyWithImpl<UserFailedState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserState.failed'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFailedState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserState.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class $UserFailedStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory $UserFailedStateCopyWith(UserFailedState value, $Res Function(UserFailedState) _then) = _$UserFailedStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UserFailedStateCopyWithImpl<$Res>
    implements $UserFailedStateCopyWith<$Res> {
  _$UserFailedStateCopyWithImpl(this._self, this._then);

  final UserFailedState _self;
  final $Res Function(UserFailedState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UserFailedState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
