import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/kelas_detail/kelas_detail_bloc.dart';
import 'package:online_course/blocs/kelas_detail/kelas_detail_event.dart';
import 'package:online_course/blocs/kelas_detail/kelas_detail_state.dart';
import 'package:online_course/blocs/peringkat/peringkat_bloc.dart';
import 'package:online_course/blocs/peringkat/peringkat_event.dart';
import 'package:online_course/blocs/peringkat/peringkat_state.dart';
import 'package:online_course/blocs/tugas/tugas_bloc.dart';
import 'package:online_course/blocs/tugas/tugas_event.dart';
import 'package:online_course/blocs/tugas/tugas_state.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_bloc.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_event.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_state.dart';
import 'package:online_course/screens/tugas_page.dart';
import 'package:online_course/screens/tugas_review.dart';
import 'package:online_course/screens/tugas_sunting_page.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/widgets/contant.dart';
import 'package:online_course/widgets/header_kelas_detail.dart';
import 'package:online_course/widgets/kelas_saya_item.dart';
import 'package:online_course/widgets/loading_card.dart';
import 'package:online_course/widgets/loading_header.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:online_course/widgets/unauthenticated.dart';

class KelasDetail extends StatefulWidget {
  final String slug;
  const KelasDetail({Key? key, required this.slug}) : super(key: key);

  @override
  State<KelasDetail> createState() => _KelasDetailState();
}

class _KelasDetailState extends State<KelasDetail> {
  late KelasDetailBloc _blocKelasDetail;
  late TugasBloc _tugasBloc;
  late PeringkatBloc _peringkatBloc;
  late int idFasilitator;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocKelasDetail = BlocProvider.of<KelasDetailBloc>(context);
    _tugasBloc = BlocProvider.of<TugasBloc>(context);
    _peringkatBloc = BlocProvider.of<PeringkatBloc>(context);

    _blocKelasDetail.add(KelasDetailLoadEvent(slug: widget.slug));
    _tugasBloc.add(TugasLoadEvent(slug: widget.slug));
    _peringkatBloc.add(PeringkatLoadEvent(slug: widget.slug));
  }

  Widget buildHeader() {
    return BlocBuilder<KelasDetailBloc, KelasDetailState>(
      builder: (context, state) {
        if (state is KelasDetailLoadingState) {
          return LoadingHeader();
        } else if (state is KelasDetailLoadedState) {
          idFasilitator = state.event!.extraFasilitator!.id!;
          return HeaderKelasDetail(
            judul: state.event!.namaEvent!,
            fasilitator: state.event!.extraFasilitator!.nama!,
          );
        } else {
          return LoadingHeader();
        }
      },
    );
  }

  Widget buildRingkasan() {
    return BlocBuilder<KelasDetailBloc, KelasDetailState>(
        builder: (context, state) {
      if (state is KelasDetailLoadedState) {
        DateTime tanggalMulai = DateTime.parse(state.event!.tanggalMulai!);
        DateTime tanggalSelesai = DateTime.parse(state.event!.tanggalSelesai!);
        initializeDateFormatting('id_ID');
        final formatTanggal = new DateFormat('dd MMMM yyyy');

        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              decoration: decorationBox,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Deskripsi Event",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .merge(TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.event!.deskripsi!,
                    style: Theme.of(context).textTheme.bodyText1!,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 190,
                    child: CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      imageUrl:
                          "https://ruangumkm.ilmanaf.com/public/storage/thumbnail_event/original/" +
                              state.event!.fotoEvent!,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Daftar Materi",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .merge(TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Color(0xff4a8f9f),
                                ),
                                Text(
                                  state.event!.extraMateri![index].judul!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: state.event!.extraMateri!.length),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Detail",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .merge(TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Bullet(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Tanggal Dimulai : " +
                            formatTanggal.format(tanggalMulai),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Bullet(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Tanggal Selesai : " +
                            formatTanggal.format(tanggalSelesai),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Bullet(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Durasi Event : " +
                            state.event!.selisihHari!.toString() +
                            " Hari",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Bullet(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Durasi Event : " +
                            state.event!.jumlahPeserta!.toString() +
                            " Orang",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Event Terkait", style: Theme.of(context).textTheme.headline2),
            SizedBox(
              height: 10,
            ),
            Text("temukan event terkait untuk menunjang kebutuhan anda."),
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
                options: CarouselOptions(
                  height: 290,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: .75,
                ),
                items: List.generate(state.eventTerkait!.length, (index) {
                  return KelasSayaItem(
                    kelas: state.eventTerkait![index],
                  );
                })),
            SizedBox(
              height: 30,
            ),
            Text("Event Terbaru", style: Theme.of(context).textTheme.headline2),
            SizedBox(
              height: 10,
            ),
            Text("temukan event terkait untuk menunjang kebutuhan anda."),
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
                options: CarouselOptions(
                  height: 290,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: .75,
                ),
                items: List.generate(state.eventBaru!.length, (index) {
                  return KelasSayaItem(
                    kelas: state.eventBaru![index],
                  );
                }))
          ],
        );
      }

      return LoadingCard();
    });
  }

  Widget buildMateri() {
    return BlocBuilder<KelasDetailBloc, KelasDetailState>(
      builder: (context, state) {
        if (state is KelasDetailLoadedState) {
          List<Widget> listMateri = state.event!.extraMateri!
              .map((e) => ListTile(
                      title: Row(
                    children: [
                      Bullet(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(e.judul!),
                    ],
                  )))
              .toList();
          return Container(
            padding: EdgeInsets.all(15),
            decoration: decorationBox,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listMateri,
            ),
          );
        }
        return LoadingCard();
      },
    );
  }

  Widget buildTugas() {
    return BlocBuilder<TugasBloc, TugasState>(
      builder: (context, state) {
        if (state is TugasLoadedState) {
          List<Widget> listTugas = state.tugas
              .map((e) => ListTile(
                      title: Row(
                    children: [
                      Bullet(),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Text(e.judul!)),
                      IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                if (e.flag == 1) {
                                  return TugasPage(
                                    slug: e.slug!,
                                    idSub: e.id!,
                                    idFasilitator: idFasilitator,
                                    slug2: e.slug2!,
                                  );
                                } else if (e.flag == 2) {
                                  return TugasSuntingPage(
                                    slug: e.slug!,
                                    idSub: e.id!,
                                    idFasilitator: idFasilitator,
                                    slug2: e.slug2!,
                                  );
                                }else{
                                  return TugasReview(
                                    slug: e.slug!,
                                    idSub: e.id!,
                                    idFasilitator: idFasilitator,
                                    slug2: e.slug2!,
                                  );
                                }
                              },
                            ));
                          },
                          icon: Icon(Icons.edit))
                    ],
                  )))
              .toList();
          return Container(
            padding: EdgeInsets.all(15),
            decoration: decorationBox,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listTugas,
            ),
          );
        } else if (state is TugasInitial) {
          return Center(child: CircularProgressIndicator());
        }
        return Unauthenticated();
      },
    );
  }

  Widget buildPeringkat() {
    return BlocBuilder<PeringkatBloc, PeringkatState>(
      builder: (context, state) {
        if (state is PeringkatLoadedState) {
          int nomor = 0;
          List<Widget> listPeringkat = state.peringkat.map((e) {
            nomor++;
            return ListTile(
                title: Row(
              children: [
                Expanded(
                  child: Text(
                    nomor.toString() + ". " + e.name!,
                  ),
                ),
                Text(e.penilaian ?? "-",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .merge(TextStyle(fontSize: 14))),
              ],
            ));
          }).toList();
          return Container(
            padding: EdgeInsets.all(15),
            decoration: decorationBox,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    ListTile.divideTiles(context: context, tiles: listPeringkat)
                        .toList()),
          );
        } else if (state is PeringkatLoadedState) {
          return Center(child: CircularProgressIndicator());
        }
        return Unauthenticated();
      },
    );
  }

  Widget buildFasilitator() {
    return BlocBuilder<KelasDetailBloc, KelasDetailState>(
      builder: (context, state) {
        if (state is KelasDetailLoadedState) {
          return Container(
              padding: EdgeInsets.all(15),
              decoration: decorationBox,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tentang Fasilitator",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .merge(TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "https://ruangumkm.ilmanaf.com/public/img/anggota/" +
                                state.event!.fotoFasilitator!),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.event!.extraFasilitator!.nama!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .merge(TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ))),
                          Text(
                            state.event!.extraFasilitator!.usaha!,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.event!.extraFasilitator!.deskripsi!,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Detail",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .merge(TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Alamat", style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(
                    height: 10,
                  ),
                  Text("No. Telp",
                      style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Email", style: Theme.of(context).textTheme.bodyText1),
                ],
              ));
        }
        return LoadingCard();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TugasSubmitBloc, TugasSubmitState>(
      listener: (context, state) {
        if (state is TugasSubmitFinishState) {
          _tugasBloc.add(TugasLoadEvent(slug: widget.slug));
        }
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
            body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                  delegate: DelegateHeader(child: buildHeader())),
              SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: Delegate(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      offset: Offset(0, 5))
                                ],
                              ),
                              child: TabBar(
                                isScrollable: true,
                                tabs: [
                                  "Ringkasan",
                                  "Materi",
                                  "Tugas",
                                  "Peringkat",
                                  "Profil Fasilitator"
                                ].map((String name) {
                                  return Tab(
                                    text: name,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ))),
            ];
          },
          body: TabBarView(
            children: [
              ContainerTabView(
                  child: SliverToBoxAdapter(child: buildRingkasan()),
                  indexKey: 1),
              ContainerTabView(
                indexKey: 2,
                child: SliverToBoxAdapter(child: buildMateri()),
              ),
              ContainerTabView(
                  child: SliverToBoxAdapter(child: buildTugas()), indexKey: 3),
              ContainerTabView(
                  child: SliverToBoxAdapter(child: buildPeringkat()),
                  indexKey: 4),
              ContainerTabView(
                  child: SliverToBoxAdapter(child: buildFasilitator()),
                  indexKey: 5),
            ],
          ),
        )),
      ),
    );
  }
}

class Bullet extends StatelessWidget {
  const Bullet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 10,
        height: 10,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Color(0xff4a8f9f)));
  }
}

class ContainerTabView extends StatelessWidget {
  final Widget child;
  final int indexKey;
  const ContainerTabView(
      {Key? key, required this.child, required this.indexKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<int>(this.indexKey),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: this.child,
              ),
            ],
          );
        },
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  Delegate({required this.child}) : super();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(child: child),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class DelegateHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  DelegateHeader({required this.child}) : super();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: child);
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
