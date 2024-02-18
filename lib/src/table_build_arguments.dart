import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';

class TableBuildArguments<T> {
  const TableBuildArguments({
    required this.tableController,
    required this.viewportWidth,
  });

  final FlexibleTableControllerMixin<T> tableController;
  final double viewportWidth;

  int get dataLength => tableController.sortedData.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableBuildArguments<T> &&
          runtimeType == other.runtimeType &&
          tableController == other.tableController &&
          viewportWidth == other.viewportWidth;

  @override
  int get hashCode => tableController.hashCode ^ viewportWidth.hashCode;
}

class TableRowBuildArguments<T> extends TableBuildArguments<T> {
  const TableRowBuildArguments({
    required super.tableController,
    required super.viewportWidth,
    required this.dataIndex,
    required this.itemIndex,
    required this.itemCount,
  });

  final int dataIndex;
  final int itemIndex;
  final int itemCount;

  T get data => tableController.sortedData[dataIndex];

  bool get isFirst => tableController.sortedData.first == data;

  bool get isLast => tableController.sortedData.last == data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is TableRowBuildArguments<T> &&
          runtimeType == other.runtimeType &&
          dataIndex == other.dataIndex &&
          itemIndex == other.itemIndex &&
          itemCount == other.itemCount;

  @override
  int get hashCode => super.hashCode ^ dataIndex.hashCode ^ itemIndex.hashCode ^ itemCount.hashCode;
}