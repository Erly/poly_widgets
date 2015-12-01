@HtmlImport('icon.html')
library icon;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

@PolymerRegister('x-icon', extendsTag: 'div')
class IconComponent extends DivElement with PolymerMixin, PolymerBase, JsProxy {
  @Property(reflectToAttribute: true) String title;
  @property String name;
  @property String src;
  @property int width;
  @property int height;

  factory IconComponent(String name, String src, int width, int height) {
    IconComponent i = new Element.tag('div', 'x-icon');
    i.set('name', name);
    i.set('title', name);
    i.set('src', src);
    i.set('width', width);
    i.set('height', height);
    i.tabIndex = 0;
    i.style.maxWidth = '${width + 20}px';
    return i;
  }

  IconComponent.created() : super.created() {
    polymerCreated();
  }

}
