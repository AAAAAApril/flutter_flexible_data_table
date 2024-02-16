import 'package:flutter/widgets.dart';

import 'flexible_table_controller.dart';

class FlexibleTableContent<T, C extends FlexibleTableControllerMixin<T>> extends StatelessWidget {
  const FlexibleTableContent({
    super.key,
    this.tableController,
  });

  final C? tableController;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
