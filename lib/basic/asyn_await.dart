Future<String> ambilData() async {
  print('Mengambil data...');

  await Future.delayed(Duration(seconds: 2));

  return 'Data berhasil dimuat!';
}

void main() async {
  print('Mulai');

  String hasil = await ambilData();
  
  print(hasil);
  print('Selesai.');
}