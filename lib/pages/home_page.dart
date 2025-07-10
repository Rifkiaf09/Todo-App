import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../helpers/database_helper.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/todo_tile.dart';
import '../widgets/add_todo_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  final VoidCallback onLogout;

  const HomePage({
    required this.onToggleTheme,
    required this.isDarkMode,
    required this.onLogout,
    super.key,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final data = await DatabaseHelper.instance.getTodos();
    setState(() {
      todos = data;
    });
  }

  Future<void> _addTodo(Todo todo) async {
    await DatabaseHelper.instance.insertTodo(todo);
    _loadTodos();
  }

  Future<void> _updateTodo(Todo todo) async {
    await DatabaseHelper.instance.updateTodo(todo);
    _loadTodos();
  }

  Future<void> _deleteTodo(int id) async {
    await DatabaseHelper.instance.deleteTodo(id);
    _loadTodos();
  }

  void _toggleDone(Todo todo) async {
    final updated = todo.copyWith(isDone: !todo.isDone);
    await _updateTodo(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'To-Do List',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
        isDarkMode: widget.isDarkMode,
        onToggleTheme: widget.onToggleTheme,
        onLogout: widget.onLogout,
      ),
      body: todos.isEmpty
          ? const Center(child: Text('Belum ada tugas.'))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoTile(
                  todo: todo,
                  onToggleDone: () => _toggleDone(todo),
                  onEdit: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTodoPage(
                          todo: todo,
                          onSave: (updatedTodo) => _updateTodo(updatedTodo),
                        ),
                      ),
                    );
                  },
                  onDelete: () => _deleteTodo(todo.id!),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoPage(
                onSave: (todo) => _addTodo(todo),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
