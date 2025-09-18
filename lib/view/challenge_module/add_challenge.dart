import 'package:assetmanag/utils/colors.dart';
import 'package:assetmanag/widget/button_widget.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

class AddChallenge extends StatefulWidget {
  const AddChallenge({super.key});

  @override
  State<AddChallenge> createState() => _AddChallengeState();
}

class _AddChallengeState extends State<AddChallenge> {
  final _formKey = GlobalKey<FormState>();
  String? _inputValue;
  String? _selectedGender;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle the selected image
      print('Image selected from gallery: ${image.path}');
    }
  }

  Future<void> _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Handle the captured image
      print('Picture taken: ${image.path}');
    }
  }

  Future<void> _pickSoundFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      // Handle the selected sound file
      print('Sound file selected: ${result.files.single.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text("PPIS APPLICATION"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    Column(children: [
                      Container(height: 120, color: Colors.blue),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                    // Positioned(
                    //     left: 90,
                    //     top: 10,
                    //     child: CircleAvatar(
                    //       radius: 30,
                    //       backgroundColor: cyan.withOpacity(0.5),
                    //     )
                    // ),
                    Positioned(
                      right: 100,
                      top: 15,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 140,
                      ),
                    ),
                    // Positioned(
                    //   right: 90,
                    //   bottom: 5,

                    //     child: CircleAvatar(
                    //       radius: 70,
                    //       backgroundColor: white,
                    //       child: Image.asset(
                    //         'assets/images/logo.png',
                    //         width: 120,
                    //       ),
                    //     ),

                    // )
                  ],
                ),
              ),
              SizedBox(
                  height: 10,
                  child: Expanded(
                    child: Container(
                      color: Colors.blue,
                      height: 10, // Set height for the row
                    ),
                  )),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Text(
                "Challenge Form",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //     labelText: 'Email',
                      //     prefixIcon: Icon(Icons.email, color: Colors.blue), // Icon color
                      //     labelStyle: TextStyle(color: Colors.blue), // Label color
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.blue), // Underline color
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.blue), // Focused underline color
                      //     ),
                      //   ),
                      //   style: const TextStyle(color: Colors.blue), // Text color
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your email';
                      //     }
                      //     // Add more validation if necessary
                      //     return null;
                      //   },
                      // ),
                      // const SizedBox(height: 16),
                      // TextFormField(
                      //   obscureText: true,
                      //   decoration: const InputDecoration(
                      //     labelText: 'Password',
                      //     prefixIcon: Icon(Icons.lock, color: Colors.blue), // Icon color
                      //     labelStyle: TextStyle(color: Colors.blue), // Label color
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.blue), // Underline color
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.blue), // Focused underline color
                      //     ),
                      //   ),
                      //   style:const  TextStyle(color: Colors.blue), // Text color
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your password';
                      //     }
                      //     // Add more validation if necessary
                      //     return null;
                      //   },
                      // ),
                      //  const SizedBox(height: 16),

                      const SizedBox(height: 16),
                      // DropdownButtonFormField<String>(
                      //   decoration: InputDecoration(
                      //     labelText: 'Gender',
                      //     prefixIcon: Icon(Icons.person, color: Colors.blue), // Icon color
                      //     labelStyle: const TextStyle(color: Colors.blue), // Label color
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.blue), // Border color
                      //       borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: const BorderSide(color: Colors.blueAccent), // Focused border color
                      //       borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      //     ),
                      //   ),
                      //   // value: _selectedGender,
                      //   items: const [
                      //     DropdownMenuItem(
                      //       value: 'Male',
                      //       child: Text('Male'),
                      //     ),
                      //     DropdownMenuItem(
                      //       value: 'Female',
                      //       child: Text('Female'),
                      //     ),
                      //   ],
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedGender = value; // Update the selected gender
                      //     });
                      //   },
                      //   validator: (value) {
                      //     if (value == null) {
                      //       return 'Please select your gender';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      //   const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          prefixIcon: Icon(Icons.person,
                              color: Colors.blue), // Icon color
                          labelStyle:
                              TextStyle(color: Colors.blue), // Label color
                          border: InputBorder.none, // Remove border
                        ),
                        value: _selectedGender,
                        items: const [
                          DropdownMenuItem(
                            value: 'Male',
                            child: Text('Male'),
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            // _selectedGender = value; // Update the selected gender
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select your gender';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly, // Space evenly
                        children: [
                          GestureDetector(
                            onTap: _pickImageFromGallery,
                            child: Container(
                              width: 80,
                              height: 80,
                              color: Colors.blue,
                              child: const Center(
                                child: Icon(Icons.photo,
                                    color: Colors.white,
                                    size: 40), // Gallery icon
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _takePicture,
                            child: Container(
                              width: 80,
                              height: 80,
                              color: Colors.blue,
                              child: Center(
                                child: Icon(Icons.camera_alt,
                                    color: Colors.white,
                                    size: 40), // Camera icon
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _pickSoundFile,
                            child: Container(
                              width: 80,
                              height: 80,
                              color: Colors.blue,
                              child: Center(
                                child: Icon(Icons.audiotrack,
                                    color: Colors.white,
                                    size: 40), // Sound file icon
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          prefixIcon: Icon(Icons.description,
                              color: Colors.blue), // Icon color
                          labelStyle: const TextStyle(
                              color: Colors.blue), // Label color
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue), // Border color
                            borderRadius:
                                BorderRadius.circular(8.0), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    Colors.blueAccent), // Focused border color
                            borderRadius:
                                BorderRadius.circular(8.0), // Rounded corners
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.blue, // Text color
                          fontWeight: FontWeight.bold, // Make text bold
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          // Add more validation if necessary
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Consumer(builder: (context, value, child) {
                        return ButtonWidget(
                            title: "Save",
                            color: blue,
                            textColor: white,
                            // isLoading: value.isLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                (context);
                              }
                            });
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
