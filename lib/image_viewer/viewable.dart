library image_viewer_model;
import 'package:polymer/polymer.dart';

class Viewable extends JsProxy {
  @reflectable String name;
  @reflectable String src;
  @reflectable int width;
  @reflectable int height;
}