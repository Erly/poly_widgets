library window;

import 'dart:html';
import 'model/model.dart';
import 'package:polymer/polymer.dart';

@CustomTag('x-icon')
class IconComponent extends DivElement with Polymer, Observable {
  final IconElement iconElement = new IconElementImpl();

  IconComponent.created() : super.created();

  iconFocus(Event e, var detail, Node target) {
    iconElement.style = 'focused';
  }

  iconBlur(Event e, var detail, Node target) {
    iconElement.style = '';
  }
}
