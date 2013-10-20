library window;

import 'dart:html';
import 'dart:math';
import 'model/model.dart';
import 'package:polymer/polymer.dart';

@CustomTag('window-component')
class WindowComponent extends PolymerElement {
  final WindowElement windowElement = new WindowElementImpl(new MutableRectangle(100, 100, 480, 320));
  Point _dragStartPoint;
  Point _windowDragStartPoint;
  int _windowStartWidth;
  int _windowStartHeight;

  windowDragStart(MouseEvent e, var detail, Node target) {
    //_dragStartPoint = new Point(e.page.x, e.page.y);
    //_windowDragStartPoint = new Point(offset.left, offset.top);
    windowElement.onMoveStart(e.page, window.innerWidth, window.innerHeight);
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(new ImageElement(src: "http://lib.store.yahoo.net/lib/simplywhispers/001pixel.gif"), 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  windowDrag(MouseEvent e, var detail, Node target) {
    windowElement.onMove(e.page);
//    num movedX = e.page.x - _dragStartPoint.x;
//    num movedY = e.page.y - _dragStartPoint.y;
//    int x = _windowDragStartPoint.x + movedX;
//    int y = _windowDragStartPoint.y + movedY;
//
//    /*if (x < windowElement.minLeft) x = windowElement.minLeft;
//    else if (x + windowElement.width > window.innerWidth - windowElement.minRight)
//      x = window.innerWidth - windowElement.minRight - windowElement.width;*/
//    if (x >= windowElement.minLeft && x + windowElement.width <
//        window.innerWidth - windowElement.minRight)
//      style.left = "${x}px";
//    /*if (y < windowElement.minTop) y = windowElement.minTop;
//    else if (y + windowElement.height > window.innerHeight - windowElement.minBottom)
//      y = window.innerHeight - windowElement.minBottom - windowElement.height;*/
//    if (y >= windowElement.minTop && y + windowElement.height <
//        window.innerHeight - windowElement.minBottom)
//      style.top = "${y}px";
    notifyProperty(windowElement, const Symbol('offset'));
  }

  resizeDragStart(MouseEvent e, var detail, Node target) {
    windowElement.onResizeStart(e.page, window.innerWidth, window.innerHeight);
    /*_dragStartPoint = new Point(e.page.x, e.page.y);
    _windowDragStartPoint = new Point(offset.right, offset.bottom);
    _windowStartWidth = windowElement.width;
    _windowStartHeight = windowElement.height;*/
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(new ImageElement(src: "http://lib.store.yahoo.net/lib/simplywhispers/001pixel.gif"), 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  resizeDrag(MouseEvent e, var detail, Node target) {
    windowElement.onResize(e.page);
//    num movedX = e.page.x - _dragStartPoint.x;
//    print('movedX: $movedX');
//    num movedY = e.page.y -_dragStartPoint.y;
//    print('movedY: $movedY');
//    int x = _windowDragStartPoint.x + movedX;
//    print('x: $x');
//    int y = _windowDragStartPoint.y + movedY;
//    print('y: $y');
//    int width = _windowStartWidth + movedX;
//    print('width: $width');
//    int height = _windowStartHeight + movedY;
//    print('height: $height');
//
//    if (width >= windowElement.minWidth && x < window.innerWidth - windowElement.minRight)
//      windowElement.width = width;
//    if (height >= windowElement.minHeight && y < window.innerHeight - windowElement.minBottom)
//      windowElement.height = height;
    notifyProperty(windowElement, const Symbol('offset'));
  }

  close() {
    if (windowElement.onClose()) this.remove();
  }
}
