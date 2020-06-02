import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class SelectColor extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const SelectColor({Key key, this.globalKey}) : super(key: key);
  @override
  _SelectColorState createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  // Uploading Images
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Detected';
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 30,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Select Images",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  // Uploading Images to Firebase Storage
  Future<dynamic> postImages(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  void uploadImages() {
    for (var imageFile in images) {
      postImages(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          String documentID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance
              .collection('images')
              .document(documentID)
              .setData({'urls': imageUrls}).then((_) {
            SnackBar snackBar = SnackBar(content: Text('Upload Successfully'));
            widget.globalKey.currentState.showSnackBar(snackBar);
            setState(() {
              images = [];
              imageUrls = [];
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

// Color DropDown List
  String _color = 'Red';
  String itemColor;

  void getItemColor(String itemColor) {
    this.itemColor = itemColor;
  }

  createColorData() {
    print('Color Added');
    DocumentReference itemColorRefernece =
        Firestore.instance.collection('Item Data').document(itemColor);

    Map<String, dynamic> items = {
      "Item Color": itemColor,
    };

    itemColorRefernece.setData(items).whenComplete(() => {
          print('$itemColor created'),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DropdownButton<String>(
            value: _color,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            onChanged: (String newColor) {
              setState(
                () {
                  _color = newColor;
                  getItemColor(newColor);
                },
              );
            },
            items: <String>['Red', 'Blue', 'Green', 'Yellow']
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text('Select Images'),
            onPressed: () {
              loadAssets();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          RaisedButton(
            child: Text('Upload'),
            onPressed: () {
              uploadImages();
              createColorData();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ],
      ),
    );
  }
}
