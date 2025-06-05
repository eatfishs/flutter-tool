import 'package:bloc/bloc.dart';
part 'counter_event.dart';
part 'counter_state.dart';

// 3. 创建Bloc - 计数器Bloc
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<CounterEvent>((event, emit) {
      switch (event) {
        case CounterEvent.increment:
          emit(CounterState(state.count + 1));
          break;
        case CounterEvent.decrement:
          emit(CounterState(state.count - 1));
          break;
      }
    });
  }
}
