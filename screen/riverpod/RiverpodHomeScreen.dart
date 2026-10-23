import 'package:flutter/material.dart';
import 'widgets/TodoList.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../riverpod/RiverpodNotifier.dart';

class TabScreen extends StatelessWidget {
  List<Todo> todos;

  TabScreen(this.todos);

  @override
  Widget build(BuildContext context) {
    return Container(child: TodoList(this.todos));
  }
}

class RiverpodHomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<RiverpodHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this); //animation
  }

  @override
  Widget build(BuildContext context) {

    final todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              context.push("/riverpod-add");
            },
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Complete'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          TabScreen(todos),
          TabScreen(todos.where((todo) => !todo.completed).toList()),
          TabScreen(todos.where((todo) => todo.completed).toList()),
        ],
      ),
    );
  }
}
