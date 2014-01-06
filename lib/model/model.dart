library models;

import 'dart:async';
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
  final modal, movable, resizable;
  int minTop, minLeft, minBottom, minRight, minWidth, minHeight;

  get id => _uuid;

  StreamController _onClear = new StreamController();
  StreamController get onClear => _onClear;

  WindowElement(this.title, this.left, this.top, this.width, this.height, {this.minTop: 0,
    this.minLeft: 0, this.minBottom: 0, this.minRight: 0, this.minWidth: 150,
    this.minHeight: 100, this.modal: false, this.movable: true, this.resizable: true
  });

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

  clear() => _onClear.add(new Event("clear"));
}

abstract class IconElement extends Object with Observable {
  @observable String name = "file";
  @observable String imageUrl = "./images/folder.png";
  @observable int width = 100;
  @observable int height = 90;
  bool _focused = false;

  IconElement(this.name, this.imageUrl, {this.width, this.height});

  get isFocused => _focused;

  StreamController<Event> onDoubleClick = new StreamController<Event>();
  StreamController<Event> onRightClick = new StreamController<Event>();

  onFocus() => _focused = true;
  onBlur() => _focused = false;
  //onDoubleClick(MouseEvent e);
  //onRightClick(MouseEvent e);
}