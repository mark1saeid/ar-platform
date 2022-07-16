import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/features/freinds/general_widgets/text_caption_widget.dart';
import 'package:ratering_gen_zero/features/freinds/viewmodel/add_friend_provider.dart';
import '../../../auth/general_widget/authwidget.dart';
import '../../general_widgets/pic_widget.dart';
import '../../general_widgets/send_friend_button.dart';

class AddNewFriendScreen extends StatelessWidget {
  final controller = TextEditingController();
  static const String id = 'AddNewFriendScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Consumer<AddFriendProvider>(
            builder: (BuildContext ctx, value, Widget child) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              if (!value.search) controller.clear();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!value.search)
                  pictureWidget(
                    context: context,
                    image:
                        'https://png.pngtree.com/png-vector/20210908/ourlarge/pngtree-boy-girl-on-the-phone-chatting-making-friends-online-png-transparent-png-image_3916413.jpg',
                    text: 'Add Your friend Now',
                    caption:
                        'You will need their username,Keep in mind that username is case sensitive ',
                  ),
                if (value.search)
                  pictureWidget(
                    context: context,
                    image: value.receiverModel.profilePic ??
                        'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png',
                    text: value.receiverModel.name ?? 'USER',
                    caption: value.receiverModel.bio ?? '',
                  ),
                SizedBox(height: 10),
                EntryField(
                  onFieldSubmitted: (String values) {
                    value.searchSingleUserMethod(userName: controller.text);
                  },
                  isPassword: false,
                  title: 'username',
                  controller: controller,
                  hint: 'Type Username here',
                ),
                FutureBuilder<String>(
                    future: getMyUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return textCaptionWidget(id: snapshot.data);
                      } else {
                        return Container();
                      }
                    }),
                SizedBox(height: 20),
                sendFriendRequestButton(
                  onTap: !value.search
                      ? () {
// need notification friend request already sent
                        }
                      : () {
// need notification friend request sent successfully
                          value.sendFollowRequestMethod();
                          controller.clear();
                          FocusScope.of(context).unfocus();
                        },
                  color: value.search ? Colors.black : Colors.grey,
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        }),
      ),
    );
  }
}
