import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/models/courses/ebook/ebook.dart';
import 'package:url_launcher/url_launcher.dart';

class EbookCard extends StatelessWidget {
  const EbookCard({super.key, required this.ebook});

  final EBook ebook;

  void _launchEBookUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchEBookUrl(ebook.fileUrl ?? 'null url');
      },
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0.5,
                color: Color.fromARGB(255, 195, 193, 193),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Theme.of(context).cardColor,
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            borderOnForeground: true,
            shadowColor: const Color.fromARGB(255, 132, 132, 132),
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: ebook.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline_rounded,
                    size: 32,
                    color: Colors.redAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ebook.name ?? 'null name',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ebook.description ?? 'null description',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        coursesLevel[ebook.level] ?? 'null level',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
