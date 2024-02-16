import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';

/// select target value [D] from [FlexibleTableControllerMixin]
class TableValueSelector<T extends FlexibleTableControllerMixin, D> extends StatefulWidget {
  const TableValueSelector({
    super.key,
    required this.tableController,
    required this.selector,
    required this.builder,
    this.child,
  });

  final T tableController;
  final D Function(T tableController) selector;
  final Widget Function(BuildContext context, D value, Widget? child) builder;
  final Widget? child;

  @override
  State<TableValueSelector<T, D>> createState() => _TableValueSelectorState<T, D>();
}

class _TableValueSelectorState<T extends FlexibleTableControllerMixin, D> extends State<TableValueSelector<T, D>> {
  late D value;

  @override
  void initState() {
    super.initState();
    value = widget.selector.call(widget.tableController);
    widget.tableController.addListener(onTableDataChanged);
  }

  @override
  void didUpdateWidget(covariant TableValueSelector<T, D> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tableController != oldWidget.tableController) {
      oldWidget.tableController.removeListener(onTableDataChanged);
      widget.tableController.addListener(onTableDataChanged);
    }
    value = widget.selector.call(widget.tableController);
  }

  @override
  void dispose() {
    super.dispose();
    widget.tableController.removeListener(onTableDataChanged);
  }

  void onTableDataChanged() {
    final newValue = widget.selector.call(widget.tableController);
    if (newValue != value) {
      setState(() {
        value = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(context, value, widget.child);
  }
}

/// select target value [A] and [B] from [FlexibleTableControllerMixin]
class TableValueSelector2<T extends FlexibleTableControllerMixin, A, B> extends StatefulWidget {
  const TableValueSelector2({
    super.key,
    required this.tableController,
    required this.selector,
    required this.builder,
    this.child,
  });

  final T tableController;
  final (A, B) Function(T tableController) selector;
  final Widget Function(BuildContext context, A valueA, B valueB, Widget? child) builder;
  final Widget? child;

  @override
  State<TableValueSelector2<T, A, B>> createState() => _TableValueSelector2State<T, A, B>();
}

class _TableValueSelector2State<T extends FlexibleTableControllerMixin, A, B>
    extends State<TableValueSelector2<T, A, B>> {
  late A valueA;
  late B valueB;

  @override
  void initState() {
    super.initState();
    final (A, B) value = widget.selector.call(widget.tableController);
    valueA = value.$1;
    valueB = value.$2;
    widget.tableController.addListener(onTableDataChanged);
  }

  @override
  void didUpdateWidget(covariant TableValueSelector2<T, A, B> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tableController != oldWidget.tableController) {
      oldWidget.tableController.removeListener(onTableDataChanged);
      widget.tableController.addListener(onTableDataChanged);
    }
    final (A, B) value = widget.selector.call(widget.tableController);
    valueA = value.$1;
    valueB = value.$2;
  }

  @override
  void dispose() {
    super.dispose();
    widget.tableController.removeListener(onTableDataChanged);
  }

  void onTableDataChanged() {
    final (A, B) newValue = widget.selector.call(widget.tableController);
    if (newValue.$1 != valueA || newValue.$2 != valueB) {
      setState(() {
        valueA = newValue.$1;
        valueB = newValue.$2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(context, valueA, valueB, widget.child);
  }
}

/// select target value [A] 、[B] and [C] from [FlexibleTableControllerMixin]
class TableValueSelector3<T extends FlexibleTableControllerMixin, A, B, C> extends StatefulWidget {
  const TableValueSelector3({
    super.key,
    required this.tableController,
    required this.selector,
    required this.builder,
    this.child,
  });

  final T tableController;
  final (A, B, C) Function(T tableController) selector;
  final Widget Function(BuildContext context, A valueA, B valueB, C valueC, Widget? child) builder;
  final Widget? child;

  @override
  State<TableValueSelector3<T, A, B, C>> createState() => _TableValueSelector3State<T, A, B, C>();
}

class _TableValueSelector3State<T extends FlexibleTableControllerMixin, A, B, C>
    extends State<TableValueSelector3<T, A, B, C>> {
  late A valueA;
  late B valueB;
  late C valueC;

  @override
  void initState() {
    super.initState();
    final (A, B, C) value = widget.selector.call(widget.tableController);
    valueA = value.$1;
    valueB = value.$2;
    valueC = value.$3;
    widget.tableController.addListener(onTableDataChanged);
  }

  @override
  void didUpdateWidget(covariant TableValueSelector3<T, A, B, C> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tableController != oldWidget.tableController) {
      oldWidget.tableController.removeListener(onTableDataChanged);
      widget.tableController.addListener(onTableDataChanged);
    }
    final (A, B, C) value = widget.selector.call(widget.tableController);
    valueA = value.$1;
    valueB = value.$2;
    valueC = value.$3;
  }

  @override
  void dispose() {
    super.dispose();
    widget.tableController.removeListener(onTableDataChanged);
  }

  void onTableDataChanged() {
    final (A, B, C) newValue = widget.selector.call(widget.tableController);
    if (newValue.$1 != valueA || newValue.$2 != valueB || newValue.$3 != valueC) {
      setState(() {
        valueA = newValue.$1;
        valueB = newValue.$2;
        valueC = newValue.$3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(context, valueA, valueB, valueC, widget.child);
  }
}
