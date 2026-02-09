import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> downloadFile({required fileLink}) async {
  final Uri url = Uri.parse(fileLink);
  if (!await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication)) {
    throw Exception('Could not launch $url');
  }
}

Future<ShareResult> shareFile({required fileLink}) async {
  return Share.share(fileLink);
}

String splitLongText({required String longText, int maxLineLength = 40}) {
  // Split the text into words
  List<String> words = longText.split(' ');
  StringBuffer buffer = StringBuffer();
  int currentLineLength = 0;

  for (String word in words) {
    if ((currentLineLength + word.length + 1) > maxLineLength) {
      // If adding the word exceeds the max line length, add a newline
      buffer.write('\n');
      currentLineLength = 0;
    }

    // Add the word to the buffer
    buffer.write('$word ');
    currentLineLength += word.length + 1;
  }

  return buffer.toString().trim();
}
