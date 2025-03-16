import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:taxi_app/presentation/global_state.dart';
import 'package:taxi_app/repository/gen/uber.pbgrpc.dart';
import 'package:taxi_app/repository/grpc_repository.dart';

class LiveBloc extends Cubit<LiveState>{
  final GrpcRepository repo;
  
  StreamController<PositionUpdate>? locStream;
  StreamController<RequestAnswer>? reqAnswerStream;

  LiveBloc(this.repo):super(LiveInitialState());

  void updatePosition(int xPos, int yPos){
    if(xPos == 0) xPos = 1;
    if(yPos == 0) yPos = 1;
    if(locStream == null){
      locStream = StreamController();
      reqAnswerStream = StreamController();
      repo.updatePosition(locStream!.stream);
      final updates = repo.getRequests(reqAnswerStream!.stream);
      reqAnswerStream!.add(RequestAnswer(placa: GlobalContext.placa));
      updates.listen((update){
        emit(LiveRequestState(update.clientName, update.clientPsoition, update.distance));
      });
    }
    locStream!.add(PositionUpdate(
      placa: GlobalContext.placa,
      position: Position(xPosition: xPos, yPosition: yPos)
    ));
  }

  void denyRequest(){
    reqAnswerStream!.add(RequestAnswer(accepted: false));
  }

  void acceptRequest(){
    reqAnswerStream!.add(RequestAnswer(accepted: true));
    String? clientName;
    Position? position;
    if(state is LiveRequestState){
      clientName = (state as LiveRequestState).clientName;
      position = (state as LiveRequestState).position;
    }
    reqAnswerStream!.close();
    emit(LiveInCourse(clientName!, position!));
  }
}


//states
abstract class LiveState{}

class LiveInitialState extends LiveState{}

class LiveRequestState extends LiveState{
  final String clientName;
  final Position position;
  final double distance;
  LiveRequestState(this.clientName, this.position, this.distance);
}

class LiveInCourse extends LiveState{
  final String clientName;
  final Position position;
  LiveInCourse(this.clientName, this.position);
}
