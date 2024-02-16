import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';

import 'flexible_table_scope.dart';

class TableInfoSelector<T extends FlexibleTableControllerMixin, D> extends StatefulWidget {
  const TableInfoSelector({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final D Function(T tableController) selector;
  final Widget Function(BuildContext context, D info, Widget? child) builder;
  final Widget? child;

  @override
  State<TableInfoSelector<T, D>> createState() => _TableInfoSelectorState<T, D>();
}

class _TableInfoSelectorState<T extends FlexibleTableControllerMixin, D> extends State<TableInfoSelector<T, D>> {
  T? tableController;
  late D info;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tableController?.removeListener(onTableChanged);
    tableController = FlexibleTableScope.of<T>(context);
    info = widget.selector.call(tableController!);
    tableController!.addListener(onTableChanged);
  }

  @override
  void dispose() {
    super.dispose();
    tableController?.removeListener(onTableChanged);
  }

  void onTableChanged() {
    final D newInfo = widget.selector.call(tableController!);
    if (newInfo != info) {
      setState(() {
        info = newInfo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(context, info, widget.child);
  }
}
