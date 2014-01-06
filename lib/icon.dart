library icon;

import 'dart:async';
import 'dart:html';
import 'model/model.dart';
import 'package:polymer/polymer.dart';

@CustomTag('x-icon')
class IconComponent extends PolymerElement {
  IconElement _iconElement;

  factory IconComponent(IconElement iconElement) {
    IconComponent i = new Element.tag('x-icon');
    i._icnElement = iconElement;
    return i;
  }

  @reflectable get iconElement => _iconElement;

  @reflectable set _icnElement(IconElement newIconElement) {
    _iconElement = notifyPropertyChange(#iconElement, _iconElement, newIconElement);

    if(_iconElement.width != null) {
      shadowRoot.querySelector('.icon').style.maxWidth = '${_iconElement.width + 20}px';
    } else if(_iconElement.height != null) {
      int width = shadowRoot.querySelector('.icon-img').offsetWidth;

      shadowRoot.querySelector('.icon').style.maxWidth = '${width + 20}px';
    }

  }

  IconComponent.created() : super.created();

  iconDoubleClick(MouseEvent e, var detail, Node target) {
    _iconElement.onDoubleClick.add(e);
  }

  iconRightClick(MouseEvent e, var detail, Node target) {
    _iconElement.onRightClick.add(e);
  }

  iconFocus(Event e, var detail, Node target) {
    _iconElement.onFocus();
  }

  iconBlur(Event e, var detail, Node target) {
    _iconElement.onBlur();
  }
}
