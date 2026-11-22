import 'package:material_ui/material_ui.dart';

import '../models/jenis_layanan.dart';

/// Daftar layanan yang bisa diajukan warga Kelurahan Sukajadi.
const List<JenisLayanan> daftarLayanan = [
  JenisLayanan(
    kode: 'SPD',
    nama: 'Surat Pengantar Domisili',
    deskripsi:
        'Keterangan tempat tinggal untuk keperluan sekolah, kerja, atau administrasi bank.',
    ikon: Icons.home_work_outlined,
    estimasi: '1 hari kerja',
    syarat: [
      'Fotokopi KTP pemohon',
      'Fotokopi Kartu Keluarga',
      'Surat pengantar RT/RW',
    ],
  ),
  JenisLayanan(
    kode: 'SKU',
    nama: 'Surat Keterangan Usaha UMKM',
    deskripsi:
        'Bukti legalitas usaha mikro untuk pengajuan kredit atau bantuan pemerintah.',
    ikon: Icons.storefront_outlined,
    estimasi: '2 hari kerja',
    syarat: [
      'Fotokopi KTP dan KK',
      'Foto tempat usaha',
      'Nomor Induk Berusaha (bila ada)',
    ],
  ),
  JenisLayanan(
    kode: 'JMS',
    nama: 'Rekomendasi Jamkesda',
    deskripsi:
        'Surat rekomendasi jaminan kesehatan daerah bagi warga kurang mampu.',
    ikon: Icons.local_hospital_outlined,
    estimasi: '1 hari kerja',
    syarat: [
      'Fotokopi KTP dan KK',
      'Surat Keterangan Tidak Mampu',
      'Kartu peserta BPJS (bila ada)',
    ],
  ),
  JenisLayanan(
    kode: 'SKTM',
    nama: 'Surat Keterangan Tidak Mampu',
    deskripsi:
        'Keterangan ekonomi untuk keringanan biaya pendidikan atau kesehatan.',
    ikon: Icons.volunteer_activism_outlined,
    estimasi: '1 hari kerja',
    syarat: [
      'Fotokopi KTP dan KK',
      'Surat pengantar RT/RW',
      'Bukti pendapatan keluarga',
    ],
  ),
  JenisLayanan(
    kode: 'SPN',
    nama: 'Surat Pengantar Nikah',
    deskripsi:
        'Pengantar kelurahan sebagai syarat administrasi pencatatan pernikahan.',
    ikon: Icons.favorite_border,
    estimasi: '2 hari kerja',
    syarat: [
      'Fotokopi KTP dan KK calon pengantin',
      'Fotokopi akta kelahiran',
      'Pas foto berwarna ukuran 2x3',
    ],
  ),
  JenisLayanan(
    kode: 'IZN',
    nama: 'Izin Keramaian',
    deskripsi:
        'Surat izin kegiatan atau acara warga di lingkungan kelurahan.',
    ikon: Icons.campaign_outlined,
    estimasi: '3 hari kerja',
    syarat: [
      'Fotokopi KTP penanggung jawab',
      'Proposal kegiatan',
      'Surat persetujuan RT/RW',
    ],
  ),
];
