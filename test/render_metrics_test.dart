// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:render_metrics/render_metrics.dart';

import 'test_utils.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(RenderMetricsBox());
  });

  const firstId = 'first';
  const secondId = 'second';

  group(
    'RenderParametersManager',
    () {
      testWidgets(
        "Calling the renderManager's getRenderData method should return "
        'the height and width of the box',
        (tester) async {
          const box = SizedBox(height: 400, width: 800);
          final renderManager = RenderParametersManager<String>();
          final object = RenderMetricsObject(
            id: firstId,
            manager: renderManager,
            child: box,
          );

          await tester.pumpWidget(makeTestableWidget(object));
          final renderData = renderManager.getRenderData(firstId);

          expect(renderData?.height, 400);
          expect(renderData?.width, 800);
        },
      );

      testWidgets(
        'After drug the yTop of the RenderData value should become less '
        'than its initial value',
        (tester) async {
          final controller = ScrollController();
          const box = SizedBox(height: 400, width: 800);
          final renderManager = RenderParametersManager<String>();
          final object = RenderMetricsObject(
            id: firstId,
            manager: renderManager,
            child: box,
          );

          await tester.pumpWidget(
            makeTestableWidget(
              ListView(
                controller: controller,
                children: [
                  const SizedBox(
                    height: 400,
                    width: 800,
                  ),
                  object,
                  const SizedBox(
                    height: 400,
                    width: 800,
                  ),
                ],
              ),
            ),
          );
          final renderData = renderManager.getRenderData(firstId);
          await tester.drag(find.byType(ListView), const Offset(0, -300));
          await tester.pumpAndSettle();
          final renderDataBeforeDrag = renderManager.getRenderData(firstId);

          expect(renderDataBeforeDrag!.yTop < renderData!.yTop, true);
        },
      );

      testWidgets(
        'getDiffById method must perform correct calculations',
        (tester) async {
          const firstBox = SizedBox(height: 400, width: 800);
          const secondBox = SizedBox(height: 200, width: 400);

          final renderManager = RenderParametersManager<String>();

          final firstObject = RenderMetricsObject(
            id: firstId,
            manager: renderManager,
            child: firstBox,
          );
          final secondObject = RenderMetricsObject(
            id: secondId,
            manager: renderManager,
            child: secondBox,
          );

          await tester.pumpWidget(
            makeTestableWidget(Column(children: [firstObject, secondObject])),
          );

          final diff = renderManager.getDiffById(firstId, secondId);

          expect(diff?.height, equals(200));
          expect(diff?.width, equals(400));

          final firstRenderData = renderManager.getRenderData(firstId);
          final secondRenderData = renderManager.getRenderData(secondId);

          final diffUsingOperator = firstRenderData! - secondRenderData!;

          expect(diffUsingOperator.height, equals(200));
          expect(diffUsingOperator.width, equals(400));

          expect(diffUsingOperator.height, diff?.height);
          expect(diffUsingOperator.width, diff?.width);
        },
      );

      test(
        'Calling the updateRenderObject method should call the correct methods',
        () {
          const box = SizedBox(height: 400, width: 800);
          final renderManager = MockRenderParametersManager<String>();
          when(() => renderManager.updateRenderObject(any(), any()))
              .thenAnswer((invocation) => Future<void>.value());

          final context = FakeContext();
          final renderObject = RenderMetricsBox();

          final onUpdate = MockOnUpdateFunction<String>();
          when(() => onUpdate.call(any(), any())).thenAnswer(
            (invocation) => Future<void>.value(),
          );

          RenderMetricsObject(
            id: firstId,
            manager: renderManager,
            child: box,
            onUpdate: onUpdate,
          ).updateRenderObject(context, renderObject);

          verify(() => onUpdate(any<String>(), any())).called(1);
          verify(() => renderManager.updateRenderObject(firstId, renderObject))
              .called(1);
        },
      );
    },
  );
}

class FakeContext extends Fake implements BuildContext {}

class MockOnUpdateFunction<T> extends Mock {
  void call(T id, RenderMetricsBox box);
}

class MockRenderParametersManager<String> extends Mock
    implements RenderParametersManager<String> {}
