import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multitrip_user/blocs/confirmride/confirmride_bloc.dart';
import 'package:multitrip_user/blocs/member/member_bloc.dart';
import 'package:multitrip_user/bottomnavigationbar.dart';
import 'package:multitrip_user/features/book_ride/vehiclelist.dart';
import 'package:multitrip_user/logic/add_member/member_controller.dart';
import 'package:multitrip_user/features/book_ride/widgets/membersSheet.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/app_image.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';
import 'package:provider/provider.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import '../../blocs/locationbloc/location_bloc_bloc.dart';

class PickupDropAddress extends StatefulWidget {
  final String pickupaddess;
  final double lat;
  final double long;
  const PickupDropAddress(
      {super.key,
      required this.pickupaddess,
      required this.lat,
      required this.long});

  @override
  State<PickupDropAddress> createState() => _PickupDropAddressState();
}

class _PickupDropAddressState extends State<PickupDropAddress> {
  late GoogleMapController googleMapController;
  List<TextEditingController> _controllers = [];
  Position? position;
  double dividerHeight = 50.h;
  bool pickenabled = true;
  bool dropenable = false;

  int currentTextField = 0;
  bool ismapvisible = false;

  TextEditingController pickupController = TextEditingController();
  TextEditingController dropController = TextEditingController();
  LocationBlocBloc locationBlocBloc = LocationBlocBloc();
  MemberBloc memberBloc = MemberBloc();

  late LatLng pickuplatlong;
  late LatLng droplatlong;

  @override
  void initState() {
    pickuplatlong = LatLng(widget.lat, widget.long);
    pickupController.text = widget.pickupaddess;
    fetchlocation();
    locationBlocBloc = BlocProvider.of<LocationBlocBloc>(context);
    memberBloc = BlocProvider.of<MemberBloc>(context);
    super.initState();
  }

  Future<void> fetchlocation() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void _addTextField() {
    setState(() {
      if (_controllers.length < 3) {
        setState(() {
          _controllers.add(TextEditingController());
          // Increase the divider height when adding a new TextField
          dividerHeight += 50.h;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        dropController.text = "";
        pickupController.text = '';
        Navigator.pop(context);
        return false;
      },
      child: KeyboardVisibilityBuilder(
        builder: (p0, isKeyboardVisible) {
          if (isKeyboardVisible == true) {
            ismapvisible = false;
          }
          return Scaffold(
            bottomNavigationBar: Visibility(
              visible: ismapvisible,
              child: GestureDetector(
                onTap: () {
                  if (pickupController.text.isEmpty) {
                    context.showSnackBar(context,
                        msg: "Please Add Pickup Address");
                  } else if (dropController.text.isEmpty) {
                    context.showSnackBar(context,
                        msg: "Please Add Drop Address");
                  } else {
                    BlocProvider.of<ConfirmrideBloc>(context).add(
                      DoConfirmRide(
                          droplocation: jsonEncode(
                            [
                              {
                                "lat": droplatlong.latitude.toString(),
                                "long": droplatlong.longitude.toString(),
                                "address": dropController.text
                              },
                            ],
                          ),
                          pickuplocation: jsonEncode(
                            {
                              "lat": pickuplatlong.latitude.toString(),
                              "long": pickuplatlong.longitude.toString(),
                              "address": pickupController.text
                            },
                          )),
                    );
                  }
                },
                child: Container(
                  height: 50.h,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                  ),
                  child: Center(
                    child: Text(
                      "Done",
                      style: AppText.text15Normal.copyWith(color: Colors.white),
                    ),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            backgroundColor: AppColors.appColor,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w) +
                    EdgeInsets.only(
                      top: 10.h,
                    ),
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<LocationBlocBloc, LocationBlocState>(
                      listener: (context, state) {
                        if (state is PickupLatLongLoaded) {
                          setState(() {
                            pickuplatlong = state.picklatlong;
                          });
                        }
                      },
                    ),
                    BlocListener<ConfirmrideBloc, ConfirmrideState>(
                      listener: (context, state) {
                        if (state is ConfirmLoading) {
                          Loader.show(context);
                        } else if (state is ConfirmLoaded) {
                          Loader.hide();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VehicleList(
                                droplat: droplatlong.latitude,
                                amount: state.confirmRide.amount,
                                bookingid:
                                    state.confirmRide.bookingNumber.toString(),
                                droplong: droplatlong.longitude,
                                pickuplat: pickuplatlong.latitude,
                                pickuplong: pickuplatlong.longitude,
                              ),
                            ),
                          );
                        } else if (state is ConfirmFail) {
                          Loader.hide();
                          context.showSnackBar(
                            context,
                            msg: state.error,
                          );
                        } else if (state is TokenExpired) {
                          Loader.hide();
                          context.showSnackBar(context, msg: "Token Expired");
                        }
                      },
                    ),
                  ],
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _showmembers(),
                      sizedBoxWithHeight(10),
                      textfields(),
                      _renderbody(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textfields() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.circle,
                color: AppColors.black,
                size: 10,
              ),
              SizedBox(
                height: dividerHeight,
                child: VerticalDivider(
                  width: 20,
                  color: AppColors.black,
                ),
              ),
              Icon(
                Icons.square,
                color: AppColors.greylight,
                size: 10,
              ),
            ],
          ),
          Flexible(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        color: Colors.grey.shade300,
                        child: TextFormField(
                          controller: pickupController,
                          onTap: () {
                            locationBlocBloc.add(ClearSuggestionList());
                            setState(() {
                              pickenabled = true;
                              dropenable = false;
                            });
                          },
                          onChanged: (value) {
                            BlocProvider.of<LocationBlocBloc>(context).add(
                              FetchSuggestions(query: value),
                            );
                          },
                          cursorColor: AppColors.grey500,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppImage(
                                "assets/sort.svg",
                                height: 10.h,
                                width: 10.w,
                              ),
                            ),
                            hintText: "Enter Pickup location",
                            hintStyle: AppText.text14w400.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.grey500,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15) +
                                EdgeInsets.only(
                                  left: 10.w,
                                ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    // sizedBoxWithWidth(5),
                    // Container(
                    //   height: 30.h,
                    //   width: 30.w,
                    // )
                  ],
                ),
                sizedBoxWithHeight(10),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return sizedBoxWithHeight(10);
                  },
                  shrinkWrap: true,
                  itemCount: _controllers.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.grey.shade300,
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  currentTextField = index;
                                });
                              },
                              controller: _controllers[index],
                              onChanged: (value) {
                                BlocProvider.of<LocationBlocBloc>(context).add(
                                  FetchSuggestions(query: value),
                                );
                              },
                              cursorColor: AppColors.grey500,
                              decoration: InputDecoration(
                                suffixIcon: LongPressDraggable(
                                  feedback: Material(
                                    child: TextFormField(
                                      controller: _controllers[index],
                                      cursorColor: AppColors.grey500,
                                      decoration: InputDecoration(
                                        hintText: "Where to?",
                                        hintStyle: AppText.text14w400.copyWith(
                                          fontSize: 14.sp,
                                          color: AppColors.grey500,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  key: ValueKey(index),
                                  childWhenDragging: Container(),
                                  child: Icon(
                                    Icons.drag_handle,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                ),
                                isDense: true,
                                hintText: "Where to?",
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15) +
                                        EdgeInsets.only(
                                          left: 10.w,
                                        ),
                                hintStyle: AppText.text14w400.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.grey500,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        sizedBoxWithWidth(5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _controllers.removeAt(index);
                              dividerHeight -= 50.h;
                            });
                          },
                          child: SizedBox(
                            height: 30.h,
                            width: 30.w,
                            child: Icon(
                              Icons.close,
                              color: AppColors.black,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                sizedBoxWithHeight(10),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        color: Colors.grey.shade300,
                        child: TextFormField(
                          controller: dropController,
                          onTap: () {
                            setState(() {
                              pickenabled = false;
                              dropenable = true;
                            });
                            if (pickupController.text == "") {
                              setState(() {
                                pickupController.text = widget.pickupaddess;
                              });
                            }

                            locationBlocBloc.add(ClearSuggestionList());
                            //  locationProvider.changepickupordrop(value: "Drop");
                          },
                          onChanged: (value) {
                            BlocProvider.of<LocationBlocBloc>(context)
                                .add(FetchSuggestions(query: value));
                          },
                          cursorColor: AppColors.grey500,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppImage(
                                "assets/sort.svg",
                                height: 10.h,
                                width: 10.w,
                              ),
                            ),
                            hintText: "Where to?",
                            hintStyle: AppText.text14w400.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.grey500,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15) +
                                EdgeInsets.only(
                                  left: 10.w,
                                ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    // sizedBoxWithWidth(5),
                    // Container(
                    //   height: 30.h,
                    //   width: 30.w,
                    // )
                  ],
                ),
              ],
            ),
          ),
          sizedBoxWithWidth(7),
          Visibility(
            visible: _controllers.length < 1,
            child: InkWell(
              onTap: () {
                _addTextField();
              },
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                    color: _controllers.length < 3
                        ? AppColors.greylight
                        : Colors.transparent,
                    shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _showmembers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            dropController.text = "";
            pickupController.text = '';
            locationBlocBloc.add(ClearSuggestionList());
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
        Spacer(),
        BlocListener<MemberBloc, MemberState>(
          listener: (context, state) async {
            if (state is MemberLoading) {
              Loader.show(context);
            } else if (state is MembersFail) {
              context.showSnackBar(context, msg: state.error);
              Loader.hide();
            } else if (state is MemberLoaded) {
              Loader.hide();
              await showTopModalSheet<String?>(
                  context, MembersSheet(members: state.listMembers.members));
            } else if (state is MemberTokenExpired) {
              Loader.hide();
              context.showSnackBar(context, msg: "Token Expired");
            }
            // TODO: implement listener
          },
          child: InkWell(
            onTap: () async {
              memberBloc.add(FetchMembers());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.grey500,
                  size: 12,
                ),
                sizedBoxWithWidth(3),
                Text(
                  "Switch Member",
                  style: AppText.text14w400.copyWith(
                    color: AppColors.grey500,
                    fontSize: 12.sp,
                  ),
                ),
                sizedBoxWithWidth(3),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.grey500,
                  size: 12,
                )
              ],
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _renderbody() {
    return Padding(
      padding: EdgeInsets.symmetric(
            horizontal: 0.w,
          ) +
          EdgeInsets.only(
            top: 16.h,
          ),
      child: !ismapvisible
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 30,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greydark,
                          shape: BoxShape.circle,
                        ),
                      ),
                      sizedBoxWithWidth(10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saved Places",
                              style: AppText.text16w400.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 5,
                    color: AppColors.greydark,
                  ),
                  sizedBoxWithHeight(10),
                  BlocConsumer<LocationBlocBloc, LocationBlocState>(
                    builder: (context, state) {
                      if (state is SuggestionsLoaded) {
                        // Loader.hide();
                        return ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.predictions.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                                if (pickenabled) {
                                  locationBlocBloc.add(
                                    FetchPickupLatLong(
                                        placeId: state.predictions
                                            .elementAt(index)
                                            .placeId),
                                  );
                                  pickupController.text = state.predictions
                                      .elementAt(index)
                                      .structuredFormatting
                                      .secondaryText;
                                  pickupController.selection =
                                      TextSelection.collapsed(
                                    offset: pickupController.text.length,
                                  );
                                  locationBlocBloc.add(
                                    FetchPickupLatLong(
                                        placeId: state.predictions
                                            .elementAt(index)
                                            .placeId),
                                  );
                                } else if (dropenable) {
                                  dropController.text = state.predictions
                                      .elementAt(index)
                                      .structuredFormatting
                                      .secondaryText;

                                  dropController.selection =
                                      TextSelection.collapsed(
                                          offset: dropController.text.length);

                                  locationBlocBloc.add(
                                    FetchDropLatlong(
                                        placeId: state.predictions
                                            .elementAt(index)
                                            .placeId),
                                  );
                                } else {
                                  _controllers
                                          .elementAt(currentTextField)
                                          .text =
                                      state.predictions
                                          .elementAt(index)
                                          .structuredFormatting
                                          .secondaryText;
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    child: Icon(
                                      Icons.access_time_filled_sharp,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    decoration: BoxDecoration(
                                        color: AppColors.greydark,
                                        shape: BoxShape.circle),
                                  ),
                                  sizedBoxWithWidth(10),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.predictions
                                              .elementAt(index)
                                              .structuredFormatting
                                              .mainText,
                                          style: AppText.text16w400.copyWith(
                                            color: AppColors.black,
                                          ),
                                        ),
                                        Text(
                                          state.predictions
                                              .elementAt(index)
                                              .structuredFormatting
                                              .secondaryText,
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
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (c, i) {
                            return Divider(
                              thickness: 0.6,
                              color: AppColors.greylight,
                            );
                          },
                        );
                      }
                      return SizedBox();
                    },
                    listener: (context, state) {
                      if (state is SuggestionsLoading) {
                        //     Loader.show(context);
                      } else if (state is DropLatLongLoading) {
                        Loader.show(context);
                      } else if (state is DropLatLongLoaded) {
                        Loader.hide();

                        droplatlong = state.latLng;
                        SchedulerBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            BlocProvider.of<ConfirmrideBloc>(context).add(
                              DoConfirmRide(
                                  droplocation: jsonEncode(
                                    [
                                      {
                                        "lat": state.latLng.latitude.toString(),
                                        "long":
                                            state.latLng.longitude.toString(),
                                        "address": dropController.text
                                      },
                                    ],
                                  ),
                                  pickuplocation: jsonEncode(
                                    {
                                      "lat": pickuplatlong.latitude.toString(),
                                      "long":
                                          pickuplatlong.longitude.toString(),
                                      "address": pickupController.text
                                    },
                                  )),
                            );
                          },
                        );
                        locationBlocBloc.add(InitBloc());
                      }
                    },
                  ),
                  Divider(
                    thickness: 0.6,
                    color: AppColors.greylight,
                  ),
                  sizedBoxWithHeight(10),
                  GestureDetector(
                    onTap: () {
                      if (ismapvisible == false) {
                        setState(() {
                          ismapvisible = true;
                        });
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 30,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.greydark,
                              shape: BoxShape.circle),
                        ),
                        sizedBoxWithWidth(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Set location on map",
                              style: AppText.text16w400.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Column(
              children: [
                SizedBox(
                  child: Stack(
                    children: [
                      position == null
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.green,
                              ),
                            )
                          : GoogleMap(
                              zoomGesturesEnabled: true,
                              zoomControlsEnabled: false,
                              gestureRecognizers: <
                                  Factory<OneSequenceGestureRecognizer>>{
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              },
                              onCameraIdle: () async {
                                LatLngBounds bounds = await googleMapController
                                    .getVisibleRegion();
                                final lon = (bounds.northeast.longitude +
                                        bounds.southwest.longitude) /
                                    2;
                                final lat = (bounds.northeast.latitude +
                                        bounds.southwest.latitude) /
                                    2;

                                List<Placemark> placemarks =
                                    await GeocodingPlatform.instance
                                        .placemarkFromCoordinates(lat, lon);
                                Placemark place = placemarks.first;

                                final _fullAddress =
                                    '${place.name}, ${place.subThoroughfare} ${place.subLocality} ';

                                // FocusScopeNode currentFocus = FocusScope.of(context);

                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                                if (pickenabled) {
                                  pickuplatlong = LatLng(lat, lon);
                                  pickupController.text = _fullAddress;
                                  pickupController.selection =
                                      TextSelection.collapsed(
                                    offset: pickupController.text.length,
                                  );
                                } else if (dropenable) {
                                  droplatlong = LatLng(lat, lon);

                                  dropController.text = _fullAddress;

                                  dropController.selection =
                                      TextSelection.collapsed(
                                          offset: dropController.text.length);
                                } else if (_controllers.length > 0) {
                                  _controllers
                                      .elementAt(currentTextField)
                                      .text = _fullAddress;
                                } else {
                                  pickupController.text = _fullAddress;
                                  pickupController.selection =
                                      TextSelection.collapsed(
                                    offset: pickupController.text.length,
                                  );
                                }
                              },
                              onMapCreated: (controller) {
                                setState(() {
                                  googleMapController = controller;
                                });
                              },
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    position!.latitude, position!.longitude),
                                zoom: 15.0,
                              ),
                            ),
                      Center(
                          child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.h,
                      )),
                    ],
                  ),
                  height: 250.h,
                ),
              ],
            ),
    );
  }
}
