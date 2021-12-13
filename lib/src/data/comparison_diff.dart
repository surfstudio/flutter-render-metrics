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

import 'package:render_metrics/src/data/coords_metrics.dart';

/// An object with data on the difference of render metrics between two objects
/// `RenderData`
///
/// [yTop] - difference of the upper Y position relative to the screen.
/// [yBottom] - difference of the lower Y position relative to the screen.
/// [yCenter] - difference of the central Y position relative to the screen.
/// [xLeft] - difference left X position relative to the screen.
/// [xRight] - difference of the right X position relative to the screen.
/// [xCenter] - difference of the central X position relative to the screen.
/// [diffTopToBottom] - difference between the upper border of first object and the lower
/// border of second object.
/// [diffBottomToTop] - difference between the lower border of first object and the upper
/// border of second object.
/// [diffLeftToRight] - difference between the left border of first object and the right
/// border of second object.
/// [diffRightToLeft] - difference between the right border of first object and the left
/// border of second object.
/// [width] - difference in width of elements.
/// [height] - difference in element heights.
/// [topLeft] - upper left coordinate.
/// [topRight] - upper right coordinate.
/// [bottomLeft] - lower left coordinate.
/// [bottomRight] - lower right coordinate.
/// [center] - central coordinate.
/// [topCenter] - upper center coordinate.
/// [bottomCenter] - lower central coordinate.
/// [centerLeft] - center left coordinate.
/// [centerRight] - center right coordinate.
class ComparisonDiff {
  final double yTop;
  final double yBottom;
  final double yCenter;
  final double xLeft;
  final double xRight;
  final double xCenter;
  final double diffTopToBottom;
  final double diffBottomToTop;
  final double diffLeftToRight;
  final double diffRightToLeft;
  final double width;
  final double height;

  CoordinatesMetrics get topLeft => CoordinatesMetrics(y: yTop, x: xLeft);

  CoordinatesMetrics get topRight => CoordinatesMetrics(y: yTop, x: xRight);

  CoordinatesMetrics get bottomLeft => CoordinatesMetrics(y: yBottom, x: xLeft);

  CoordinatesMetrics get bottomRight => CoordinatesMetrics(y: yBottom, x: xRight);

  CoordinatesMetrics get center => CoordinatesMetrics(y: yCenter, x: xCenter);

  CoordinatesMetrics get topCenter => CoordinatesMetrics(y: yTop, x: xCenter);

  CoordinatesMetrics get bottomCenter => CoordinatesMetrics(y: yBottom, x: xCenter);

  CoordinatesMetrics get centerLeft => CoordinatesMetrics(y: yCenter, x: xLeft);

  CoordinatesMetrics get centerRight => CoordinatesMetrics(y: yCenter, x: xRight);

  const ComparisonDiff({
    required this.yTop,
    required this.yBottom,
    required this.yCenter,
    required this.xLeft,
    required this.xRight,
    required this.xCenter,
    required this.diffTopToBottom,
    required this.diffBottomToTop,
    required this.diffLeftToRight,
    required this.diffRightToLeft,
    required this.width,
    required this.height,
  });

  const ComparisonDiff({
    required this.yTop,
    required this.yBottom,
    required this.yCenter,
    required this.xLeft,
    required this.xRight,
    required this.xCenter,
    required this.diffTopToBottom,
    required this.diffBottomToTop,
    required this.diffLeftToRight,
    required this.diffRightToLeft,
    required this.width,
    required this.height,
  });

  @override
  String toString() {
    return 'ComparisonDiff(\n'
        '    yTop = $yTop;\n'
        '    yBottom = $yBottom;\n'
        '    yCenter = $yCenter;\n'
        '    xLeft = $xLeft;\n'
        '    xRight = $xRight;\n'
        '    xCenter = $xCenter;\n'
        '    diffTopToBottom = $diffTopToBottom;\n'
        '    diffBottomToTop = $diffBottomToTop;\n'
        '    diffLeftToRight = $diffLeftToRight;\n'
        '    diffRightToLeft = $diffRightToLeft;\n'
        '    width = $width;\n'
        '    height = $height;\n'
        ')';
  }
}
