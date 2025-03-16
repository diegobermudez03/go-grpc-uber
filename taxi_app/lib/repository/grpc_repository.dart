import 'package:dartz/dartz.dart';
import 'package:grpc/service_api.dart';
import 'package:taxi_app/repository/gen/uber.pbgrpc.dart';

class GrpcRepository {
  final UberServiceClient _client;

  GrpcRepository(ClientChannel channel) : _client = UberServiceClient(channel);

  Future<Tuple2<bool, String>> register(String placa, String serviceType) async{
    try{
      final request = UberRegisterDTO(placa: placa, serviceType: serviceType);
      final response = await _client.uberRegister(request);
      return Tuple2(response.registered, "");
    }catch(e){
      return Tuple2(false, e.toString());
    }
  }

  Future<Tuple2<void, String>> updatePosition(Stream<PositionUpdate> posStream) async{
    try{
      final call = _client.updatePosition(posStream);
      await call;
      return Tuple2(null, "");
    }catch(e){
      return Tuple2(null, e.toString());
    }
  }

  Stream<RequestsUpdates> getRequests(Stream<RequestAnswer> answerStream) async*{
    try{
      final call = _client.getRequests(answerStream);

      await for(final update in call){
        yield update;
      }
    }catch(e){
      print('errooooooooooor: $e');
    }
  }
}