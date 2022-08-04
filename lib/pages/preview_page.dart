import 'package:flutter/material.dart';
import 'package:linkie/providers/link_data_provider.dart';
import 'package:linkie/utils/helpers.dart';
import 'package:provider/provider.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
          ],
        ),
        //
        body: Consumer<LinkDataProvider>(
          builder: (context, value, child) {
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
                    child: Container(
                      width: _getScreenWidth(screenSize),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 22.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              value.linkData?.image ?? '',
                              fit: BoxFit.fitWidth,
                              width: screenSize.width * .25,
                            ),
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
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ActionChip(
                              onPressed: () {},
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                              label: Text(
                                value.linkData?.domain ?? '',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
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
                        // Navigator.pushNamed(context, '/preview');
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
                          const Flexible(child: Icon(Icons.share, size: 16))
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

  double _getScreenWidth(Size screenSize) {
    if (screenSize.width < 481) {
      return 300;
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
