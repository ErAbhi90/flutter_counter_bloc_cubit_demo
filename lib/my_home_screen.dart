import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc_cubit_demo/blocs/counter/counter_bloc.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state.counter > 10) {
            // Dismiss any existing Snackbar
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Counter is greater than 10'),
              ),
            );
          }
        },
        child: Builder(builder: (context) {
          return Center(
            child: Text(
              '${context.watch<CounterBloc>().state.counter}',
              style: TextStyle(fontSize: 52.0),
            ),
          );
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () =>
                  context.read<CounterBloc>().add(CounterIncrementEvent()),
              heroTag: 'increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () =>
                  context.read<CounterBloc>().add(CounterDecrementEvent()),
              heroTag: 'decrement',
              child: Icon(Icons.remove),
            )
          ],
        ),
      ),
    );
  }
}
