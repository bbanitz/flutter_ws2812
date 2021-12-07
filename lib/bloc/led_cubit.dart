import '../model/led_infos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int colCount = 64;
int rowCount = 8;

class LedCubit extends Cubit<LedInfos> {
  LedCubit(int numero) : super(LedInfos(numero));
}

List<LedCubit> ledCubits = [];

initLedCubits() {
  for (int i = 0; i < colCount * rowCount; i++) {
    ledCubits.add(LedCubit(i));
  }
}
