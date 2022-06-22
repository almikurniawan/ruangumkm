import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/login/login_bloc.dart';
import 'package:online_course/blocs/login/login_event.dart';
import 'package:online_course/blocs/login/login_state.dart';
import 'package:online_course/blocs/sertifikat/sertifikat_bloc.dart';
import 'package:online_course/blocs/sertifikat/sertifikat_event.dart';
import 'package:online_course/blocs/sertifikat/sertifikat_state.dart';
import 'package:online_course/screens/login.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/loading_card.dart';
import 'package:online_course/widgets/no_data.dart';
import 'package:online_course/widgets/pagination.dart';
import 'package:online_course/widgets/sertifikat_item.dart';
import 'package:online_course/widgets/unauthenticated.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sertifikat extends StatefulWidget {
  Sertifikat({Key? key}) : super(key: key);

  @override
  _SertifikatState createState() => _SertifikatState();
}

class _SertifikatState extends State<Sertifikat> {
  Future<Map<String, dynamic>> checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    if (await prefs.containsKey('token')) {
      // ignore: await_only_futures
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
              return SertifikatSaya();
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

class SertifikatSaya extends StatefulWidget {
  const SertifikatSaya({Key? key}) : super(key: key);

  @override
  State<SertifikatSaya> createState() => _SertifikatSayaState();
}

class _SertifikatSayaState extends State<SertifikatSaya> {
  late SertifikatBloc _sertifikatBloc;

  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    _sertifikatBloc = BlocProvider.of<SertifikatBloc>(context);
    loginBloc = BlocProvider.of<LoginBloc>(context);

    _sertifikatBloc.add(SertifikatEventLoad(page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  "Sertifikat Saya",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                centerTitle: false,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: Delegate(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SizedBox(
                          width: double.infinity,
                          child: BlocBuilder<SertifikatBloc, SertifikatState>(
                            builder: (context, state) {
                              if (state is SertifikatStateLoad) {
                                return DropdownButtonFormField<
                                        Map<String, String>>(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffe7e7ec)),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
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
                                      _sertifikatBloc.add(SertifikatEventLoad(
                                          page: state.page,
                                          order: state.order));
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
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: BlocBuilder<SertifikatBloc, SertifikatState>(
                  builder: (context, state) {
                if (state is SertifikatStateLoad) {
                  int jumlah = 5;
                  SertifikatStateLoad curState = state as SertifikatStateLoad;
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
                                _sertifikatBloc.add(SertifikatEventLoad(
                                    page: newPage, order: curState.order));
                              },
                            );
                          }
                          return GestureDetector(
                            child: SertifikatItem(kelas: state.kelas[index]),
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
                  loginBloc.add(Logout());
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
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
