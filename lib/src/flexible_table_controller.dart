import 'dart:async';
import 'dart:collection';

import 'package:flutter/widgets.dart';

import 'custom/flexible_table_value_mixin.dart';
import 'flexible_table_build_delegate.dart';
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

  /// table widget build delegate
  FlexibleTableBuildDelegateMixin<T, FlexibleTableControllerMixin<T>> get tableBuildDelegate;

  /// notify raw table data list
  void setRawData(List<T> rawData);

  /// return next sort type of [sortingType]
  FlexibleTableSortType getNextSortType();

  /// notify table sort type
  void setSortingType(FlexibleTableSortType newType);

  /// notify table sorting column
  void setSortingColumn(Object? columnId);

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

  @override
  void notifyListeners() {
    if (isDisposed) {
      return;
    }
    super.notifyListeners();
  }
}

abstract class AbsFlexibleTableController<T> extends ChangeNotifier
    with FlexibleTableControllerMixin<T>, FlexibleTableValueMixin<T> {
  AbsFlexibleTableController();

  UnmodifiableListView<T> _rawDataList = UnmodifiableListView<T>(<T>[]);
  UnmodifiableListView<T> _sortedDataList = UnmodifiableListView<T>(<T>[]);
  FlexibleTableSortType _currentSortType = FlexibleTableSortType.normal;
  AbsFlexibleTableColumn<T>? _currentSortColumn;

  bool _disposed = false;
  Timer? _notifyDelay;

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
  void setRawData(List<T> rawData) {
    _rawDataList = UnmodifiableListView<T>(rawData);
    notifyListenersDelayed();
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
    notifyListenersDelayed();
  }

  @override
  void setSortingColumn(Object? columnId) {
    if (_currentSortColumn?.id == columnId) {
      return;
    }
    _currentSortColumn = columnId == null ? null : tableBuildDelegate.findTableColumnById(columnId);
    notifyListenersDelayed();
  }

  @protected
  void setSortedData(List<T> sortedData) {
    _sortedDataList = UnmodifiableListView<T>(sortedData);
    super.notifyListeners();
  }

  @protected
  void notifyListenersDelayed() {
    _notifyDelay?.cancel();
    _notifyDelay = Timer(Duration.zero, () {
      final List<T> dataListNeedSort = List<T>.of(_rawDataList);
      sortDataList(dataListNeedSort);
      setSortedData(dataListNeedSort);
    });
  }

  @override
  void dispose() {
    _notifyDelay?.cancel();
    _disposed = true;
    super.dispose();
  }
}
