import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:http/http.dart' as http;

class QuranVM {
  Future<QuranModel> getDataQuran() async{
    http.Response hasil = await http.get(Uri.parse('https://equran.id/api/v2/surat'));
    if(hasil.statusCode == 200){
      return quranModelFromJson(hasil.body);
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}