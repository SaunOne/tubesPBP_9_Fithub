import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugd6_b_9/view/Preview_page.dart';

class Camera extends StatefulWidget {
  const Camera({super.key, required this.camera});

  final List<CameraDescription>? camera;

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  late CameraController _controller;
  bool _isRearCameraSelected = true;

  void initState() {
    super.initState();
    initCamera(widget.camera![0]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _controller =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  Future takePicture() async {
    if (!_controller.value.isInitialized) {
      return null;
    }
    if (_controller.value.isTakingPicture) {
      return null;
    }
    try {
      await _controller.setFlashMode(FlashMode.off);
      XFile picture = await _controller.takePicture();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewPage(
                picture: picture,
              )));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 115, 0, 54),
            title: const Text('Camera Page')),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                )
                    : Container(),
              ),
            ),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _isRearCameraSelected = !_isRearCameraSelected;
                          _controller = CameraController(
                              widget.camera![
                              _isRearCameraSelected ? 0 : 1],
                              ResolutionPreset.high);
                          _controller.initialize().then((_) {
                            if (!mounted) {
                              return;
                            }
                            setState(() {});
                          });
                        });
                      },
                      icon: const Icon(
                        Icons.flip_camera_ios,
                        color: Colors.black,
                      )),
                  IconButton(
                      onPressed: () {
                        takePicture();
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.black,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (_controller.value.flashMode ==
                              FlashMode.off) {
                            _controller.setFlashMode(FlashMode.torch);
                          } else {
                            _controller.setFlashMode(FlashMode.off);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.flash_off,
                        color: Colors.black,
                      )),
                ],
              ),
            )
          ],
        ));
  }

}
