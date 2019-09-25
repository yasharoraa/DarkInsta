import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class InstaHome extends StatelessWidget {
  const InstaHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Building insta Story items by images in "Story_images" folder
    var story_items = List.generate(
        10,
        (index) => Story('story_images/image$index.jpg',
            faker.person.firstName().toLowerCase()));

    story_items.insert(0, Story('assets/person.jpg', 'My story'));

    //Building insta post items by "post_images" folder and using "profile_images"
    // post list will contain 11 items because at 0 place we have added story ListView
    var post_items = List.generate(
        11,
        (index) => Post(
            'profile_images/image$index.jpg',
            'post_images/image$index.jpg',
            faker.person.firstName().toLowerCase()));

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            title: Text(
              'Instagram',
              style: TextStyle(fontFamily: 'Billabong'),
            ),
            leading: Icon(Icons.camera_alt),
            actions: <Widget>[
              Icon(Icons.live_tv),
              SizedBox(
                width: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: RotationTransition(
                    turns: AlwaysStoppedAnimation(330 / 360),
                    child: Icon(Icons.send)),
              ),
              SizedBox(
                width: 10.0,
              )
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                          child: ListView.builder(
                itemCount: 11,
                itemBuilder: (context, index) {
                  return _post(index, story_items, post_items);
                },
              ),
            ),
            Container(
                height: 1.0,
                color: Colors.white24,
            ),
            Container(
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.only(top:6.0,bottom:6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.home),
                    Icon(Icons.search),
                    Icon(Icons.add),
                    Icon(Icons.favorite_border),
                    ClipOval(
                      child: Image.asset(
                        'assets/person.jpg',
                        width: 20.0,
                        fit: BoxFit.fill,
                        height: 20.0,
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ));
  }

  //story widget : done :)
  Widget _story(int index, List<Story> items) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 26.0,
                child: ClipOval(
                  child: Image.asset(
                    'assets/story_circle.png',
                    width: 52.0,
                    fit: BoxFit.fill,
                    height: 52.0,
                  ),
                ),
              ),
              Positioned(
                left: 2.0,
                top: 2.0,
                child: CircleAvatar(
                  radius: 24.0,
                  child: ClipOval(
                    child: Image.asset(
                      items[index].imageSource,
                      width: 48.0,
                      fit: BoxFit.fill,
                      height: 48.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              items[index].bottomText,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10.0),
            ),
          ),
        ],
      ),
    );
  }

  //lets start post widget now
  Widget _post(int index, List<Story> story_items, List<Post> post_items) {
    var random = Random();

    if (index == 0) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 85.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: story_items.length,
                itemBuilder: (context, index) {
                  return _story(index, story_items);
                },
              ),
            ),
          ),
          Container(
              height: 1.0,
              width: double.maxFinite,
              color: Colors.white10,
            )
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 12.5,
                      child: ClipOval(
                        child: Image.asset(
                          post_items[index].profileImageSource,
                          width: 25.0,
                          fit: BoxFit.fill,
                          height: 25.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      post_items[index].username,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_vert,
                  size: 16.0,
                ),
              )
            ],
          ),
          Image.asset(
            post_items[index].profileImageSource,
            height: 200.0,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite_border,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RotationTransition(
                          turns: AlwaysStoppedAnimation(330 / 360),
                          child: Icon(
                            Icons.send,
                            size: 20.0,
                          )),
                    ),
                  ],
                ),
                Icon(Icons.bookmark_border)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              random.nextInt(100).toString() +
                  ',' +
                  random.nextInt(1000).toString() +
                  ' likes ',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 0.0),
            child: Text(
              'View All ' + random.nextInt(1000).toString() + ' Comments',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w200),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 8.0, 8.0, 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 12.5,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/person.jpg',
                            width: 25.0,
                            fit: BoxFit.fill,
                            height: 25.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:4.0),
                      child: Text(
                        'Add a comment...',
                        style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
                Row(
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  color:Colors.red,
                  size: 10.0
                ),
                SizedBox(width: 12.0,),
                Icon(
                  Icons.add_circle_outline,
                  size: 10.0,
                  color: Colors.white38,
                )
              ],
            )
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.only(left: 8.0),
            child: Text(
              random.nextInt(10).toString() + ' hours ago',
              style : TextStyle(fontSize: 7.0,fontWeight:FontWeight.w300)
            ),
          )
        ],
      );
    }
  }
}

// Thanks for watching 

//Subscribe for more speed codes :)
