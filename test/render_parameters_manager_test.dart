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
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:render_metrics/render_metrics.dart';

void main() {
  const id = 'Test id';
  const secondId = 'Second id';

  late RenderParametersManager renderParametersManager;
  final renderObject = RenderMetricsBox();

  final secondRenderObject = RenderMetricsBox();

  setUp(
    () {
      renderParametersManager = RenderParametersManager<String>();
    },
  );

  test(
    'renderObjects getter call should return <String, RenderMetricsBox>{}',
    () {
      final renderObjects = renderParametersManager.renderObjects;

      expect(renderObjects, <String, RenderMetricsBox>{});
    },
  );

  test(
    'addRenderObject method should add an instance of [RenderObject] in '
        'renderObjects',
    () {
      renderParametersManager.addRenderObject(id, renderObject);

      final renderObjects = renderParametersManager.renderObjects;

      expect(renderObjects, <String, RenderMetricsBox>{id: renderObject});
    },
  );

  test(
    'updateRenderObject method should update an instance of [RenderObject] '
        'by [id] in renderObjects',
    () {
      renderParametersManager.updateRenderObject(id, secondRenderObject);

      final rendersObjects = renderParametersManager.renderObjects;

      expect(
        rendersObjects,
        <String, RenderMetricsBox>{id: secondRenderObject},
      );
    },
  );

  test(
    'removeRenderObject method should delete an instance of [RenderObject] by '
        '[id] in renderObjects',
    () {
      renderParametersManager
        ..addRenderObject(id, renderObject)
        ..addRenderObject(secondId, secondRenderObject);

      var rendersObjects = renderParametersManager.renderObjects;

      expect(
        rendersObjects,
        <String, RenderMetricsBox>{
          id: renderObject,
          secondId: secondRenderObject,
        },
      );

      renderParametersManager.removeRenderObject(id);

      rendersObjects = renderParametersManager.renderObjects;

      expect(
        rendersObjects,
        <String, RenderMetricsBox>{secondId: secondRenderObject},
      );

      renderParametersManager.removeRenderObject(secondId);

      rendersObjects = renderParametersManager.renderObjects;

      expect(rendersObjects, <String, RenderMetricsBox>{});
    },
  );

  test(
    '[] operator should return correctly render object',
    () {
      renderParametersManager.addRenderObject(id, renderObject);

      final RenderObject? object = renderParametersManager[id];

      expect(object, renderObject);
    },
  );

  test(
    'getRenderObject method should return renderObject from renderObjects',
    () {
      renderParametersManager.addRenderObject(id, renderObject);

      final object = renderParametersManager.getRenderObject(id);

      expect(object, renderObject);
    },
  );
}
