import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course/blocs/kelas_saya/kelas_bloc.dart';
import 'package:online_course/blocs/kelas_saya/kelas_event.dart';
import 'package:online_course/blocs/kelas_saya/kelas_state.dart';
import 'package:online_course/blocs/login/login_bloc.dart';
import 'package:online_course/blocs/login/login_event.dart';
import 'package:online_course/blocs/login/login_state.dart';
import 'package:online_course/screens/kelas_detail.dart';
import 'package:online_course/screens/login.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/category_item.dart';
import 'package:online_course/widgets/kelas_saya_item.dart';
import 'package:online_course/widgets/kelas_saya_item_dua.dart';
import 'package:online_course/widgets/loading_card.dart';
import 'package:online_course/widgets/no_data.dart';
import 'package:online_course/widgets/pagination.dart';
import 'package:online_course/widgets/unauthenticated.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KelasSaya extends StatefulWidget {
  KelasSaya({Key? key}) : super(key: key);

  @override
  _KelasSayaState createState() => _KelasSayaState();
}

class _KelasSayaState extends State<KelasSaya> {
  Future<Map<String, dynamic>> checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.containsKey('token')) {
      String? token = await prefs.getString('token');
      return {"auth": true, "token": token};
    } else {
      return {"auth": false};
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        setState(() {});
      },
      child: FutureBuilder<Map<String, dynamic>>(
        future: checkAuth(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!;
            if (data['auth'] == true) {
              return Kelas();
            } else {
              return Login();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Kelas extends StatefulWidget {
  const Kelas({Key? key}) : super(key: key);

  @override
  State<Kelas> createState() => _KelasState();
}

class _KelasState extends State<Kelas> {
  late KelasBloc _kelasBloc;

  late LoginBloc loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kelasBloc = BlocProvider.of<KelasBloc>(context);
    loginBloc = BlocProvider.of<LoginBloc>(context);

    _kelasBloc.add(KelasEventLoad(page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  "Kelas Saya",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                centerTitle: false,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: Delegate(
                    child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 15, top: 10, bottom: 5),
                      child: BlocBuilder<KelasBloc, KelasState>(
                        builder: (context, state) {
                          if (state is KelasStateLoad) {
                            return Row(
                              children: List.generate(
                                categories.length,
                                (index) => CategoryItem(
                                  onTap: () {
                                    _kelasBloc.add(KelasEventLoad(
                                        page: state.page,
                                        type: categories[index]['value'],
                                        order: state.order));
                                  },
                                  isAktif:
                                      (categories[index]['value'] == state.type)
                                          ? true
                                          : false,
                                  data: categories[index],
                                ),
                              ),
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<KelasBloc, KelasState>(
                          builder: (context, state) {
                            if (state is KelasStateLoad) {
                              return DropdownButtonFormField<
                                      Map<String, String>>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffe7e7ec)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                  ),
                                  value: orders[0],
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: primary,
                                  ),
                                  isExpanded: true,
                                  elevation: 16,
                                  style: const TextStyle(color: primary),
                                  onChanged: (Map<String, String>? newValue) {
                                    _kelasBloc.add(KelasEventLoad(
                                        order: newValue!['value'],
                                        page: state.page,
                                        type: state.type));
                                  },
                                  items: orders.map<
                                          DropdownMenuItem<
                                              Map<String, String>>>(
                                      (Map<String, String> value) {
                                    return DropdownMenuItem<
                                        Map<String, String>>(
                                      value: value,
                                      child: Text(value['name']!),
                                    );
                                  }).toList());
                            }
                            return Container();
                          },
                        ),
                      ),
                    )
                  ],
                )),
              ),
            ];
          },
          body: Container(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child:
                  BlocBuilder<KelasBloc, KelasState>(builder: (context, state) {
                if (state is KelasErrorState) {
                  loginBloc.add(Logout());
                }
                if (state is KelasStateLoad) {
                  int jumlah = 5;
                  KelasStateLoad curState = state as KelasStateLoad;
                  if (!curState.statusLoading) {
                    jumlah = curState.kelas.length + 1;
                    if (curState.kelas.length == 0) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: NoData(),
                        ),
                      );
                    }
                  }

                  return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      itemCount: jumlah,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (!curState.statusLoading) {
                          if (index == (jumlah - 1)) {
                            return Pagination(
                              totalPage: curState.totalPage,
                              currentPage: curState.page,
                              onPageChanged: (int newPage) {
                                _kelasBloc.add(KelasEventLoad(
                                    page: newPage,
                                    type: curState.type,
                                    order: curState.order));
                              },
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KelasDetail(
                                            slug: state.kelas[index].slug!,
                                          )));
                            },
                            child: KelasSayaItemDua(
                              kelas: state.kelas[index],
                            ),
                          );
                        } else {
                          if (index == (jumlah - 1)) {
                            return Pagination(
                              totalPage: 1,
                              currentPage: 1,
                              onPageChanged: (int newPage) {},
                            );
                          }
                          return LoadingCard();
                        }
                      });
                } else {
                  return Unauthenticated();
                }
              }),
            ),
          )),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  Delegate({required this.child}) : super();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: child);
  }

  @override
  double get maxExtent => 130;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
