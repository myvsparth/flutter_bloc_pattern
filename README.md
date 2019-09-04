# flutter_bloc_pattern
 How to implement BLoC Pattern in Flutter for State Management

## Introduction:
 This Article explains how state will be managed in flutter. There is a method you already know about is provider, Inherited Widget, redux etc. BLoC Pattern is also a state management technique. BLoC Pattern is somehow advanced compared to Scoped Model and it’s also better in performance as well.
 BLoC Pattern uses Sink and Stream Concept in which Sink will accept input as Event and Stream provide output. BLoC Pattern is bit complicated to implementation from scratch but there is also a plugin for that makes the work easy but we are going to implement it from scratch because we should have a deep understanding of it to use readymade plugin of it. Now let’s see BLoC Pattern implementation in Flutter in detail.

## Steps:
 Step 1:
 First and basic step to create new application in flutter. If you are a beginner in flutter then you can check my blog Create a first app in Flutter. I have created an app named as “flutter_bloc_pattern”.

 Step 2:
 Now you can see that you will have counter app by default now our purpose is to make the same app using inherited widget. We are also adding decrement operation to it as well.

 Step 3:
 Now Create a new file named as counter_bloc_provider.dart. In this file we will add abstract class for events for increment and decrement operation which will be mapped in bloc pattern to handle stream and sink controls.
 We have state and event controller implementation in which when constructor will be generated then event will be allocated to state according to event type.Following is the programming implementation of that.
```
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
```

 Step 4:
 Now in main.dart file we will import bloc pattern class in to it and define the stream for output and also call abstract event to add sink to increment and decrement counter variable. You will also see dispose() will be overridden because stream will consume memory which will be released when widget is not in use. Following is the programming implementation of that.
```
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/counter_bloc_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     theme: ThemeData(
       primarySwatch: Colors.blue,
     ),
     home: MyHomePage(),
   );
 }
}
 
class MyHomePage extends StatefulWidget {
 @override
 _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
 final _bloc = CounterBloc();
 
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Flutter BLoC Patter'),
     ),
     body: Center(
       child: StreamBuilder(
         stream: _bloc.counter,
         initialData: 0,
         builder: (context, snapshot) {
           return Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text(
                 'Counter Value:',
               ),
               Text(
                 '${snapshot.data}',
                 style: Theme.of(context).textTheme.display1,
               ),
             ],
           );
         },
       ),
     ),
     floatingActionButton: Row(
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
         FloatingActionButton(
           onPressed: () => _bloc.counterEventSink.add(DecrementEvent()),
           tooltip: 'Decrement',
           child: Icon(Icons.remove),
         ),
         SizedBox(width: 25,),
         FloatingActionButton(
           onPressed: () => _bloc.counterEventSink.add(IncrementEvent()),
           tooltip: 'Increment',
           child: Icon(Icons.add),
         ),
       ],
     ),
   );
 }
 
 @override
 void dispose() {
   super.dispose();
   _bloc.dispose();
 }
}
```

 Hurrey…. Run the app and Test It on emulator/simulator or device :)))

## Conclusion:
 State Management is one of the key parts of performance improvement of the app and BLoC Pattern is one of the approaches of it and it has better performance then Scoped Model. Though it is complex but very efficient in complex systems.

> Git Repo: https://github.com/myvsparth/flutter_bloc_pattern
 Referenced: https://www.youtube.com/watch?v=oxeYeMHVLII
 
## Related to Tags: Flutter, State Management, BLoC Pattern

