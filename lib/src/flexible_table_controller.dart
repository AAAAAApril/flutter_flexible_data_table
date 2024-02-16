import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'flexible_table_column.dart';
import 'flexible_table_sort_type.dart';

mixin FlexibleTableControllerMixin<T> on ChangeNotifier {
  /// table data list
  UnmodifiableListView<T> get rawData;

  /// sorted table data list
  UnmodifiableListView<T> get sortedData;

  /// current sort type
  FlexibleTableSortType get sortingType;

  /// current sorting table column
  AbsFlexibleTableColumn<T>? get sortingColumn;

  /// all table columns
  Set<AbsFlexibleTableColumn<T>> get tableColumns;

  /// notify raw table data list
  void setRawData(List<T> rawData);

  /// notify table sort type
  void setSortingType(FlexibleTableSortType newType);

  /// notify table sorting column
  void setSortingColumn(AbsFlexibleTableColumn<T>? newColumn);

  /// sort data list by [sortingType] and [sortingColumn]
  void sortDataList(List<T> source) {
    if (source.isEmpty || sortingType == FlexibleTableSortType.normal || sortingColumn == null) {
      return;
    }
    source.sort((a, b) {
      int result = sortingColumn!.compare(this, a, b);
      if (sortingType == FlexibleTableSortType.descending) {
        result = -result;
      }
      return result;
    });
  }

  AbsFlexibleTableColumn<T>? findTableColumnById(Object columnId) {
    try {
      return tableColumns.firstWhere((element) => element.id == columnId);
    } catch (_) {
      return null;
    }
  }
}

mixin FlexibleTableController<T> implements FlexibleTableControllerMixin<T> {}
