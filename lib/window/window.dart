@HtmlImport('window.html')
library window;

import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

@PolymerRegister('x-window', extendsTag: 'div')
class WindowComponent extends DivElement with PolymerMixin, PolymerBase, JsProxy {

  @property String windowTitle = 'Window';
  @property bool modal = false;
  @property bool movable = true;
  @property bool resizable = true;
  @property int minTop = 0;
  @property int minLeft = 0;
  @property int minBottom = 0;
  @property int minRight = 0;
  @property int minWidth = 150;
  @property int minHeight = 100;

  Point _dragStartPoint, _windowReferencePoint;
  int _windowInitialWidth, _windowInitialHeight;

  ImageElement _invPixel = new ImageElement(src: "packages/poly_widgets/window/001pixel.gif");

  StreamController _onMinimize = new StreamController();
  Stream get onMinimize => _onMinimize.stream;
  StreamController _onMaximize = new StreamController();
  Stream get onMaximize => _onMaximize.stream;
  StreamController _onClose = new StreamController();
  Stream get onClose => _onClose.stream;

  factory WindowComponent(String title, int left, int top, int width, int height, {int minTop: 0,
    int minLeft: 0, int minBottom: 0, int minRight: 0, int minWidth: 150,
    int minHeight: 100, int zIndex, bool modal: false, bool movable: true,
    bool resizable: true
  }) {
    WindowComponent w = new Element.tag('div', 'x-window');
    w.style.position = 'absolute';
    w.set('windowTitle', title);
    w.style.top = '${top}px';
    w.style.left = '${left}px';
    w.style.width = '${width}px';
    w.style.height = '${height}px';
    w.set('minTop', minTop);
    w.set('minLeft', minLeft);
    w.set('minBottom', minBottom);
    w.set('minRight', minRight);
    w.set('minWidth', minWidth);
    w.set('minHeight', minHeight);
    w.style.zIndex = '$zIndex';
    w.set('modal', modal);
    w.set('movable', movable);
    w.set('resizable', resizable);
    return w;
  }

  WindowComponent.created() : super.created() {
    polymerCreated();
  }

  @reflectable
  windowDragStart(MouseEvent e, var detail) {
    _dragStartPoint = e.page;
    _windowReferencePoint = new Point(offsetLeft, offsetTop);
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(_invPixel, 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  @reflectable
  windowDrag(MouseEvent e, var detail) {
    if (movable) {
      Point newWindowPosition = _windowReferencePoint + (e.page - _dragStartPoint);

      if (newWindowPosition.x >= minLeft && newWindowPosition.x + offsetWidth <
          window.innerWidth - minRight)
        style.left = '${newWindowPosition.x}px';
      if (newWindowPosition.y >= minTop && newWindowPosition.y + offsetHeight <
          window.innerHeight - minBottom)
        style.top = '${newWindowPosition.y}px';
    }
  }

  @reflectable
  resizeDragStart(MouseEvent e, var detail) {
    _dragStartPoint = e.page;
    _windowReferencePoint = new Point(offsetLeft + offsetWidth, offsetTop + offsetHeight);
    _windowInitialWidth = offsetWidth;
    _windowInitialHeight = offsetHeight;
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(_invPixel, 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  @reflectable
  resizeDrag(MouseEvent e, var detail) {
    if (resizable) {
      Point movedPosition = e.page - _dragStartPoint;
      Point newReferencePoint = _windowReferencePoint + movedPosition;
      int newWidth = _windowInitialWidth + movedPosition.x;
      int newHeight = _windowInitialHeight + movedPosition.y;

      if (newWidth >= minWidth && newReferencePoint.x < window.innerWidth - minRight)
        style.width = '${newWidth}px';
      if (newHeight >= minHeight && newReferencePoint.y < window.innerHeight - minBottom)
        style.height = '${newHeight}px';
    }
  }

  @reflectable
  minimize([_, __]) {
    _onMinimize.add(new CustomEvent('minimize'));
  }

  @reflectable
  maximize([_, __]) {
    _onMaximize.add(new CustomEvent('maximize'));
  }

  @reflectable
  close([_, __]) {
    _onClose.add(new CustomEvent('close'));
  }
}
