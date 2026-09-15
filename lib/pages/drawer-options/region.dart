import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

class RegionPage extends StatelessWidget {
  final String cropName;
  final String cropImage;

  const RegionPage({
    super.key,
    required this.cropName,
    required this.cropImage,
  });


  @override
  Widget build(BuildContext context) {
    final List<String> regions = [
      'Barishal',
      'Bogura',
      'Dhaka',
      'Jessore',
      'Mymensingh',
      'Cumilla',
      'Dinajpur',
      'Faridpur',
      'Khulna',
      'Rajshahi',
      'Rangpur'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$cropName - Crop Weather Calendar'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: regions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.green),
              ),
              onPressed: () async {
                final querySnapshot = await FirebaseFirestore.instance
                    .collection('crop_calendars')
                    .where('crop', isEqualTo: cropName)
                    .where('region', isEqualTo: regions[index])
                    .get();

                if (!context.mounted) return;

                if (querySnapshot.docs.isNotEmpty) {
                  final doc = querySnapshot.docs.first;
                  final url = doc.data()['url'] as String?;
                  if (url == null || url.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('The calendar link is unavailable'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }
                  final uri = Uri.tryParse(url);
                  if (uri == null ||
                      (uri.scheme != 'http' && uri.scheme != 'https')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('The calendar link is invalid'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }

                  final opened = await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                  if (!opened && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Could not open calendar link'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No calendar found for this region'),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: Text(
                regions[index],
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String cropName;
  final String cropImage;
  final String url;

  const PDFViewerPage({
    super.key,
    required this.cropName,
    required this.cropImage,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$cropName Crop Calendar',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    cropImage,
                    height: 84,
                    width: 84,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    cropName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: SelectableText(
                    url,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                IconButton(
                  tooltip: 'Open calendar link',
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () async {
                    final opened = await launchUrl(
                      Uri.parse(url),
                      mode: LaunchMode.externalApplication,
                    );
                    if (!opened && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open link')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: const PDF().cachedFromUrl(
              url,
              placeholder: (progress) => Center(
                child: CircularProgressIndicator(value: progress),
              ),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
