library new_window;

import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:polymer/polymer.dart';

@CustomTag('x-window')
class NewWindowComponent extends DivElement with Polymer, Observable {

  @published String title = 'Window';
  @published bool modal = false, movable = true, resizable = true;
  @published int minTop = 0, minLeft = 0, minBottom = 0, minRight = 0, minWidth = 150, minHeight = 100;

  Point _dragStartPoint, _windowReferencePoint;
  int _windowInitialWidth, _windowInitialHeight;

  ImageElement _invPixel = new ImageElement(src: "packages/poly_widgets/window/001pixel.gif");

  StreamController _onMinimize = new StreamController();
  Stream get onMinimize => _onMinimize.stream;
  StreamController _onMaximize = new StreamController();
  Stream get onMaximize => _onMaximize.stream;
  StreamController _onClose = new StreamController();
  Stream get onClose => _onClose.stream;

  factory NewWindowComponent(String title, int left, int top, int width, int height, {int minTop: 0,
    int minLeft: 0, int minBottom: 0, int minRight: 0, int minWidth: 150,
    int minHeight: 100, int zIndex, bool modal: false, bool movable: true,
    bool resizable: true
  }) {
    NewWindowComponent w = new Element.tag('div', 'x-window');
    w.style.position = 'absolute';
    w.title = title;
    w.style.top = '${top}px';
    w.style.left = '${left}px';
    w.style.width = '${width}px';
    w.style.height = '${height}px';
    w.minTop = minTop;
    w.minLeft = minLeft;
    w.minBottom = minBottom;
    w.minRight = minRight;
    w.minWidth = minWidth;
    w.minHeight = minHeight;
    w.style.zIndex = '$zIndex';
    w.modal = modal;
    w.movable = movable;
    w.resizable = resizable;
    return w;
  }

  NewWindowComponent.created() : super.created();

  windowDragStart(MouseEvent e, var detail, Node target) {
    _dragStartPoint = e.page;
    _windowReferencePoint = new Point(offsetLeft, offsetTop);
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(_invPixel, 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  windowDrag(MouseEvent e, var detail, Node target) {
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

  resizeDragStart(MouseEvent e, var detail, Node target) {
    _dragStartPoint = e.page;
    _windowReferencePoint = new Point(offsetLeft + offsetWidth, offsetTop + offsetHeight);
    _windowInitialWidth = offsetWidth;
    _windowInitialHeight = offsetHeight;
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(_invPixel, 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  resizeDrag(MouseEvent e, var detail, Node target) {
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

  minimize() {
    _onMinimize.add(new CustomEvent('minimize'));
  }

  maximize() {
    _onMaximize.add(new CustomEvent('maximize'));
  }

  close() {
    _onClose.add(new CustomEvent('close'));
  }
}
