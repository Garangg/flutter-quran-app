import 'package:flutter/material.dart';
import 'package:flutter_quran_app/border.dart';
import 'package:flutter_quran_app/models/detail_surah_model.dart';
import 'package:flutter_quran_app/models/detail_surah_vm.dart';
import 'package:flutter_quran_app/pages/detail_tafsir_page.dart';

class DetailPage extends StatelessWidget {
  final int nomor;
  final DetailQuranVM _detailQuranService = DetailQuranVM();

  DetailPage({super.key, required this.nomor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.blue[200],
        title: FutureBuilder<DetailSurah>(
          future: _detailQuranService.getDataQuran(nomor),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Text(snapshot.data!.namaLatin)
                : const Text('Loading...');
          },
        ),
      ),
      body: FutureBuilder<DetailSurah>(
        future: _detailQuranService.getDataQuran(nomor),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 229, 249, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.namaLatin,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "${snapshot.data!.arti} | (${snapshot.data!.jumlahAyat} ayat) | ${snapshot.data!.tempatTurun}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  const Spacer(),
                                  OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailTafsir(
                                                        nomor: nomor)));
                                      },
                                      child: const Text('Lihat Tafsir',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 24, 107, 185),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  Expanded(
                    flex: 8,
                    child: ListView.builder(
                      itemCount: snapshot.data!.ayat.length,
                      itemBuilder: (context, index) {
                        var ayat = snapshot.data!.ayat[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CustomPaint(
                                                size: const Size(40, 40),
                                                painter: StarPainter(
                                                    color: const Color.fromARGB(
                                                        255, 180, 238, 235)),
                                              ),
                                              Text(
                                                ayat.nomorAyat.toString(),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ]),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            ayat.teksArab,
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ayat.teksLatin,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      ayat.teksIndonesia,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                                const Divider(
                                  color: Color.fromARGB(244, 211, 211, 211),
                                  thickness: 1,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
