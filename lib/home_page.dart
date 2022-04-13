import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_app_2/detail_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? image;

  late final TextEditingController nameController;
  late final TextEditingController birthdateController;

  DateTime? birthdate;

  @override
  void initState() {
    nameController = TextEditingController();
    birthdateController = TextEditingController();

    super.initState();
  }

  Future getImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    image = await showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Title
                const Text(
                  'Pilih mana?',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    /// Gallery button
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        onPressed: () async {
                          final XFile? _image = await _picker.pickImage(
                            source: ImageSource.gallery,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.25,
                            maxWidth: MediaQuery.of(context).size.height * 0.5,
                          );

                          if (_image != null) {
                            Navigator.pop(context, _image);
                          }
                        },
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Galeri'),
                      ),
                    ),
                    const SizedBox(width: 12),

                    /// Camera button
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        onPressed: () async {
                          final XFile? _image = await _picker.pickImage(
                            source: ImageSource.camera,
                            preferredCameraDevice: CameraDevice.front,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.25,
                            maxWidth: MediaQuery.of(context).size.height * 0.5,
                          );

                          if (_image != null) {
                            Navigator.pop(context, _image);
                          }
                        },
                        icon: const Icon(Icons.photo_camera),
                        label: const Text('Kamera'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    setState(() {});
  }

  List datas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            /// Profile Image
            Column(
              children: [
                /// Title
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Foto Profil',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),

                /// Image Avatar
                if (image != null)
                  CircleAvatar(
                    foregroundImage: FileImage(
                      File(image!.path),
                    ),
                    radius: 50,
                  )
                else
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 50,
                  ),

                const SizedBox(height: 10),

                /// Change image profile button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    shape: const StadiumBorder(
                      side: BorderSide(),
                    ),
                  ),
                  onPressed: () => getImage(context),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            /// Form
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  /// Nama
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nama',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: nameController,
                        validator: (value) =>
                            value!.isEmpty ? "Name Shouldn't be empty" : null,
                        decoration: InputDecoration(
                          hintText: 'Masukan nama',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          suffixIcon: ValueListenableBuilder(
                            valueListenable: nameController,
                            builder: (context, TextEditingValue value, _) {
                              return Visibility(
                                visible: value.text.isNotEmpty,
                                child: IconButton(
                                  onPressed: () => nameController.clear(),
                                  icon: const Icon(
                                    CupertinoIcons.clear_circled_solid,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Tanggal Lahir
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tanggal lahir',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        readOnly: true,
                        controller: birthdateController,
                        validator: (value) => value!.isEmpty
                            ? "Birthdate Shouldn't be empty"
                            : null,
                        decoration: const InputDecoration(
                          hintText: 'Masukan tanggal lahir',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        textInputAction: TextInputAction.next,
                        onTap: () async {
                          birthdate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(DateTime.now().year - 12),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(DateTime.now().year - 12),
                          );

                          if (birthdate != null) {
                            birthdateController.text =
                                DateFormat('EEEE dd MMMM yyyy')
                                    .format(birthdate!);
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Jenis Kelamin
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       localization.gender,
                  //       style: const TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //     const SizedBox(height: 4),
                  //     GenderOverlayTextField(
                  //       defaultGender: widget.gender,
                  //       defaultGenderId: widget.genderId,
                  //     ),
                  //   ],
                  // ),

                  ElevatedButton(
                    // onPressed: () => nameController.text = "Eddi Guererro",
                    onPressed: () async {
                      final String user = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailWidget(
                            imagePath: image!.path,
                            nama: nameController.text,
                            tgl: birthdateController.text,
                          ),
                        ),
                      );

                      datas.add(user);

                      setState(() {});
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
