library window;

import 'dart:html';
import 'dart:math';
import 'model/model.dart';
import 'package:polymer/polymer.dart';

@CustomTag('x-window')
class WindowComponent extends PolymerElement {
  WindowElement _windowElement;
  Point _dragStartPoint;
  Point _windowDragStartPoint;
  int _windowStartWidth;
  int _windowStartHeight;

  factory WindowComponent(WindowElement windowElement) {
    WindowComponent w = new Element.tag('x-window');
    w._wndElement = windowElement;
    w._windowElement.onClear.stream.listen((_) => w.children.clear());
    return w;
  }

  @reflectable get windowElement => _windowElement;

  @reflectable set _wndElement(WindowElement newWindowElement) {
    _windowElement = notifyPropertyChange(#windowElement, _windowElement, newWindowElement);
  }

  WindowComponent.created() : super.created();

  windowDragStart(MouseEvent e, var detail, Node target) {
    _windowElement.onMoveStart(e.page, window.innerWidth, window.innerHeight);
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(new ImageElement(src: "http://lib.store.yahoo.net/lib/simplywhispers/001pixel.gif"), 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  windowDrag(MouseEvent e, var detail, Node target) {
    _windowElement.onMove(e.page);
  }

  resizeDragStart(MouseEvent e, var detail, Node target) {
    _windowElement.onResizeStart(e.page, window.innerWidth, window.innerHeight);
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(new ImageElement(src: "http://lib.store.yahoo.net/lib/simplywhispers/001pixel.gif"), 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  resizeDrag(MouseEvent e, var detail, Node target) {
    _windowElement.onResize(e.page);
  }

  close() {
    if (_windowElement.onClose()) this.remove();
  }
}
