double hitungRataRata(List<int> nilai) {
  int total = 0;

  for(int n in nilai) {
    total += n;
  }

  return total / nilai.length;
}

String cekStatus(double rataRata) {
  return rataRata >= 75 ? 'Lulus' : 'Belum Lulus';
}

void main() {
  List<int> nilaiMahasiswa = [80, 90, 70, 85, 95];
  double rataRata = hitungRataRata(nilaiMahasiswa);

  print('Rata-rata: $rataRata');
  print('Status: ${cekStatus(rataRata)}');
}