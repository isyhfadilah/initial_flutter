double hitungRataRata(double a, double b) {
  return (a + b) / 2;
}

String statusLulus(double nilai) {
  if(nilai >= 75) {
    return 'Lulus';
  } else {
    return 'Belum Lulus';
  }
}
void main() {
  double rataRata = hitungRataRata(80, 90);

  print('Rata-rata: $rataRata');
  print('Status: ${statusLulus(rataRata)}');
}