
import 'package:bloc/bloc.dart';

class RegistrationBloc extends Cubit<RegistraionState>{
  
  RegistrationBloc():super(InitialRegistrationState());

  void registrate(String placa, int initialX, int initialY){
    emit(RegistrationLoading());
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