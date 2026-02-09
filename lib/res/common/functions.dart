
String getInOutColor({String? status}) {
  if (status == "OT") {
    return "0xff46A44D"; //green Color
  } else if (status == "L") {
    return "0xffF44336"; // red Color
  } else if (status == "A") {
    return "0xff000000"; // Black Color
  } else if (status == "LE") {
    return "0xffF44336"; // red Color
  } else if (status == "LT") {
    return "0xff46A44D"; //green Color
  } else if (status == "LL") {
    return "0xffFFC107"; // yellow Color
  } else {
    return "0xff46A44D"; //green Color
  }
}
