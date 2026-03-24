import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;

class PreProcessedImageData {
  final Size originalSize;
  final Uint8List preProccessedImageBytes;

  PreProcessedImageData._(this.originalSize, this.preProccessedImageBytes);

  factory PreProcessedImageData(CameraImage camImg) {
    final rawRgbImage = convertCameraImageToImageColor(camImg);
    final rgbImage = Platform.isAndroid ? imglib.copyRotate(rawRgbImage, angle: 90) : rawRgbImage;

    return PreProcessedImageData._(
      Size(rgbImage.width.toDouble(), rgbImage.height.toDouble()),
      imglib.copyResizeCropSquare(rgbImage, size: 300).getBytes(order: imglib.ChannelOrder.rgb),
    );
  }
}

imglib.Image convertCameraImageToImageColor(CameraImage image) {
  switch (image.format.group) {
    case ImageFormatGroup.bgra8888:
      return convertBGRA8888toImageColor(image);
    case ImageFormatGroup.yuv420:
      return convertYUV420toImageColor(image);
    default:
      throw UnsupportedError(
        'Unsupported camera image format: ${image.format.group}',
      );
  }
}

imglib.Image convertBGRA8888toImageColor(CameraImage image) {
  final plane = image.planes.first;

  return imglib.Image.fromBytes(
    width: image.width,
    height: image.height,
    bytes: plane.bytes.buffer,
    bytesOffset: plane.bytes.offsetInBytes,
    rowStride: plane.bytesPerRow,
    numChannels: 4,
    order: imglib.ChannelOrder.bgra,
  );
}

imglib.Image convertYUV420toImageColor(CameraImage image) {
  final width = image.width;
  final height = image.height;
  final yPlane = image.planes[0];
  final uPlane = image.planes[1];
  final vPlane = image.planes[2];
  final yRowStride = yPlane.bytesPerRow;
  final yPixelStride = yPlane.bytesPerPixel ?? 1;
  final uvRowStride = uPlane.bytesPerRow;
  final uvPixelStride = uPlane.bytesPerPixel ?? 1;

  final img = imglib.Image(width: width, height: height);

  for (var y = 0; y < height; y++) {
    final yRowOffset = y * yRowStride;
    final uvRowOffset = (y >> 1) * uvRowStride;

    for (var x = 0; x < width; x++) {
      final yIndex = yRowOffset + (x * yPixelStride);
      final uvIndex = uvRowOffset + ((x >> 1) * uvPixelStride);

      final yp = yPlane.bytes[yIndex];
      final up = uPlane.bytes[uvIndex];
      final vp = vPlane.bytes[uvIndex];

      final r = (yp + 1.402 * (vp - 128)).round().clamp(0, 255);
      final g = (yp - 0.344136 * (up - 128) - 0.714136 * (vp - 128)).round().clamp(0, 255);
      final b = (yp + 1.772 * (up - 128)).round().clamp(0, 255);

      img.setPixelRgba(x, y, r, g, b, 255);
    }
  }

  return img;
}

extension CameraImageToJpeg on CameraImage {
  Future<Uint8List> frameToJpeg() async {
    final rgbImage = convertCameraImageToImageColor(this);
    final outputImage = Platform.isAndroid ? imglib.copyRotate(rgbImage, angle: 90) : rgbImage;

    return imglib.encodeJpg(outputImage, quality: 90);
  }
}
