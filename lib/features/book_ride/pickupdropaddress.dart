import 'package:flutter/material.dart';
import 'package:multitrip_user/features/book_ride/widgets/membersSheet.dart';
import 'package:multitrip_user/models/address.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class PickupDropAddress extends StatefulWidget {
  const PickupDropAddress({super.key});

  @override
  State<PickupDropAddress> createState() => _PickupDropAddressState();
}

class _PickupDropAddressState extends State<PickupDropAddress> {
  List<Address> addresslist = [
    Address(
      addressSubtitle: "1217 Islington Ave, Toronto, Ontario",
      addresstitle: "1217 Islington Ave",
    ),
    Address(
      addressSubtitle: "618 102nd Avenue, Dawson Creek, British Columbia",
      addresstitle: "618 102nd Avenue",
    ),
    Address(
        addressSubtitle: "618 102nd Avenue, Toronto, Ontario",
        addresstitle: "4128 Tycos Dr")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 40.w,
        bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w) +
                EdgeInsets.only(
                  bottom: 10.h,
                ),
            child: Row(
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 10,
                    ),
                    SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        width: 20,
                        color: Colors.black,
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
                      Container(
                        color: Colors.grey.shade300,
                        child: TextFormField(
                          cursorColor: AppColors.grey500,
                          decoration: InputDecoration(
                            hintText: "Enter Pickup location",
                            hintStyle: AppText.text14w400.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.grey500,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      sizedBoxWithHeight(20),
                      Container(
                        color: Colors.grey.shade300,
                        child: TextFormField(
                          cursorColor: AppColors.grey500,
                          decoration: InputDecoration(
                            hintText: "Where to?",
                            hintStyle: AppText.text14w400.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.grey500,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxWithWidth(7),
                Container(
                  height: 30.h,
                  width: 30.w,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.greylight, shape: BoxShape.circle),
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(110.h),
        ),
        title: InkWell(
          onTap: () async {
            await showTopModalSheet<String?>(context, MembersSheet());
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
        leading: InkWell(
          onTap: () {
            AppEnvironment.navigator.pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ) +
            EdgeInsets.only(
              top: 16.h,
            ),
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
                      color: AppColors.greydark, shape: BoxShape.circle),
                ),
                sizedBoxWithWidth(10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saved Places",
                        style: AppText.text16w400.copyWith(
                          color: Colors.black,
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
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: addresslist.length,
              itemBuilder: (context, index) {
                return Row(
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
                          color: AppColors.greydark, shape: BoxShape.circle),
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
            Divider(
              thickness: 0.6,
              color: AppColors.greylight,
            ),
            sizedBoxWithHeight(10),
            Row(
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
                      color: AppColors.greydark, shape: BoxShape.circle),
                ),
                sizedBoxWithWidth(10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set location on map",
                        style: AppText.text16w400.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
