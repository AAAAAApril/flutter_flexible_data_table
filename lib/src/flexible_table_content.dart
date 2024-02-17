import 'package:flutter/widgets.dart';

import 'flexible_table_content_list_build_delegate.dart';
import 'flexible_table_controller.dart';

class FlexibleTableContent<T, C extends FlexibleTableControllerMixin<T>> extends StatelessWidget {
  const FlexibleTableContent({
    super.key,
    this.tableController,
    this.listBuildDelegate,
  });

  final C? tableController;
  final AbsFlexibleTableContentListBuildDelegate<T>? listBuildDelegate;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Placeholder();
  }
}
