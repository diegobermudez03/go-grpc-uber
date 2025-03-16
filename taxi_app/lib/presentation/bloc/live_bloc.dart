import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:taxi_app/presentation/global_state.dart';
import 'package:taxi_app/repository/gen/uber.pbgrpc.dart';
import 'package:taxi_app/repository/grpc_repository.dart';

class LiveBloc extends Cubit<LiveState>{
  final GrpcRepository repo;
  
  StreamController<PositionUpdate>? locStream;

  LiveBloc(this.repo):super(LiveInitialState());

  void updatePosition(int xPos, int yPos){
    if(xPos == 0) xPos = 1;
    if(yPos == 0) yPos = 1;
    if(locStream == null){
      locStream = StreamController();
      repo.updatePosition(locStream!.stream);
    }
    locStream!.add(PositionUpdate(
      placa: GlobalContext.placa,
      position: Position(xPosition: xPos, yPosition: yPos)
    ));

  }
}


//states
abstract class LiveState{}

class LiveInitialState extends LiveState{}