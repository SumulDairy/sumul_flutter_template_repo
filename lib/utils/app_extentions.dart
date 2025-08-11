import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/utils/app_enums.dart';

//Font Weight
extension PoppinsWeightExtension on PoppinsWeight {
  FontWeight get weight {
    switch (this) {
      case PoppinsWeight.thin100:
        return FontWeight.w100;
      case PoppinsWeight.extraLight200:
        return FontWeight.w200;
      case PoppinsWeight.light300:
        return FontWeight.w300;
      case PoppinsWeight.regular400:
        return FontWeight.w400;
      case PoppinsWeight.medium500:
        return FontWeight.w500;
      case PoppinsWeight.semiBold600:
        return FontWeight.w600;
      case PoppinsWeight.bold700:
        return FontWeight.w700;
      case PoppinsWeight.extraBold800:
        return FontWeight.w800;
      case PoppinsWeight.black900:
        return FontWeight.w900;
    }
  }
}

//Color Converter
extension HexColorExtension on String {
  Color toColor() {
    final hex = replaceAll("#", "");
    final formatted = hex.length == 6 ? "FF$hex" : hex;
    return Color(int.parse("0x$formatted"));
  }
}

//Main Category

extension MainCategoryExtension on MainCategoryEnum {
  static MainCategoryEnum? fromString(String value) {
    switch (value.toLowerCase()) {
      case 'dairy product':
        return MainCategoryEnum.dairyProduct;
      case 'bakery':
        return MainCategoryEnum.bakery;
      default:
        return MainCategoryEnum.milk;
    }
  }

  String get shortCode {
    switch (this) {
      case MainCategoryEnum.milk:
        return "M";
      case MainCategoryEnum.dairyProduct:
        return "DP";
      case MainCategoryEnum.bakery:
        return "BK";
    }
  }

  String get displayName {
    switch (this) {
      case MainCategoryEnum.milk:
        return "Milk";
      case MainCategoryEnum.dairyProduct:
        return "Dairy Product";
      case MainCategoryEnum.bakery:
        return "Bakery";
    }
  }
}

//pouch and Crates Unit
extension UnitTypeEnumExtension on UnitTypeEnum {
  String get code {
    switch (this) {
      case UnitTypeEnum.pouch:
        return "2";
      case UnitTypeEnum.crates:
        return "1";
    }
  }

  String get displayName {
    switch (this) {
      case UnitTypeEnum.pouch:
        return "pouch".tr;
      case UnitTypeEnum.crates:
        return "crates".tr;
    }
  }
}

UnitTypeEnum getUnitTypeFromCustType(String? custType) {
  switch (custType?.toUpperCase()) {
    case 'AGN':
      return UnitTypeEnum.pouch;
    default:
      return UnitTypeEnum.crates; // fallback default
  }
}

UnitTypeEnum getUnitTypeFromIndex(String? index) {
  switch (index) {
    case '1':
      return UnitTypeEnum.crates;
    default:
      return UnitTypeEnum.pouch; // fallback default
  }
}

//Menu
extension MenuEnumExtension on MenuEnum {
  String get title {
    switch (this) {
      case MenuEnum.orderManagement:
        return 'Order Management';
      case MenuEnum.orderHistory:
        return 'Order History';
      case MenuEnum.cashManagement:
        return 'Cash Management';
      case MenuEnum.reports:
        return 'Reports';
    }
  }
}

//Status
extension StatusExtension on CashStatusEnum {
  String get displayName {
    switch (this) {
      case CashStatusEnum.pending:
        return "pending".tr;
      case CashStatusEnum.completed:
        return "completed".tr;
      case CashStatusEnum.cancel:
        return "cancel".tr;
    }
  }
}

String getCashStatusFromIndex(int? index) {
  switch (index) {
    case 0:
      return CashStatusEnum.pending.displayName;
    case 1:
      return CashStatusEnum.completed.displayName;
    case 2:
      return CashStatusEnum.cancel.displayName;
    default:
      return CashStatusEnum.pending.displayName;
  }
}

//Month wise Extention
extension MonthExtension on MonthEnum {
  String get displayName {
    switch (this) {
      case MonthEnum.april:
        return 'April';
      case MonthEnum.may:
        return 'May';
      case MonthEnum.june:
        return 'June';
      case MonthEnum.july:
        return 'July';
      case MonthEnum.august:
        return 'August';
      case MonthEnum.september:
        return 'September';
      case MonthEnum.october:
        return 'October';
      case MonthEnum.november:
        return 'November';
      case MonthEnum.december:
        return 'December';
      case MonthEnum.january:
        return 'January';
      case MonthEnum.february:
        return 'February';
      case MonthEnum.march:
        return 'March';
    }
  }
}

extension ShiftEnumExtension on ShiftEnum {
  String get displayName {
    switch (this) {
      case ShiftEnum.M:
        return 'Morning';
      case ShiftEnum.E:
        return 'Evening';
      case ShiftEnum.G:
        return 'GatePass';
      case ShiftEnum.T:
        return 'Extra';
      case ShiftEnum.O:
        return 'Other';
    }
  }
}

extension DistOrderTypeEnumExtension on DistOrderTypeEnum {
  String get displayName {
    switch (this) {
      case DistOrderTypeEnum.summary:
        return 'Summary';
      case DistOrderTypeEnum.customerwise:
        return 'Customer Wise';
      case DistOrderTypeEnum.productwise:
        return 'Product Wise';
    }
  }

  String get type {
    switch (this) {
      case DistOrderTypeEnum.summary:
        return 'Summary';
      case DistOrderTypeEnum.customerwise:
        return 'Customer';
      case DistOrderTypeEnum.productwise:
        return 'Product';
    }
  }
}

extension CrateEnumExtension on CrateEnum {
  String get displayName {
    switch (this) {
      case CrateEnum.normalcrate:
        return 'Normal Crates';
      case CrateEnum.smallcrate:
        return 'Small Crates';
    }
  }

  String get type {
    switch (this) {
      case CrateEnum.normalcrate:
        return 'Normal';
      case CrateEnum.smallcrate:
        return 'Small';
    }
  }
}

//Month wise Extention
// extension GetMonthYearValueExtension on MonthYearEnum {
//   String get displayName {
//     switch (this) {
//       case MonthYearEnum.month:
//         return 'M';
//       case MonthYearEnum.year:
//         return 'Y';
//     }
//   }
// }
