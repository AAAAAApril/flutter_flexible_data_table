import 'package:flutter/widgets.dart';

import 'table_build_arguments.dart';

abstract class AbsTableListBuildDelegate<T> {
  const AbsTableListBuildDelegate();

  /// whether table content list has header item
  bool get hasListHeader;

  /// whether table content list has footer item
  bool get hasListFooter;

  /// whether should show placeholder widget when table data list is empty
  bool get hasListPlaceholder;

  /// build table content list header item
  Widget buildListHeaderWidget();

  /// build table content list footer item
  Widget buildListFooterWidget();

  /// build placeholder widget when table data list is empty
  Widget buildListPlaceholderWidget();

  /// build table data list item widget
  Widget buildListDataItemWidget(TableBuildArguments<T> buildArguments, int itemIndex) {
    return buildArguments.tableController.rowBuildDelegate.buildTableInfoRow(
      TableRowBuildArguments<T>(
        tableController: buildArguments.tableController,
        viewportWidth: buildArguments.viewportWidth,
        dataIndex: getDataIndex(itemIndex),
        itemIndex: itemIndex,
        itemCount: getItemCount(buildArguments),
      ),
    );
  }

  /// table content list total item count
  int getItemCount(TableBuildArguments<T> buildArguments) {
    if (buildArguments.tableController.sortedData.isEmpty) {
      return hasListPlaceholder ? 1 : 0;
    }
    return (hasListHeader ? 1 : 0) + buildArguments.tableController.sortedData.length + (hasListFooter ? 1 : 0);
  }

  /// whether [itemIndex] is header index
  bool isHeaderIndex(TableBuildArguments<T> buildArguments, int itemIndex) {
    return itemIndex == 0 && hasListHeader;
  }

  /// whether [itemIndex] is footer index
  bool isFooterIndex(TableBuildArguments<T> buildArguments, int itemIndex) {
    return itemIndex == buildArguments.tableController.sortedData.length + (hasListHeader ? 1 : 0);
  }

  /// transform [itemIndex] to data index
  int getDataIndex(int itemIndex) => itemIndex - (hasListHeader ? 1 : 0);

  /// build table content list item widget
  Widget buildListItemWidget(BuildContext context, TableBuildArguments<T> buildArguments, int itemIndex) {
    if (buildArguments.tableController.sortedData.isEmpty && hasListPlaceholder) {
      return buildListPlaceholderWidget();
    }
    if (isHeaderIndex(buildArguments, itemIndex)) {
      return buildListHeaderWidget();
    }
    if (isFooterIndex(buildArguments, itemIndex)) {
      return buildListFooterWidget();
    }
    return buildListDataItemWidget(buildArguments, itemIndex);
  }
}

class TableListBuildDelegate<T> extends AbsTableListBuildDelegate<T> {
  const TableListBuildDelegate();

  @override
  bool get hasListFooter => false;

  @override
  bool get hasListHeader => false;

  @override
  bool get hasListPlaceholder => false;

  @override
  Widget buildListHeaderWidget() => const SizedBox.shrink();

  @override
  Widget buildListFooterWidget() => const SizedBox.shrink();

  @override
  Widget buildListPlaceholderWidget() => const SizedBox.shrink();
}
