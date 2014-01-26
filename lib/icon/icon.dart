library icon;

import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('x-icon')
class IconComponent extends DivElement with Polymer, Observable {
  @published String src, name;
  @published int width, height;

  factory IconComponent(String name, String src, int width, int height) {
    IconComponent i = new Element.tag('div', 'x-icon');
    i.name = name;
    i.src = src;
    i.width = width;
    i.height = height;
    i.tabIndex = 0;
    i.style.maxWidth = '${width + 20}px';
    return i;
  }

  IconComponent.created() : super.created();

}
