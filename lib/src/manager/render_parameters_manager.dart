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

import 'package:flutter/cupertino.dart';
import 'package:render_metrics/src/data/comparison_diff.dart';
import 'package:render_metrics/src/data/render_data.dart';
import 'package:render_metrics/src/manager/render_manager.dart';
import 'package:render_metrics/src/render/render_metrics.dart';

/// Manager class extending [RenderManager].
/// Contains a collection of mounted [RenderMetricsBox]
/// and provides methods for working with it.
class RenderParametersManager<T> extends RenderManager<T> {
  @visibleForTesting
  final renderObjects = <T, RenderMetricsBox>{};

  /// Add an instance of [RenderObject] by [id].
  @override
  void addRenderObject(T id, RenderObject renderObject) {
    renderObjects[id] = renderObject as RenderMetricsBox;
  }

  /// Update an instance of [RenderObject] by [id].
  @override
  void updateRenderObject(T id, RenderObject renderObject) {
    renderObjects[id] = renderObject as RenderMetricsBox;
  }

  /// Delete an instance of [RenderObject] by [id].
  @override
  void removeRenderObject(T id) {
    renderObjects.remove(id);
  }

  /// Collection with mounted [RenderMetricsBox].
  RenderMetricsBox? operator [](T id) {
    return renderObjects[id];
  }

  /// Get an instance of [RenderObject] by [id].
  RenderMetricsBox? getRenderObject(T id) {
    return renderObjects[id];
  }

  /// Get instance of [RenderData] from [RenderObject] by [id].
  RenderData? getRenderData(T id) {
    return getRenderObject(id)?.data;
  }

  /// Get the difference between two instances [RenderObject]
  /// by [firstId] and [secondId].
  ComparisonDiff? getDiffById(T firstId, T secondId) {
    final first = getRenderData(firstId);
    final second = getRenderData(secondId);
    return getDiffByInstance(first, second);
  }

  /// Get the difference between
  /// two instances [RenderObject] by Instance.
  ComparisonDiff? getDiffByInstance(RenderData? first, RenderData? second) {
    if (first == null || second == null) return null;
    return first - second;
  }
}
