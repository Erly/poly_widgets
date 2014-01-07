library models;

import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:polymer/polymer.dart';

part 'implementations.dart';

abstract class WindowElement extends Object with Observable {

  @observable String title = 'Window';
  @observable int left;
  @observable int top;
  @observable int width;
  @observable int height;
  @observable int zIndex;

  final modal, movable, resizable;
  int minTop, minLeft, minBottom, minRight, minWidth, minHeight;

  StreamController _onClear = new StreamController();
  Stream get onClear => _onClear.stream;
  StreamController<HtmlElement> _onContentAdded = new StreamController<HtmlElement>();
  Stream<HtmlElement> get onContentAdded => _onContentAdded.stream;


  WindowElement(this.title, this.left, this.top, this.width, this.height, {this.minTop: 0,
    this.minLeft: 0, this.minBottom: 0, this.minRight: 0, this.minWidth: 150,
    this.minHeight: 100, this.zIndex, this.modal: false, this.movable: true,
    this.resizable: true
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

  onFocus();
  onBlur();

  // return true to close the window, false to cancel.
  bool onClose();

  clear() => _onClear.add("clear");

  addContent(HtmlElement el) => _onContentAdded.add(el);
}

abstract class IconElement extends Object with Observable {
  @observable String name = "file";
  @observable String imageUrl = "./images/folder.png";
  @observable int width;
  @observable int height;
  @observable int maxWidth = 100;
  bool _focused = false;

  IconElement(this.name, this.imageUrl, this.maxWidth, {this.width, this.height});

  get isFocused => _focused;

  StreamController<Event> _onDoubleClick = new StreamController<Event>();
  StreamController<Event> _onRightClick = new StreamController<Event>();
  StreamController<Event> get onDoubleClick => _onDoubleClick;
  StreamController<Event> get onRightClick => _onRightClick;

  onFocus() => _focused = true;
  onBlur() => _focused = false;
  //onDoubleClick(MouseEvent e);
  //onRightClick(MouseEvent e);
}