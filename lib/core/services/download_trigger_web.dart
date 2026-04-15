import 'dart:html' as html;

/// Flutter web: trigger file download via anchor element.
void triggerWebDownload(String url, String filename) {
  final anchor = html.AnchorElement(href: url)
    ..target = '_blank'
    ..download = filename
    ..style.display = 'none';

  html.document.body?.append(anchor);
  anchor.click();
  Future<void>.delayed(const Duration(milliseconds: 200), () {
    anchor.remove();
  });
}
