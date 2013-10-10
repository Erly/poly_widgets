library window;

import 'dart:html';
import 'model.dart';
import 'package:polymer/polymer.dart';

@CustomTag('window-component')
class WindowComponent extends PolymerElement with ObservableMixin {
  final WindowElement windowElement = new WindowElement();
  Point _dragStartPoint;
  Point _windowDragStartPoint;
  int _windowStartWidth;
  int _windowStartHeight;

  windowDragStart(MouseEvent e, var detail, Node target) {
    _dragStartPoint = new Point(e.page.x, e.page.y);
    _windowDragStartPoint = new Point(offset.left, offset.top);
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(new ImageElement(src: "http://lib.store.yahoo.net/lib/simplywhispers/001pixel.gif"), 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  windowDrag(MouseEvent e, var detail, Node target) {
    num movedX = e.page.x - _dragStartPoint.x;
    num movedY = e.page.y - _dragStartPoint.y;
    int x = _windowDragStartPoint.x + movedX;
    int y = _windowDragStartPoint.y + movedY;

    /*if (x < windowElement.minLeft) x = windowElement.minLeft;
    else if (x + windowElement.width > window.innerWidth - windowElement.minRight)
      x = window.innerWidth - windowElement.minRight - windowElement.width;*/
    if (x >= windowElement.minLeft && x + windowElement.width <
        window.innerWidth - windowElement.minRight)
      style.left = "${x}px";
    /*if (y < windowElement.minTop) y = windowElement.minTop;
    else if (y + windowElement.height > window.innerHeight - windowElement.minBottom)
      y = window.innerHeight - windowElement.minBottom - windowElement.height;*/
    if (y >= windowElement.minTop && y + windowElement.height <
        window.innerHeight - windowElement.minBottom)
      style.top = "${y}px";
  }

  windowDrop(MouseEvent e, var detail, Node target) {
    e.stopPropagation();
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.dropEffect = "none";
    return false;
  }

  resizeDragStart(MouseEvent e, var detail, Node target) {
    _dragStartPoint = new Point(e.page.x, e.page.y);
    _windowDragStartPoint = new Point(offset.right, offset.bottom);
    _windowStartWidth = windowElement.width;
    _windowStartHeight = windowElement.height;
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.setDragImage(new ImageElement(src: "http://lib.store.yahoo.net/lib/simplywhispers/001pixel.gif"), 0, 0);
    e.dataTransfer.dropEffect = "none";
  }

  resizeDrag(MouseEvent e, var detail, Node target) {
    num movedX = e.page.x - _dragStartPoint.x;
    print('movedX: $movedX');
    num movedY = e.page.y -_dragStartPoint.y;
    print('movedY: $movedY');
    int x = _windowDragStartPoint.x + movedX;
    print('x: $x');
    int y = _windowDragStartPoint.y + movedY;
    print('y: $y');
    int width = _windowStartWidth + movedX;
    print('width: $width');
    int height = _windowStartHeight + movedY;
    print('height: $height');

    if (width >= windowElement.minWidth && x < window.innerWidth - windowElement.minRight)
      windowElement.width = width;
    if (height >= windowElement.minHeight && y < window.innerHeight - windowElement.minBottom)
      windowElement.height = height;
  }

  resizeDrop(MouseEvent e, var detail, Node target) {
    e.stopPropagation();
    e.dataTransfer.effectAllowed = "none";
    e.dataTransfer.dropEffect = "none";
    return false;
  }

}
