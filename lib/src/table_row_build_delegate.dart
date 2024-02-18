import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';

import 'table_build_arguments.dart';
import 'flexible_table_column.dart';

mixin TableRowBuildDelegateMixin<T, C extends FlexibleTableControllerMixin<T>> {
  C get tableController;

  /// all table columns
  List<AbsFlexibleTableColumn<T>> get tableColumns;

  /// find table column by [AbsFlexibleTableColumn.id]
  AbsFlexibleTableColumn<T>? findTableColumnById(Object columnId) {
    try {
      return tableColumns.firstWhere((element) => element.id == columnId);
    } catch (_) {
      return null;
    }
  }

  /// build table header row widget
  Widget buildTableHeaderRow(TableBuildArguments<T> arguments);

  /// build table info row widget
  Widget buildTableInfoRow(TableRowBuildArguments<T> arguments);
}

abstract class AbsTableRowBuildDelegate<T, C extends FlexibleTableControllerMixin<T>>
    with TableRowBuildDelegateMixin<T, C> {
  const AbsTableRowBuildDelegate(this.tableController);

  @override
  final C tableController;

  @override
  Widget buildTableHeaderRow(TableBuildArguments<T> arguments) {
    return buildTableRow(arguments, (column) => column.buildHeaderCell(arguments));
  }

  @override
  Widget buildTableInfoRow(TableRowBuildArguments<T> arguments) {
    return buildTableRow(arguments, (column) => column.buildInfoCell(arguments));
  }

  @protected
  Widget buildTableRow(
    TableBuildArguments<T> arguments,
    Widget Function(AbsFlexibleTableColumn<T> column) buildCell,
  );
}
