import 'package:flutter/foundation.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';

class TableValueNotifier<T extends FlexibleTableControllerMixin, D> extends ValueNotifier<D> {
  TableValueNotifier(
    this.tableController, {
    required this.selector,
  }) : super(selector.call(tableController)) {
    tableController.addListener(onTableControllerChanged);
  }

  @protected
  @override
  set value(D newValue) {
    super.value = newValue;
  }

  @override
  void dispose() {
    tableController.removeListener(onTableControllerChanged);
    super.dispose();
  }

  final T tableController;
  final D Function(T tableController) selector;

  void onTableControllerChanged() {
    value = selector.call(tableController);
  }
}

class TableValueNotifier2<T extends FlexibleTableControllerMixin, A, B> extends ValueNotifier<(A, B)> {
  TableValueNotifier2(
    this.tableController, {
    required this.selector,
  }) : super(selector.call(tableController)) {
    tableController.addListener(onTableControllerChanged);
  }

  @protected
  @override
  set value((A, B) newValue) {
    super.value = newValue;
  }

  @override
  void dispose() {
    tableController.removeListener(onTableControllerChanged);
    super.dispose();
  }

  final T tableController;
  final (A, B) Function(T tableController) selector;

  A get valueA => value.$1;
  B get valueB => value.$2;

  void onTableControllerChanged() {
    final newValue = selector.call(tableController);
    if (newValue.$1 != valueA || newValue.$2 != valueB) {
      value = newValue;
    }
  }
}

class TableValueNotifier3<T extends FlexibleTableControllerMixin, A, B, C> extends ValueNotifier<(A, B, C)> {
  TableValueNotifier3(
    this.tableController, {
    required this.selector,
  }) : super(selector.call(tableController)) {
    tableController.addListener(onTableControllerChanged);
  }

  @protected
  @override
  set value((A, B, C) newValue) {
    super.value = newValue;
  }

  @override
  void dispose() {
    tableController.removeListener(onTableControllerChanged);
    super.dispose();
  }

  final T tableController;
  final (A, B, C) Function(T tableController) selector;

  A get valueA => value.$1;
  B get valueB => value.$2;
  C get valueC => value.$3;

  void onTableControllerChanged() {
    final newValue = selector.call(tableController);
    if (newValue.$1 != valueA || newValue.$2 != valueB || newValue.$3 != valueC) {
      value = newValue;
    }
  }
}
