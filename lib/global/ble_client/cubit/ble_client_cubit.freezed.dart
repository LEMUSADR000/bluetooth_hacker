// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ble_client_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BleClientState {
  BleClient? get client => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BleClient? client) connecting,
    required TResult Function(BleClient? client) connected,
    required TResult Function(BleClient? client) disconnecting,
    required TResult Function(BleClient? client) disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnecting value) disconnecting,
    required TResult Function(Disconnected value) disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BleClientStateCopyWith<BleClientState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BleClientStateCopyWith<$Res> {
  factory $BleClientStateCopyWith(
          BleClientState value, $Res Function(BleClientState) then) =
      _$BleClientStateCopyWithImpl<$Res>;
  $Res call({BleClient? client});
}

/// @nodoc
class _$BleClientStateCopyWithImpl<$Res>
    implements $BleClientStateCopyWith<$Res> {
  _$BleClientStateCopyWithImpl(this._value, this._then);

  final BleClientState _value;
  // ignore: unused_field
  final $Res Function(BleClientState) _then;

  @override
  $Res call({
    Object? client = freezed,
  }) {
    return _then(_value.copyWith(
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as BleClient?,
    ));
  }
}

/// @nodoc
abstract class $ConnectingCopyWith<$Res>
    implements $BleClientStateCopyWith<$Res> {
  factory $ConnectingCopyWith(
          Connecting value, $Res Function(Connecting) then) =
      _$ConnectingCopyWithImpl<$Res>;
  @override
  $Res call({BleClient? client});
}

/// @nodoc
class _$ConnectingCopyWithImpl<$Res> extends _$BleClientStateCopyWithImpl<$Res>
    implements $ConnectingCopyWith<$Res> {
  _$ConnectingCopyWithImpl(Connecting _value, $Res Function(Connecting) _then)
      : super(_value, (v) => _then(v as Connecting));

  @override
  Connecting get _value => super._value as Connecting;

  @override
  $Res call({
    Object? client = freezed,
  }) {
    return _then(Connecting(
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as BleClient?,
    ));
  }
}

/// @nodoc

class _$Connecting implements Connecting {
  const _$Connecting({this.client});

  @override
  final BleClient? client;

  @override
  String toString() {
    return 'BleClientState.connecting(client: $client)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Connecting &&
            const DeepCollectionEquality().equals(other.client, client));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(client));

  @JsonKey(ignore: true)
  @override
  $ConnectingCopyWith<Connecting> get copyWith =>
      _$ConnectingCopyWithImpl<Connecting>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BleClient? client) connecting,
    required TResult Function(BleClient? client) connected,
    required TResult Function(BleClient? client) disconnecting,
    required TResult Function(BleClient? client) disconnected,
  }) {
    return connecting(client);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
  }) {
    return connecting?.call(client);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(client);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnecting value) disconnecting,
    required TResult Function(Disconnected value) disconnected,
  }) {
    return connecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
  }) {
    return connecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(this);
    }
    return orElse();
  }
}

abstract class Connecting implements BleClientState {
  const factory Connecting({final BleClient? client}) = _$Connecting;

  @override
  BleClient? get client => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ConnectingCopyWith<Connecting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectedCopyWith<$Res>
    implements $BleClientStateCopyWith<$Res> {
  factory $ConnectedCopyWith(Connected value, $Res Function(Connected) then) =
      _$ConnectedCopyWithImpl<$Res>;
  @override
  $Res call({BleClient? client});
}

/// @nodoc
class _$ConnectedCopyWithImpl<$Res> extends _$BleClientStateCopyWithImpl<$Res>
    implements $ConnectedCopyWith<$Res> {
  _$ConnectedCopyWithImpl(Connected _value, $Res Function(Connected) _then)
      : super(_value, (v) => _then(v as Connected));

  @override
  Connected get _value => super._value as Connected;

  @override
  $Res call({
    Object? client = freezed,
  }) {
    return _then(Connected(
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as BleClient?,
    ));
  }
}

/// @nodoc

class _$Connected implements Connected {
  const _$Connected({this.client});

  @override
  final BleClient? client;

  @override
  String toString() {
    return 'BleClientState.connected(client: $client)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Connected &&
            const DeepCollectionEquality().equals(other.client, client));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(client));

  @JsonKey(ignore: true)
  @override
  $ConnectedCopyWith<Connected> get copyWith =>
      _$ConnectedCopyWithImpl<Connected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BleClient? client) connecting,
    required TResult Function(BleClient? client) connected,
    required TResult Function(BleClient? client) disconnecting,
    required TResult Function(BleClient? client) disconnected,
  }) {
    return connected(client);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
  }) {
    return connected?.call(client);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(client);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnecting value) disconnecting,
    required TResult Function(Disconnected value) disconnected,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class Connected implements BleClientState {
  const factory Connected({final BleClient? client}) = _$Connected;

  @override
  BleClient? get client => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ConnectedCopyWith<Connected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DisconnectingCopyWith<$Res>
    implements $BleClientStateCopyWith<$Res> {
  factory $DisconnectingCopyWith(
          Disconnecting value, $Res Function(Disconnecting) then) =
      _$DisconnectingCopyWithImpl<$Res>;
  @override
  $Res call({BleClient? client});
}

/// @nodoc
class _$DisconnectingCopyWithImpl<$Res>
    extends _$BleClientStateCopyWithImpl<$Res>
    implements $DisconnectingCopyWith<$Res> {
  _$DisconnectingCopyWithImpl(
      Disconnecting _value, $Res Function(Disconnecting) _then)
      : super(_value, (v) => _then(v as Disconnecting));

  @override
  Disconnecting get _value => super._value as Disconnecting;

  @override
  $Res call({
    Object? client = freezed,
  }) {
    return _then(Disconnecting(
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as BleClient?,
    ));
  }
}

/// @nodoc

class _$Disconnecting implements Disconnecting {
  const _$Disconnecting({this.client});

  @override
  final BleClient? client;

  @override
  String toString() {
    return 'BleClientState.disconnecting(client: $client)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Disconnecting &&
            const DeepCollectionEquality().equals(other.client, client));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(client));

  @JsonKey(ignore: true)
  @override
  $DisconnectingCopyWith<Disconnecting> get copyWith =>
      _$DisconnectingCopyWithImpl<Disconnecting>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BleClient? client) connecting,
    required TResult Function(BleClient? client) connected,
    required TResult Function(BleClient? client) disconnecting,
    required TResult Function(BleClient? client) disconnected,
  }) {
    return disconnecting(client);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
  }) {
    return disconnecting?.call(client);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnecting != null) {
      return disconnecting(client);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnecting value) disconnecting,
    required TResult Function(Disconnected value) disconnected,
  }) {
    return disconnecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
  }) {
    return disconnecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnecting != null) {
      return disconnecting(this);
    }
    return orElse();
  }
}

abstract class Disconnecting implements BleClientState {
  const factory Disconnecting({final BleClient? client}) = _$Disconnecting;

  @override
  BleClient? get client => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $DisconnectingCopyWith<Disconnecting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DisconnectedCopyWith<$Res>
    implements $BleClientStateCopyWith<$Res> {
  factory $DisconnectedCopyWith(
          Disconnected value, $Res Function(Disconnected) then) =
      _$DisconnectedCopyWithImpl<$Res>;
  @override
  $Res call({BleClient? client});
}

/// @nodoc
class _$DisconnectedCopyWithImpl<$Res>
    extends _$BleClientStateCopyWithImpl<$Res>
    implements $DisconnectedCopyWith<$Res> {
  _$DisconnectedCopyWithImpl(
      Disconnected _value, $Res Function(Disconnected) _then)
      : super(_value, (v) => _then(v as Disconnected));

  @override
  Disconnected get _value => super._value as Disconnected;

  @override
  $Res call({
    Object? client = freezed,
  }) {
    return _then(Disconnected(
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as BleClient?,
    ));
  }
}

/// @nodoc

class _$Disconnected implements Disconnected {
  const _$Disconnected({this.client});

  @override
  final BleClient? client;

  @override
  String toString() {
    return 'BleClientState.disconnected(client: $client)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Disconnected &&
            const DeepCollectionEquality().equals(other.client, client));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(client));

  @JsonKey(ignore: true)
  @override
  $DisconnectedCopyWith<Disconnected> get copyWith =>
      _$DisconnectedCopyWithImpl<Disconnected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BleClient? client) connecting,
    required TResult Function(BleClient? client) connected,
    required TResult Function(BleClient? client) disconnecting,
    required TResult Function(BleClient? client) disconnected,
  }) {
    return disconnected(client);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
  }) {
    return disconnected?.call(client);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BleClient? client)? connecting,
    TResult Function(BleClient? client)? connected,
    TResult Function(BleClient? client)? disconnecting,
    TResult Function(BleClient? client)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(client);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnecting value) disconnecting,
    required TResult Function(Disconnected value) disconnected,
  }) {
    return disconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
  }) {
    return disconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnecting value)? disconnecting,
    TResult Function(Disconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(this);
    }
    return orElse();
  }
}

abstract class Disconnected implements BleClientState {
  const factory Disconnected({final BleClient? client}) = _$Disconnected;

  @override
  BleClient? get client => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $DisconnectedCopyWith<Disconnected> get copyWith =>
      throw _privateConstructorUsedError;
}
