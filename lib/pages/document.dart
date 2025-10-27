import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:dcs_polman_kkn/pages/detail_document.dart';

class DaftarDocumentContent extends StatefulWidget {
  const DaftarDocumentContent({super.key});

  @override
  _DaftarDocumentContentState createState() => _DaftarDocumentContentState();
}

class _DaftarDocumentContentState extends State<DaftarDocumentContent> {
  int? selectedEntries = 10;
  List<int> numberView = [10, 20, 50, 100];

  String? selectedFilter;
  List<String> filterOptions = [
    'Semua',
    'Dokumen Aktif',
    'Dokumen Arsip',
    'Favorit'
  ];

  Color mainColor = const Color(0xFF13A79B);

  List<Map<String, String>> dummyData = List.generate(47, (index) => {
    'judul': 'Judul Dokumen ${index + 1} yang cukup panjang untuk contoh',
    'kategori': 'Kategori ${(index % 3) + 1}',
    'status': index % 2 == 0 ? 'Aktif' : 'Arsip',
    'pengunggah': 'Nama Pengunggah ${(index % 5) + 1}',
  });

  int currentPage = 1;
  int get totalPages => (filteredData.length / selectedEntries!).ceil();

  List<Map<String, String>> get filteredData {
    List<Map<String, String>> result = List.from(dummyData);
    if (selectedFilter == 'Dokumen Aktif') {
      result = result.where((doc) => doc['status'] == 'Aktif').toList();
    } else if (selectedFilter == 'Dokumen Arsip') {
      result = result.where((doc) => doc['status'] == 'Arsip').toList();
    } else if (selectedFilter == 'Favorit') {
      // Contoh filter favorit (dummy)
      result = result.where((doc) => int.parse(doc['judul']!.split(' ')[2]) % 3 == 0).toList();
    }

    return result;
  }
  List<Map<String, String>> get currentPageData {
    final startIndex = (currentPage - 1) * selectedEntries!;
    final endIndex = startIndex + selectedEntries!;
    return filteredData.sublist(
      startIndex,
      endIndex > filteredData.length ? filteredData.length : endIndex,
    );
  }
  InputDecoration _readOnlyDecoration(String value) {
    return InputDecoration(
      hintText: value,
      filled: true,
      fillColor: const Color(0xFFEFF3F8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    );
  }

  @override
  void initState() {
    super.initState();
    selectedFilter = filterOptions[0];
  }

  void _downloadFile(String url) {
    FileDownloader.downloadFile(
      url: url,
      onProgress: (fileName, progress) {
        print('Progress: $progress%');
      },
      onDownloadCompleted: (filePath) {
        debugPrint('Download selesai: $filePath');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File berhasil diunduh: $filePath')),
        );
      },
      onDownloadError: (error) {
        debugPrint('Error download: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download gagal: $error')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 0))
            ]),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Daftar Dokumen',
              style: TextStyle(
                color: const Color(0xFF13A79B),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3,
              width: 140,
              color: const Color(0xFF13A79B),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Masukan nama dokumen .....',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 2,
                    color: const Color(0xFF13A79B),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.search,
                    color: const Color(0xFF23B6A4),
                    size: 24,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Show',
                      style: TextStyle(
                        color: const Color(0xFF13A79B),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedEntries,
                          iconEnabledColor: mainColor,
                          items: numberView.map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedEntries = value!;
                              currentPage = 1;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedFilter,
                      hint: Text(
                        'Pilih filter',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      iconEnabledColor: mainColor,
                      isExpanded: true,
                      items: filterOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(
                            option,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedFilter = value!;
                          currentPage = 1;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF13A79B)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 1.5,
                      ),
                      child: Table(
                        defaultColumnWidth: const FixedColumnWidth(200),
                        columnWidths: const {
                          0: FixedColumnWidth(250),
                          1: FixedColumnWidth(150),
                          2: FixedColumnWidth(100),
                          3: FixedColumnWidth(150),
                          4: FixedColumnWidth(120),
                        },
                        border: TableBorder.symmetric(
                          inside: BorderSide(color: Colors.teal, width: 0.5),
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                            ),
                            children: const [
                              _HeaderCell(text: "Judul"),
                              _HeaderCell(text: "Kategori"),
                              _HeaderCell(text: "Status"),
                              _HeaderCell(text: "Pengunggah"),
                              _HeaderCell(text: "Aksi"),
                            ],
                          ),
                          ...currentPageData.asMap().entries.map((entry) {
                            final index = entry.key;
                            final data = entry.value;
                            Color rowColor = index % 2 == 0
                                ? Colors.white
                                : const Color(0xFF13A79B).withOpacity(0.1);

                            return TableRow(
                              decoration: BoxDecoration(
                                color: rowColor,
                              ),
                              children: [
                                _DataCell(text: data['judul']!),
                                _DataCell(text: data['kategori']!),
                                _DataCell(text: data['status']!),
                                _DataCell(text: data['pengunggah']!),
                                _ActionCell(
                                  onDetail: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const DetailDocumentContent(),
                                      ),
                                    );
                                  },
                                  onRevisi: () {
                                    _showRevisiDialog(index + 1);
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Pagination yang lebih compact
            _buildPagination(),
          ],
        ),
      ),
    );
  }

  void _showRevisiDialog(int documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24), // untuk atur jarak dari tepi layar
          contentPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Tolak Dokumen',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 700,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReadOnlyField('ID Dokumen', documentId.toString()),
                  const SizedBox(height: 16),
                  _buildReadOnlyField('Judul', 'Laporan Keuangan Bulanan'),
                  const SizedBox(height: 16),
                  _buildReadOnlyField('Kategori', 'Laporan Bulanan'),
                  const SizedBox(height: 16),
                  _buildReadOnlyField('Pengunggah', 'PJ Program'),
                  const SizedBox(height: 16),
                  Text('Berkas Donwload',style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () {
                      _downloadFile('https://drive.usercontent.google.com/download?id=1BQyFDKPOCcv63z5SX8ROAHW0FXkU9p4Q&export=download&authuser=0&confirm=t&uuid=9959e306-c6e6-470b-998e-8743cd5375f9&at=AKSUxGNC45L-np345lS1sxui7-av:1761529025909'); // Ganti URL dengan file kamu
                    },
                    child: const Text(
                      'Download Dokumen',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  RichText(
                    text: TextSpan(
                      text: 'Alasan Pengajuan Revisi ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: const [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Tuliskan alasan revisi...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.only(right: 16, bottom: 8),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aksi revisi
                Navigator.of(context).pop();
              },
              child: const Text('Revisi'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextField(
          readOnly: true,
          decoration: _readOnlyDecoration(value),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 36,
            child: ElevatedButton(
              onPressed: currentPage > 1
                  ? () {
                setState(() {
                  currentPage--;
                });
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Icon(Icons.chevron_left, size: 18),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: mainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: mainColor),
            ),
            child: Text(
              '$currentPage / $totalPages',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 36,
            child: ElevatedButton(
              onPressed: currentPage < totalPages
                  ? () {
                setState(() {
                  currentPage++;
                });
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Icon(Icons.chevron_right, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      constraints: const BoxConstraints(minHeight: 50),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  const _DataCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      constraints: const BoxConstraints(minHeight: 50),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _ActionCell extends StatelessWidget {
  final VoidCallback onDetail;
  final VoidCallback onRevisi;

  const _ActionCell({
    required this.onDetail,
    required this.onRevisi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(minHeight: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: onDetail,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF13A79B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.visibility, size: 12),
                  SizedBox(width: 4),
                  Text('Detail', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: onRevisi,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 12),
                  SizedBox(width: 4),
                  Text('Revisi', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}