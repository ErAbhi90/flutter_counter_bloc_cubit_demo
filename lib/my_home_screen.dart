import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc_cubit_demo/cubits/counter/counter_cubit.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

          /* 
      Center(
        child: 

        Method one: Using extension method to access the state
        This is not recommended as whole widget including the scaffold will rebuild
        Text(
          "${context.watch<CounterCubit>().state.counter}",
          style: TextStyle(fontSize: 52.0),
        ), 

        Method one: Optimized using Builder
        To optimize this so that when counter is changed only the text widget rebuilds, we can use Builder with child as Text Widget
        Builder(
          builder: (context) {
            final counterState = context.watch<CounterCubit>().state;
            return Text(
              "${counterState.counter}",
              style: TextStyle(fontSize: 52.0),
            );
          },
        ),
        
        
        Method 2: When we use BlocBuilder, only the widget inside the builder will rebuild
            BlocBuilder<CounterCubit, CounterState>(builder: (context, state) {
          return Text(
            "${state.counter}",
            style: TextStyle(fontSize: 52.0),
          );
        }),
      ),

    */

          BlocConsumer<CounterCubit, CounterState>(listener: (context, state) {
        //This is to do stuff based on cubit state that basically needs an overlay like snackbar, dialog etc
        final snackBar = SnackBar(content: Text('Counter is ${state.counter}'));
        //Dismiss Existing SnackBar
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }, builder: (context, state) {
        return Center(
          child: Text(
            "${state.counter}",
            style: TextStyle(fontSize: 52.0),
          ),
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().increment(),
              heroTag: 'increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().decrement(),
              heroTag: 'decrement',
              child: Icon(Icons.remove),
            )
          ],
        ),
      ),
    );
  }
}
