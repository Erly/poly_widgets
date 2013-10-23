library window;

import 'dart:html';
import 'model/model.dart';
import 'package:polymer/polymer.dart';

@CustomTag('x-icon')
class IconComponent extends PolymerElement with ObservableMixin {
  final IconElement iconElement = new IconElementImpl();

  iconFocus(Event e, var detail, Node target) {
    iconElement.style = 'focused';
  }

  iconBlur(Event e, var detail, Node target) {
    iconElement.style = '';
  }
}
