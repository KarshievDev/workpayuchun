

import 'package:meta_club_api/meta_club_api.dart';

String? checkInStatusColor(DailyReport? dateWiseReport, String? checkInColor) {
  if (dateWiseReport?.checkInStatus == "OT") {
    checkInColor = "0xff46A44D"; //green Color
  } else if (dateWiseReport?.checkInStatus == "L") {
    checkInColor = "0xffF44336"; // red Color
  } else if (dateWiseReport?.checkInStatus == "A") {
    checkInColor = "0xff000000"; // Black Color
  } else if (dateWiseReport?.checkInStatus == "LT") {
    checkInColor = "0xff46A44D"; //green Color
  } else if (dateWiseReport?.checkInStatus == "LL") {
    checkInColor = "0xffFFC107"; // yellow Color
  } else {
    checkInColor = "0xff46A44D"; //green Color
  }
  return checkInColor;
}

String? checkOutStatusColor(DailyReport? dateWiseReport, String? checkOutColor) {
  if (dateWiseReport?.checkOutStatus == "OT") {
    checkOutColor = "0xff46A44D"; //green Color
  } else if (dateWiseReport?.checkOutStatus == "LE") {
    checkOutColor = "0xffF44336"; // red Color
  } else if (dateWiseReport?.checkOutStatus == "L") {
    checkOutColor = "0xffF44336"; // red Color
  } else if (dateWiseReport?.checkOutStatus == "A") {
    checkOutColor = "0xff000000"; // Black Color
  } else if (dateWiseReport?.checkOutStatus == "LT") {
    checkOutColor = "0xff46A44D"; //green Color
  } else if (dateWiseReport?.checkOutStatus == "LL") {
    checkOutColor = "0xffFFC107"; // yellow Color
  } else {
    checkOutColor = "0xff46A44D"; //green Color
  }
  return checkOutColor;
}