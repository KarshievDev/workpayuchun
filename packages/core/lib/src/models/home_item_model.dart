import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeItems {
  static List<HomeItemModel> get getHomeItems {

    List<HomeItemModel> items = [];

    items.add(const HomeItemModel(
        icon: 'assets/images/directory.png',
        name: 'Directory',
        color: Colors.purple,
        type: ItemType.directory));
    items.add(const HomeItemModel(
        icon: 'assets/images/notice.png',
        name: 'Notice Board',
        color: Colors.amber,
        type: ItemType.notice));
    items.add(const HomeItemModel(
        icon: 'assets/images/event.png',
        name: 'Event Calendar',
        color: Colors.blue,
        type: ItemType.event));
    items.add(const HomeItemModel(
        icon: 'assets/images/ec.png',
        name: 'Central EC',
        color: Colors.brown,
        type: ItemType.ec));
    items.add(const HomeItemModel(
        icon: 'assets/images/act.png',
        name: 'Acts & regulations',
        color: Colors.grey,
        type: ItemType.acts));
    items.add(const HomeItemModel(
        icon: 'assets/images/call.png',
        name: 'Contacts',
        color: Colors.deepOrange,
        type: ItemType.contacts));
    items.add(const HomeItemModel(
        icon: 'assets/images/search.png',
        name: 'Donation',
        color: Colors.indigo,
        type: ItemType.donation));
    items.add(const HomeItemModel(
        icon: 'assets/images/profile.png',
        name: 'My Profile',
        color: Colors.cyanAccent,
        type: ItemType.profile));
    items.add(const HomeItemModel(
        icon: 'assets/images/anniversary.png',
        name: 'Anniversary',
        color: Colors.orange,
        type: ItemType.anniversary));
    items.add(const HomeItemModel(
        icon: 'assets/images/birthday.png',
        name: 'Birthday',
        color: Colors.yellow,
        type: ItemType.birthday));
    items.add(const HomeItemModel(
        icon: 'assets/images/gallery.png',
        name: 'Gallery',
        color: Colors.cyan,
        type: ItemType.gallery));
    items.add(const HomeItemModel(
        icon: 'assets/images/event.png',
        name: 'More',
        color: Colors.cyan,
        type: ItemType.more));
    return items;
  }

  static List<HomeItemModel> get getHomeItemsWithPaddingList {
    List<HomeItemModel> items = [];

    items.add(const HomeItemModel(
        icon: 'assets/images/directory.png',
        name: 'Directory',
        color: Colors.purple,
        type: ItemType.directory));
    items.add(const HomeItemModel(
        icon: 'assets/images/notice.png',
        name: 'Notice Board',
        color: Colors.amber,
        type: ItemType.notice));
    items.add(const HomeItemModel(
        icon: 'assets/images/event.png',
        name: 'Event Calendar',
        color: Colors.blue,
        type: ItemType.event));
    items.add(const HomeItemModel(
        icon: 'assets/images/ec.png',
        name: 'Central EC',
        color: Colors.brown,
        type: ItemType.ec));
    items.add(const HomeItemModel(
        icon: 'assets/images/act.png',
        name: 'Acts & regulations',
        color: Colors.grey,
        type: ItemType.acts));
    items.add(const HomeItemModel(
        icon: 'assets/images/call.png',
        name: 'Contacts',
        color: Colors.deepOrange,
        type: ItemType.contacts));
    // items.add(const HomeItemModel(
    //     icon: 'assets/images/search.png',
    //     name: 'Donation',
    //     color: Colors.indigo,
    //     type: ItemType.donation));
    items.add(const HomeItemModel(
        icon: 'assets/images/profile.png',
        name: 'My Profile',
        color: Colors.cyanAccent,
        type: ItemType.profile));
    items.add(const HomeItemModel(
        icon: 'assets/images/anniversary.png',
        name: 'Anniversary',
        color: Colors.orange,
        type: ItemType.anniversary));
    items.add(const HomeItemModel(
        icon: 'assets/images/birthday.png',
        name: 'Birthday',
        color: Colors.yellow,
        type: ItemType.birthday));
    items.add(const HomeItemModel(
        icon: 'assets/images/gallery.png',
        name: 'Gallery',
        color: Colors.cyan,
        type: ItemType.gallery));
    items.add(const HomeItemModel(
        icon: 'assets/images/notice.png',
        name: 'pending request',
        color: Colors.red,
        type: ItemType.pendingRequest));
    items.add(const HomeItemModel(
        icon: 'assets/images/event.png',
        name: 'More',
        color: Colors.cyan,
        type: ItemType.more));
    return items;
  }
}

enum ItemType {
  directory,
  notice,
  event,
  ec,
  acts,
  anniversary,
  contacts,
  donation,
  faculty,
  profile,
  birthday,
  gallery,
  more,
  pendingRequest
}

class HomeItemModel extends Equatable {
  const HomeItemModel(
      {required this.name,
      required this.icon,
      required this.color,
      required this.type});

  final String name;
  final String icon;
  final Color color;
  final ItemType type;

  factory HomeItemModel.fromJson(Map<String, dynamic> json) => HomeItemModel(
      name: json["name"],
      icon: json["icon"],
      color: json["color"],
      type: ItemType.contacts);

  Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon,
        "color": color,
      };

  @override
  List<Object?> get props => [name, icon, color, type];
}
