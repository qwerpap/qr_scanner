import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QrCodeCreationData extends Equatable {
  const QrCodeCreationData({
    required this.contentType,
    required this.data,
    required this.color,
    this.title,
    this.hasLogo = false,
  });

  final String contentType; // 'url', 'text', 'wifi', 'contact'
  final String data;
  final Color color;
  final String? title;
  final bool hasLogo;

  @override
  List<Object?> get props => [contentType, data, color, title, hasLogo];
}

class WifiQrCodeData extends Equatable {
  const WifiQrCodeData({
    required this.ssid,
    required this.password,
    required this.securityType,
  });

  final String ssid;
  final String password;
  final String securityType; // 'WPA', 'WEP', 'None'

  @override
  List<Object?> get props => [ssid, password, securityType];
}

class ContactQrCodeData extends Equatable {
  const ContactQrCodeData({
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.organization,
  });

  final String name;
  final String? phone;
  final String? email;
  final String? address;
  final String? organization;

  @override
  List<Object?> get props => [name, phone, email, address, organization];
}
