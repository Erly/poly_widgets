part of models;

class WindowElementImpl extends WindowElement
{
  Point _dragStartPoint, _windowReferencePoint;
  int _browserWidth, _browserHeight, _windowInitialWidth, _windowInitialHeight;

  WindowElementImpl(MutableRectangle window) : super(window);

  onMoveStart(Point absolutePosition, int browserWidth, int browserHeight) {
    _dragStartPoint = absolutePosition;
    _windowReferencePoint = new Point(offset.left, offset.top);
    this._browserWidth = browserWidth;
    this._browserHeight = browserHeight;
  }

  onMove(Point absolutePosition) {
    Point newWindowPosition = _windowReferencePoint + (absolutePosition - _dragStartPoint);

    if (newWindowPosition.x >= minLeft && newWindowPosition.x + offset.width <
        _browserWidth - minRight)
      offset.left = newWindowPosition.x;
    if (newWindowPosition.y >= minTop && newWindowPosition.y + offset.height <
        _browserHeight - minBottom)
      offset.top = newWindowPosition.y;
  }

  onResizeStart(Point absolutePosition, int browserWidth, int browserHeight) {
    _dragStartPoint = absolutePosition;
    _windowReferencePoint = new Point(offset.left + offset.width, offset.top + offset.height);
    _browserWidth = browserWidth;
    _browserHeight = browserHeight;
    _windowInitialWidth = offset.width;
    _windowInitialHeight = offset.height;
  }

  onResize(Point absolutePosition) {
    Point movedPosition = absolutePosition - _dragStartPoint;
    Point newReferencePoint = _windowReferencePoint + movedPosition;
    int newWidth = _windowInitialWidth + movedPosition.x;
    int newHeight = _windowInitialHeight + movedPosition.y;
//    print ("MovedPosition: movedPosition");
//    print('New relative position: $newRelativePosition');
//    print('width: $newWidth');
//    print('height: $newHeight');

    if (newWidth >= minWidth && newReferencePoint.x < _browserWidth - minRight)
      offset.width = newWidth;
    if (newHeight >= minHeight && newReferencePoint.y < _browserHeight - minBottom)
      offset.height = newHeight;
  }

  bool onClose() {
    print('The window $id has been closed.');
    return true;
  }
}

class IconElementImpl extends IconElement {
  onDoubleClick() {

  }

  onRightClick() {

  }
}