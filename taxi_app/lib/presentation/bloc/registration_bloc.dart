
import 'package:bloc/bloc.dart';
import 'package:taxi_app/presentation/global_state.dart';
import 'package:taxi_app/repository/grpc_repository.dart';

class RegistrationBloc extends Cubit<RegistraionState>{

  final GrpcRepository _repo;
  
  RegistrationBloc(this._repo):super(InitialRegistrationState());

  void registrate(String placa, String serviceType) async{
    emit(RegistrationLoading());
    final res  = await _repo.register(placa, serviceType);
    if(res.value2.isNotEmpty){
      emit(RegistrationError(res.value2));
    }else if(!res.value1){
      emit(RegistrationError("something went wrong"));
    }else{
      GlobalContext.placa = placa;
      emit(RegistrationSuccess());
    }
  }
}


//states
abstract class RegistraionState{}

class RegistrationLoading extends RegistraionState{}

class InitialRegistrationState extends RegistraionState{}

class RegistrationError extends RegistraionState{
  final String message;
  RegistrationError(this.message);
}

class RegistrationSuccess extends RegistraionState{}