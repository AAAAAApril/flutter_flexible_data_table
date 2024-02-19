import 'package:flutter/widgets.dart';
import 'package:flutter_flexible_data_table/src/table_build_arguments.dart';
import 'package:flutter_flexible_data_table/src/widgets/lazy_layout_builder.dart';
import 'package:flutter_flexible_data_table/src/widgets/table_value_selector.dart';

import 'table_list_build_delegate.dart';
import 'flexible_table_controller.dart';
import 'widgets/flexible_table_scope.dart';

class FlexibleTableList<T, C extends FlexibleTableControllerMixin<T>> extends StatelessWidget {
  const FlexibleTableList({super.key, this.tableController, this.listBuildDelegate});

  final C? tableController;
  final AbsTableListBuildDelegate<T>? listBuildDelegate;

  @override
  Widget build(BuildContext context) {
    if (tableController != null) {
      return FlexibleTableScope<C>(
        notifier: tableController!,
        child: buildContent(tableController!),
      );
    }
    return buildContent(FlexibleTableScope.get<C>(context));
  }

  Widget buildContent(C tableController) {
    final AbsTableListBuildDelegate<T> buildDelegate = listBuildDelegate ?? TableListBuildDelegate<T>();
    return LazyLayoutBuilder(builder: (context, viewportWidth) {
      final TableBuildArguments<T> arguments = TableBuildArguments<T>(
        tableController: tableController,
        viewportWidth: viewportWidth,
      );
      return TableValueSelector<C, List<T>>(
        tableController: tableController,
        selector: (tableController) => tableController.sortedData,
        builder: (context, value, child) => ListView.builder(
          itemCount: buildDelegate.getItemCount(arguments),
          primary: false,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => buildDelegate.buildListItemWidget(context, arguments, index),
        ),
      );
    });
  }
}

class FlexibleTableSliverList<T, C extends FlexibleTableControllerMixin<T>> extends StatelessWidget {
  const FlexibleTableSliverList({super.key, this.tableController, this.listBuildDelegate});

  final C? tableController;
  final AbsTableListBuildDelegate<T>? listBuildDelegate;

  @override
  Widget build(BuildContext context) {
    if (tableController != null) {
      return FlexibleTableScope<C>(
        notifier: tableController!,
        child: buildContent(tableController!),
      );
    }
    return buildContent(FlexibleTableScope.get<C>(context));
  }

  Widget buildContent(C tableController) {
    final AbsTableListBuildDelegate<T> buildDelegate = listBuildDelegate ?? TableListBuildDelegate<T>();
    return LazySliverLayoutBuilder(builder: (context, viewportWidth) {
      final TableBuildArguments<T> arguments = TableBuildArguments<T>(
        tableController: tableController,
        viewportWidth: viewportWidth,
      );
      return TableValueSelector<C, List<T>>(
        tableController: tableController,
        selector: (tableController) => tableController.sortedData,
        builder: (context, value, child) => SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => buildDelegate.buildListItemWidget(context, arguments, index),
            childCount: buildDelegate.getItemCount(arguments),
          ),
        ),
      );
    });
  }
}
