import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_build_arguments.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';
import 'package:flutter_flexible_data_table/src/widgets/flexible_table_scope.dart';

/// table header row widget
class FlexibleTableHeader<T, C extends FlexibleTableControllerMixin<T>> extends StatelessWidget {
  const FlexibleTableHeader({
    super.key,
    this.tableController,
  });

  final C? tableController;

  @override
  Widget build(BuildContext context) {
    if (tableController != null) {
      return FlexibleTableScope<C>(
        notifier: tableController!,
        child: tableController!.buildTableHeaderRow(
          FlexibleTableBuildArguments<T>(tableController: tableController!),
        ),
      );
    }
    final controller = FlexibleTableScope.get<C>(context);
    return controller.buildTableHeaderRow(
      FlexibleTableBuildArguments<T>(tableController: controller),
    );
  }
}
