import 'package:dart_console_user_interface/boundaries.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/component.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/tree.dart';

class Element extends Tree implements BuildContext {
  late Element _parent;
  final List<Element> _children = <Element>[];

  final Component _component;

  Element(this._component) {
    _parent = this;
  }

  @override
  Element get parent => _parent;

  Component get component => _component;

  void attachTo(Element parent) {
    _parent = parent;
    build();
  }

  @override
  List<Element> get children => _children;

  final Map<Component, Element> _previosChildren = <Component, Element>{};

  void build() {
    for (final elem in children) {
      _previosChildren[elem.component] = elem;
    }
    _children.clear();
    _component.buildChildren(this);
  }

  void render(ConsoleInterface console) {
    _component.render(console, this);
  }

  // BuildContext
  @override
  void addChild(Component child) {
    if (_previosChildren.containsKey(child)) {
      _children.add(_previosChildren[child]!);
      _previosChildren[child]!.build();
    } else {
      final elem = child.createElement();
      elem.attachTo(this);
      _children.add(elem);
    }
  }

  @override
  DimensionalBoundaries get size => children[0].size;

  @override
  LayoutBoundaries get layoutBoundaries => parent.layoutBoundaries;

  @override
  BuildContext get owner => parent;

  // DEBUG
  @override
  void debugPrintTree(ConsoleInterface console) {
    console.write('$runtimeType (${component.runtimeType})');
    console.cursor.down(1);
    if (children.isNotEmpty) {
      console.cursor.right(4);
      for (final child in children) {
        child.debugPrintTree(console);
      }
      console.cursor.left(4);
    }
  }
}

class RenderableElement extends Element {
  // @override
  // addChildrenComponent
  // In this case children is empty.
  // RenderableElement when is attached to a parent, it does nothing on 'addChildrenComponent' because it has no children.
  // Anyways, it buildChildren is called and also build (on RendereableComponent)

  final RendererComponent _renderableComponent;

  RenderableElement(this._renderableComponent) : super(_renderableComponent);

  @override
  DimensionalBoundaries get size => _renderableComponent.size;

  @override
  LayoutBoundaries get layoutBoundaries {
    // RendererComponent has already built
    return _renderableComponent.layoutBoundaries;
  }
}
