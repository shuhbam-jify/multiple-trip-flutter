import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multitrip_user/features/logic/app_permission_handler.dart';
import 'package:multitrip_user/models/address.dart';
import 'package:multitrip_user/models/drivers.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/app_image.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';
import 'package:provider/provider.dart';

List<Drivers> drivers = [
  Drivers(drivername: "Same", rating: 4.5),
  Drivers(drivername: "Rony", rating: 4),
  Drivers(drivername: "Harry", rating: 3.5),
  Drivers(drivername: "John", rating: 2.5),
  Drivers(drivername: "Rahul", rating: 1),
];

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;

  const HomeScreen({
    super.key,
    this.parentScaffoldKey,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;

  late AppPermissionProvider appPermissionProvider;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  List<Address> addresslist = [
    Address(
      addressSubtitle: "1217 Islington Ave, Toronto, Ontario",
      addresstitle: "1217 Islington Ave",
    ),
    Address(
      addressSubtitle: "618 102nd Avenue, Dawson Creek, British Columbia",
      addresstitle: "618 102nd Avenue",
    )
  ];
  @override
  void initState() {
    appPermissionProvider =
        Provider.of<AppPermissionProvider>(context, listen: false);
    appPermissionProvider.fetchuserlocation();
    super.initState();
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.appColor,
        body:
            Consumer<AppPermissionProvider>(builder: ((context, value, child) {
          if (value.latitude == null) {
            Loader.show(context);
          } else {
            Loader.hide();
            return _renderbody(value: value);
          }
          return SizedBox();
        })),
      ),
    );
  }

  Widget _renderbody({required AppPermissionProvider value}) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ) +
            EdgeInsets.only(
              top: 10.h,
            ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  onTap: () {
                    AppEnvironment.navigator.pushNamed(
                      GeneralRoutes.pickupdropaddress,
                    );
                  },
                  cursorColor: AppColors.grey500,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        AppEnvironment.navigator.pushNamed(
                          GeneralRoutes.scheduleride,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time_filled_outlined,
                              color: Colors.black,
                            ),
                            sizedBoxWithWidth(3),
                            Text(
                              "Now",
                              style: AppText.text14w400.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    hintText: "Where to?",
                    hintStyle: AppText.text18w400.copyWith(
                      color: Colors.black,
                      height:
                          1.6, //                                <----- this was the key
                    ),
                    isDense: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 25,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              sizedBoxWithHeight(10),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: addresslist.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        child: Icon(
                          Icons.location_on_sharp,
                          color: Colors.black,
                          size: 30,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.greylight, shape: BoxShape.circle),
                      ),
                      sizedBoxWithWidth(10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addresslist.elementAt(index).addresstitle,
                              style: AppText.text16w400.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              addresslist.elementAt(index).addressSubtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.text14w400.copyWith(
                                color: AppColors.grey500,
                                fontSize: 13.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      )
                    ],
                  );
                },
                separatorBuilder: (c, i) {
                  return Divider(
                    thickness: 0.6,
                    color: AppColors.greylight,
                  );
                },
              ),
              sizedBoxWithHeight(10),
              Divider(
                thickness: 5,
                color: AppColors.greydark,
              ),
              sizedBoxWithHeight(10),
              Text(
                "Top rated drivers",
                style: AppText.text18w400.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              sizedBoxWithHeight(10),
              SizedBox(
                height: 130.h,
                child: ListView.separated(
                    padding: EdgeInsets.only(
                      left: 20.w,
                    ),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          AppImage(
                            "assets/driver.svg",
                            height: 70.h,
                            width: 70.w,
                          ),
                          Text(
                            drivers.elementAt(index).drivername,
                            style: AppText.text14w400.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: drivers.elementAt(index).rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            ignoreGestures: true,
                            allowHalfRating: true,
                            unratedColor: Colors.grey,
                            itemCount: 5,
                            itemSize: 15,
                            itemPadding: EdgeInsets.symmetric(horizontal: .0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 10,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 50.w,
                      );
                    },
                    itemCount: drivers.length),
              ),
              Stack(
                children: [
                  CarouselSlider(
                    items: imageSliders,
                    carouselController: _controller,
                    options: CarouselOptions(
                        height: 120.h,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Positioned(
                    top: 90.h,
                    left: MediaQuery.of(context).size.width / 2.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: drivers.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 6.0,
                            height: 6.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              sizedBoxWithHeight(10),
              Divider(
                thickness: 5,
                color: AppColors.greydark,
              ),
              sizedBoxWithHeight(10),
              Text(
                "Previous drivers",
                style: AppText.text18w400.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              sizedBoxWithHeight(10),
              SizedBox(
                height: 130.h,
                child: ListView.separated(
                    padding: EdgeInsets.only(
                      left: 20.w,
                    ),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          AppImage(
                            "assets/driver.svg",
                            height: 70.h,
                            width: 70.w,
                          ),
                          Text(
                            drivers.elementAt(index).drivername,
                            style: AppText.text14w400.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: drivers.elementAt(index).rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            ignoreGestures: true,
                            allowHalfRating: true,
                            unratedColor: Colors.grey,
                            itemCount: 5,
                            itemSize: 15,
                            itemPadding: EdgeInsets.symmetric(horizontal: .0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 10,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 50.w,
                      );
                    },
                    itemCount: drivers.length),
              ),
              Divider(
                thickness: 5,
                color: AppColors.greydark,
              ),
              sizedBoxWithHeight(10),
              Text(
                "Drivers Nearby",
                style: AppText.text18w400.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              sizedBoxWithHeight(10),
              Container(
                height: 170.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GoogleMap(
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    markers: <Marker>{
                      Marker(
                        markerId: const MarkerId('marker_1'),
                        draggable: true,
                        onDrag: (values) {
                          //    value.ondrag(values);
                        },
                        position: LatLng(
                          value.latitude!,
                          value.longitude!,
                        ),
                        infoWindow: const InfoWindow(
                            title: 'Marker Title', snippet: 'Marker Snippet'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed),
                      ),
                    },
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    onMapCreated: (controller) {
                      mapController = controller;

                      mapController.moveCamera(
                        CameraUpdate.newLatLng(
                          LatLng(value.latitude!, value.longitude!),
                        ),
                      );
                      mapController.animateCamera(
                        CameraUpdate.newLatLng(
                          LatLng(value.latitude!, value.longitude!),
                        ),
                      );

                      // setState(() {
                      //   ismapCreated = true;
                      // });
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        value.latitude!,
                        value.longitude!,
                      ),
                      zoom: 15.0,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: AppColors.greylight,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              sizedBoxWithHeight(10),
              Divider(
                thickness: .5,
                color: AppColors.greydark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Widget> imageSliders = drivers
    .map((item) => Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Text(
                  "Book drivers by hours",
                  style: AppText.text15w400
                      .copyWith(color: Colors.black, fontSize: 14.sp),
                ),
              ),
              AppImage(
                "assets/driver-slider.jpeg",
                // width: 130.w,
                // height: 130.h,
              )
            ],
          ),
          decoration: BoxDecoration(
            color: AppColors.greylight,
            borderRadius: BorderRadius.circular(20),
          ),
        ))
    .toList();
