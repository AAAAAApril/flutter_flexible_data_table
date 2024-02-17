import 'package:flutter/widgets.dart';

import 'flexible_table_build_arguments.dart';

class FlexibleTableContentListBuildDelegate<T> {
  const FlexibleTableContentListBuildDelegate();

  /// whether table content list has header item
  bool get hasListHeader => false;

  /// whether table content list has footer item
  bool get hasListFooter => false;

  /// whether should show placeholder widget when table data list is empty
  bool get hasListPlaceholder => false;

  /// table content list total item count
  int getItemCount(FlexibleTableBuildArguments<T> buildArguments) {
    if (buildArguments.tableController.sortedData.isEmpty) {
      return hasListPlaceholder ? 1 : 0;
    }
    return (hasListHeader ? 1 : 0) + buildArguments.tableController.sortedData.length + (hasListFooter ? 1 : 0);
  }

  /// whether [itemIndex] is header index
  bool isHeaderIndex(FlexibleTableBuildArguments<T> buildArguments, int itemIndex) {
    return itemIndex == 0 && hasListHeader;
  }

  /// whether [itemIndex] is footer index
  bool isFooterIndex(FlexibleTableBuildArguments<T> buildArguments, int itemIndex) {
    return itemIndex == buildArguments.tableController.sortedData.length + (hasListHeader ? 1 : 0);
  }

  /// transform [itemIndex] to data index
  int getDataIndex(int itemIndex) => itemIndex - (hasListHeader ? 1 : 0);

  /// build table content list item widget
  Widget buildListItemWidget(BuildContext context, FlexibleTableBuildArguments<T> buildArguments, int itemIndex) {
    //数据是空的，却又需要构建列表项，说明是需要绘制占位组件
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

  Widget buildListDataItemWidget(FlexibleTableBuildArguments<T> buildArguments, int itemIndex) {
    return buildArguments.tableController.tableBuildDelegate.buildTableInfoRow(
      FlexibleTableInfoRowBuildArguments<T>(
        tableController: buildArguments.tableController,
        viewportWidth: buildArguments.viewportWidth,
        dataIndex: getDataIndex(itemIndex),
        itemIndex: itemIndex,
        itemCount: getItemCount(buildArguments),
      ),
    );
  }

  Widget buildListHeaderWidget() => const SizedBox.shrink();

  Widget buildListFooterWidget() => const SizedBox.shrink();

  Widget buildListPlaceholderWidget() => const SizedBox.shrink();
}
