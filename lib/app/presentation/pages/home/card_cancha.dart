// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// //
// class CardCanchas extends StatefulWidget {
//   final Cancha laCancha;

//   const CardCanchas({super.key, required this.laCancha});

//   @override
//   State<CardCanchas> createState() => _CardCanchasState();
// }

// class _CardCanchasState extends State<CardCanchas> {
//   final dbCache = CacheDb();

//   final myFunc = Helpers();

//   @override
//   Widget build(BuildContext context) {
//     final ctrler = Provider.of<HomeCtrler>(context);

//     return Card(
//       color: Colors.green.shade100,
//       shadowColor: Colors.blueGrey.shade300,
//       elevation: 10.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//       child: Container(
//         margin: const EdgeInsets.all(5),
//         padding: const EdgeInsets.all(15),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Cancha: ${widget.laCancha.nombre}'),

//                 // Eliminar el elemento.
//                 InkWell(
//                   onTap: () async {
//                     // Confirmar
//                     final isDel = await myFunc.showAlert(
//                       context: context,
//                     );

//                     if (isDel) {
//                       // Afirmativo, se borra
//                       final nvoCache = ctrler.delItem(item: widget.laCancha);

//                       // Actualizar Cache.
//                       dbCache.canchas = nvoCache;
//                     }
//                   },
//                   child: const Image(
//                     image: AssetImage('assets/png/cancel.png'),
//                     height: 20,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//                 'Fecha agendada:  ${widget.laCancha.fecha.toString().substring(0, 10)} '),
//             const SizedBox(height: 10),
//             Text('Usuario: ${widget.laCancha.usuario}'),
//             const SizedBox(height: 10),
//             Text('Probabilidad de Lluvia: ${widget.laCancha.porcentaje} %'),
//           ],
//         ),
//       ),
//     );
//   }
// }
