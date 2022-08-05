import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkie/providers/link_data_provider.dart';
import 'package:linkie/utils/helpers.dart';
import 'package:linkie/widgets/indicators/my_circular_progress_indicator_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(),
        //
        body: Consumer<LinkDataProvider>(
          builder: (context, value, child) {
            // if user navigates to /preview directly, go to /
            if (value.linkData == null) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              });
            }

            return Center(
              // main outer column, including card and share button
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    elevation: 8,
                    shadowColor: Colors.black87,
                    borderRadius: BorderRadius.circular(12.0),
                    color: Theme.of(context).colorScheme.background,
                    surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
                    child: Container(
                      width: _getScreenWidth(screenSize),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 22.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        // color: Theme.of(context).colorScheme.background,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // image

                          _buildImage(
                            context,
                            value.linkData?.image,
                            screenSize: screenSize,
                            domain: value.linkData?.domain ?? '',
                          ),

                          spacer(height: 12.0),

                          // title
                          Text(
                            value.linkData?.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: _getScreenWidth(screenSize) * .045,
                            ),
                          ),
                          spacer(height: 8.0),

                          // description
                          Flexible(
                            child: Text(
                              value.linkData?.description ?? '',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.1,
                                fontSize: _getScreenWidth(screenSize) * .033,
                              ),
                            ),
                          ),
                          spacer(height: 8.0),

                          // link chip
                          _buildDomainChip(
                            context,
                            value.linkData?.domain ?? '',
                            url: value.linkData?.url ?? '',
                            faviconUrl: value.linkData?.favicon ?? '',
                          ),
                        ],
                      ),
                    ),
                  ),
                  spacer(height: 12.0),

                  // share button
                  Hero(
                    tag: 'primary-button',
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                          'https://twitter.com/intent/tweet?text=${value.linkData?.title ?? ''}\n\n${value.linkData?.description ?? ''}&url=${value.linkData?.url ?? ''}',
                        ));
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          primary: Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.all(22)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Flexible(child: Text('Share')),
                          spacer(width: 8.0),
                          Flexible(
                            child: SvgPicture.asset(
                              "assets/twitter.svg",
                              height: 20,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget _buildDomainChip(
    BuildContext context,
    String domain, {
    required String url,
    required String faviconUrl,
  }) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ActionChip(
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundImage: NetworkImage(faviconUrl),
          radius: 12,
        ),
        onPressed: () async {
          await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
        },
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        label: Text(
          domain,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Theme.of(context).colorScheme.onTertiary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String? url,
      {required Size screenSize, required String domain}) {
    if (url != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          url,
          fit: BoxFit.fitWidth,
          width: screenSize.width * .4,
          errorBuilder: (context, error, stackTrace) {
            return _buildCircularAvatar(context, domain);
          },
          loadingBuilder: ((context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const MyCircularProgressIndicator();
          }),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  CircleAvatar _buildCircularAvatar(BuildContext context, String domain) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      child: Text(domain[0]),
    );
  }

  double _getScreenWidth(Size screenSize) {
    if (screenSize.width < 481) {
      return screenSize.width * .9;
    } else {
      if (screenSize.width > 481 && screenSize.width < 768) {
        return 400;
      } else {
        if (screenSize.width > 769 && screenSize.width < 1024) {
          return 500;
        } else {
          if (screenSize.width > 1025) {
            return 600;
          } else {
            return 500;
          }
        }
      }
    }
  }
}
