import 'dart:async';
import 'dart:io' as io;

//
import 'package:flutter/material.dart';
// import 'package:another_flushbar/flushbar.dart';

class Andy {
  // Old Pattern
  // static const String patternCorreo =
  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  // static const String patternPass =
  //     r'^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{6,10}$';

  static const String patternCorreo =
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

  static const String patternPass =
      r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$";

  static const String patternTel = r'^[0-9]{10}$';

  // static final CacheDb _dbCache = CacheDb();

/*  Devuelvo dimensiones de pantalla deacuerdo al context
    que recibo
*/

  static Size thisScreen({required Size hw}) {
    if (hw.height < 640) {
      return Size(hw.width, hw.height);
    } else {
      return Size(360 + (hw.width - 355.0), 640 + (hw.height - 630.0));
    }
    // return Size(thisWidth, 640 + (hw.height - 630.0));
  }

  /* ************************************************************
      Retorno fecha y hora junto solo numeros.
  ************************************************************** */
  static String getStringFechaHora() {
    final fecha = DateTime.now();
    final ret = fecha.toString().replaceAll(RegExp(r'([:. -])'), '');
    return ret;
  }

  /* ************************************************************
      Muestra un snack bar, diferente
  ************************************************************** */

  static SnackBar getSimpleSnack({
    required String msg,
    required Color elColor,
    required int elTiempo,
  }) {
    return SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: elTiempo),
      backgroundColor: elColor,
      margin: const EdgeInsets.only(bottom: 20),
      showCloseIcon: true,
      content: Row(
        children: [
          const Icon(Icons.report, size: 35),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              msg,
              style: const TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }

  // static Flushbar<dynamic> getBigSnack({
  //   required String titulo,
  //   required String mensaje,
  //   required int duracion,
  //   required String isOk,
  // }) {
  //   return Flushbar(
  //     icon: isOk == 'ok'
  //         ? Icon(Icons.check_circle, color: Colors.green.shade50, size: 80)
  //         : const Icon(Icons.report, color: Colors.black, size: 80),
  //     title: titulo,
  //     titleColor: Colors.black,
  //     message: mensaje,
  //     messageColor: Colors.black,
  //     messageSize: 20.0,
  //     borderWidth: 3.5,
  //     isDismissible: true,
  //     duration: Duration(seconds: duracion),
  //     animationDuration: const Duration(milliseconds: 350),
  //     dismissDirection: FlushbarDismissDirection.HORIZONTAL,
  //     backgroundColor:
  //         isOk == 'ok' ? Colors.green.shade200 : Colors.yellow.shade600,
  //     leftBarIndicatorColor:
  //         isOk == 'ok' ? Colors.green : Colors.yellow.shade600,
  //     borderColor: isOk == 'ok' ? Colors.green : Colors.yellow.shade600,
  //     padding: const EdgeInsets.only(left: 35.0, right: 0, top: 10, bottom: 20),
  //     forwardAnimationCurve: Curves.easeInQuad,
  //   );
  // }

  /* ************************************************************
      Retorna un widget con una imagen de no imagen con un cover
  ************************************************************** */
  static Widget showImage({required String pathImagen}) {
    if (pathImagen == '') {
      return const Image(
        image: AssetImage('assets/png/noimagen.png'),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    }

    // if (picture.startsWith('http'))
    //   return FadeInImage(
    //     image: NetworkImage(this.url!),
    //     placeholder: AssetImage('assets/animations/imgloading.gif'),
    //     fit: BoxFit.cover,
    //   );

    return Image.file(
      io.File(pathImagen),
      fit: BoxFit.cover,
    );
  }

  /* ************************************************************
      Retorno el path final
  ************************************************************** */
  static Future<String> getFinalPath({
    required List<String> oldPath,
    required String imagen,
  }) async {
    String finalPath = '';
    String archivo = '';

    for (var i = 0; i < oldPath.length - 1; i++) {
      if (oldPath[i] != '') {
        finalPath = '$finalPath/${oldPath[i]}';
      }
    }

    await io.Directory(finalPath).exists().then((value) {
      if (value) {
        archivo = finalPath + imagen;
      }
    });
    return archivo;
  }

  /* ************************************************************
      Retorno Borrar el cache de imagenes
  ************************************************************** */
  static void borrarCacheImagen({
    required String path,
    required int tipo,
  }) async {
    var systemTempDir = io.Directory(
      getPathCache(
        cachePath: path.split('/'),
      ),
    );

    await for (var entity
        in systemTempDir.list(recursive: true, followLinks: false)) {
      if (tipo == 0) {
        if (entity.path.contains('.jpg')) {
          io.File(entity.path).delete();
        }
      } else if (tipo == 1) {
        if (entity.path.contains('image_picker')) {
          if (!entity.path.contains('scaled')) {
            io.File(entity.path).delete();
          }
        }
      }
    }
  }

  /* ************************************************************
      Retorno el path del cache actual
  ************************************************************** */
  static String getPathCache({required List<String> cachePath}) {
    String finalPath = '';
    for (var i = 0; i < cachePath.length - 1; i++) {
      if (cachePath[i] != '') {
        finalPath = '$finalPath/${cachePath[i]}';
      }
    }
    return finalPath;
  }

  //
}
