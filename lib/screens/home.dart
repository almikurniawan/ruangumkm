import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course/blocs/dashboard/dashboard_bloc.dart';
import 'package:online_course/blocs/dashboard/dashboard_event.dart';
import 'package:online_course/blocs/dashboard/dashboard_state.dart';
import 'package:online_course/screens/kelas_detail.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/category_box.dart';
import 'package:online_course/widgets/fasilitator.dart';
import 'package:online_course/widgets/feature_item.dart';
import 'package:online_course/widgets/icon_circular.dart';
import 'package:online_course/widgets/kelas_saya_item.dart';
import 'package:online_course/widgets/loading_card.dart';
import 'package:online_course/widgets/loading_fasilitator.dart';
import 'package:online_course/widgets/no_data.dart';
// import 'package:online_course/widgets/notification_box.dart';
import 'package:online_course/widgets/recommend_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DashboardBloc _dashboardBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    _dashboardBloc.add(DashboardLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: SingleChildScrollView(
          child: buildBody(),
        ));
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            Positioned(
              height: 355,
              top: 10,
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.network(
                "https://ruangumkm.ilmanaf.com/public/assets_enduser/img/illustrations/illustration-5.svg",
                fit: BoxFit.scaleDown,
                height: 350,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 800, vertical: 180),
              //   child: Column(
              //     children: [
              // Text(
              //   "Menangkan Persaingan Global",
              //   style: Theme.of(context).textTheme.headline1,
              // ),
              // SizedBox(height: 45),
              // Text(
              //   "Kuasai skill digital dan akses peluang kerja dari seluruh dunia",
              //   style: Theme.of(context).textTheme.subtitle1,
              // ),
              //     ],
              //   ),
            )
          ],
        ),
        Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0),
            ),
          ),
          // width: double.infinity,
          // color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Kenapa Belajar di\nOnboarding",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2),
              Row(
                children: [
                  IconCircular(
                      color: Color(0xFFF8C994),
                      icon: Icon(Icons.card_travel,
                          size: 30, color: Colors.amber[700])),
                  SizedBox(width: 20),
                  Text(
                    "Pelajari Apa Saja",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .merge(TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconCircular(
                      color: Color(0xffB7B3F8),
                      icon: Icon(Icons.share_outlined,
                          size: 30, color: Colors.blue)),
                  SizedBox(width: 20),
                  Text(
                    "Pembelajaran Fleksibel",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .merge(TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconCircular(
                      color: Color(0xffb2f4dc),
                      icon: Icon(Icons.person, size: 30, color: Colors.green)),
                  SizedBox(width: 20),
                  Text(
                    "Belajar Dengan Ahlinya",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .merge(TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kelas Terbaru",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                "See all",
                style: TextStyle(fontSize: 14, color: darker),
              ),
            ],
          ),
        ),
        getKelasTerbaru(),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kelas Terpopuler",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                "See all",
                style: TextStyle(fontSize: 14, color: darker),
              ),
            ],
          ),
        ),
        getKelasTerpopuler(),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kelas Mendatang",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                "See all",
                style: TextStyle(fontSize: 14, color: darker),
              ),
            ],
          ),
        ),
        getKelasMendatang(),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fasilitator Onboarding",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
        getFasilitator(),
      ]),
    );
  }

  getKelasTerbaru() {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      DashboardLoadState currentState = state as DashboardLoadState;
      int jumlahItem;
      if (currentState.loading) {
        jumlahItem = 3;
      } else {
        jumlahItem = currentState.kelasTerbaru!.length;
      }

      return CarouselSlider(
          options: CarouselOptions(
            height: 290,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: .75,
          ),
          items: List.generate(jumlahItem, (index) {
            if (currentState.loading)
              return LoadingCard();
            else
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => KelasDetail(
                    slug: currentState.kelasTerbaru![index].slug!,
                  )));
                },
                child: KelasSayaItem(kelas: currentState.kelasTerbaru![index]));
          }));
    });
  }

  getKelasTerpopuler() {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      DashboardLoadState currentState = state as DashboardLoadState;
      int jumlahItem;
      if (currentState.loading) {
        jumlahItem = 3;
      } else {
        jumlahItem = currentState.kelasTerpopuler!.length;
      }

      return CarouselSlider(
          options: CarouselOptions(
            height: 290,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: .75,
          ),
          items: List.generate(jumlahItem, (index) {
            if (currentState.loading)
              return LoadingCard();
            else
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => KelasDetail(
                    slug: currentState.kelasTerpopuler![index].slug!,
                  )));
                },
                child: KelasSayaItem(kelas: currentState.kelasTerpopuler![index]));
          }));
    });
  }

  getKelasMendatang() {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      DashboardLoadState currentState = state as DashboardLoadState;
      int jumlahItem;
      if (currentState.loading) {
        jumlahItem = 3;
      } else {
        jumlahItem = currentState.kelasMendatang!.length;
        if (jumlahItem == 0) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: NoData(),
          ));
        }
      }

      return CarouselSlider(
          options: CarouselOptions(
            height: 290,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: .75,
          ),
          items: List.generate(jumlahItem, (index) {
            if (currentState.loading)
              return LoadingCard();
            else
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => KelasDetail(
                    slug: currentState.kelasMendatang![index].slug!,
                  )));
                }, child: KelasSayaItem(kelas: currentState.kelasMendatang![index]));
          }));
    });
  }

  getFasilitator() {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      DashboardLoadState currentState = state as DashboardLoadState;
      int jumlahItem;
      if (currentState.loading) {
        jumlahItem = 3;
      } else {
        jumlahItem = currentState.fasilitator!.length;
      }
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            jumlahItem,
            (index) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: (state.loading)
                    ? LoadingFasilitator()
                    : FasilitatorItem(
                        fasilitator: currentState.fasilitator![index])),
          ),
        ),
      );
    });
  }
}
