import 'package:dart_console_user_interface/base.dart';

class LayoutBoundaries {
  final Dimensions minSize;
  final Dimensions maxSize;
  LayoutBoundaries(
      {this.minSize = Dimensions.zero, this.maxSize = Dimensions.zero});
}

class BuildContext {
  final LayoutBoundaries layoutBoundaries;
  BuildContext({required this.layoutBoundaries});
}
