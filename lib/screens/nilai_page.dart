import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/tombol_nilai.dart';

class NilaiPage extends StatelessWidget {
  const NilaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penilaian'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Cek Nilai Kamu',
                style: TextStyle(
                  color: Color(0xFF6D4C41),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tambahkan nilai dan lihat status kelulusanmu.',
                style: TextStyle(
                  color: Color(0xFF8D6E63),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE9F0),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFF4A7C1)),
                ),
                child: const TombolNilai(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}