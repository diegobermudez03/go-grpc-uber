//
//  Generated code. Do not modify.
//  source: uber.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use uberRegisterDTODescriptor instead')
const UberRegisterDTO$json = {
  '1': 'UberRegisterDTO',
  '2': [
    {'1': 'placa', '3': 1, '4': 1, '5': 9, '10': 'placa'},
    {'1': 'service_type', '3': 2, '4': 1, '5': 9, '10': 'serviceType'},
  ],
};

/// Descriptor for `UberRegisterDTO`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uberRegisterDTODescriptor = $convert.base64Decode(
    'Cg9VYmVyUmVnaXN0ZXJEVE8SFAoFcGxhY2EYASABKAlSBXBsYWNhEiEKDHNlcnZpY2VfdHlwZR'
    'gCIAEoCVILc2VydmljZVR5cGU=');

@$core.Deprecated('Use ackonledgmentDescriptor instead')
const Ackonledgment$json = {
  '1': 'Ackonledgment',
  '2': [
    {'1': 'registered', '3': 1, '4': 1, '5': 8, '10': 'registered'},
  ],
};

/// Descriptor for `Ackonledgment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ackonledgmentDescriptor = $convert.base64Decode(
    'Cg1BY2tvbmxlZGdtZW50Eh4KCnJlZ2lzdGVyZWQYASABKAhSCnJlZ2lzdGVyZWQ=');

@$core.Deprecated('Use positionUpdateDescriptor instead')
const PositionUpdate$json = {
  '1': 'PositionUpdate',
  '2': [
    {'1': 'placa', '3': 1, '4': 1, '5': 9, '10': 'placa'},
    {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.ubergrpc.Position', '10': 'position'},
  ],
};

/// Descriptor for `PositionUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List positionUpdateDescriptor = $convert.base64Decode(
    'Cg5Qb3NpdGlvblVwZGF0ZRIUCgVwbGFjYRgBIAEoCVIFcGxhY2ESLgoIcG9zaXRpb24YAiABKA'
    'syEi51YmVyZ3JwYy5Qb3NpdGlvblIIcG9zaXRpb24=');

@$core.Deprecated('Use requestAnswerDescriptor instead')
const RequestAnswer$json = {
  '1': 'RequestAnswer',
  '2': [
    {'1': 'placa', '3': 1, '4': 1, '5': 9, '10': 'placa'},
    {'1': 'accepted', '3': 2, '4': 1, '5': 8, '10': 'accepted'},
  ],
};

/// Descriptor for `RequestAnswer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAnswerDescriptor = $convert.base64Decode(
    'Cg1SZXF1ZXN0QW5zd2VyEhQKBXBsYWNhGAEgASgJUgVwbGFjYRIaCghhY2NlcHRlZBgCIAEoCF'
    'IIYWNjZXB0ZWQ=');

@$core.Deprecated('Use requestsUpdatesDescriptor instead')
const RequestsUpdates$json = {
  '1': 'RequestsUpdates',
  '2': [
    {'1': 'client_name', '3': 1, '4': 1, '5': 9, '10': 'clientName'},
    {'1': 'client_psoition', '3': 2, '4': 1, '5': 11, '6': '.ubergrpc.Position', '10': 'clientPsoition'},
    {'1': 'distance', '3': 3, '4': 1, '5': 1, '10': 'distance'},
    {'1': 'price', '3': 4, '4': 1, '5': 1, '10': 'price'},
  ],
};

/// Descriptor for `RequestsUpdates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestsUpdatesDescriptor = $convert.base64Decode(
    'Cg9SZXF1ZXN0c1VwZGF0ZXMSHwoLY2xpZW50X25hbWUYASABKAlSCmNsaWVudE5hbWUSOwoPY2'
    'xpZW50X3Bzb2l0aW9uGAIgASgLMhIudWJlcmdycGMuUG9zaXRpb25SDmNsaWVudFBzb2l0aW9u'
    'EhoKCGRpc3RhbmNlGAMgASgBUghkaXN0YW5jZRIUCgVwcmljZRgEIAEoAVIFcHJpY2U=');

@$core.Deprecated('Use positionDescriptor instead')
const Position$json = {
  '1': 'Position',
  '2': [
    {'1': 'x_position', '3': 1, '4': 1, '5': 13, '10': 'xPosition'},
    {'1': 'y_position', '3': 2, '4': 1, '5': 13, '10': 'yPosition'},
  ],
};

/// Descriptor for `Position`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List positionDescriptor = $convert.base64Decode(
    'CghQb3NpdGlvbhIdCgp4X3Bvc2l0aW9uGAEgASgNUgl4UG9zaXRpb24SHQoKeV9wb3NpdGlvbh'
    'gCIAEoDVIJeVBvc2l0aW9u');

