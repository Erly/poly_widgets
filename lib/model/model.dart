library models;

import 'dart:html';
import 'dart:math';
import 'package:polymer/polymer.dart';
import 'package:uuid/uuid.dart';

part 'implementations.dart';

abstract class WindowElement extends Object with Observable {

  @observable String title = 'Window';
  @observable int left;
  @observable int top;
  @observable int width;
  @observable int height;

  final String _uuid = new Uuid().v4();
  final modal = false, movable = true, resizable = true;
  int minTop = 0;
  int minLeft = 0;
  int minBottom = 0;
  int minRight = 0;
  int minWidth = 150;
  int minHeight = 100;

  get id => _uuid;

  WindowElement(this.left, this.top, this.width, this.height);

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

abstract class IconElement extends Object with Observable {
  @observable String name = "file";
  @observable String imageUrl = "./images/folder.png";
  @observable int width = 100;
  @observable int height = 90;
  bool _focused = false;

  IconElement(this.name, this.imageUrl, {this.width, this.height});

  get isFocused => _focused;

  onFocus() => _focused = true;
  onBlur() => _focused = false;
  onDoubleClick(MouseEvent e);
  onRightClick(MouseEvent e);
}