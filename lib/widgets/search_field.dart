import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_image_assets.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/widgets/common_text.dart';
import 'package:sumul_transport/common/functions.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonSearchField extends StatelessWidget {
  final String? title;
  final TextEditingController controller;
  final List<dynamic> suggestions;
  final String? displayKey;
  final String hintText;
  final void Function(SearchFieldListItem<dynamic>)? onItemSelected;
  final bool isFilled;
  final bool? isSuffix;
  final bool? removeClose;
  final bool? isReadOnly;
  final Color fillColor;
  final Color textColor;
  final void Function()? cancelClick;

  // final RxList<VehicleResponseData>? allvehicleLists;

  const CommonSearchField({
    super.key,
    required this.controller,
    required this.suggestions,
    this.displayKey,
    required this.hintText,
    this.title,
    this.onItemSelected,
    this.isFilled = true,
    this.isSuffix,
    this.fillColor = Colors.transparent,
    this.cancelClick,
    this.textColor = AppColor.blackColor,
    this.removeClose,
    this.isReadOnly = false,
    // this.allvehicleLists,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Column(
              children: [
                if (!AllFunction.isStringNullOrEmptyOrBlank(displayKey ?? ""))
                  AllFunction.commonPopinsText("$displayKey"),
                SearchField<dynamic>(
                  enabled: true,

                  textAlign: TextAlign.center,
                  controller: controller,
                  inputType: TextInputType.number,

                  suggestions: suggestions
                      .map((e) => SearchFieldListItem<dynamic>(e.toString()))
                      .toList(),
                  suggestionItemDecoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColor.lightGreyColor),
                    ),
                  ),
                  suggestionState: Suggestion.expand,
                  textInputAction: TextInputAction.next,
                  readOnly: isReadOnly ?? false,
                  suggestionsDecoration: SuggestionDecoration(
                    color: AppColor.whiteColor, // ✅ Set your desired color here
                    borderRadius: Sizer.radius(Sizer.s12),
                  ),
                  suggestionStyle: commonTextStyle(
                    fontSize: Sizer.font(Sizer.s14),
                  ),

                  searchInputDecoration: SearchInputDecoration(
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderRadius: Sizer.radius(Sizer.s12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: Sizer.radius(Sizer.s12),
                      borderSide: BorderSide(color: AppColor.lightGreyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: Sizer.radius(Sizer.s12),
                      borderSide: BorderSide(
                        color: AppColor.lightGreyColor,
                        width: 2,
                      ),
                    ),
                    searchStyle: commonTextStyle(
                      fontSize: Sizer.font(Sizer.s14),
                    ),
                    hintStyle: commonTextStyle(
                      fontSize: Sizer.s14,
                      color: AppColor.primaryColor,
                    ),
                    filled: isFilled,

                    fillColor: fillColor,
                  ),
                  onSuggestionTap: onItemSelected,

                  // (item) {
                  //   // controller.text = item.item ?? '';
                  //   // final matched = castedSuggestions.where(
                  //   //   (e) => e[displayKey] == item.item,
                  //   // );
                  //   // if (matched.isNotEmpty) {
                  //   //   onItemSelected?.call(matched.first);
                  //   // }
                  // },
                ),
              ],
            ),

            if ((!AllFunction.isStringNullOrEmptyOrBlank(controller.text)) &&
                !(removeClose ?? false))
              Positioned(
                left: 10,
                child:
                    Padding(
                      padding: Sizer.paddingOnly(right: Sizer.s12),
                      child: Icon(Icons.close, color: AppColor.primaryColor),
                    ).onTap(() {
                      cancelClick?.call(); // afe way to call nullable function
                    }),
              ),

            if (isSuffix ?? false)
              Positioned(
                right: 10,
                child:
                    Padding(
                      padding: Sizer.paddingOnly(right: Sizer.s12),
                      child: Image.asset(
                        ImageConstants.imgDropArrow,
                        color: AppColor.primaryColor,
                        height: Sizer.s10,
                      ),
                    ).onTap(() {
                      // cancelClick?.call(); // afe way to call nullable function
                    }),
              ),
          ],
        ),
      ],
    );
  }
}
