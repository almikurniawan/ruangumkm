
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_course/blocs/kelas_saya/kelas_bloc.dart';
import 'package:online_course/blocs/kelas_saya/kelas_bloc_all.dart';
import 'package:online_course/blocs/kelas_saya/kelas_event.dart';
import 'package:online_course/blocs/kelas_saya/kelas_state.dart';
import 'package:online_course/screens/kelas_detail.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/category_item.dart';
import 'package:online_course/widgets/kelas_pencarian.dart';
import 'package:online_course/widgets/kelas_saya_item_dua.dart';
import 'package:online_course/widgets/loading_card.dart';
import 'package:online_course/widgets/no_data.dart';
import 'package:online_course/widgets/pagination.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late KelasBlocAll _kelasBloc;
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kelasBloc = BlocProvider.of<KelasBlocAll>(context);
    _kelasBloc.add(KelasEventLoadAll(page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  "Pencarian",
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
                      child: BlocBuilder<KelasBlocAll, KelasState>(
                        builder: (context, state) {
                          if (state is KelasStateLoad) {
                            return Row(
                              children: List.generate(
                                categories.length,
                                (index) => CategoryItem(
                                  onTap: () {
                                    _kelasBloc.add(KelasEventLoadAll(
                                        search: search.text,
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
                        child: BlocBuilder<KelasBlocAll, KelasState>(
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
                                    _kelasBloc.add(KelasEventLoadAll(
                                        search: search.text,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: search,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffe7e7ec)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<KelasBlocAll, KelasState>(
                            builder: (context, state) {
                              if (state is KelasStateLoad) {
                                return IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    _kelasBloc.add(KelasEventLoadAll(
                                        page: state.page,
                                        type: state.type,
                                        order: state.order,
                                        search: search.text));
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
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
                  BlocBuilder<KelasBlocAll, KelasState>(builder: (context, state) {
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
                              _kelasBloc.add(KelasEventLoadAll(
                                  search: search.text,
                                  page: newPage,
                                  type: curState.type,
                                  order: curState.order));
                            },
                          );
                        }
                        return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => KelasDetail(
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
  double get maxExtent => 180;

  @override
  double get minExtent => 180;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
