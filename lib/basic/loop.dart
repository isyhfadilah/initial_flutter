void main() {
  List<String> peserta = ['Ani', 'Budi', 'Citra'];

  for (String nama in peserta) {
    print('Halo, $nama!');
  }

  int i = 1;
  while(i <= 3) {
    print('Pertemuan ke-$i');
    i++;
  } 
}