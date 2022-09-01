import 'package:flutter/material.dart';
import 'package:flutter_to_do/models/todo_model.dart';
import 'package:flutter_to_do/providers/todo_filter.dart';
import 'package:flutter_to_do/providers/todo_list.dart';
import 'package:flutter_to_do/providers/todo_search.dart';

class FilteredTodosState {
  final List<Todo> filteredTodos;

  FilteredTodosState({required this.filteredTodos});

  factory FilteredTodosState.initial() {
    return FilteredTodosState(filteredTodos: []);
  }

  List<Object> get props => [filteredTodos];

  bool get stringify => true;

  FilteredTodosState copyWith({List<Todo>? filteredTodos}) {
    return FilteredTodosState(
        filteredTodos: filteredTodos ?? this.filteredTodos);
  }
}

class FilteredTodos with ChangeNotifier {
  FilteredTodosState _state = FilteredTodosState.initial();
  FilteredTodosState get state => _state;

  void update(
    TodoFilter todoFilter,
    TodoSearch todoSearch,
    TodoList todoList,
  ) {
    List<Todo> _filteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => !todo.completed).toList();
        break;

      case Filter.completed:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearch.state.searchTerm))
          .toList();
    }

    _state = _state.copyWith(filteredTodos: _filteredTodos);
    notifyListeners();
  }
}
