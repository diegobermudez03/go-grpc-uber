import 'package:bloc/bloc.dart';
import 'package:taxi_app/repository/grpc_repository.dart';

class LiveBloc extends Cubit<LiveState>{
  final GrpcRepository repo;
  LiveBloc(this.repo):super(LiveInitialState());
}


//states
abstract class LiveState{}

class LiveInitialState extends LiveState{}