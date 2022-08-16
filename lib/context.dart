import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/build_context.dart';

class SumExpression extends BuildableComponent {
  final Component child;
  SumExpression(this.child);

  @override
  Component build(BuildContext context) {
    return child;
  }
}
