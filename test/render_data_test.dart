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

import 'package:flutter_test/flutter_test.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:render_metrics/src/data/coords_metrics.dart';

void main() {
  const yTop = 250.72;
  const yBottom = 316.72;
  const yCenter = 283.72;
  const xLeft = -10.0;
  const xRight = 82.72;
  const xCenter = 36.36;
  const width = 92.72;
  const height = 66.0;

  const yTopOther = 451.99;
  const yBottomOther = 663.99;
  const yCenterOther = 557.99;
  const xLeftOther = 0.0;
  const xRightOther = 392.72;
  const xCenterOther = 196.36;
  const widthOther = 392.72;
  const heightOther = 212.0;

  const renderData = RenderData(
    yTop: yTop,
    yBottom: yBottom,
    yCenter: yCenter,
    xLeft: xLeft,
    xRight: xRight,
    xCenter: xCenter,
    width: width,
    height: height,
  );

  const renderDataOther = RenderData(
    yTop: yTopOther,
    yBottom: yBottomOther,
    yCenter: yCenterOther,
    xLeft: xLeftOther,
    xRight: xRightOther,
    xCenter: xCenterOther,
    width: widthOther,
    height: heightOther,
  );

  test(
    'topLeft getter should return CoordinatesMetrics with correct parameters',
    () {
      final topLeft = renderData.topLeft;

      expect(topLeft.runtimeType, CoordinatesMetrics);
      expect(topLeft.x, xLeft);
      expect(topLeft.y, yTop);
    },
  );

  test(
    'topRight getter should return CoordinatesMetrics with correct parameters',
    () {
      final topRight = renderData.topRight;

      expect(topRight.runtimeType, CoordinatesMetrics);
      expect(topRight.x, xRight);
      expect(topRight.y, yTop);
    },
  );

  test(
    'bottomLeft getter should return CoordinatesMetrics with correct parameters',
    () {
      final bottomLeft = renderData.bottomLeft;

      expect(bottomLeft.runtimeType, CoordinatesMetrics);
      expect(bottomLeft.x, xLeft);
      expect(bottomLeft.y, yBottom);
    },
  );

  test(
    'bottomLeft getter should return CoordinatesMetrics with correct parameters',
    () {
      final bottomRight = renderData.bottomRight;

      expect(bottomRight.runtimeType, CoordinatesMetrics);
      expect(bottomRight.x, xRight);
      expect(bottomRight.y, yBottom);
    },
  );

  test(
    'center getter should return CoordinatesMetrics with correct parameters',
    () {
      final center = renderData.center;

      expect(center.runtimeType, CoordinatesMetrics);
      expect(center.x, xCenter);
      expect(center.y, yCenter);
    },
  );

  test(
    'topCenter getter should return CoordinatesMetrics with correct parameters',
    () {
      final topCenter = renderData.topCenter;

      expect(topCenter.runtimeType, CoordinatesMetrics);
      expect(topCenter.x, xCenter);
      expect(topCenter.y, yTop);
    },
  );

  test(
    'bottomCenter getter should return CoordinatesMetrics with correct parameters',
    () {
      final bottomCenter = renderData.bottomCenter;

      expect(bottomCenter.runtimeType, CoordinatesMetrics);
      expect(bottomCenter.x, xCenter);
      expect(bottomCenter.y, yBottom);
    },
  );

  test(
    'centerLeft getter should return CoordinatesMetrics with correct parameters',
    () {
      final centerLeft = renderData.centerLeft;

      expect(centerLeft.runtimeType, CoordinatesMetrics);
      expect(centerLeft.x, xLeft);
      expect(centerLeft.y, yCenter);
    },
  );

  test(
    'centerRight getter should return CoordinatesMetrics with correct parameters',
    () {
      final centerRight = renderData.centerRight;

      expect(centerRight.runtimeType, CoordinatesMetrics);
      expect(centerRight.x, xRight);
      expect(centerRight.y, yCenter);
    },
  );

  test(
    'toString method should return correctly string',
    () {
      const expectString = 'RenderData(\n'
          '    yTop = $yTop;\n'
          '    yBottom = $yBottom;\n'
          '    yCenter = $yCenter;\n'
          '    xLeft = $xLeft;\n'
          '    xRight = $xRight;\n'
          '    xCenter = $xCenter;\n'
          '    width = $width;\n'
          '    height = $height;\n'
          ')';

      final string = renderData.toString();

      expect(string, expectString);
    },
  );

  test(
    "Overridden '-' operator should work correctly",
    () {
      final difference = renderData - renderDataOther;

      expect(difference.yTop, yTop - yTopOther);
      expect(difference.yBottom, yBottom - yBottomOther);
      expect(difference.yCenter, yCenter - yCenterOther);
      expect(difference.xLeft, xLeft - xLeftOther);
      expect(difference.xRight, xRight - xRightOther);
      expect(difference.xCenter, xCenter - xCenterOther);
      expect(difference.diffTopToBottom, yTop - yBottomOther);
      expect(difference.diffBottomToTop, yBottom - yTopOther);
      expect(difference.diffLeftToRight, xLeft - xRightOther);
      expect(difference.diffRightToLeft, xRight - xLeftOther);
      expect(difference.width, width - widthOther);
      expect(difference.height, height - heightOther);
    },
  );
}
