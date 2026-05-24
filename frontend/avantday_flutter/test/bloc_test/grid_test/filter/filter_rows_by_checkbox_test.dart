import 'package:avantday/plugins/database_view/application/filter/filter_service.dart';
import 'package:avantday_backend/protobuf/flowy-database/checkbox_filter.pbenum.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util.dart';
import 'filter_util.dart';

void main() {
  late AvantdayGridTest gridTest;
  setUpAll(() async {
    gridTest = await AvantdayGridTest.ensureInitialized();
  });

  test('filter rows by checkbox is check condition)', () async {
    final context = await createTestFilterGrid(gridTest);
    final service = FilterBackendService(viewId: context.gridView.id);

    final controller = await context.makeCheckboxCellController(0);
    controller.saveCellData("Yes");
    await gridResponseFuture();

    // create a new filter
    final checkboxField = context.checkboxFieldContext();
    await service.insertCheckboxFilter(
      fieldId: checkboxField.id,
      condition: CheckboxFilterConditionPB.IsChecked,
    );
    await gridResponseFuture();
    assert(context.rowInfos.length == 1,
        "expect 1 but receive ${context.rowInfos.length}");
  });

  test('filter rows by checkbox is uncheck condition)', () async {
    final context = await createTestFilterGrid(gridTest);
    final service = FilterBackendService(viewId: context.gridView.id);

    final controller = await context.makeCheckboxCellController(0);
    controller.saveCellData("Yes");
    await gridResponseFuture();

    // create a new filter
    final checkboxField = context.checkboxFieldContext();
    await service.insertCheckboxFilter(
      fieldId: checkboxField.id,
      condition: CheckboxFilterConditionPB.IsUnChecked,
    );
    await gridResponseFuture();
    assert(context.rowInfos.length == 2,
        "expect 2 but receive ${context.rowInfos.length}");
  });
}
