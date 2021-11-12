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

import 'package:render_metrics/src/data/comparison_diff.dart';
import 'package:render_metrics/src/data/coords_metrics.dart';

/// Widget metric data class.
/// [yTop] - top Y position relative to the screen.
/// [yBottom] - lower Y position relative to the screen.
/// [yCenter] - center Y position relative to the screen.
/// [xLeft] - left X position relative to the screen.
/// [xRight] - right X position relative to the screen.
/// [xCenter] - center X position relative to the screen.
/// [width] - element width.
/// [height] - element height.
/// [topLeft] - upper left coordinate.
/// [topRight] - upper right coordinate.
/// [bottomLeft] - lower left coordinate.
/// [bottomRight] - lower right coordinate.
/// [center] - central coordinate.
/// [topCenter] - upper center coordinate.
/// [bottomCenter] - lower central coordinate.
/// [centerLeft] - center left coordinate.
/// [centerRight] - center right coordinate.
class RenderData {
  final double yTop;
  final double yBottom;
  final double yCenter;
  final double xLeft;
  final double xRight;
  final double xCenter;
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

  const RenderData({
    required this.yTop,
    required this.yBottom,
    required this.yCenter,
    required this.xLeft,
    required this.xRight,
    required this.xCenter,
    required this.width,
    required this.height,
  });

  @override
  String toString() {
    return 'RenderData(\n'
        '    yTop = $yTop;\n'
        '    yBottom = $yBottom;\n'
        '    yCenter = $yCenter;\n'
        '    xLeft = $xLeft;\n'
        '    xRight = $xRight;\n'
        '    xCenter = $xCenter;\n'
        '    width = $width;\n'
        '    height = $height;\n'
        ')';
  }

  /// Returns the difference between
  /// the external and the current instance ofRenderData,
  /// as an instance of the ComparisonDiff class.
  ComparisonDiff operator -(RenderData other) => ComparisonDiff(
        yTop: yTop - other.yTop,
        yBottom: yBottom - other.yBottom,
        yCenter: yCenter - other.yCenter,
        xLeft: xLeft - other.xLeft,
        xRight: xRight - other.xRight,
        xCenter: xCenter - other.xCenter,
        diffTopToBottom: yTop - other.yBottom,
        diffBottomToTop: yBottom - other.yTop,
        diffLeftToRight: xLeft - other.xRight,
        diffRightToLeft: xRight - other.xLeft,
        width: width - other.width,
        height: height - other.height,
      );
}
