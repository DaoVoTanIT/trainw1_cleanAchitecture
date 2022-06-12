import 'dart:io';
import 'package:flutter/material.dart';

const keyLocalStore = "findroomApp";
const formatDateTimeString = "HH:mm dd-MM-yyyy";
const formatHourMinuteString = "HH:mm";
const formatDateString = "dd-MM-yyyy";
const apikeyGoogleMap = "AIzaSyAOzmhiNCy9ecozAQ_-M2p39R3DYBKPO1Y";
const timeoutfirebase = 10;
bool noInternet = false;
const String noImgUrl =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png";

extension FileExtention on FileSystemEntity {
  String? get name {
    return this.path.split("/").last.split(".").last;
  }
}

enum FormAction {
  view,
  create,
  edit,
  delete,
  reUse,
  stopUsing,
  view_waranty,
  create_waranty,
  view_repair,
  create_repair
}
