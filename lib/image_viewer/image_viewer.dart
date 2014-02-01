library image_viewer;

import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';

part 'viewable.dart';

@CustomTag('x-image-viewer')
class ImageViewerComponent extends DivElement with Polymer, Observable {
  @published List<Viewable> images;
  @published int position, maxWidth, maxHeight;
  @published bool loop = false;
  ImageElement _imageElement;
  StreamSubscription<KeyboardEvent> _keyDownSubscription;
  StreamSubscription<Event> _fullscreenSubscription;

  factory ImageViewerComponent(List<Viewable> images, int position, int maxWidth, int maxHeight, {bool loop: false}) {
    ImageViewerComponent iv = new Element.tag('div', 'x-image-viewer');
    iv.images = images;
    iv.position = position;
    iv.maxWidth = maxWidth;
    iv.maxHeight = maxHeight;
    iv.loop = loop;
    return iv;
  }

  ImageViewerComponent.created() : super.created();

  @override
  ready() {
    super.ready();
    _imageElement = shadowRoot.querySelector('.image');
    _calculateImageSize();
    _keyDownSubscription = document.onKeyDown.listen((key) {
      //print('${key.keyCode.toString()} ${key.which.toString()}');
      if (key.keyCode == KeyCode.LEFT) {
        previous();
      } else if (key.keyCode == KeyCode.RIGHT) {
        next();
      } else if (key.keyCode == KeyCode.SPACE) {
        fullscreen();
      } else if (key.keyCode == KeyCode.ESC) {
        remove();
      }
    });
    _fullscreenSubscription = document.onFullscreenChange.listen((e) => _calculateImageSize());
  }

  @override
  leftView() {
    super.leftView();
    _keyDownSubscription.cancel();
    _fullscreenSubscription.cancel();
  }

  previousClick(MouseEvent e, var detail, Node target) {
    previous();
  }

  nextClick(MouseEvent e, var detail, Node target) {
    next();
  }

  loadPosition(int pos) {
    if (pos > 0 && pos < images.length - 1 && pos != position) {
      position = pos;
      _calculateImageSize();
    }
  }

  previous() {
    if (position > 0) position--;
    else if (loop) position = images.length - 1;
    _calculateImageSize();
  }

  next() {
    if (position < images.length - 1) position++;
    else if (loop) position = 0;
    _calculateImageSize();
  }

  fullscreen() {
    requestFullscreen();
  }

  _calculateImageSize() {
    // This could be calculated just once in the constructor and use polymer to
    // update automatically the style. But if maxWidth or maxHeight change or
    // another image is inserted in the list the new width and margin wouldn't be
    // calculated.
    int _width = images[position].width, _height = images[position].height;
    double widthPercentage;
    double heightPercentage;
    if (document.fullscreenElement == null) {
      widthPercentage = _width / maxWidth;
      heightPercentage = _height / maxHeight;
    } else {
      widthPercentage = _width / (window.outerWidth * 0.9);
      heightPercentage = _height / (window.outerHeight * 0.9);
    }
    //print('$widthPercentage $heightPercentage');
    if (widthPercentage > heightPercentage) {
      if (widthPercentage > 1.0) {
        _width = (_width / widthPercentage).round();
        _height = (_height / widthPercentage).round();
      }
    } else {
      if (heightPercentage > 1.0) {
        _width = (_width / heightPercentage).round();
        _height = (_height / heightPercentage).round();
      }
    }
    _imageElement.style.width = '${_width}px';
    _imageElement.style.height = '${_height}px';
    _imageElement.style.marginLeft = '-${_width / 2}px';
    _imageElement.style.marginTop = '-${_height / 2}px';
  }

}