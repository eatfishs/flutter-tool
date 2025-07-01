/**
 * @author: jiangjunhui
 * @date: 2025/5/29
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter/counter_bloc.dart';

class CounterFirstBlocPagePage extends StatelessWidget {
  const CounterFirstBlocPagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider 只在 CounterPage 及其子 Widget 中可用
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const CounterFirstBlocView(),
    );
  }
}



class CounterFirstBlocView extends StatefulWidget {
  const CounterFirstBlocView({super.key});

  @override
  State<CounterFirstBlocView> createState() => _CounterFirstBlocViewState();
}

class _CounterFirstBlocViewState extends State<CounterFirstBlocView> {
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Bloc Counter')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text(
              'Count: ${state.count}',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => counterBloc.add(CounterEvent.increment),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => counterBloc.add(CounterEvent.decrement),
          ),
        ],
      ),
    );
  }
}
