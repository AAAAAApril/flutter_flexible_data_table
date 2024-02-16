import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';

import 'flexible_table_build_arguments.dart';
import 'flexible_table_column.dart';

mixin FlexibleTableBuildDelegateMixin<T, C extends FlexibleTableControllerMixin<T>> {
  C get tableController;

  /// all table columns
  Set<AbsFlexibleTableColumn<T>> get tableColumns;

  /// find table column by [AbsFlexibleTableColumn.id]
  AbsFlexibleTableColumn<T>? findTableColumnById(Object columnId) {
    try {
      return tableColumns.firstWhere((element) => element.id == columnId);
    } catch (_) {
      return null;
    }
  }

  /// build table header row widget
  Widget buildTableHeaderRow(FlexibleTableBuildArguments<T> arguments);

  /// build table info row widget
  Widget buildTableInfoRow(FlexibleTableInfoRowBuildArguments<T> arguments);
}

abstract class AbsFlexibleTableBuildDelegate<T, C extends FlexibleTableControllerMixin<T>>
    with FlexibleTableBuildDelegateMixin<T, C> {
  const AbsFlexibleTableBuildDelegate(this.tableController);

  @override
  final C tableController;
}
