part of 'pages.dart';

class RoomPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Firestore.instance;
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return ListView(
      children: [
        // TODO : HEADER
        Container(
          decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                if (imageFileToUpluad != null) {
                  uploadImage(imageFileToUpluad).then((downloadURL) {
                    imageFileToUpluad = null;
                    context
                        .bloc<UserBloc>()
                        .add(UpdateData(profileImage: downloadURL));
                  });
                }
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(GoToProfilePage());
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Color(0xFF5F5588), width: 1)),
                        child: Stack(
                          children: [
                            SpinKitCircle(
                              color: accentColor2,
                              size: 50,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: (userState.user.profilePicture ==
                                              ""
                                          ? AssetImage("assets/user_pic.png")
                                          : NetworkImage(
                                              userState.user.profilePicture)),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              78,
                          child: Text(
                            userState.user.name,
                            style: whiteTextFont.copyWith(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Text(
                          userState.user.email,
                          style: yellowNumberFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return SpinKitCircle(
                  color: accentColor2,
                  size: 50,
                );
              }
            },
          ),
        ),

        // TODO : HOTEL ROOM
//        Container(
//          margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
//          child: Text(
//            "Hotel Room",
//            style: blackTextFont.copyWith(
//                fontSize: 18, fontWeight: FontWeight.bold),
//          ),
//        ),
      ],
    );
  }
}
