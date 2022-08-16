import 'dart:math';

import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interfaces/console_interface.dart';

late HookTree hookPointer;

class StateValue<T> {
  dynamic _value;
  final HookTree from;
  final int index;

  T get value => _value;

  set value(T value) {
    _value = value;
    from.owner.update();
  }

  StateValue(this._value, this.from, this.index);

  @override
  String toString() {
    return "$value";
  }
}

class HooksManager {
  final HookComponent owner;
  late final HookTree tree;
  HooksManager(this.owner) {
    tree = HookTreeBase(owner);
  }

  void startCycle() {
    hookPointer = tree;
    tree.resetIndexes();
  }
}

class HookTreeBase extends HookTree {
  HookTreeBase(super.owner);

  @override
  HookTree get parent => this;
}

class HookTree {
  late final HookTree parent;
  HookComponent owner;

  void setParent(HookTree parent) {
    this.parent = parent;
  }

  final List<HookTree> children = [];
  int childIndex = 0;

  final List<StateValue> states = [];
  int stateIndex = 0;

  void resetIndexes() {
    childIndex = 0;
    stateIndex = 0;
    for (final child in children) {
      child.resetIndexes();
    }
  }

  HookTree(this.owner);

  HookTree child(HookComponent owner) {
    stateIndex = 0;
    late HookTree child;
    if (childIndex < children.length) {
      child = children[childIndex];
      child.owner = owner;
    } else {
      child = HookTree(owner);
      child.setParent(this);
      children.add(child);
    }

    hookPointer = child;
    childIndex++;
    return child;
  }

  StateValue<T> state<T>(T defaultValue) {
    if (stateIndex == states.length) {
      states.add(StateValue<T>(defaultValue, this, stateIndex));

      stateIndex++;

      return states.last as StateValue<T>;
    } else if (stateIndex > states.length) {
      throw Exception("FATAL ERROR, hook state modified ilegally");
    } else {
      final r = states[stateIndex] as StateValue<T>;
      stateIndex++;
      return r;
    }
  }

  void up() {
    for (int i = childIndex; i < children.length; i++) {
      children.removeLast();
    }
    stateIndex = 0;
    hookPointer = hookPointer.parent;
  }

  void debugPrintTree(ConsoleInterface console) {
    console.write(
        "Tree node (states ${states.length}, children: ${children.length})");
    console.cursor.down();

    // Print states
    console.cursor.right(2);
    for (final state in states) {
      console.write("| ${state.value}");
      console.cursor.down();
    }
    // End print states

    console.cursor.right(4);
    for (final child in children) {
      child.debugPrintTree(console);
    }
    console.cursor.left(4);
  }
}

abstract class HookComponent extends BuildableComponent {
  String? key;
  HookComponent({this.key});

  void update() {
    userInterface.update();
  }

  @override
  Renderer buildRenderer(BuildContext context) {
    hookPointer.child(this);
    final r = super.buildRenderer(context);
    hookPointer.up();
    return r;
  }
}

StateValue<T> useState<T>(T defaultValue) {
  return hookPointer.state<T>(defaultValue);
}
