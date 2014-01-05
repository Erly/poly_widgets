part of models;

class WindowElementImpl extends WindowElement
{
  Point _dragStartPoint, _windowReferencePoint;
  int _browserWidth, _browserHeight, _windowInitialWidth, _windowInitialHeight;

  WindowElementImpl(int left, int top, int width, int height) : super(left, top, width, height);

  onMoveStart(Point absolutePosition, int browserWidth, int browserHeight) {
    _dragStartPoint = absolutePosition;
    _windowReferencePoint = new Point(left, top);
    this._browserWidth = browserWidth;
    this._browserHeight = browserHeight;
  }

  onMove(Point absolutePosition) {
    Point newWindowPosition = _windowReferencePoint + (absolutePosition - _dragStartPoint);

    if (newWindowPosition.x >= minLeft && newWindowPosition.x + width <
        _browserWidth - minRight)
      left = newWindowPosition.x;
    if (newWindowPosition.y >= minTop && newWindowPosition.y + height <
        _browserHeight - minBottom)
      top = newWindowPosition.y;
  }

  onResizeStart(Point absolutePosition, int browserWidth, int browserHeight) {
    _dragStartPoint = absolutePosition;
    _windowReferencePoint = new Point(left + width, top + height);
    _browserWidth = browserWidth;
    _browserHeight = browserHeight;
    _windowInitialWidth = width;
    _windowInitialHeight = height;
  }

  onResize(Point absolutePosition) {
    Point movedPosition = absolutePosition - _dragStartPoint;
    Point newReferencePoint = _windowReferencePoint + movedPosition;
    int newWidth = _windowInitialWidth + movedPosition.x;
    int newHeight = _windowInitialHeight + movedPosition.y;

    if (newWidth >= minWidth && newReferencePoint.x < _browserWidth - minRight)
      width = newWidth;
    if (newHeight >= minHeight && newReferencePoint.y < _browserHeight - minBottom)
      height = newHeight;
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