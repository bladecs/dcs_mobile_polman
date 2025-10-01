import 'package:flutter/material.dart';

class Document {
  final String nomor;
  final String judul;
  final String kategori;
  final String status;
  final String pengunggah;

  Document({
    required this.nomor,
    required this.judul,
    required this.kategori,
    required this.status,
    required this.pengunggah,
  });
}

class DocumentDataSource extends DataTableSource {
  List<Document> _documents = [];

  DocumentDataSource(this._documents);

  void updateData(List<Document> newDocuments) {
    _documents = newDocuments;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _documents.length) return null;
    final document = _documents[index];

    Widget statusWidget(String status) {
      Color color;
      switch (status.toLowerCase()) {
        case 'aktif':
          color = Colors.green;
          break;
        case 'kadaluarsa':
          color = Colors.red;
          break;
        case 'proses revisi':
          color = Colors.orange;
          break;
        case 'pengajuan revisi':
          color = Colors.blue;
          break;
        default:
          color = Colors.grey;
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          document.status,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      );
    }

    return DataRow(cells: [
      DataCell(Center(child: Text(document.nomor))),
      DataCell(Center(child: Text(document.judul))),
      DataCell(Center(child: Text(document.kategori))),
      DataCell(Center(child: statusWidget(document.status))),
      DataCell(Center(child: Text(document.pengunggah))),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              tooltip: 'Edit',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Hapus',
              onPressed: () {},
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _documents.length;
  @override
  int get selectedRowCount => 0;
}

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final List<Document> _allDocuments = [
    Document(nomor: 'DOC-001', judul: 'Panduan Keselamatan Kerja', kategori: 'SOP', status: 'Aktif', pengunggah: 'Andi'),
    Document(nomor: 'DOC-002', judul: 'Laporan Keuangan Q3', kategori: 'Laporan', status: 'Kadaluarsa', pengunggah: 'Budi'),
    Document(nomor: 'DOC-003', judul: 'Prosedur Pengajuan Cuti', kategori: 'SOP', status: 'Proses Revisi', pengunggah: 'Citra'),
    Document(nomor: 'DOC-004', judul: 'Manual Aplikasi', kategori: 'Manual', status: 'Pengajuan Revisi', pengunggah: 'Dedi'),
    Document(nomor: 'DOC-005', judul: 'Notulensi Rapat', kategori: 'Notulensi', status: 'Aktif', pengunggah: 'Eka'),
    Document(nomor: 'DOC-006', judul: 'Rencana Proyek Baru', kategori: 'Rencana', status: 'Aktif', pengunggah: 'Andi'),
    Document(nomor: 'DOC-007', judul: 'Analisis Pasar 2024', kategori: 'Analisis', status: 'Kadaluarsa', pengunggah: 'Budi'),
    Document(nomor: 'DOC-008', judul: 'SOP Penggunaan Mesin', kategori: 'SOP', status: 'Aktif', pengunggah: 'Citra'),
    Document(nomor: 'DOC-009', judul: 'Laporan Bulanan', kategori: 'Laporan', status: 'Aktif', pengunggah: 'Dedi'),
    Document(nomor: 'DOC-010', judul: 'Manual Quality Control', kategori: 'Manual', status: 'Proses Revisi', pengunggah: 'Eka'),
    Document(nomor: 'DOC-011', judul: 'SOP Maintenance', kategori: 'SOP', status: 'Aktif', pengunggah: 'Andi'),
    Document(nomor: 'DOC-012', judul: 'Laporan Tahunan 2024', kategori: 'Laporan', status: 'Aktif', pengunggah: 'Budi'),
    Document(nomor: 'DOC-013', judul: 'Manual Operasional', kategori: 'Manual', status: 'Kadaluarsa', pengunggah: 'Citra'),
    Document(nomor: 'DOC-014', judul: 'Prosedur Audit', kategori: 'SOP', status: 'Proses Revisi', pengunggah: 'Dedi'),
    Document(nomor: 'DOC-015', judul: 'Notulensi Rapat Direksi', kategori: 'Notulensi', status: 'Aktif', pengunggah: 'Eka'),
  ];

  late List<Document> _filteredDocuments;
  late DocumentDataSource _documentDataSource;
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Semua';

  @override
  void initState() {
    super.initState();
    _filteredDocuments = _allDocuments;
    _documentDataSource = DocumentDataSource(_filteredDocuments);
    _searchController.addListener(_performSearch);
  }

  void _performSearch() {
    _filterDocuments(_selectedFilter);
  }

  void _filterDocuments(String filter) {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _selectedFilter = filter;
      _filteredDocuments = _allDocuments.where((doc) {
        final statusMatch = filter == 'Semua' || doc.status == filter;
        final searchMatch = doc.judul.toLowerCase().contains(query) ||
            doc.nomor.toLowerCase().contains(query) ||
            doc.kategori.toLowerCase().contains(query);
        return statusMatch && searchMatch;
      }).toList();
      _documentDataSource.updateData(_filteredDocuments);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content - bisa di-scroll sampai bawah tanpa terhalang navbar
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.only(left: 6, right: 15, top: 6, bottom: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: "Search...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const CircleAvatar(radius: 16, backgroundColor: Colors.grey),
                      ],
                    ),
                  ),
                ),

                // Filter Section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Filter:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedFilter,
                          underline: const SizedBox(),
                          items: [
                            'Semua',
                            'Aktif',
                            'Kadaluarsa',
                            'Proses Revisi',
                            'Pengajuan Revisi'
                          ].map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          )).toList(),
                          onChanged: (val) => _filterDocuments(val!),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_filteredDocuments.length} dokumen',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Table Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100), // Extra bottom padding untuk navbar
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            cardTheme: const CardTheme(color: Colors.transparent, elevation: 0),
                            dividerTheme: DividerThemeData(
                              color: Colors.grey.shade300,
                              thickness: 1,
                              space: 0,
                            ),
                          ),
                          child: PaginatedDataTable(
                            header: Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  const Icon(Icons.description, color: Colors.black),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Daftar Dokumen',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Total: ${_filteredDocuments.length}',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            columns: const [
                              DataColumn(label: Center(child: Text('Nomor', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                              DataColumn(label: Center(child: Text('Judul', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                              DataColumn(label: Center(child: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                              DataColumn(label: Center(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                              DataColumn(label: Center(child: Text('Pengunggah', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                              DataColumn(label: Center(child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                            ],
                            source: _documentDataSource,
                            rowsPerPage: _calculateRowsPerPage(),
                            showCheckboxColumn: false,
                            columnSpacing: 12,
                            dataRowHeight: 60,
                            headingRowHeight: 56,
                            horizontalMargin: 12,
                            headingRowColor: MaterialStateProperty.all(const Color(0xFF0BA89C)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _calculateRowsPerPage() {
    return _filteredDocuments.length.clamp(1, 10);
  }
}

