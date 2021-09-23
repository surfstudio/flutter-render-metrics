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
import 'package:render_metrics/render_metrics.dart';

import 'test_utils.dart';

void main() {
  group('RenderParametersManager', () {
    testWidgets('returns renderData', (tester) async {
      const box = SizedBox(height: 400, width: 800);

      const firstId = 'box';

      final renderManager = RenderParametersManager<String>();

      final object = RenderMetricsObject(
        id: firstId,
        manager: renderManager,
        child: box,
      );

      await tester.pumpWidget(TestableWidget(object));

      final renderData = renderManager.getRenderData('box');

      expect(renderData?.height, 400);
      expect(renderData?.width, 800);

      expect(renderData?.topLeft.x, 0);
      expect(renderData?.topLeft.y, 0);

      expect(renderData?.topRight.x, 800);
      expect(renderData?.topRight.y, 0);

      expect(renderData?.bottomLeft.x, 0);
      expect(renderData?.bottomLeft.y, 400);

      expect(renderData?.bottomRight.x, 800);
      expect(renderData?.bottomRight.y, 400);

      expect(renderData?.center.x, 400);
      expect(renderData?.center.y, 200);

      expect(renderData?.topCenter.x, 400);
      expect(renderData?.topCenter.y, 0);

      expect(renderData?.bottomCenter.x, 400);
      expect(renderData?.bottomCenter.y, 400);

      expect(renderData?.centerLeft.x, 0);
      expect(renderData?.centerLeft.y, 200);

      expect(renderData?.centerRight.x, 800);
      expect(renderData?.centerRight.y, 200);

      expect(
        renderData?.toString(),
        'RenderData(\n'
        '    yTop = 0.0;\n'
        '    yBottom = 400.0;\n'
        '    yCenter = 200.0;\n'
        '    xLeft = 0.0;\n'
        '    xRight = 800.0;\n'
        '    xCenter = 400.0;\n'
        '    width = 800.0;\n'
        '    height = 400.0;\n'
        ')',
      );
    });

    testWidgets('calculates diff', (tester) async {
      const firstBox = SizedBox(height: 400, width: 800);
      const secondBox = SizedBox(height: 200, width: 400);

      const firstId = 'first';
      const secondId = 'second';

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
        TestableWidget(Column(children: [firstObject, secondObject])),
      );

      final diff = renderManager.getDiffById(firstId, secondId);

      expect(renderManager.renderObjects[firstId] is RenderMetricsBox, isTrue);

      expect(diff?.height, equals(200));
      expect(diff?.width, equals(400));

      final firstRenderData = renderManager.getRenderData(firstId);
      final secondRenderData = renderManager.getRenderData(secondId);

      final diffUsingOperatior = firstRenderData! - secondRenderData!;

      expect(diffUsingOperatior.height, equals(200));
      expect(diffUsingOperatior.width, equals(400));

      expect(diffUsingOperatior.topLeft.x, equals(-200.0));
      expect(diffUsingOperatior.topLeft.y, equals(-400.0));

      expect(diffUsingOperatior.topRight.x, equals(200.0));
      expect(diffUsingOperatior.topRight.y, equals(-400.0));

      expect(diffUsingOperatior.bottomLeft.x, equals(-200.0));
      expect(diffUsingOperatior.bottomLeft.y, equals(-200.0));

      expect(diffUsingOperatior.bottomRight.x, equals(200.0));
      expect(diffUsingOperatior.bottomRight.y, equals(-200.0));

      expect(diffUsingOperatior.center.x, equals(0.0));
      expect(diffUsingOperatior.center.y, equals(-300.0));

      expect(diffUsingOperatior.topCenter.x, equals(0.0));
      expect(diffUsingOperatior.topCenter.y, equals(-400.0));

      expect(diffUsingOperatior.bottomCenter.x, equals(0.0));
      expect(diffUsingOperatior.bottomCenter.y, equals(-200.0));

      expect(diffUsingOperatior.centerLeft.x, equals(-200.0));
      expect(diffUsingOperatior.centerLeft.y, equals(-300.0));

      expect(diffUsingOperatior.centerRight.x, equals(200.0));
      expect(diffUsingOperatior.centerRight.y, equals(-300.0));

      expect(
        diffUsingOperatior.toString(),
        'ComparisonDiff(\n'
        '    yTop = -400.0;\n'
        '    yBottom = -200.0;\n'
        '    yCenter = -300.0;\n'
        '    xLeft = -200.0;\n'
        '    xRight = 200.0;\n'
        '    xCenter = 0.0;\n'
        '    diffTopToBottom = -600.0;\n'
        '    diffBottomToTop = 0.0;\n'
        '    diffLeftToRight = -600.0;\n'
        '    diffRightToLeft = 600.0;\n'
        '    width = 400.0;\n'
        '    height = 200.0;\n'
        ')',
      );

      await tester.pumpWidget(
        TestableWidget(Column(children: [secondObject, firstObject])),
      );
    });
  });
}
