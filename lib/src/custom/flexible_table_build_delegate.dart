import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_build_arguments.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_build_delegate.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_column.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';

class FlexibleTableBuildDelegate<T, C extends FlexibleTableControllerMixin<T>>
    extends AbsFlexibleTableBuildDelegate<T, C> {
  FlexibleTableBuildDelegate(
    super.tableController, {
    Set<AbsFlexibleTableColumn<T>>? startColumns,
    Set<AbsFlexibleTableColumn<T>>? scrollableColumns,
    Set<AbsFlexibleTableColumn<T>>? endColumns,
  })  : _startPinnedColumns = Set<AbsFlexibleTableColumn<T>>.of(startColumns ?? {}),
        _centerScrollableColumns = Set<AbsFlexibleTableColumn<T>>.of(scrollableColumns ?? {}),
        _endPinnedColumns = Set<AbsFlexibleTableColumn<T>>.of(endColumns ?? {});

  final Set<AbsFlexibleTableColumn<T>> _startPinnedColumns;
  final Set<AbsFlexibleTableColumn<T>> _centerScrollableColumns;
  final Set<AbsFlexibleTableColumn<T>> _endPinnedColumns;

  @override
  late final List<AbsFlexibleTableColumn<T>> tableColumns = [
    ..._startPinnedColumns,
    ..._centerScrollableColumns,
    ..._endPinnedColumns,
  ];

  @override
  Widget buildTableRow(
    FlexibleTableBuildArguments<T> arguments,
    Widget Function(AbsFlexibleTableColumn<T> column) buildCell,
  ) {
    // TODO: implement buildTableRow
    throw UnimplementedError();
  }
}
