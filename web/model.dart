library models;

import 'package:polymer/polymer.dart';
import 'package:uuid/uuid.dart';

abstract class WindowElement extends Object with ObservableMixin {

  @observable String title = 'Window';
  @observable int left;
  @observable int top;
  @observable int right;
  @observable int bottom;
  @observable int width = 150;
  @observable int height = 100;

  final String _uuid = new Uuid().v4();
  int minTop = 0;
  int minLeft = 0;
  int minBottom = 0;
  int minRight = 0;
  int minWidth = 150;
  int minHeight = 100;

  get id => _uuid;

  WindowElement();

  // return true to close the window, false to cancel.
  bool close();
}

class WindowElementImpl extends WindowElement
{
  bool close() {
    print('The window $id has been closed.');
    return true;
  }
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