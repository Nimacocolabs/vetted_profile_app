import 'package:faculty_app/utils/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatefulWidget {
  final String? title;
  final String image;
  final bool networkImage;
  const PhotoViewer(
      {Key? key, required this.image, this.networkImage = false, this.title})
      : super(key: key);

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: widget.networkImage
              ? Stack(children: [
            PhotoView(
              enableRotation: false,
              imageProvider: NetworkImage(widget.image),
            ),
            if (widget.title != null)
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: screenWidth,
                  decoration:
                  BoxDecoration(color: Colors.black.withOpacity(.3)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
          ])
              : Stack(children: [
            PhotoView(
              enableRotation: false,
              imageProvider: AssetImage(widget.image),
            ),
            if (widget.title != null)
              Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: screenWidth,
                    decoration:
                    BoxDecoration(color: Colors.black.withOpacity(.3)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )),
          ]),
        ));
  }
}
