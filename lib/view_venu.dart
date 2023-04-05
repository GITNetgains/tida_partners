import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:tida_partners/add_venue.dart';
import 'package:tida_partners/controllers/HomeScreenController.dart';
import 'package:tida_partners/network/responses/VenueListResponse.dart';
import 'package:tida_partners/utilss/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AppColors.dart';
import 'controllers/VenueDetailsController.dart';

class ViewVenu extends StatelessWidget {
  ViewVenu({Key? key}) : super(key: key);
  final _controller = Get.put(HomeScreenController());


  @override
  Widget build(BuildContext context) {
    Data selectedVenue = _controller.venueList[_controller.index.value];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          //Get.back(result: true);
          _controller.editVenue(_controller.index.value);
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium(selectedVenue.title!.toUpperCase()),
      ),
      body: Container(
        color: Colors.white,
        child: Obx(() => _controller.loading.value
            ? showLoader()
            : ListView(
                children: [
                  Obx(() => _controller.imageList.isEmpty
                      ? Container()
                      : ImageSlideshow(
                          /// Width of the [ImageSlideshow].
                          width: double.infinity,

                          /// Height of the [ImageSlideshow].
                          height: 200,

                          /// The page to show when first creating the [ImageSlideshow].
                          initialPage: 0,

                          /// The color to paint the indicator.
                          indicatorColor: PRIMARY_COLOR,

                          /// The color to paint behind th indicator.
                          indicatorBackgroundColor: Colors.grey,

                          /// Called whenever the page in the center of the viewport changes.
                          onPageChanged: (value) {
                            // print('Page changed: $value');
                          },

                          /// Auto scroll interval.
                          /// Do not auto scroll with null or 0.
                          autoPlayInterval: 4000,

                          /// Loops back to first slide.
                          isLoop: _controller.imageList.isEmpty,

                          /// The widgets to display in the [ImageSlideshow].
                          /// Add the sample image file into the images folder
                          children: getList(),
                        )),
                  getVerticalSpace(),
                  ListTile(
                    title: setHeadlineMedium(
                      'Description',
                      color: Colors.deepOrange,
                      fontSize: 20,
                    ),
                    subtitle: setSmallLabel(
                      selectedVenue.description ?? "N/A",
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: setHeadlineMedium(
                      'Location',
                      color: Colors.deepOrange,
                      fontSize: 20,
                    ),
                    subtitle: setSmallLabel(
                      selectedVenue.address ?? "N/A",
                    ),
                    /* trailing: InkWell(
                onTap: () {
                  _launchUrl();
                },
                child: CircleAvatar(
                  backgroundColor: PRIMARY_COLOR,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
              ),*/
                  ),
                  Divider(),
                  ListTile(
                    title: setHeadlineMedium(
                      'Availability',
                      color: Colors.deepOrange,
                      fontSize: 20,
                    ),
                    subtitle: setSmallLabel(
                      selectedVenue.address ?? "N/A",
                    ),
                  ),
                  Divider(),
                  (selectedVenue.amenities != null)
                      ? ListTile(
                          title: setHeadlineMedium(
                            'Amenities',
                            color: Colors.deepOrange,
                            fontSize: 20,
                          ),
                          subtitle: Container(
                            child: ChipsChoice<String>.multiple(
                              wrapped: true,
                              value: _controller.getAmenitiesNames(
                                  selectedVenue.amenities!.split(",")),
                              onChanged: (val) => print("vvv"),
                              choiceItems: C2Choice.listFrom<String, String>(
                                source: _controller.getAmenitiesNames(
                                    selectedVenue.amenities!.split(",")),
                                value: (i, v) => v,
                                label: (i, v) => v,
                              ),
                            ),
                          ))
                      : Container(),
                  (selectedVenue.sports != null) ? Divider() : Container(),
                  (selectedVenue.sports != null)
                      ? ListTile(
                          title: setHeadlineMedium(
                            'Sports',
                            color: Colors.deepOrange,
                            fontSize: 20,
                          ),
                          subtitle:   Container(
                            child:  (_controller.getSelectedSportName(
                            selectedVenue.sports.toString().split(",")).isNotEmpty)?  ChipsChoice<String>.multiple(
                              wrapped: true,
                              value: _controller.getSelectedSportName(
                                  selectedVenue.sports.toString().split(",")),
                              onChanged: (val) => print("vvv"),
                              choiceItems: C2Choice.listFrom<String, String>(
                                source: _controller.getSelectedSportName(
                                    selectedVenue.sports!.split(",")),
                                value: (i, v) => v,
                                label: (i, v) => v,
                              ),
                            ):Container(),
                          ))
                      : Container(),
                ],
              )),
      ),
    );
  }

  List<Widget> getList() {
    List<Widget> items = [];
    if (_controller.imageList.isNotEmpty) {
      for (int i = 0; i < _controller.imageList.length; i++) {
        if (_controller.imageList[i]!.image!.split(".").length > 2) {
          items.add(
            getImageWidget('${_controller.imageList[i]?.image}'),
          );
        }
      }
    }
    if (items.isEmpty) {
      items.add(
        Image.network(
            _controller.getSelectedVenue().image??"",
            fit: BoxFit.fitWidth, errorBuilder: (context, obj, e) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Image not available. Please edit venue and update featured image ",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }),
      );
    }
    return items;
  }
}
