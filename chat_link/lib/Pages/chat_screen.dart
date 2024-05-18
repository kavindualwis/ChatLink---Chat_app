import 'package:chat_link/Components/chat_textfield.dart';
import 'package:chat_link/Services/Auth/auth_service.dart';
import 'package:chat_link/Services/Chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String receiverName;
  final String receiverID;

  const ChatScreen({
    super.key,
    required this.receiverName,
    required this.receiverID,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //for textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated,
        // then scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 900),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(widget.receiverID, messageController.text);

      //clear controller
      messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            widget.receiverName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //msg
              Expanded(
                child: _buildMessageList(),
              ),

              //user input
              _buildUserInput()
            ],
          ),
        ),
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        //errors
        if (snapshot.hasError) {
          return const Text('Error');
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        // Scroll down when new messages arrive
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollDown();
        });

        //return listview
        return ListView.builder(
            controller: _scrollController, // Attach controller here
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data?.docs[index];
              return _buildMessageItem(doc!);
            });
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align message to use if sender is current user, ohterwise left
    var alignment = isCurrentUser ? Alignment.center : Alignment.center;

    var borderRadius = isCurrentUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    var margin = isCurrentUser
        ? EdgeInsets.only(
            right: 10,
            top: 20,
            left: MediaQuery.of(context).size.width / 2,
          )
        : EdgeInsets.only(
            right: MediaQuery.of(context).size.width / 2,
            top: 20,
            left: 20,
          );
    final message = data['message'] ?? 'No message';
    return Container(
      padding: const EdgeInsets.all(12),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: borderRadius,
      ),
      child: Column(
        children: [
          Text(
            message,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    //Text(message);
  }

  //build user message send textfield
  Widget _buildUserInput() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: ChatTextField(
              suffixIcon: const Icon(Icons.category_outlined),
              hintText: 'Type a message',
              obscureText: false,
              controller: messageController,
              focusNode: myFocusNode,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
