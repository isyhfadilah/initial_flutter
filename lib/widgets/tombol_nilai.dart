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
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _tambahNilai,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Tambah nilai'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _resetNilai,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Reset nilai'),
          ),
        ),
      ],
    );
  }
}