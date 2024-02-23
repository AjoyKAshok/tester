import 'package:flutter/material.dart';
import 'package:merchandising/utils/background.dart';


class HQCommunication extends StatefulWidget {
  static const routeName = '/HQCommunication';
  HQCommunication();

  @override
  State<HQCommunication> createState() => _HQCommunicationState();
}

class _HQCommunicationState extends State<HQCommunication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Color(0XFF909090),
        ),
        title: const Text(
          'HQ Communication',
          style: TextStyle(
            color: Color(0XFF909090),
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Stack(
        children: [
          BackGround(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                  //  Navigator.of(context).pushNamed(ChatScreen.routeName);
                  },
                  child: chatContainer(
                    'RMS Team',
                    'All',
                    0XFFF76F8D,
                    0XFF1EC2C1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    print('Clicked on 1st');
                  },
                  child: chatContainer(
                    'Field Manager',
                    'Sailesh Bhandari',
                    0XFFF76F8D,
                    0XFF1EC2C1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget chatContainer(
    String title,
    String memberName,
    int arrowColorCode,
    int iconColorCode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 108,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            var _value = title;
            if(_value == 'RMS Team') {
            // Navigator.of(context).pushNamed(ChatScreen.routeName);
            }
            else {
              // Navigator.of(context).pushNamed(ChatPage.routeName);
            }
          },
          // child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 15,
                ),
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: const BoxDecoration(
                    color: Color(0XFFFFF2F5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 42,
                    color: Color(0XFFF76F8D),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.man),
                        Text(memberName),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .30,
              ),
              Icon(Icons.arrow_forward_ios_outlined, color: Color(0XFFE84201)),
            ],
          ),

          // ),
        ),
      ),
    );
  }
}
