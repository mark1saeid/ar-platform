import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/features/auth/view_model/edt_profile_provider.dart';
import 'package:ratering_gen_zero/features/home/view/main_page.dart';
import '../../general_widget/authwidget.dart';
import '../../general_widget/edit_profile_button.dart';
import '../../general_widget/edit_profile_pic_widget.dart';

class EditProfileScreen extends StatelessWidget {
  static const String id = 'EditProfileScreen';
  final userNameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            )),
        elevation: 5,
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Consumer<EditProfileProvider>(
          builder: (BuildContext ctx, value, child) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Center(
                    child: Stack(
                      children: [
                        if (value.profileImage != null)
                          buildProfilePicWidget(
                              context: context,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(value.profileImage),
                              )),
                        if (value.profileImage == null)
                          buildProfilePicWidget(
                            context: context,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png'),
                            ),
                          ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.black,
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  value.getProfilePic();
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  EntryField(
                    controller: userNameController,
                    title: "Username",
                    hint: "example123",
                    isPassword: false,
                  ),
                  EntryField(
                    validator: (String value) {},
                    controller: bioController,
                    title: "bio",
                    hint: "write bio here",
                    isPassword: false,
                  ),
                  EntryField(
                      controller: phoneNumberController,
                      title: "phone number",
                      hint: "0100000000",
                      isPassword: false),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, MainScreen.id);
                        },
                        child: buildEditProfileButton(
                          text: 'Cancel',
                          textColor: Colors.black,
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              value.uploadToFireBase(
                                picture: value.myPicture,
                                name: userNameController.text,
                                bio: bioController.text,
                                phoneNumber: phoneNumberController.text,
                              );
                              Navigator.pushNamed(context, MainScreen.id);
                            },
                            child: buildEditProfileButton(
                              text: 'Save',
                              textColor: Colors.white,
                              backgroundColor: Colors.black,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
