import 'package:chatview/chatview.dart';
import 'package:example/data.dart';
import 'package:example/glass.dart';
import 'package:example/models/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat UI Demo',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: const Color(0xffEE5366),
      //   colorScheme:
      //       ColorScheme.fromSwatch(accentColor: const Color(0xffEE5366)),
      // ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  AppTheme theme = LightTheme();
  bool isDarkTheme = false;
  final currentUser = ChatUser(
    id: '1',
    name: 'Flutter',
    profilePhoto: Data.profileImage,
  );
  final _chatController = ChatController(
    initialMessageList: Data.messageList,
    scrollController: ScrollController(),
    chatUsers: [
      ChatUser(
        id: '2',
        name: 'Simform',
        profilePhoto: Data.profileImage,
      ),
      ChatUser(
        id: '3',
        name: 'Jhon',
        profilePhoto: Data.profileImage,
      ),
      ChatUser(
        id: '4',
        name: 'Mike',
        profilePhoto: Data.profileImage,
      ),
      ChatUser(
        id: '5',
        name: 'Rich',
        profilePhoto: Data.profileImage,
      ),
    ],
  );

  void _showHideTypingIndicator() {
    _chatController.setTypingIndicator = !_chatController.showTypingIndicator;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassContainer(
        imageUrl: 'https://picsum.photos/250',
        child: ChatView(
          currentUser: currentUser,
          chatController: _chatController,
          onSendTap: _onSendTap,
          featureActiveConfig: const FeatureActiveConfig(
            lastSeenAgoBuilderVisibility: true,
            receiptsBuilderVisibility: true,
            enableSwipeToSeeTime: false,
            enableOtherUserProfileAvatar: false,
            enableChatSeparator: true,
          ),
          chatViewState: ChatViewState.hasMessages,
          chatViewStateConfig: ChatViewStateConfiguration(
            loadingWidgetConfig: ChatViewStateWidgetConfiguration(
              loadingIndicatorColor: theme.outgoingChatBubbleColor,
            ),
            onReloadButtonTap: () {},
          ),
          typeIndicatorConfig: TypeIndicatorConfiguration(
            flashingCircleBrightColor: theme.flashingCircleBrightColor,
            flashingCircleDarkColor: theme.flashingCircleDarkColor,
          ),
          appBar: ChatViewAppBar(
            elevation: 0, //theme.elevation,
            backGroundColor: Colors
                .transparent, //.black.withOpacity(0.25), //theme.appBarColor,
            profilePicture: Data.profileImage,
            backArrowColor: theme.backArrowColor,
            chatTitle: "Chat view",
            chatTitleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.25,
            ),
            // userStatus: "online",
            // leading: Expanded(child: Spacer()),
            showLeading: false,
            userStatusTextStyle: const TextStyle(color: Colors.grey),
            // actions: [
            //   IconButton(
            //     onPressed: _onThemeIconTap,
            //     icon: Icon(
            //       isDarkTheme
            //           ? Icons.brightness_4_outlined
            //           : Icons.dark_mode_outlined,
            //       color: theme.themeIconColor,
            //     ),
            //   ),
            //   IconButton(
            //     tooltip: 'Toggle TypingIndicator',
            //     onPressed: _showHideTypingIndicator,
            //     icon: Icon(
            //       Icons.keyboard,
            //       color: theme.themeIconColor,
            //     ),
            //   ),
            // ],
          ),
          chatBackgroundConfig: ChatBackgroundConfiguration(
              messageTimeIconColor: theme.messageTimeIconColor,
              messageTimeTextStyle:
                  TextStyle(color: theme.messageTimeTextColor),
              defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
                textStyle: TextStyle(
                  color: Colors.white.withOpacity(0.25),
                  fontSize: 14,
                ),
              ),
              backgroundColor:
                  Colors.black.withOpacity(0.75) //theme.backgroundColor,
              ),
          sendMessageConfig: SendMessageConfiguration(
            imagePickerIconsConfig: ImagePickerIconsConfiguration(
              cameraIconColor: Colors.white.withOpacity(0.75),
              galleryIconColor: Colors.white.withOpacity(0.75),
            ),
            replyMessageColor: Colors.white,
            defaultSendButtonColor: Colors.white,
            replyDialogColor: Colors.black.withOpacity(0.85),
            replyTitleColor: Colors.white,
            textFieldBackgroundColor: Colors.white
                .withOpacity(0.25), //theme.textFieldBackgroundColor,
            closeIconColor: Colors.white,
            textFieldConfig: TextFieldConfiguration(
              onMessageTyping: (status) {
                /// Do with status
                debugPrint(status.toString());
              },
              compositionThresholdTime: const Duration(seconds: 1),
              // textStyle: TextStyle(color: theme.textFieldTextColor),
            ),
            micIconColor: theme.replyMicIconColor,
            voiceRecordingConfiguration: VoiceRecordingConfiguration(
              backgroundColor: theme.waveformBackgroundColor,
              recorderIconColor: Colors.white.withOpacity(0.75),
              waveStyle: WaveStyle(
                showMiddleLine: false,
                waveColor: theme.waveColor ?? Colors.white,
                extendWaveform: true,
              ),
            ),
          ),
          chatBubbleConfig: ChatBubbleConfiguration(
            outgoingChatBubbleConfig: ChatBubble(
              linkPreviewConfig: LinkPreviewConfiguration(
                backgroundColor: Colors.red,
                bodyStyle: theme.outgoingChatLinkBodyStyle,
                titleStyle: theme.outgoingChatLinkTitleStyle,
              ),
              receiptsWidgetConfig: const ReceiptsWidgetConfig(
                  showReceiptsIn: ShowReceiptsIn.all),
              color: Colors.white.withOpacity(0.75),
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            inComingChatBubbleConfig: ChatBubble(
              linkPreviewConfig: LinkPreviewConfiguration(
                linkStyle: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
                backgroundColor: Colors.black,
                bodyStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
                titleStyle: TextStyle(
                  color: Colors.white,
                  // fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              onMessageRead: (message) {
                /// send your message reciepts to the other client
                debugPrint('Message Read');
              },
              senderNameTextStyle:
                  TextStyle(color: theme.inComingChatBubbleTextColor),
              color: Colors.white.withOpacity(0.25),
            ),
          ),
          replyPopupConfig: ReplyPopupConfiguration(
            backgroundColor: theme.replyPopupColor,
            buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor),
            topBorderColor: theme.replyPopupTopBorderColor,
          ),
          reactionPopupConfig: ReactionPopupConfiguration(
            shadow: BoxShadow(
              color: isDarkTheme ? Colors.black54 : Colors.grey.shade400,
              blurRadius: 20,
            ),
            backgroundColor: theme.reactionPopupColor,
          ),
          messageConfig: MessageConfiguration(
            messageReactionConfig: MessageReactionConfiguration(
              backgroundColor: theme.messageReactionBackGroundColor,
              borderColor: theme.messageReactionBackGroundColor,
              reactedUserCountTextStyle:
                  TextStyle(color: theme.inComingChatBubbleTextColor),
              reactionCountTextStyle:
                  TextStyle(color: theme.inComingChatBubbleTextColor),
              reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
                backgroundColor: theme.backgroundColor,
                reactedUserTextStyle: TextStyle(
                  color: theme.inComingChatBubbleTextColor,
                ),
                reactionWidgetDecoration: BoxDecoration(
                  color: theme.inComingChatBubbleColor,
                  boxShadow: [
                    BoxShadow(
                      color:
                          isDarkTheme ? Colors.black12 : Colors.grey.shade200,
                      offset: const Offset(0, 20),
                      blurRadius: 40,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            imageMessageConfig: ImageMessageConfiguration(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              shareIconConfig: ShareIconConfiguration(
                defaultIconBackgroundColor: theme.shareIconBackgroundColor,
                defaultIconColor: theme.shareIconColor,
              ),
            ),
          ),
          profileCircleConfig: const ProfileCircleConfiguration(
            profileImageUrl: Data.profileImage,
          ),
          repliedMessageConfig: RepliedMessageConfiguration(
            backgroundColor: Colors.black,
            verticalBarColor: Colors.white, //Colors.deepPurple,
            repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
              enableHighlightRepliedMsg: true,
              highlightColor: Colors.pinkAccent.shade100,
              highlightScale: 1.1,
            ),
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
              // fontWeight: FontWeight.bold,
              letterSpacing: 0.25,
            ),
            replyTitleTextStyle: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    final id = int.parse(Data.messageList.last.id) + 1;
    _chatController.addMessage(
      Message(
        id: id.toString(),
        createdAt: DateTime.now(),
        message: message,
        sendBy: currentUser.id,
        replyMessage: replyMessage,
        messageType: messageType,
      ),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      _chatController.initialMessageList.last.setStatus =
          MessageStatus.undelivered;
    });
    Future.delayed(const Duration(seconds: 1), () {
      _chatController.initialMessageList.last.setStatus = MessageStatus.read;
    });
  }

  void _onThemeIconTap() {
    setState(() {
      if (isDarkTheme) {
        theme = LightTheme();
        isDarkTheme = false;
      } else {
        theme = DarkTheme();
        isDarkTheme = true;
      }
    });
  }
}
