import 'package:flutter/material.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';

class AddHomeAndWork extends StatefulWidget {
  const AddHomeAndWork({super.key});

  @override
  State<AddHomeAndWork> createState() => _AddHomeAndWorkState();
}

class _AddHomeAndWorkState extends State<AddHomeAndWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          16.r,
        ),
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade300,
              child: TextFormField(
                cursorColor: AppColors.grey500,
                decoration: InputDecoration(
                  hintText: "Enter location",
                  hintStyle: AppText.text14w400.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.grey500,
                  ),
                  suffixIcon: Icon(
                    Icons.close,
                  ),
                  contentPadding: EdgeInsets.only(
                        left: 10.w,
                      ) +
                      EdgeInsets.symmetric(vertical: 15),
                  border: InputBorder.none,
                ),
              ),
            ),
            // sizedBoxWithHeight(40),
            // ListView.separated(
            //   shrinkWrap: true,
            //   primary: false,
            //   itemCount: addresslist.length,
            //   itemBuilder: (context, index) {
            //     return Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Container(
            //           height: 50.h,
            //           width: 50.w,
            //           child: Icon(
            //             Icons.access_time_filled_sharp,
            //             color: Colors.white,
            //             size: 30,
            //           ),
            //           decoration: BoxDecoration(
            //               color: AppColors.greydark, shape: BoxShape.circle),
            //         ),
            //         sizedBoxWithWidth(10),
            //         Flexible(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 addresslist.elementAt(index).addresstitle,
            //                 style: AppText.text16w400.copyWith(
            //                   color: AppColors.black,
            //                 ),
            //               ),
            //               Text(
            //                 addresslist.elementAt(index).addressSubtitle,
            //                 maxLines: 2,
            //                 overflow: TextOverflow.ellipsis,
            //                 style: AppText.text14w400.copyWith(
            //                   color: AppColors.grey500,
            //                   fontSize: 13.sp,
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            //   separatorBuilder: (c, i) {
            //     return Divider(
            //       thickness: 0.6,
            //       color: AppColors.greylight,
            //     );
            //   },
            // ),
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
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RidePickup(),
                    //   ),
                    // );
                  },
                  child: Column(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
