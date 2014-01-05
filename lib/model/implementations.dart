part of models;

class WindowElementImpl extends WindowElement
{
  Point _dragStartPoint, _windowReferencePoint;
  int _browserWidth, _browserHeight, _windowInitialWidth, _windowInitialHeight;

  WindowElementImpl(String title, int left, int top, int width, int height,
      {int minTop: 0, int minLeft: 0, int minBottom: 0, int minRight: 0,
      int minWidth: 150, int minHeight: 100, bool modal: false, bool movable: true,
      bool resizable: true}) : super(title, left, top, width, height, minTop: minTop,
          minLeft: minLeft, minBottom: minBottom, minRight: minRight, minWidth: minWidth,
          minHeight: minHeight, modal: modal, movable: movable, resizable: resizable);

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

  IconElementImpl(String name, String imageUrl, {int width, int height}) :
    super(name, imageUrl, width: width, height: height);

//  onDoubleClick(MouseEvent e) {
//    window.alert("You double clicked the icon $name");
//  }
//
//  onRightClick(MouseEvent e) {
//    e.preventDefault();
//    e.stopPropagation();
//    window.alert("You right clicked the icon $name");
//  }
}