import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/userprovider.dart';

class AlertBoxWidget extends StatelessWidget {
  AlertBoxWidget({
    super.key,
  });

  final CollectionReference _items =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add a new user",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Stack(
              children: [
                Consumer<UserProvider>(
                  builder: (context, userprovider, _) {
                    return CircleAvatar(
                      radius: 35,
                      backgroundImage: userprovider.images.isNotEmpty
                          ? NetworkImage(userprovider.images)
                          : const AssetImage(
                              'assets/images/avatar.jpg',
                            ) as ImageProvider<Object>?,
                    );
                  },
                ),
                Positioned(
                  top: 42,
                  child: Transform.rotate(
                    angle: 3.14 / 1,
                    child: const ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.4,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Color.fromARGB(165, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 32,
                  left: 12,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        builder: (_) {
                          return SizedBox(
                            height: 200,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "Pick Image From",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              elevation: 20,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 0, 0, 0),
                                            ),
                                            onPressed: () async {
                                              final file = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (file == null) return;
                                              String fileName = DateTime.now()
                                                  .microsecondsSinceEpoch
                                                  .toString();

                                              Reference referenceRoot =
                                                  FirebaseStorage.instance
                                                      .ref();
                                              Reference referenceDireImage =
                                                  referenceRoot
                                                      .child('userpics');

                                              Reference referenceImageToUpload =
                                                  referenceDireImage
                                                      .child(fileName);

                                              try {
                                                await referenceImageToUpload
                                                    .putFile(File(file.path));

                                                userprovider.images = '';

                                                userprovider.images =
                                                    await referenceImageToUpload
                                                        .getDownloadURL();
                                              } catch (e) {}
                                            },
                                            child: Icon(Icons.image)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Gallery",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              elevation: 20,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 0, 0, 0),
                                            ),
                                            onPressed: () async {
                                              final file = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (file == null) return;
                                              String fileName = DateTime.now()
                                                  .microsecondsSinceEpoch
                                                  .toString();

                                              Reference referenceRoot =
                                                  FirebaseStorage.instance
                                                      .ref();
                                              Reference referenceDireImage =
                                                  referenceRoot
                                                      .child('userpics');

                                              Reference referenceImageToUpload =
                                                  referenceDireImage
                                                      .child(fileName);

                                              try {
                                                await referenceImageToUpload
                                                    .putFile(File(file.path));

                                                userprovider.images = '';

                                                userprovider.images =
                                                    await referenceImageToUpload
                                                        .getDownloadURL();
                                              } catch (e) {}
                                            },
                                            child: Icon(
                                                Icons.camera_alt_outlined)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Camera",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Name ",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: userprovider.nameController,
            decoration: InputDecoration(
              hintText: "Enter name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Age ",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: userprovider.ageController,
            decoration: InputDecoration(
              hintText: "Enter Age",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 206, 206, 206)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color.fromARGB(255, 101, 101, 101),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 49, 73, 255)),
                child: MaterialButton(
                  onPressed: () async {
                    if (userprovider.images.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please select and Upload try Image"),
                      ));
                      return;
                    }
                    final String name = userprovider.nameController.text;
                    final int? age =
                        int.tryParse(userprovider.ageController.text);
                    if (age != null) {
                      await _items.add({
                        "name": name,
                        "age": age,
                        "image": userprovider.images,
                      });
                      userprovider.nameController.text = "";
                      userprovider.ageController.text = '';

                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
