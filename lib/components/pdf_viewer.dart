import 'package:flutter/widgets.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:ny_tiona/components/loading.dart';
import 'package:ny_tiona/components/page_error_read_failed.dart';
import 'package:ny_tiona/components/paginator_indication.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({Key? key, required this.filename}) : super(key: key);

  final String filename;

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late final PdfController pdfController;
  late String filename;
  int page = 1;
  int pageCount = 1;
  bool error = false;

  @override
  void initState() {
    super.initState();
    filename = widget.filename;
    pdfController = PdfController(
      document: PdfDocument.openAsset(filename),
    );
  }

  void onPageChange(int currentPage) {
    setState(() {
      page = currentPage;
    });
  }

  void onDocumentLoaded(document) {
    setState(() {
      pageCount = document.pagesCount;
    });
  }

  void onDocumentError(error) {
    setState(() {
      error = true;
    });
  }

  Widget errorBuilder(error) => const PageErrorReadFailed();

  @override
  Widget build(BuildContext context) {
    return error
        ? const PageErrorReadFailed()
        : Stack(
            children: [
              PdfView(
                controller: pdfController,
                scrollDirection: Axis.vertical,
                onPageChanged: onPageChange,
                onDocumentLoaded: onDocumentLoaded,
                onDocumentError: onDocumentError,
                documentLoader: const Loading(),
                errorBuilder: errorBuilder,
              ),
              Positioned(
                top: 10,
                right: 0,
                child: PaginatorIndication(
                    label: '${page.toString()}/${pageCount.toString()}'),
              ),
            ],
          );
  }
}
