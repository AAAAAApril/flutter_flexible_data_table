import 'package:flutter/foundation.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_column.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_controller.dart';
import 'package:flutter_flexible_data_table/src/flexible_table_sort_type.dart';
import 'package:flutter_flexible_data_table/src/utils/flexible_table_value_notifier.dart';

mixin FlexibleTableValueMixin<T> on FlexibleTableControllerMixin<T> {
  ValueListenable<FlexibleTableSortType> get currentSortingType =>
      _currentSortingType ??= FlexibleTableValueNotifier<FlexibleTableControllerMixin<T>, FlexibleTableSortType>(
        this,
        selector: (tableController) => tableController.sortingType,
      );

  ValueListenable<AbsFlexibleTableColumn<T>?> get currentSortingColumn =>
      _currentSortingColumn ??= FlexibleTableValueNotifier<FlexibleTableControllerMixin<T>, AbsFlexibleTableColumn<T>?>(
        this,
        selector: (tableController) => tableController.sortingColumn,
      );

  ValueListenable<List<T>> get dataList =>
      _value ??= FlexibleTableValueNotifier<FlexibleTableControllerMixin<T>, List<T>>(
        this,
        selector: (tableController) => tableController.sortedData,
      );

  ValueListenable<bool> get isNotEmpty =>
      _isNotEmpty ??= FlexibleTableValueNotifier<FlexibleTableControllerMixin<T>, bool>(
        this,
        selector: (tableController) => tableController.sortedData.isNotEmpty,
      );

  ValueNotifier<FlexibleTableSortType>? _currentSortingType;
  ValueNotifier<AbsFlexibleTableColumn<T>?>? _currentSortingColumn;
  ValueNotifier<List<T>>? _value;
  ValueNotifier<bool>? _isNotEmpty;

  @override
  void dispose() {
    _isNotEmpty?.dispose();
    _value?.dispose();
    _currentSortingColumn?.dispose();
    _currentSortingType?.dispose();
    super.dispose();
  }
}
