void main() {
  int umur = 20;
  double ipk = 4.00;
  String nama = "Aisyah";
  bool aktif = true;

  List<String> skills = ['Dart', 'Flutter', 'Firebase'];
  Map<String, dynamic> mahasiswa = {
    'nama' : nama,
    'semester' : 5,
  };

  print(nama);
  print('Umur: $umur');
  print('IPK: $ipk');
  print('Aktif: $aktif');
  print(skills);
  print(mahasiswa);
}