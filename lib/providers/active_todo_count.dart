import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/models/todo_model.dart';
import 'package:flutter_to_do/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;
  ActiveTodoCountState({required this.activeTodoCount});

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  List<Object> get props => [activeTodoCount];

  bool get stringify => true;

  ActiveTodoCountState copyWtih({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
        activeTodoCount: activeTodoCount ?? this.activeTodoCount);
  }
}

class ActiveTodoCount with ChangeNotifier {
  ActiveTodoCountState _state = ActiveTodoCountState.initial();
  ActiveTodoCountState get state => _state;

  void update(TodoList todoList) {
    final int newActiveTodoCount = todoList.state.todos
        .where((Todo todo) => !todo.completed)
        .toList()
        .length;

    _state = _state.copyWtih(activeTodoCount: newActiveTodoCount);
    notifyListeners();
  }
}
