library models;

import 'package:polymer/polymer.dart';

class WindowElement extends Object with ObservableMixin {

  @observable String title = 'Window';
  @observable int left;
  @observable int top;
  @observable int right;
  @observable int bottom;
  @observable int width = 150;
  @observable int height = 100;

  String _uuid;
  int minTop = 0;
  int minLeft = 0;
  int minBottom = 0;
  int minRight = 0;
  int minWidth = 150;
  int minHeight = 100;

  WindowElement();
}

class IconElement extends Object with ObservableMixin {
  @observable String name = "file";
  @observable String imageUrl = "./images/folder.png";
  @observable int width = 100;
  @observable int height = 90;
  @observable String style = "";

  String action;
  var actionData;
}