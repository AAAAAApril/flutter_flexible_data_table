import 'package:flutter/widgets.dart';

import 'table_build_arguments.dart';
import 'flexible_table_controller.dart';

abstract class AbsFlexibleTableColumn<T> {
  const AbsFlexibleTableColumn(this.id);

  /// table column unique id
  final Object id;

  /// header widget of current table column
  Widget buildHeaderCell(TableBuildArguments<T> arguments);

  /// table data info widget of current table column
  Widget buildInfoCell(TableRowBuildArguments<T> arguments);

  /// called when sort by current table column
  int compare(FlexibleTableControllerMixin<T> tableController, T a, T b) => 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbsFlexibleTableColumn<T> && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
