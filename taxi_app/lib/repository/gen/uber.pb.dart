//
//  Generated code. Do not modify.
//  source: uber.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// for uber registering
class UberRegisterDTO extends $pb.GeneratedMessage {
  factory UberRegisterDTO({
    $core.String? placa,
    $core.String? serviceType,
  }) {
    final $result = create();
    if (placa != null) {
      $result.placa = placa;
    }
    if (serviceType != null) {
      $result.serviceType = serviceType;
    }
    return $result;
  }
  UberRegisterDTO._() : super();
  factory UberRegisterDTO.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UberRegisterDTO.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UberRegisterDTO', package: const $pb.PackageName(_omitMessageNames ? '' : 'ubergrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'placa')
    ..aOS(2, _omitFieldNames ? '' : 'serviceType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UberRegisterDTO clone() => UberRegisterDTO()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UberRegisterDTO copyWith(void Function(UberRegisterDTO) updates) => super.copyWith((message) => updates(message as UberRegisterDTO)) as UberRegisterDTO;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UberRegisterDTO create() => UberRegisterDTO._();
  UberRegisterDTO createEmptyInstance() => create();
  static $pb.PbList<UberRegisterDTO> createRepeated() => $pb.PbList<UberRegisterDTO>();
  @$core.pragma('dart2js:noInline')
  static UberRegisterDTO getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UberRegisterDTO>(create);
  static UberRegisterDTO? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get placa => $_getSZ(0);
  @$pb.TagNumber(1)
  set placa($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlaca() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlaca() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get serviceType => $_getSZ(1);
  @$pb.TagNumber(2)
  set serviceType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasServiceType() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceType() => clearField(2);
}

class Ackonledgment extends $pb.GeneratedMessage {
  factory Ackonledgment({
    $core.bool? registered,
  }) {
    final $result = create();
    if (registered != null) {
      $result.registered = registered;
    }
    return $result;
  }
  Ackonledgment._() : super();
  factory Ackonledgment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Ackonledgment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Ackonledgment', package: const $pb.PackageName(_omitMessageNames ? '' : 'ubergrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'registered')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Ackonledgment clone() => Ackonledgment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Ackonledgment copyWith(void Function(Ackonledgment) updates) => super.copyWith((message) => updates(message as Ackonledgment)) as Ackonledgment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Ackonledgment create() => Ackonledgment._();
  Ackonledgment createEmptyInstance() => create();
  static $pb.PbList<Ackonledgment> createRepeated() => $pb.PbList<Ackonledgment>();
  @$core.pragma('dart2js:noInline')
  static Ackonledgment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Ackonledgment>(create);
  static Ackonledgment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get registered => $_getBF(0);
  @$pb.TagNumber(1)
  set registered($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRegistered() => $_has(0);
  @$pb.TagNumber(1)
  void clearRegistered() => clearField(1);
}

/// for position update
class PositionUpdate extends $pb.GeneratedMessage {
  factory PositionUpdate({
    $core.String? placa,
    Position? position,
  }) {
    final $result = create();
    if (placa != null) {
      $result.placa = placa;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  PositionUpdate._() : super();
  factory PositionUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PositionUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PositionUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'ubergrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'placa')
    ..aOM<Position>(2, _omitFieldNames ? '' : 'position', subBuilder: Position.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PositionUpdate clone() => PositionUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PositionUpdate copyWith(void Function(PositionUpdate) updates) => super.copyWith((message) => updates(message as PositionUpdate)) as PositionUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PositionUpdate create() => PositionUpdate._();
  PositionUpdate createEmptyInstance() => create();
  static $pb.PbList<PositionUpdate> createRepeated() => $pb.PbList<PositionUpdate>();
  @$core.pragma('dart2js:noInline')
  static PositionUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PositionUpdate>(create);
  static PositionUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get placa => $_getSZ(0);
  @$pb.TagNumber(1)
  set placa($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlaca() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlaca() => clearField(1);

  @$pb.TagNumber(2)
  Position get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(Position v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => clearField(2);
  @$pb.TagNumber(2)
  Position ensurePosition() => $_ensure(1);
}

/// for getting ride requests
class RequestAnswer extends $pb.GeneratedMessage {
  factory RequestAnswer({
    $core.bool? accepted,
  }) {
    final $result = create();
    if (accepted != null) {
      $result.accepted = accepted;
    }
    return $result;
  }
  RequestAnswer._() : super();
  factory RequestAnswer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestAnswer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestAnswer', package: const $pb.PackageName(_omitMessageNames ? '' : 'ubergrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'accepted')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestAnswer clone() => RequestAnswer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestAnswer copyWith(void Function(RequestAnswer) updates) => super.copyWith((message) => updates(message as RequestAnswer)) as RequestAnswer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestAnswer create() => RequestAnswer._();
  RequestAnswer createEmptyInstance() => create();
  static $pb.PbList<RequestAnswer> createRepeated() => $pb.PbList<RequestAnswer>();
  @$core.pragma('dart2js:noInline')
  static RequestAnswer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestAnswer>(create);
  static RequestAnswer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get accepted => $_getBF(0);
  @$pb.TagNumber(1)
  set accepted($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccepted() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccepted() => clearField(1);
}

class RequestsUpdates extends $pb.GeneratedMessage {
  factory RequestsUpdates({
    $core.String? clientEmail,
    Position? clientPsoition,
    $core.double? distance,
    $core.double? price,
  }) {
    final $result = create();
    if (clientEmail != null) {
      $result.clientEmail = clientEmail;
    }
    if (clientPsoition != null) {
      $result.clientPsoition = clientPsoition;
    }
    if (distance != null) {
      $result.distance = distance;
    }
    if (price != null) {
      $result.price = price;
    }
    return $result;
  }
  RequestsUpdates._() : super();
  factory RequestsUpdates.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestsUpdates.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestsUpdates', package: const $pb.PackageName(_omitMessageNames ? '' : 'ubergrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'clientEmail')
    ..aOM<Position>(2, _omitFieldNames ? '' : 'clientPsoition', subBuilder: Position.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'distance', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestsUpdates clone() => RequestsUpdates()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestsUpdates copyWith(void Function(RequestsUpdates) updates) => super.copyWith((message) => updates(message as RequestsUpdates)) as RequestsUpdates;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestsUpdates create() => RequestsUpdates._();
  RequestsUpdates createEmptyInstance() => create();
  static $pb.PbList<RequestsUpdates> createRepeated() => $pb.PbList<RequestsUpdates>();
  @$core.pragma('dart2js:noInline')
  static RequestsUpdates getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestsUpdates>(create);
  static RequestsUpdates? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clientEmail => $_getSZ(0);
  @$pb.TagNumber(1)
  set clientEmail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClientEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientEmail() => clearField(1);

  @$pb.TagNumber(2)
  Position get clientPsoition => $_getN(1);
  @$pb.TagNumber(2)
  set clientPsoition(Position v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasClientPsoition() => $_has(1);
  @$pb.TagNumber(2)
  void clearClientPsoition() => clearField(2);
  @$pb.TagNumber(2)
  Position ensureClientPsoition() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get distance => $_getN(2);
  @$pb.TagNumber(3)
  set distance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDistance() => $_has(2);
  @$pb.TagNumber(3)
  void clearDistance() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get price => $_getN(3);
  @$pb.TagNumber(4)
  set price($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearPrice() => clearField(4);
}

class Position extends $pb.GeneratedMessage {
  factory Position({
    $core.int? xPosition,
    $core.int? yPosition,
  }) {
    final $result = create();
    if (xPosition != null) {
      $result.xPosition = xPosition;
    }
    if (yPosition != null) {
      $result.yPosition = yPosition;
    }
    return $result;
  }
  Position._() : super();
  factory Position.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Position.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Position', package: const $pb.PackageName(_omitMessageNames ? '' : 'ubergrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'xPosition', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'yPosition', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Position clone() => Position()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Position copyWith(void Function(Position) updates) => super.copyWith((message) => updates(message as Position)) as Position;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Position create() => Position._();
  Position createEmptyInstance() => create();
  static $pb.PbList<Position> createRepeated() => $pb.PbList<Position>();
  @$core.pragma('dart2js:noInline')
  static Position getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Position>(create);
  static Position? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get xPosition => $_getIZ(0);
  @$pb.TagNumber(1)
  set xPosition($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasXPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearXPosition() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get yPosition => $_getIZ(1);
  @$pb.TagNumber(2)
  set yPosition($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasYPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearYPosition() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
