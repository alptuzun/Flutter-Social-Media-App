
/*
class CommentCard extends StatefulWidget {
  final Comment userComment;

  const CommentCard(
      {Key? key, required this.userComment})
      : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}
/*
class _CommentCardState extends State<CommentCard> {
  String userPfp = "";
  String? comment;

  Future getAvatar() async {
    final pFp = await UserService.getProfilePicture(widget.userComment.userID);
    setState(() {
      userPfp = pFp;
    });
  }

  @override
  void initState() {
    super.initState();
    getAvatar();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                if (userPfp.isNotEmpty)
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: CachedNetworkImageProvider(userPfp),
                  ),
                SizedBox(
                  width: screenWidth(context, dividedBy: 100) * 2,
                ),
                Text(
                  widget.realPost.fullName,
                  style: Styles.userNameTextStyle,
                  textAlign: TextAlign.start,
                  textScaleFactor: 0.75,
                ),
                SizedBox(
                  width: screenWidth(context, dividedBy: 100),
                ),
                Text(
                  "@${widget.realPost.username}",
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.start,
                ),
                const Spacer(),
                Text(
                  "${widget.realPost.postTime.day}-${widget.realPost.postTime.month}-${widget.realPost.postTime.year}",
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
       */           ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            if (widget.realPost.type != "text")
              Container(
                  padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                  child: CachedNetworkImage(
                    imageUrl: widget.realPost.postURL,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                  )),
            Text(
              widget.realPost.caption,
              style: Styles.appMainTextStyle,
            ),
            if (widget.realPost.caption.isNotEmpty)
              SizedBox(
                height: screenHeight(context, dividedBy: 100),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.isOwner == true)
                  PopupMenuButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.black,
                    ),
                    iconSize: 35,
                    onSelected: (value) {
                      if (value == 'Edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditPost(editedPost: widget.realPost)),
                        );
                      } else {
                        setState(() {
                          PostService.deletePost(
                              widget.userID, widget.jsonPost);
                        });
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          height: screenHeight(context) / 100 * 4,
                          value: 'Edit',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Edit"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          height: screenHeight(context) / 100 * 4,
                          value: 'Delete',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Delete"),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                const Spacer(flex: 30),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_upward_rounded),
                  onPressed: widget.likes,
                  iconSize: screenWidth(context, dividedBy: 20),
                  splashRadius: 18,
                  color: Colors.green,
                ),
                const Spacer(
                  flex: 8,
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_downward_rounded),
                  onPressed: widget.dislikes,
                  iconSize: screenWidth(context, dividedBy: 20),
                  splashRadius: 18,
                  color: Colors.red,
                ),
                const Spacer(
                  flex: 6,
                ),
                Text(
                    (widget.realPost.likes.length -
                        widget.realPost.dislikes.length)
                        .toString(),
                    style: Styles.appMainTextStyle),
                const Spacer(
                  flex: 21,
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.mode_comment_outlined),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: AlertDialog(
                        insetPadding:
                        const EdgeInsets.fromLTRB(10, 200, 10, 200),
                        elevation: 0,
                        backgroundColor: Colors.white,
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              minLines: 1,
                              maxLines: 4,
                              onChanged: (value) {
                                comment = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Add your comment",
                                hintStyle: Styles.appMainTextStyle,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight(context) / 100 * 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: (screenWidth(context) / 100) * 40,
                                  height: (screenHeight(context) / 100) * 5.5,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment(0, -1),
                                        end: Alignment(0, 0),
                                        colors: [
                                          Colors.lightBlue,
                                          Colors.lightBlueAccent
                                        ]),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20))),
                                      child: Text(
                                        "Go Back",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth(context) / 100 * 2,
                                ),
                                Container(
                                  width: (screenWidth(context) / 100) * 40,
                                  height: (screenHeight(context) / 100) * 5.5,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment(0, -1),
                                        end: Alignment(0, 0),
                                        colors: [
                                          Colors.lightBlue,
                                          Colors.lightBlueAccent
                                        ]),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (comment != null) {
                                          PostService.commentToPost(
                                              user!.uid,
                                              widget.realPost.userID,
                                              widget.realPost.postID,
                                              Comment(
                                                  time: DateTime.now(),
                                                  userID: user.uid,
                                                  content: comment!));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20))),
                                      child: Text(
                                        "Comment",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  iconSize: screenWidth(context, dividedBy: 20),
                  splashRadius: 18,
                  color: Colors.blue,
                ),
                const Spacer(
                  flex: 3,
                ),
                Text(widget.realPost.comments.length.toString(),
                    style: Styles.appMainTextStyle),
                const Spacer(flex: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
*/