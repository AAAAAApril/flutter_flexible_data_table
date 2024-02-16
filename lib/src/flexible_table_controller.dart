import 'dart:collection';

import 'package:flutter/widgets.dart';

import 'flexible_table_build_arguments.dart';
import 'flexible_table_column.dart';
import 'flexible_table_sort_type.dart';

mixin FlexibleTableControllerMixin<T> on ChangeNotifier {
  /// whether table is disposed
  bool get isDisposed;

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

  /// return next sort type of [sortingType]
  FlexibleTableSortType getNextSortType();

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

  @override
  void notifyListeners() {
    if (isDisposed) {
      return;
    }
    super.notifyListeners();
  }
}

abstract class AbsFlexibleTableController<T> extends ChangeNotifier with FlexibleTableControllerMixin<T> {
  AbsFlexibleTableController();

  UnmodifiableListView<T> _rawDataList = UnmodifiableListView<T>(<T>[]);
  UnmodifiableListView<T> _sortedDataList = UnmodifiableListView<T>(<T>[]);
  FlexibleTableSortType _currentSortType = FlexibleTableSortType.normal;
  AbsFlexibleTableColumn<T>? _currentSortColumn;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  bool get isDisposed => _disposed;

  @override
  UnmodifiableListView<T> get rawData => _rawDataList;

  @override
  UnmodifiableListView<T> get sortedData => _sortedDataList;

  @override
  FlexibleTableSortType get sortingType => _currentSortType;

  @override
  AbsFlexibleTableColumn<T>? get sortingColumn => _currentSortColumn;

  @override
  Set<AbsFlexibleTableColumn<T>> get tableColumns;

  @override
  void setRawData(List<T> rawData) {
    _rawDataList = UnmodifiableListView<T>(rawData);
    sortAndNotifyListeners();
  }

  @override
  FlexibleTableSortType getNextSortType() {
    return switch (sortingType) {
      FlexibleTableSortType.normal => FlexibleTableSortType.descending,
      FlexibleTableSortType.ascending => FlexibleTableSortType.normal,
      FlexibleTableSortType.descending => FlexibleTableSortType.ascending,
    };
  }

  @override
  void setSortingType(FlexibleTableSortType newType) {
    if (_currentSortType == newType) {
      return;
    }
    _currentSortType = newType;
    sortAndNotifyListeners();
  }

  @override
  void setSortingColumn(AbsFlexibleTableColumn<T>? newColumn) {
    if (_currentSortColumn == newColumn) {
      return;
    }
    _currentSortColumn = newColumn;
    sortAndNotifyListeners();
  }

  @protected
  void sortAndNotifyListeners() {
    final List<T> dataListNeedSort = List<T>.of(_rawDataList);
    sortDataList(dataListNeedSort);
    _sortedDataList = UnmodifiableListView<T>(dataListNeedSort);
    super.notifyListeners();
  }

  @override
  Widget buildTableHeaderRow(FlexibleTableBuildArguments<T> arguments);

  @override
  Widget buildTableInfoRow(FlexibleTableInfoRowBuildArguments<T> arguments);
}
