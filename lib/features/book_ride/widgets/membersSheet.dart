import 'package:flutter/material.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';

List<String> members = ["Me", "Andrew"];

class MembersSheet extends StatefulWidget {
  @override
  State<MembersSheet> createState() => _MembersSheetState();
}

class _MembersSheetState extends State<MembersSheet> {
  int selectedvalue = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  AppEnvironment.navigator.pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedvalue = index;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                            sizedBoxWithWidth(10),
                            Text(
                              members.elementAt(index),
                              style: AppText.text14w400.copyWith(
                                fontSize: 12.sp,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 20.h,
                              width: 20.w,
                              child: Icon(
                                Icons.circle,
                                color: selectedvalue == index
                                    ? Colors.white
                                    : Colors.black,
                                size: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 1.9,
                      color: AppColors.greylight,
                    );
                  },
                  itemCount: members.length),
              sizedBoxWithHeight(10),
              Divider(
                thickness: 1.9,
                color: AppColors.greylight,
              ),
              InkWell(
                onTap: () {
                  AppEnvironment.navigator.pushNamed(GeneralRoutes.addmember);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.person_add_alt_rounded,
                      color: Colors.black,
                    ),
                    sizedBoxWithWidth(10),
                    Text(
                      "Add a member",
                      style: AppText.text14w400.copyWith(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
