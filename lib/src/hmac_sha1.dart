
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class hmacsha extends StatefulWidget{
  @override
  State<hmacsha> createState() => _hmacshaState();
}

class _hmacshaState extends State<hmacsha> {
  @override
  void initState() {
    super.initState();
    var key = utf8.encode('password1234');
    var bytes = utf8.encode('woolhadotcom');

    var hmacSha1 = new Hmac(sha1, key);
    Digest sha1Result = hmacSha1.convert(bytes);
    print('SHA1: $sha1Result');




  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: SafeArea(
    child: Text(""),
  ),
);
  }
}