import 'package:flutter_quran_app/models/detail_surah_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailQuranVM {
  Future<DetailSurah> getDataQuran(int nomor) async{
    http.Response hasil = await http.get(Uri.parse('https://equran.id/api/v2/surat/$nomor'));
    if(hasil.statusCode == 200){
      final json = jsonDecode(hasil.body);
      return DetailSurah.fromJson(json['data']);
    } else {
      throw Exception('Gagal memuat data');
    }
  }

}