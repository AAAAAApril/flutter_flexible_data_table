import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_build_arguments.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';
import 'package:flutter_flexible_data_table/src/widgets/flexible_table_scope.dart';

import 'widgets/lazy_layout_builder.dart';

/// table header row widget
class FlexibleTableHeader<T, C extends FlexibleTableControllerMixin<T>> extends StatelessWidget {
  const FlexibleTableHeader({
    super.key,
    this.tableController,
  });

  final C? tableController;

  Widget buildRow(C tableController) {
    return LazyLayoutBuilder(
      builder: (context, viewportWidth) => tableController.tableBuildDelegate.buildTableHeaderRow(
        FlexibleTableBuildArguments<T>(
          tableController: tableController,
          viewportWidth: viewportWidth,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (tableController != null) {
      return FlexibleTableScope<C>(
        notifier: tableController!,
        child: buildRow(tableController!),
      );
    }
    return buildRow(FlexibleTableScope.get<C>(context));
  }
}
