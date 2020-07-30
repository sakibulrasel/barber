import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class ReviewWidget extends StatefulWidget {
  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xff476cfb),
              child: ClipOval(
                child: new SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Image.network(
                      "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                      fit: BoxFit.fill,
                    )

                ),
              ),
          ),

            Expanded(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Alex Piw Daniel"),
                      SmoothStarRating(
                        rating: 4,
                        size: 20,
                        isReadOnly: true,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                      )
                    ],
                  ),
                  Container(
                    margin:EdgeInsets.only(top:5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin:EdgeInsets.only(left: 25),
                          child: Text(
                              "Yesterday",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(right: 25),
                          child: Text(
                              "4 out of 5",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:EdgeInsets.only(left: 25,top: 15),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam semper, odio et efficitur tristique, ex nibh ullamcorper ante, elementum ultrices sapien erat id nisi. Maecenas nec risus eget leo volutpat suscipit.",
                      style: TextStyle(
                        fontSize: 10
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
