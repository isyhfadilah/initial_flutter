class Mahasiswa {
  String nama;
  int semester;

  Mahasiswa(this.nama, this.semester);

  void perkenalan() {
    print('Halo, nama saya $nama dan saya berada di semester $semester.');
  }
}

void main() {
  Mahasiswa mhs1 = Mahasiswa('Aisyah', 5);
  Mahasiswa mhs2 = Mahasiswa('Budi', 3);

  mhs1.perkenalan();
  mhs2.perkenalan();
}