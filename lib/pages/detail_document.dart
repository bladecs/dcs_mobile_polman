import 'package:flutter/material.dart';

class DetailDocumentContent extends StatefulWidget {
  const DetailDocumentContent({super.key});

  @override
  _DetailDocumentState createState() => _DetailDocumentState();
}

class _DetailDocumentState extends State<DetailDocumentContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    spreadRadius: 2,
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Color(0xFF13A79B),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Detail Dokumen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Table(
                      columnWidths: {
                        0: FixedColumnWidth(120),
                        1: FixedColumnWidth(20),
                        2: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        _buildTableRow('Nomor Dokumen', 'DOC-001-2024'),
                        _buildTableRow(
                            'Judul', 'Laporan Tahunan Perusahaan 2024'),
                        _buildTableRow('Kategori', 'Administrasi'),
                        _buildTableRowWithStatus('Status', 'Disetujui'),
                        _buildTableRow('Pembuat', 'John Doe'),
                        _buildTableRow('Deskripsi',
                            'Laporan kinerja tahunan perusahaan yang berisi pencapaian dan target untuk tahun depan.'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    spreadRadius: 2,
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.file_open,
                          color: Color(0xFF13A79B),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'File Dokumen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Laporan Keuangan Bulan September',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Container(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.sim_card_download),
                              SizedBox(width: 5),
                              Text('Unduh')
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF13A79B),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    spreadRadius: 2,
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.message_rounded,
                          color: Color(0xFF13A79B),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Status Dokumen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Mengubah:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(height: 10),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 1)),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: '-', border: InputBorder.none),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(), // Spacer
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            value,
            style: TextStyle(fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRowWithStatus(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(), // Spacer
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Container(
            width: 120,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF13A79B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
