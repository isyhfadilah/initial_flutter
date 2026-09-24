import 'package:flutter/material.dart';
import 'package:flutter_application_2/logic/nilai.dart';

class TombolNilai extends StatefulWidget {
  const TombolNilai({super.key});

  @override
  State<TombolNilai> createState() => _TombolNilaiState();
}

class _TombolNilaiState extends State<TombolNilai> {
  final Nilai dataNilai = Nilai();

  void _tambahNilai() {
    setState(() {
      dataNilai.tambahNilai();
    });
  }

  void _resetNilai() {
    setState(() {
      dataNilai.resetNilai();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Nilai: ${dataNilai.nilai}'),
        Text('Status: ${dataNilai.status}'),
        ElevatedButton(
          onPressed: _tambahNilai,
          child: const Text('Tambah nilai'),
        ),
        ElevatedButton(
          onPressed: _resetNilai,
          child: const Text('Reset nilai'),
        ),
      ],
    );
  }
}