import 'package:flutter/material.dart';
import 'package:flutter_quran_app/border.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/models/quran_vm.dart';
import 'package:flutter_quran_app/pages/detail_surah_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Datum> data = [];
  QuranVM quranVM = QuranVM();

  void getData() async {
    QuranModel quranModel = await quranVM.getDataQuran();
    setState(() {
      data = quranModel.data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.blue[50],
          title: const Text('MyQuran',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: Color.fromARGB(
                      255, 61, 143, 209) // Set your desired fill color here
                  )),
          actions: const [
            Icon(
              Icons.search,
              color: Color.fromARGB(
                  255, 61, 143, 209) // Set your desired fill color here
              ,
            ),
            SizedBox(width: 10),
          ],
        ),
        body: data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/bg1.jpeg'),
                                  fit: BoxFit.cover),
                              // color: Colors.amber[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Daftar Surat Al-Quran',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Jumlah Surat : ${data.length}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300)),
                                  const SizedBox(width: 10),
                                  Text(
                                      "Jumlah Ayat : ${data.map((e) => e.jumlahAyat).reduce((value, element) => value + element)}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300)),
                                ],
                              )
                            ],
                          )),
                        ),
                      )),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                            nomor: data[index].nomor)));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CustomPaint(
                                            size: const Size(40, 40),
                                            painter: StarPainter(
                                                color: const Color.fromARGB(
                                                    255, 180, 238, 235)),
                                          ),
                                          Text(data[index].nomor.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                        ]),
                                    title: Text(data[index].namaLatin,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Color.fromARGB(255, 61, 143,
                                                209) // Set your desired fill color here
                                            )),
                                    subtitle: Text(
                                        "${data[index].arti} - ${data[index].jumlahAyat} Ayat"),
                                    trailing: Text(data[index].nama,
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 61, 143,
                                                209) // Set your desired fill color here
                                            ,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 24)),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 221, 221, 221),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ));
  }
}
