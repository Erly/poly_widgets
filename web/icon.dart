library window;

import 'dart:html';
import 'model.dart';
import 'package:polymer/polymer.dart';

@CustomTag('icon-component')
class IconComponent extends PolymerElement with ObservableMixin {
  final IconElement iconElement = new IconElement();

  iconFocus(Event e, var detai, Node target) {
    iconElement.style = 'focused';
  }

  iconBlur(Event e, var detai, Node target) {
    iconElement.style = '';
  }
}
