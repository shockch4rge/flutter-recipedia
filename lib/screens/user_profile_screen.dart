import 'package:flutter/material.dart';
import 'package:flutter_recipedia/main.dart';
import 'package:flutter_recipedia/models/user.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';
import 'package:flutter_recipedia/widgets/appbars/profile_app_bar.dart';
import 'package:flutter_recipedia/widgets/common/avatar.dart';
import 'package:flutter_recipedia/widgets/common/expandable_container.dart';
import 'package:flutter_recipedia/widgets/common/navbar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // User get user => getArgs<User>(context);
  User get user => mockUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ProfileAppBar(
          title: Text(
            user.username,
            style: const TextStyle(color: App.primaryAccent),
          ),
        ),
        bottomNavigationBar: const Navbar(),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _buildUserDescription(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 30),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "${user.username}'s posts",
                  textAlign: TextAlign.center,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ExpandableContainer(width: 40, height: 40);
                  },
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
              ),
            ],
          ),
        ));
  }

  _buildUserDescription() {
    const countTextStyle = TextStyle(
      color: App.primaryAccent,
      fontSize: 18,
      fontWeight: FontWeight.w800,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Avatar(size: 64, avatarUrl: user.avatarUrl),
            Wrap(
              spacing: 14,
              children: [
                Column(
                  children: [
                    const Text(
                      "${0}",
                      style: countTextStyle,
                    ),
                    Text(
                      "Posts",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "${user.followers.length}",
                      style: countTextStyle,
                    ),
                    Text(
                      "Followers",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "${user.following.length}",
                      style: countTextStyle,
                    ),
                    Text(
                      "Following",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: 10),
            Text(user.bio, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: Size.infinite.width,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Follow"),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: App.primaryAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
