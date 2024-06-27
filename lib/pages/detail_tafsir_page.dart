import 'package:flutter/material.dart';
import 'package:flutter_quran_app/models/detail_surah_model.dart';
import 'package:flutter_quran_app/models/detail_surah_vm.dart';

class DetailTafsir extends StatelessWidget {
  final int nomor;
  final DetailQuranVM _detailQuranService = DetailQuranVM();

  DetailTafsir({super.key, required this.nomor});

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
                      child: Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 8,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Deskripsi Surah",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(
                                  snapshot.data!.deskripsi
                                      .replaceAll(RegExp(r'<[^>]*>'), ''),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
