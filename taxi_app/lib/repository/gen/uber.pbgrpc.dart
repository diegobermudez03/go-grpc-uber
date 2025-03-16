//
//  Generated code. Do not modify.
//  source: uber.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/empty.pb.dart' as $1;
import 'uber.pb.dart' as $0;

export 'uber.pb.dart';

@$pb.GrpcServiceName('ubergrpc.UberService')
class UberServiceClient extends $grpc.Client {
  static final _$uberRegister = $grpc.ClientMethod<$0.UberRegisterDTO, $0.Ackonledgment>(
      '/ubergrpc.UberService/UberRegister',
      ($0.UberRegisterDTO value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Ackonledgment.fromBuffer(value));
  static final _$updatePosition = $grpc.ClientMethod<$0.PositionUpdate, $1.Empty>(
      '/ubergrpc.UberService/UpdatePosition',
      ($0.PositionUpdate value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getRequests = $grpc.ClientMethod<$0.RequestAnswer, $0.RequestsUpdates>(
      '/ubergrpc.UberService/GetRequests',
      ($0.RequestAnswer value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RequestsUpdates.fromBuffer(value));

  UberServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.Ackonledgment> uberRegister($0.UberRegisterDTO request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uberRegister, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> updatePosition($async.Stream<$0.PositionUpdate> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$updatePosition, request, options: options).single;
  }

  $grpc.ResponseStream<$0.RequestsUpdates> getRequests($async.Stream<$0.RequestAnswer> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getRequests, request, options: options);
  }
}

@$pb.GrpcServiceName('ubergrpc.UberService')
abstract class UberServiceBase extends $grpc.Service {
  $core.String get $name => 'ubergrpc.UberService';

  UberServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UberRegisterDTO, $0.Ackonledgment>(
        'UberRegister',
        uberRegister_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UberRegisterDTO.fromBuffer(value),
        ($0.Ackonledgment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PositionUpdate, $1.Empty>(
        'UpdatePosition',
        updatePosition,
        true,
        false,
        ($core.List<$core.int> value) => $0.PositionUpdate.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestAnswer, $0.RequestsUpdates>(
        'GetRequests',
        getRequests,
        true,
        true,
        ($core.List<$core.int> value) => $0.RequestAnswer.fromBuffer(value),
        ($0.RequestsUpdates value) => value.writeToBuffer()));
  }

  $async.Future<$0.Ackonledgment> uberRegister_Pre($grpc.ServiceCall call, $async.Future<$0.UberRegisterDTO> request) async {
    return uberRegister(call, await request);
  }

  $async.Future<$0.Ackonledgment> uberRegister($grpc.ServiceCall call, $0.UberRegisterDTO request);
  $async.Future<$1.Empty> updatePosition($grpc.ServiceCall call, $async.Stream<$0.PositionUpdate> request);
  $async.Stream<$0.RequestsUpdates> getRequests($grpc.ServiceCall call, $async.Stream<$0.RequestAnswer> request);
}
