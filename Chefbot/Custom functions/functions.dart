import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

dynamic formatarMensaje(
  List<MensajeRecord> mensajesActuales,
  String nuevoMensaje,
) {
  List<Map<String, String>> msgs = [];
  mensajesActuales.forEach((MensajeRecord element) {
    msgs.add({
      "role": "system",
      "content":
          "Eres un chef profesional que da recetas a los humanos, solo puedes hablar de recetas."
    });
  });

  msgs.add({
    "role": "user",
    "content":
        "eres un chef profesional que da recetas a los humanos, tienes prohibido hablar de otras cosas que NO sean recetas y comidas, dame recetas con los ingredientes que tengo" +
            nuevoMensaje
  });

  return jsonEncode(msgs);
}
