import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_build_arguments.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_build_delegate.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_column.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';

class FlexibleTableBuildDelegate<T, C extends FlexibleTableControllerMixin<T>>
    extends AbsFlexibleTableBuildDelegate<T, C> {

  FlexibleTableBuildDelegate(super.tableController);

  @override
  // TODO: implement tableColumns
  Set<AbsFlexibleTableColumn<T>> get tableColumns => throw UnimplementedError();

  @override
  Widget buildTableHeaderRow(FlexibleTableBuildArguments<T> arguments) {
    // TODO: implement buildTableHeaderRow
    throw UnimplementedError();
  }

  @override
  Widget buildTableInfoRow(FlexibleTableInfoRowBuildArguments<T> arguments) {
    // TODO: implement buildTableInfoRow
    throw UnimplementedError();
  }
}
