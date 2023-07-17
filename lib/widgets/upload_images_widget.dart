import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UploadImagesWidget extends StatefulWidget {
  final ValueChanged<List<Asset>> onImagesSelected;

  const UploadImagesWidget({super.key, required this.onImagesSelected});

  @override
  State<UploadImagesWidget> createState() => _UploadImagesWidgetState();
}

class _UploadImagesWidgetState extends State<UploadImagesWidget> {
  List<Asset> images = <Asset>[];

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];

    resultList = await MultiImagePicker.pickImages(
      maxImages: 3,
      enableCamera: true,
    );

    if (!mounted) return;

    setState(() {
      images = resultList;
    });

    widget.onImagesSelected(images);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: loadAssets,
          child: const Text('Pick Images'),
        ),
        ...images
            .map((asset) => AssetThumb(asset: asset, width: 100, height: 100))
            .toList(),
      ],
    );
  }
}
