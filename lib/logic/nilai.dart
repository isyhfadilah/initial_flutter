class Nilai {
  int nilai = 0;

  void tambahNilai() {
    if(nilai < 100) nilai += 5;
  }

  void resetNilai() {
    nilai = 0;
  }

  String get status => nilai >= 75 ? 'Lulus' : 'Belum Lulus';
}