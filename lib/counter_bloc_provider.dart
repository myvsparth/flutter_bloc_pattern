import 'dart:async';

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class CounterBloc {
  int _counter = 0;
  final _counterController = StreamController<int>();
  StreamSink<int> get _incrementCounter => _counterController.sink;
  Stream<int> get counter => _counterController.stream;
  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;
  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }
  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;
    _incrementCounter.add(_counter);
  }

  void dispose(){
    _counterController.close();
    _counterEventController.close();
  }
}
