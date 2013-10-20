library models;

import 'dart:math';
import 'package:polymer/polymer.dart';
import 'package:uuid/uuid.dart';

part 'implementations.dart';

abstract class WindowElement extends Object with ObservableMixin {

  @observable String title = 'Window';
  @observable MutableRectangle offset;

  final String _uuid = new Uuid().v4();
  final modal = false, movable = true, resizable = true;
  int minTop = 0;
  int minLeft = 0;
  int minBottom = 0;
  int minRight = 0;
  int minWidth = 150;
  int minHeight = 100;

  get id => _uuid;

  WindowElement(this.offset);

  /*int get width => _width;
  int get height => _height;
  set width(int width) {
    if (width < 0) throw new Exception("Width can't be lower than 0.");
    _width = width;
  }
  set height(int height) {
    if (height < 0) throw new Exception("Height can't be lower than 0.");
    _height = height;
  }*/

  onMoveStart(Point absolutePosition, int browserWidth, int browserHeight);
  onMove(Point absolutePosition);

  onResizeStart(Point absolutePosition, int browserWidth, int browserHeight);
  onResize(Point absolutePosition);

  // return true to close the window, false to cancel.
  bool onClose();
}

abstract class IconElement extends Object with ObservableMixin {
  @observable String name = "file";
  @observable String imageUrl = "./images/folder.png";
  @observable int width = 100;
  @observable int height = 90;
  @observable String style = "";

  onDoubleClick();
  onRightClick();
}