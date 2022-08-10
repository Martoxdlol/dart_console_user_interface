import 'dart:html';

abstract class TreeObject {
  TreeObject? get parent;
  List<TreeObject> get children;
}

class TreeRoot extends TreeObject {
  TreeObject? child;
  TreeRoot([this.child]);

  @override
  TreeObject? get parent => null;

  @override
  List<TreeObject> get children => [];

  void appendChild(TreeObject child) {
    if (this.child != null) throw ErrorEvent("Only one child allowed");
    child = child;
  }
}

class Tree {
  TreeObject? root;
  Tree([this.root]);
}
