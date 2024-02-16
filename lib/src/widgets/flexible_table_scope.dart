import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';

class FlexibleTableScope<T extends FlexibleTableControllerMixin> extends InheritedNotifier<T> {
  static T of<T extends FlexibleTableControllerMixin>(BuildContext context) {
    final notifier = context.dependOnInheritedWidgetOfExactType<FlexibleTableScope<T>>();
    assert(notifier != null, 'No ${T.runtimeType} found in context.');
    return notifier!.notifier!;
  }

  const FlexibleTableScope({
    super.key,
    required T super.notifier,
    required super.child,
  });
}
