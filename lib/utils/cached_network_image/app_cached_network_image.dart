import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../feedback/feedback_message.dart';
import '../locale/app_localization.dart';
import '../locale/app_localization_keys.dart';



class AppCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final BoxFit? boxFit;
  final double borderRadius;
  const AppCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.placeholder,
    this.width,
    this.height,
    this.boxFit,
    this.borderRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: (imageUrl.split(".").last.toLowerCase() == "pdf")
          ? _pdfPreview(context)
          : CachedNetworkImage(
              height: height,
              width: width,
              imageUrl: imageUrl,
              fit: boxFit,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) =>
                  placeholder ?? const Icon(Icons.error),
            ),
    );
  }

//
  Widget _pdfPreview(BuildContext context) {
    return InkWell(
      onTap: () => _openPdfFile(context),
      child: Text(
        imageUrl.split("/").last,
        style: const TextStyle(
            fontSize: 18,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _openPdfFile(BuildContext context) async {
    try {
      if (await canLaunchUrlString(imageUrl)) {
        await launchUrlString(imageUrl, mode: LaunchMode.externalApplication);
      } else {
        // ignore: use_build_context_synchronously
        showFeedbackMessage(AppLocalizations.of(context)!
            .translate(LocalizationKeys.unableToOpenLink)!);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showFeedbackMessage(AppLocalizations.of(context)!
          .translate(LocalizationKeys.unableToOpenLink)!);
    }
  }
}

class AppCachedNetworkImageProvider extends CachedNetworkImageProvider {
  final String imageUrl;
  const AppCachedNetworkImageProvider({
    required this.imageUrl,
    int? maxHeight,
    int? maxWidth,
  }) : super(
          imageUrl,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        );
}
