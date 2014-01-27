library image_viewer;

import 'dart:html';
import 'package:polymer/polymer.dart';

part 'image.dart';

@CustomTag('x-image-viewer')
class ImageViewerComponent extends DivElement with Polymer, Observable {
  @published List<Image> images;
  @published int position, maxWidth, maxHeight;
  ImageElement _imageElement;

  factory ImageViewerComponent(List<Image> images, int position, int maxWidth, int maxHeight) {
    ImageViewerComponent iv = new Element.tag('div', 'x-image-viewer');
    iv.images = images;
    iv.position = position;
    iv.maxWidth = maxWidth;
    iv.maxHeight = maxHeight;
    onKeyPress.listen((key) {
      if (key.keyCode == KeyCode.LEFT) {
        iv.previous();
      } else if (key.keyCode == KeyCode.RIGHT) {
        iv.next();
      } else if (key.keyCode == KeyCode.SPACE) {
        iv.fullscreen();
      } else if (key.keyCode == KeyCode.ESC) {
        iv.remove();
      }
    });
    return iv;
  }

  ImageViewerComponent.created() : super.created();

  ready() {
    super.ready();
    _imageElement = shadowRoot.querySelector('.image');
    _calculateImageSize();
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
    if (position > 0) {
      position--;
      _calculateImageSize();
    }
  }

  next() {
    if (position < images.length - 1) {
      position++;
      _calculateImageSize();
    }
  }

  fullscreen() {
  }

  _calculateImageSize() {
    // This could be calculated just once in the constructor and use polymer to
    // update automatically the style. But if maxWidth or maxHeight change or
    // another image is inserted in the list the new width and margin wouldn't be
    // calculated.
    double widthPercentage = images[position].width / maxWidth;
    double heightPercentage = images[position].height / maxHeight;
    print('$widthPercentage $heightPercentage');
    if (widthPercentage > heightPercentage) {
      if (widthPercentage > 1.0) {
        images[position].width = (images[position].width / widthPercentage).round();
        images[position].height = (images[position].height / widthPercentage).round();
      }
    } else {
      if (heightPercentage > 1.0) {
        images[position].width = (images[position].width / heightPercentage).round();
        images[position].height = (images[position].height / heightPercentage).round();
      }
    }
    _imageElement.style.width = '${images[position].width}px';
    _imageElement.style.height = '${images[position].height}px';
    _imageElement.style.marginLeft = '-${images[position].width / 2}px';
    _imageElement.style.marginTop = '-${images[position].height / 2}px';
  }

}