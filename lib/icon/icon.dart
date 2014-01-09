library new_icon;

import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('x-icon')
class NewIconComponent extends DivElement with Polymer, Observable {
  @published String src, name;
  @published int width, height;

  factory NewIconComponent(String name, String src, int width, int height) {
    NewIconComponent i = new Element.tag('div', 'x-icon');
    i.name = name;
    i.src = src;
    i.width = width;
    i.height = height;
    i.tabIndex = 0;
    i.style.maxWidth = '${width + 20}px';
    return i;
  }

  NewIconComponent.created() : super.created();

}
