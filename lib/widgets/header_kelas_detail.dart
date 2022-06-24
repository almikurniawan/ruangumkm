import 'package:flutter/material.dart';
import 'package:online_course/widgets/icon_circular.dart';

class HeaderKelasDetail extends StatelessWidget {
  final String judul;
  final String fasilitator;
  const HeaderKelasDetail(
      {Key? key, required this.judul, required this.fasilitator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black, size: 16)),
              SizedBox(width: 10),
              Text(this.judul, style: Theme.of(context).textTheme.headline2),
            ],
          ),
          Row(
            children: [
              IconCircular(
                  color: Color(0xff424242),
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Fasilitator",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .merge(TextStyle(fontWeight: FontWeight.bold))),
                  Text(this.fasilitator,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       "Review",
              //       style: Theme.of(context).textTheme.headline6!.merge(
              //             TextStyle(fontWeight: FontWeight.bold),
              //           ),
              //     ),
              //     Row(
              //       children: [
              //         Icon(
              //           Icons.star,
              //           color: Colors.amber,
              //           size: 18,
              //         ),
              //         Icon(
              //           Icons.star,
              //           color: Colors.amber,
              //           size: 18,
              //         ),
              //         Icon(
              //           Icons.star,
              //           color: Colors.amber,
              //           size: 18,
              //         ),
              //         Icon(
              //           Icons.star,
              //           color: Colors.amber,
              //           size: 18,
              //         ),
              //         Icon(
              //           Icons.star,
              //           color: Colors.amber,
              //           size: 18,
              //         ),
              //       ],
              //     )
              //   ],
              // )
            ],
          )
        ],
      ),
    );
  }
}
