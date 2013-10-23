import 'dart:html';
import 'dart:math';
import '../lib/model/model.dart';
import '../lib/window.dart';

void main() {
  var window = query("#Window-test");
  window = new WindowComponent(
      new WindowElementImpl(
          new MutableRectangle(100, 100, 640, 480)
      )
  );
}