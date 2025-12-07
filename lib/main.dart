import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'screens/twitter_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';



// ========== FIREBASE IMPORTS ==========
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

// ========== MAIN CON FIREBASE ==========

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // AquÃ­ muy temprano
  runApp(const MyApp());
}
class BettingPage extends StatelessWidget { 


  // Ejemplo con datos reales y links directos de eventos actuales (estos links llevan a la secciÃ³n esports de 1xBet, reemplaza con links especÃ­ficos para cada partido si lo deseas)
  final List<Map<String, String>> matches = [
  {
    "teams": "Natus Vincere vs FaZe Clan",
    "datetime": "2025-11-13 18:00",
    "logoA": "https://liquipedia.net/commons/images/6/6e/Natus_Vincere_full_logo.png",
    "logoB": "https://liquipedia.net/commons/images/a/a7/FaZe_Clanlogo_profile.png",
    "bettingUrl": "https://1xbet.com/esports/match/3981619-natus-vincere-vs-faze-clan-csgo-blast-fall-2025",
  },
  {
    'teams': 'Team Liquid vs G2 Esports',
    'datetime': '2025-11-14 20:00',
    'logoA': 'assets/images/liquid.png',
    'logoB': 'assets/images/g2.png',
    'bettingUrl': 'https://1xbet.com/esports/match/3981620-team-liquid-vs-g2-esports-csgo-blast-fall-2025',
  },
  // Repite para los demÃ¡s...
];

  void _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir la URL: $url')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apuestas Esports 1xBet')),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return Slidable(
  key: ValueKey(match['teams']),
  endActionPane: ActionPane(
    motion: const ScrollMotion(),
    children: [
      SlidableAction(
        onPressed: (_) => _launchURL(context, match['bettingUrl']!),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: Icons.sports_esports,
        label: 'Apostar',
      ),
    ],
  ),
  child: Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    elevation: 5,
    margin: const EdgeInsets.only(bottom: 18),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              match['logoA']!,
              width: 32, height: 32,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              match['logoB']!,
              width: 32, height: 32,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
            ),
          ),
        ],
      ),
      title: Text(match['teams']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      subtitle: Text(match['datetime']!),
      trailing: Icon(Icons.swipe_right, color: Colors.green.shade700),
      onTap: () => _launchURL(context, match['bettingUrl']!),
    ),
  ),
);

        },
      ),
    );
  }
}


 

//const String NEWS_API_KEY = '8ece716a47e04f05a67354b5510bf72d';

// ========== MAPA DE BANDERAS ==========
const Map<String, String> banderaUrls = {
  'flag_kr': 'https://flagcdn.com/w40/kr.png',
  'flag_id': 'https://flagcdn.com/w40/id.png',
  'flag_in': 'https://flagcdn.com/w40/in.png',
  'flag_br': 'https://flagcdn.com/w40/br.png',
  'flag_us': 'https://flagcdn.com/w40/us.png',
  'flag_ph': 'https://flagcdn.com/w40/ph.png',
  'flag_th': 'https://flagcdn.com/w40/th.png',
  'flag_vn': 'https://flagcdn.com/w40/vn.png',
  'flag_my': 'https://flagcdn.com/w40/my.png',
  'flag_sg': 'https://flagcdn.com/w40/sg.png',
  'flag_jp': 'https://flagcdn.com/w40/jp.png',
  'flag_cn': 'https://flagcdn.com/w40/cn.png',
  'flag_es': 'https://flagcdn.com/w40/es.png',
  'flag_tr': 'https://flagcdn.com/w40/tr.png',
  'flag_fr': 'https://flagcdn.com/w40/fr.png',
  'flag_de': 'https://flagcdn.com/w40/de.png',
  'flag_gb': 'https://flagcdn.com/w40/gb.png',
  'flag_ru': 'https://flagcdn.com/w40/ru.png',
  'flag_ar': 'https://flagcdn.com/w40/ar.png',
  'flag_cl': 'https://flagcdn.com/w40/cl.png',
  'flag_mx': 'https://flagcdn.com/w40/mx.png',
};


   // ========== CSGO ==========
     
     
      class CsgoMajorInfo {
        final String mainTitle;
        final String subtitle;
        final String special;

        CsgoMajorInfo({required this.mainTitle, required this.subtitle, required this.special});
      }





// ========== LOL ==========
class Partido {
  final String hora;
  final String equipo1;
  final String equipo2;
  final String torneo;
  final String formato;
  final String logoEquipo1;
  final String logoEquipo2;
  final int? scoreEquipo1;
  final int? scoreEquipo2;
  final String? ganador;

  Partido({
    required this.hora,
    required this.equipo1,
    required this.equipo2,
    required this.torneo,
    required this.formato,
    required this.logoEquipo1,
    required this.logoEquipo2,
    this.scoreEquipo1,
    this.scoreEquipo2,
    this.ganador,
  });
}

// ========== CLASE NOTICIA ==========
class Noticia {
  final String titulo;
  final String descripcion;
  final String url;
  final String imagenUrl;
  final String fuente;
  final String fecha;
  final String juego;
  Noticia({
    required this.titulo,
    required this.descripcion,
    required this.url,
    required this.imagenUrl,
    required this.fuente,
    required this.fecha,
    required this.juego,
  });
}

// === WIDGET EQUIPO CON LOGO ===
class CampeonCard extends StatefulWidget {
  final String campeonNombre;
  final String campeonLogoUrl;
  final Color cardColor;
  final double borderWidth;

  const CampeonCard({
    Key? key,
    required this.campeonNombre,
    required this.campeonLogoUrl,
    this.cardColor = const Color(0xFF181A27),
    this.borderWidth = 4.0,
  }) : super(key: key);

  @override
  State<CampeonCard> createState() => _CampeonCardState();
}



class _CampeonCardState extends State<CampeonCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 10, end: 30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 251, 11, 3).withOpacity(0.9),
                  blurRadius: _glowAnimation.value,
                  spreadRadius: widget.borderWidth,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: widget.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 21, 0),
                  width: widget.borderWidth,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 179, 179).withOpacity(0.5),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.campeonLogoUrl,
                      width: 68,
                      height: 68,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.emoji_events,
                        color: Color.fromARGB(255, 255, 0, 0),
                        size: 60,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Felicidades POR LA SEXTA ESTRELLA EN LOL ESPORTS!',
                          style: TextStyle(
                            color: const Color.fromARGB(197, 255, 17, 0),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: const Color.fromRGBO(255, 13, 0, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.campeonNombre,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 0, 0),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.amber.shade900,
                                blurRadius: 10,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EquipoConLogo extends StatelessWidget {
  final String nombreEquipo;
  final String urlLogo;

  const EquipoConLogo({
    Key? key,
    required this.nombreEquipo,
    required this.urlLogo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget csgoMajorCard(CsgoMajorInfo info) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withOpacity(0.7),
          blurRadius: 20,
          spreadRadius: 3,
        ),
      ],
    ),
    padding: const EdgeInsets.all(18.0),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset('assets/icons/csgo.png', height: 40), // Cambia la ruta a tu logo CS:GO
            SizedBox(width: 16),
            Text('CS:GO', style: TextStyle(fontSize: 28, color: Colors.amber, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8),
        Text(info.mainTitle, style: TextStyle(color: Colors.redAccent, fontSize: 20)),
        SizedBox(height: 8),
        Text(info.subtitle, style: TextStyle(color: Colors.white70, fontSize: 16)),
        SizedBox(height: 8),
        Text(info.special, style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.w500)),
      ],
    ),
  );
}
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (urlLogo.isNotEmpty)
          Image.network(
            urlLogo,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.sports_esports,
                size: 32,
                color: Color(0xFF2E3639),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 32,
                height: 32,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            },
          )
        else
          const Icon(
            Icons.sports_esports,
            size: 32,
            color: Colors.grey,
          ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            nombreEquipo,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}


// ========== WIDGET DIÃLOGO PARTIDOS ==========
class DialogoPartidos extends StatefulWidget {
  final Future<List<Partido>> partidosAPI;
  final List<String> opcionesLiga;
  final String filtroInicial;
  final String titulo;

  const DialogoPartidos({
    Key? key,
    required this.partidosAPI,
    required this.opcionesLiga,
    required this.filtroInicial,
    required this.titulo,
  }) : super(key: key);

  @override
  State<DialogoPartidos> createState() => _DialogoPartidosState();
}

class _DialogoPartidosState extends State<DialogoPartidos>
    with TickerProviderStateMixin {
  late String filtroLiga;
  late Future<List<Partido>> partidosFiltrados;
  late AnimationController pulseController;

  @override
  void initState() {
    super.initState();
    filtroLiga = widget.filtroInicial;
    partidosFiltrados = widget.partidosAPI;
    //infoMajorCsgo = fetchCsgoMajorInfo(); 
    pulseController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }
  
  

  @override
  void dispose() {
    pulseController.dispose();
    super.dispose();
  }

  bool esEnVivo(String horaInicio) {
    try {
      final inicio = DateTime.parse(horaInicio);
      final ahora = DateTime.now();
      final duracionPromedio = Duration(hours: 2);
      return ahora.isAfter(inicio) &&
          ahora.isBefore(inicio.add(duracionPromedio));
    } catch (e) {
      return false;
    }
  }

  bool partidoTerminado(String horaInicio) {
    try {
      final inicio = DateTime.parse(horaInicio);
      final ahora = DateTime.now();
      final duracionPromedio = Duration(hours: 2);
      return ahora.isAfter(inicio.add(duracionPromedio));
    } catch (e) {
      return false;
    }
  }

  String formatearHora(String horaISO) {
    try {
      if (horaISO == "Sin hora") return "Fecha por confirmar";
      final dateTime = DateTime.parse(horaISO).toLocal();
      return "${dateTime.day} ${nombreMes(dateTime.month)}, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return horaISO.isNotEmpty ? horaISO : "Fecha por confirmar";
    }
  }

  String nombreMes(int mes) {
    const meses = [
      "Ene",
      "Feb",
      "Mar",
      "Abr",
      "May",
      "Jun",
      "Jul",
      "Ago",
      "Sep",
      "Oct",
      "Nov",
      "Dic"
    ];
    return meses[mes - 1];
  }

  @override
Widget build(BuildContext context) {
    Future<CsgoMajorInfo> fetchCsgoMajorInfo() async {
  await Future.delayed(const Duration(seconds: 1));
  return CsgoMajorInfo(
    mainTitle: 'Camino a la Major',
    subtitle: 'PrÃ³xima parada: CS:GO Major',
    special: 'Equipo destacado: TBA',
  );
}


  return FutureBuilder<List<Partido>>(
    future: partidosFiltrados,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.titulo,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,        // <-- antes seguro era negro/por defecto
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                tooltip: "Cerrar",
              ),
              ],
          ),
          content: Center(child: CircularProgressIndicator()),
        );
      } else if (snapshot.hasError) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.titulo),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                tooltip: "Cerrar",
              ),
            ],
          ),
          content: Text("Error: ${snapshot.error}"),
        );
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.titulo,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,        // <-- antes seguro era negro/por defecto
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                tooltip: "Cerrar",
              ),
              ],
          ),
          content: Text("No hay eventos disponibles"),
        );
      }

      final todosPartidos = snapshot.data!;
      final partidos = todosPartidos.where((p) {
        if (filtroLiga == "Todos") return true;
        return p.torneo.toLowerCase().contains(filtroLiga.toLowerCase());
      }).toList();

      return AlertDialog(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.titulo,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,        
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              tooltip: "Cerrar",
            ),
            if (widget.opcionesLiga.length > 1) ...[
              SizedBox(width: 8),
              DropdownButton<String>(
                value: filtroLiga,
                underline: Container(),
                items: widget.opcionesLiga
                    .map((opcion) => DropdownMenuItem(
                          value: opcion,
                          child: Text(opcion, style: TextStyle(fontSize: 14,color: Colors.white70)),
                        ))
                    .toList(),
                onChanged: (nuevoValor) {
                  setState(() {
                    filtroLiga = nuevoValor!;
                  });
                },
              ),
            ],
          ],
        ),
         content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            
            shrinkWrap: true,
            itemCount: partidos.length,
            itemBuilder: (context, index) {
              final p = partidos[index];
              final terminado = partidoTerminado(p.hora);
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: terminado ? Colors.grey[200] : null,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              formatearHora(p.hora),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: terminado ? Colors.grey[600] : null,
                              ),
                            ),
                          ),
                          if (esEnVivo(p.hora))
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FadeTransition(
                                    opacity: pulseController,
                                    child: Icon(Icons.circle,
                                        color: Colors.white, size: 6),
                                  ),
                                  SizedBox(width: 4),
                                  Text("EN VIVO",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          else if (terminado)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text("FINALIZADO",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      
                      // ========== SECCIÃ“N CON RESULTADOS (MODIFICADA) ==========
                      if (p.equipo1.isNotEmpty && p.equipo2.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Equipo 1 con score
                            Expanded(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: EquipoConLogo(
                                      nombreEquipo: p.equipo1,
                                      urlLogo: p.logoEquipo1,
                                    ),
                                  ),
                                  // Mostrar score del equipo 1 si existe
                                  if (p.scoreEquipo1 != null) ...[
                                    SizedBox(width: 8),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: p.ganador == p.equipo1
                                            ? Colors.green[100]
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: p.ganador == p.equipo1
                                              ? Colors.green[700]!
                                              : Colors.grey[500]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        '${p.scoreEquipo1}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: p.ganador == p.equipo1
                                              ? Colors.green[900]
                                              : Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            
                            // VS en el medio
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "VS",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            
                            // Equipo 2 con score
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Mostrar score del equipo 2 si existe
                                  if (p.scoreEquipo2 != null) ...[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: p.ganador == p.equipo2
                                            ? Colors.green[100]
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: p.ganador == p.equipo2
                                              ? Colors.green[700]!
                                              : Colors.grey[500]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        '${p.scoreEquipo2}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: p.ganador == p.equipo2
                                              ? Colors.green[900]
                                              : Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                  Flexible(
                                    child: EquipoConLogo(
                                      nombreEquipo: p.equipo2,
                                      urlLogo: p.logoEquipo2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      // ========== FIN SECCIÃ“N CON RESULTADOS ==========
                      
                      const SizedBox(height: 6),
                      Text(p.torneo,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      Text(p.formato,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

}

// ========== APP PRINCIPAL CON FIREBASE ==========
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esports Sync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF00D9FF),
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.bebasNeueTextTheme(),
    ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const MyHomePage(title: 'Esports Sync'),
      },
      home: StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Scaffold(
        backgroundColor: Color(0xFF1a1a2e),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF00d9ff))),
        
      );
    }
    if (snapshot.hasData) {
      return const MyHomePage(title: "Esports Sync");
    }
    return const LoginScreen();
  },
)


    );
  }
}

// ========== PÃGINA PRINCIPAL (TU APP COMPLETA) ==========
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  
  
  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

 //--------------CSGO--------------------------



//-----------------------------------------------
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  
  
  // ==== VARIABLES DE ESTADO AQUÃ ====
  final PageController pageController = PageController();
  int currentPage = 0;

  int _selectedIndex = 0;
 
 
  //--------------CSGO--------------------------
late Future<CsgoMajorInfo> infoMajorCsgo;
Future<CsgoMajorInfo> fetchCsgoMajorInfo() async {
  await Future.delayed(const Duration(seconds: 1));
  return CsgoMajorInfo(
    mainTitle: 'Camino a la Major',
    subtitle: 'Próxima parada: CS:GO Major',
    special: 'Equipo destacado: TBA',
  );
}
  

  Widget csgoMajorCard(CsgoMajorInfo info, VoidCallback onTap) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.white.withOpacity(0.5),
      highlightColor: Colors.white.withOpacity(0.2),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.black, // color base por si no carga la imagen
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          image: const DecorationImage(
            image: AssetImage("assets/icons/fondocsgo2.jpg"), 
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black54, 
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Text(
            "CS:GO", 
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.8),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}


void mostrarDialogoCsgo(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Partidos CS:GO (demo)'),
      content: const Text('AquÃ­ luego mostraremos los partidos de la Major.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}


  

  Map<String, String> logosEquipos = {};
  Future<Map<String, String>> obtenerLogosValorant() async {
  final response = await http.get(Uri.parse("http://192.168.31.35:5000/api/v1/teams"));
  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    final equipos = decoded['data'] as List;
    Map<String, String> logos = {};
   for (var equipo in equipos) {
    if (equipo['logo'] != null) {
      logos[equipo['name'].trim().toLowerCase()] = equipo['logo'];
    }
    print('Nombres en logosEquipos: ${logos.keys.toList()}');
  }
    return logos;
  }
  return {};
}
void cargarLogosEquipos() async {
    logosEquipos = await obtenerLogosValorant();
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    cargarLogosEquipos();
    infoMajorCsgo = fetchCsgoMajorInfo();
    partidosLoL = obtenerPartidosLoL();
    partidosValorant = obtenerPartidosValorant();
    partidosFortnite = obtenerPartidosFortnite();
    noticias = obtenerNoticias();

    card1Controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    card2Controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    card3Controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
  
    card1Animation = Tween<Offset>(
      begin: Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: card1Controller,
      curve: Curves.easeOutCubic,
    ));

    card2Animation = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: card2Controller,
      curve: Curves.easeOutCubic,
    ));

    card3Animation = Tween<Offset>(
      begin: Offset(0.0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: card3Controller,
      curve: Curves.easeOutCubic,
    ));

    card1FadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: card1Controller,
      curve: Curves.easeIn,
    ));

    card2FadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: card2Controller,
      curve: Curves.easeIn,
    ));

    card3FadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: card3Controller,
      curve: Curves.easeIn,
    ));

    card1Controller.forward();
    Future.delayed(Duration(milliseconds: 200), () => card2Controller.forward());
    Future.delayed(Duration(milliseconds: 400), () => card3Controller.forward());
  }
    
       Future<List<Partido>> obtenerPartidosValorant() async {
  final logosEquipos = await obtenerLogosValorant();
  final response = await http.get(Uri.parse("http://192.168.31.35:5000/api/v1/matches"));
  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    final matches = decoded['data'] as List;
    List<Partido> partidos = [];
    for (var match in matches) {
      String equipo1 = match['teams'][0]['name'] ?? '';
      String equipo2 = match['teams'][1]['name'] ?? '';
      String equipo1Key = equipo1.trim().toLowerCase();
      String equipo2Key = equipo2.trim().toLowerCase();

      // Usa el Map de logos con nombres normalizados
      String logo1 = logosEquipos[equipo1Key] ?? '';
      String logo2 = logosEquipos[equipo2Key] ?? '';

      // ver la terminal para ver que nos trae de vuelta
      print("Equipo1: '$equipo1' (key: '$equipo1Key') | Logo1: $logo1");
      print("Equipo2: '$equipo2' (key: '$equipo2Key') | Logo2: $logo2");    

      partidos.add(Partido(
        hora: match['utc'] ?? '',
        equipo1: equipo1,
        equipo2: equipo2,
        torneo: match['tournament'] ?? '',
        formato: 'Bo3',
        logoEquipo1: logo1,
        logoEquipo2: logo2,
        scoreEquipo1: match['teams'][0]['score'],
        scoreEquipo2: match['teams'][1]['score'],
        ganador: null,
      ));
    }
    return partidos;
  }
  return [];
}


  void _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir la URL: $url')),
      );
    }
  }
  late Future<List<Partido>> partidosLoL;
  String filtroLigaLoL = "Worlds";
  final List<String> opcionesLigaLoL = [
    "Worlds",
    "Todos",
    "LEC",
    "LCS",
    "LCK",
    "LPL"
  ];
  
  late Future<List<Partido>> partidosValorant;
  String filtroLigaValorant = "Todos";
  final List<String> opcionesLigaValorant = [
    "Todos",
    "VCT",
    "Champions",
    "Masters",
    "EMEA",
    "Americas",
    "Pacific"
  ];
  Future<List<Map<String, String>>> fetchMatches1xbet() async {
    final res = await http.get(Uri.parse(''));
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map<Map<String, String>>((item) => {
        'teams': item['teams']?.toString() ?? '',
        'datetime': item['datetime']?.toString() ?? '',
        'logoA': item['logoA']?.toString() ?? '',
        'logoB': item['logoB']?.toString() ?? '',
        'bettingUrl': item['bettingUrl']?.toString() ?? '',
      }).toList();
    }
    throw Exception("No se pudo cargar partidos");
  }

  


  late Future<List<Partido>> partidosFortnite;
  final List<String> opcionesLigaFortnite = ["Todos"];

  late Future<List<Noticia>> noticias;

  late AnimationController card1Controller;
  late AnimationController card2Controller;
  late AnimationController card3Controller;

  late Animation<Offset> card1Animation;
  late Animation<Offset> card2Animation;
  late Animation<Offset> card3Animation;

  late Animation<double> card1FadeAnimation;
  late Animation<double> card2FadeAnimation;
  late Animation<double> card3FadeAnimation;


// El mÃ©todo async:
  @override
  void dispose() {
    pageController.dispose();
    card1Controller.dispose();
    card2Controller.dispose();
    card3Controller.dispose();
    super.dispose();
  }
  
  


Widget buildApuestas1xbetTab(BuildContext context) {
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Text(
            "Apuestas 1xBet - Partidos de eSports Disponibles",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, String>>>(
            future: fetchMatches1xbet(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(
                  'Error cargando partidos de apuestas: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No hay partidos de apuestas disponibles'));
              }
              final matches = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return Slidable(
                    key: ValueKey(match['teams']),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) => _launchURL(context, match['bettingUrl']!),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.sports_esports,
                          label: 'Apostar',
                        ),
                      ],
                    ),
                    
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      elevation: 5,
                      margin: const EdgeInsets.only(bottom: 18),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                match['logoA']!,
                                width: 32, height: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                match['logoB']!,
                                width: 32, height: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
                              ),
                            ),
                          ],
                        ),
                        title: Text(match['teams']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        subtitle: Text(match['datetime']!),
                        trailing: Icon(Icons.swipe_right, color: Colors.green.shade700),
                        onTap: () => _launchURL(context, match['bettingUrl']!),
                      ),
                    ),
                    
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }


  Future<List<Partido>> obtenerPartidosLoL() async {
  const url =
      "https://esports-api.lolesports.com/persisted/gw/getSchedule?hl=es-MX";
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'x-api-key': '0TvQnueqKa5mxJntVWt0w4LpLfEkrV1Ta8rQBb9Z',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['data'] == null || data['data']['schedule'] == null) return [];

    final events = data['data']['schedule']['events'] as List;

    List<Partido> partidos = [];

    const baseUrl = 'https://esports-api.lolesports.com';

    for (var evento in events) {
      if (evento['match'] != null && evento['match']['teams'] != null) {
        final teams = evento['match']['teams'] as List;
        if (teams.length == 2) {
          final team1 = teams[0];
          final team2 = teams[1];

          // Corregir ruta de logo si es relativa
          String rutaLogo1 = team1['image'] ?? '';
          String rutaLogo2 = team2['image'] ?? '';

          String logo1 = rutaLogo1.startsWith('/')
              ? baseUrl + rutaLogo1
              : rutaLogo1;

          String logo2 = rutaLogo2.startsWith('/')
              ? baseUrl + rutaLogo2
              : rutaLogo2;
          
            print('Logo equipo 1 URL: $logo1');
            print('Logo equipo 2 URL: $logo2');


          partidos.add(Partido(
            hora: evento['startTime'] ?? "Sin hora",
            equipo1: team1['code'] ?? "Desconocido",
            equipo2: team2['code'] ?? "Desconocido",
            torneo: evento['league']?['name'] ?? "",
            formato: evento['blockName'] ?? "",
            logoEquipo1: logo1,
            logoEquipo2: logo2,
            scoreEquipo1: team1['result']?['gameWins'],
            scoreEquipo2: team2['result']?['gameWins'],
            ganador: team1['result']?['outcome'] == "win"
                ? team1['code']
                : team2['result']?['outcome'] == "win"
                    ? team2['code']
                    : null,
          ));
        }
      }
    }

    partidos.sort((a, b) => a.hora.compareTo(b.hora));
    return partidos;
  }
  return [];
}


  


  Future<List<Partido>> obtenerPartidosFortnite() async {
    final ahora = DateTime.now();

    List<Partido> eventos = [
      Partido(
        hora: "2025-09-06T16:00:00Z",
        equipo1: "",
        equipo2: "",
        torneo: "FNCS Global Championship 2025",
        formato: "33 Trios - \$2,001,000 USD",
        logoEquipo1: "",
        logoEquipo2: "",
        scoreEquipo1: null,
        scoreEquipo2: null,
        ganador: null,
      ),
    ];

    eventos = eventos.where((e) {
      try {
        final fecha = DateTime.parse(e.hora);
        return fecha.isAfter(ahora);
      } catch (_) {
        return true;
      }
    }).toList();

    return eventos;
  }

  Future<List<Noticia>> obtenerNoticias() async {
    print("[Noticias] Obteniendo noticias de esports...");
    final url =
        "";

    try {
      final response = await http.get(Uri.parse(url));
      print("[Noticias] StatusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['articles'] == null) {
          print("[Noticias] No hay artÃ­culos");
          return [];
        }

        final articulos = data['articles'] as List;
        print("[Noticias] Total artÃ­culos recibidos: ${articulos.length}");

        List<Noticia> noticias = [];

        for (var articulo in articulos) {
          if (articulo['title'] == null || articulo['title'] == "[Removed]") {
            continue;
          }

          noticias.add(Noticia(
            titulo: articulo['title'] ?? "Sin tÃ­tulo",
            descripcion: articulo['description'] ?? "Sin descripciÃ³n",
            url: articulo['url'] ?? "",
            imagenUrl: articulo['urlToImage'] ?? "",
            fuente: articulo['source']?['name'] ?? "Desconocido",
            fecha: articulo['publishedAt'] != null
                ? formatearFecha(articulo['publishedAt'])
                : "Fecha desconocida",
            juego: articulo['source']?['name'] ?? "Desconocido",
          ));
        }

        print("[Noticias] Total noticias filtradas: ${noticias.length}");
        return noticias;
      } else {
        print("[Noticias] Error: ${response.statusCode}");
        print("[Noticias] Respuesta: ${response.body}");
        return [];
      }
    } catch (e) {
      print("[Noticias] Exception: $e");
      return [];
    }
  }

  String formatearFecha(String fechaISO) {
    try {
      final dateTime = DateTime.parse(fechaISO).toLocal();
      final ahora = DateTime.now();
      final diferencia = ahora.difference(dateTime);

      if (diferencia.inDays == 0) {
        if (diferencia.inHours == 0) {
          return "Hace ${diferencia.inMinutes} minutos";
        }
        return "Hace ${diferencia.inHours} horas";
      } else if (diferencia.inDays < 7) {
        return "Hace ${diferencia.inDays} dÃ­as";
      } else {
        return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
      }
    } catch (e) {
      return fechaISO;
    }
  }

  Future<void> abrirURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print("[URL] No se pudo abrir: $url");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No se pudo abrir el enlace")),
          );
        }
      }
    } catch (e) {
      print("[URL] Error abriendo URL: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al abrir enlace")),
        );
      }
    }
  }

  void mostrarDialogoLoL(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return DialogoPartidos(
          partidosAPI: partidosLoL,
          opcionesLiga: opcionesLigaLoL,
          filtroInicial: filtroLigaLoL,
          titulo: "League of Legends",
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 0.3),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }

  void mostrarDialogoValorant(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return DialogoPartidos(
          partidosAPI: partidosValorant,
          opcionesLiga: opcionesLigaValorant,
          filtroInicial: filtroLigaValorant,
          titulo: "Valorant",
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 0.3),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }

  void mostrarDialogoFortnite(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return DialogoPartidos(
          partidosAPI: partidosFortnite,
          opcionesLiga: opcionesLigaFortnite,
          filtroInicial: "Todos",
          titulo: "Fortnite",
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 0.3),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }
  
@override
Widget build(BuildContext context) {
  // Usuario actual de Firebase
  final user = FirebaseAuth.instance.currentUser;

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/icons/iconapp.png',
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.sports_esports, size: 32);
          },
        ),
      ),
      title: Text(
        'Esports Syncs',
        style: GoogleFonts.bebasNeue(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle),
          tooltip: user?.email ?? 'Usuario',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Usuario'),
                content: Text(user?.email ?? 'No autenticado'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cerrar'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == 0 ? Colors.teal : Colors.grey[400],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == 1 ? Colors.teal : Colors.grey[400],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == 2 ? Colors.teal : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    ),

    // CUERPO CON PAGEVIEW
    body: PageView(
      controller: pageController,
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
          _selectedIndex = index;
        });
      },
      children: [
        buildPaginaInicio(),
        buildPaginaNoticias(),
        buildApuestas1xbetTab(context),
      ],
    ),

    // BOTTOM NAVIGATION BAR
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          currentPage = index;
        });
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Noticias'),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_esports),
          label: 'Apuestas',
        ),
      ],
    ),
  );
}



  Widget buildPaginaInicio() {
  return SingleChildScrollView( // 1) ahora toda la pÃ¡gina puede hacer scroll
    child: Column(
      children: [
        
        // Card de T1
        CampeonCard(
          campeonNombre: 'T1',
          campeonLogoUrl:
              'http://static.lolesports.com/teams/1726801573959_539px-T1_2019_full_allmode.png',
          cardColor: const Color.fromARGB(255, 0, 0, 0),
          borderWidth: 3.0,
        ),

        // ---- CONTENEDOR DE CARDS (LOL / VAL / CSGO / FN) ----
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // ---------------- DESKTOP / TABLET: ROW ----------------
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOL
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 2.0,
                        child: SlideTransition(
                          position: card1Animation,
                          child: FadeTransition(
                            opacity: card1FadeAnimation,
                            child: _buildGameCard(
                              context,
                              color: Colors.cyan,
                              title: "LOL ESPORTS",
                              imageAsset: "assets/icons/fondolol.jpg",
                              onTap: () => mostrarDialogoLoL(context),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // VALORANT
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 2.0,
                        child: SlideTransition(
                          position: card2Animation,
                          child: FadeTransition(
                            opacity: card2FadeAnimation,
                            child: _buildGameCard(
                              context,
                              color: const Color(0xFFFF4655),
                              title: "VALORANT",
                              imageAsset: "assets/icons/fondovct.jpg",
                              onTap: () => mostrarDialogoValorant(context),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // CSGO (USA FUTUREBUILDER)
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 2.0,
                        child: FutureBuilder<CsgoMajorInfo>(
                          future: infoMajorCsgo,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError ||
                                !snapshot.hasData) {
                              return const Card(
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    'Error cargando CS:GO',
                                    style: TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }

                            final info = snapshot.data!;

                            return Center(
                              child: SizedBox(
                                height: 160,
                                child: csgoMajorCard(
                                  info,
                                  () => mostrarDialogoCsgo(context),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // FORTNITE
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 2.0,
                        child: SlideTransition(
                          position: card3Animation,
                          child: FadeTransition(
                            opacity: card3FadeAnimation,
                            child: _buildGameCard(
                              context,
                              color: const Color(0xFF8B5CF6),
                              title: "FORTNITE",
                              imageAsset: "assets/icons/fondofncs.jpg",
                              onTap: () => mostrarDialogoFortnite(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // ---------------- MÃ“VIL: GRIDVIEW EN UNA COLUMNA ----------------
                return GridView.count(
                  crossAxisCount: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.3,
                  shrinkWrap: true, // 2) Para que tome solo el alto necesario
                  physics:
                      const NeverScrollableScrollPhysics(), // 3) El scroll lo maneja el SingleChildScrollView
                  children: [
                    // LOL
                    SlideTransition(
                      position: card1Animation,
                      child: FadeTransition(
                        opacity: card1FadeAnimation,
                        child: _buildGameCard(
                          context,
                          color: Colors.cyan,
                          title: "LOL ESPORTS",
                          imageAsset: "assets/icons/fondolol.jpg",
                          onTap: () => mostrarDialogoLoL(context),
                        ),
                      ),
                    ),

                    // VALORANT
                    SlideTransition(
                      position: card2Animation,
                      child: FadeTransition(
                        opacity: card2FadeAnimation,
                        child: _buildGameCard(
                          context,
                          color: const Color(0xFFFF4655),
                          title: "VALORANT",
                          imageAsset: "assets/icons/fondovct.jpg",
                          onTap: () => mostrarDialogoValorant(context),
                        ),
                      ),
                    ),

                    // FORTNITE
                    SlideTransition(
                      position: card3Animation,
                      child: FadeTransition(
                        opacity: card3FadeAnimation,
                        child: _buildGameCard(
                          context,
                          color: const Color(0xFF8B5CF6),
                          title: "FORTNITE",
                          imageAsset: "assets/icons/fondofncs.jpg",
                          onTap: () => mostrarDialogoFortnite(context),
                        ),
                      ),
                    ),

                    // CSGO EN MÃ“VIL
                    FutureBuilder<CsgoMajorInfo>(
                      future: infoMajorCsgo,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError || !snapshot.hasData) {
                          return const Card(
                            color: Colors.black,
                            child: Center(
                              child: Text(
                                'Error cargando CS:GO',
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }

                        final info = snapshot.data!;

                        return SizedBox(
                          height: 160,
                          child: csgoMajorCard(
                            info,
                            () => mostrarDialogoCsgo(context),
                           ),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}
  List<Noticia> noticiasManuales = [

    Noticia(
    titulo: "RAZORK will be Fnatic .",
    descripcion: "Jungler Razork ðŸ‡ªðŸ‡¸ will be Fnatic ðŸ‡¬ðŸ‡§'s starting jungler in the 2026 #LEC season",
    url: "https://x.com/Sheep_Esports/status/1993813247926128706",
    imagenUrl: "https://pbs.twimg.com/card_img/1993813249469587456/pfol0MbF?format=jpg&name=small",
    fuente: "Oficial",
    fecha: "26 Noviembre, 2025",
    juego: "LE"
  ),

    Noticia(
    titulo: "Toplaner Shelfmade ðŸ‡©ðŸ‡ª and Jungler Markoon ðŸ‡³ðŸ‡± are set to join G2 NORD ðŸ‡©ðŸ‡ª",
    descripcion: "",
    url: "https://www.sheepesports.com/en/articles/sources-shelfmade-and-markoon-set-to-join-g2-academy/en",
    imagenUrl: "https://pbs.twimg.com/card_img/1993823034470260736/HASL90-O?format=jpg&name=small", 
    fuente: "Oficial",
    fecha: "26 Noviembre, 2025",
    juego: "11 Noviembre, 2025",
  ),
    Noticia(
    titulo: "Delight ðŸ‡°ðŸ‡· will remain with Hanwha Life Esports.",
    descripcion: "Delight ðŸ‡°ðŸ‡· will remain with Hanwha Life Esports ðŸ‡°ðŸ‡· for LCK 2026, as confirmed by the organization.",
    url: "https://www.sheepesports.com/en/articles/lol-lck-delight-re-signs-with-hanwha-life-esports/en",
    imagenUrl: "https://pbs.twimg.com/media/G6RVM7DWoAAl_4h?format=jpg&name=large", 
    fuente: "Oficial",
    fecha: "21 Noviembre, 2025",
    juego: "11 Noviembre, 2025",
  ),
  
  Noticia(
    titulo: "Dplus KIA ðŸ‡°ðŸ‡· has officially announced the signing of its new AD Carry, Smash ðŸ‡°ðŸ‡·",
    descripcion: "Dplus KIA ðŸ‡°ðŸ‡· has officially announced the signing of its new AD Carry, Smash ðŸ‡°ðŸ‡·.",
    url: "https://x.com/Sheep_Esports/status/1991810038793744836",
    imagenUrl: "https://pbs.twimg.com/media/G6RT9FEXgAAl7aP?format=jpg&name=4096x4096", 
    fuente: "OFFICIAL",
    fecha: "21 Noviembre, 2025",
    juego: "11 Noviembre, 2025",
  ),
  Noticia(
    titulo: "GUMAYUSI OUT OF T1",
    descripcion: "Se esperan cambios importantes en campeones y jugabilidad.",
    url: "https://x.com/T1LoL/status/1990389461771816974",
    imagenUrl: "https://pbs.twimg.com/media/G59CCtVa0AAAgNI?format=jpg&name=large", 
    fuente: "OFFICIAL",
    fecha: "17 Noviembre, 2025",
   juego: "11 Noviembre, 2025",
  ),
  Noticia(
    titulo: "KEZNIT cerca de ENVY",
    descripcion: "Reporte de @AkamaruVal,Keznit sera el duelista en lugar de Canezerra (menor de edad) y jugarÃ¡ con Eggsterr, Inspire y P0PPIN a falta de cerrar el quinto. Vuelve el Deus.",
    url: "https://x.com/Lembo006/status/1988370535513027086",
    imagenUrl: "https://pbs.twimg.com/media/G5haSxRWoAAfcUm?format=jpg&name=900x900", 
    fuente: "RUMORS",
    fecha: "11 Noviembre, 2025",
    juego: "11 Noviembre, 2025",
  ),
  
  
];

  
  Widget buildPaginaNoticias() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Noticias y Rumores",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: noticiasManuales.length,
              itemBuilder: (context, index) {
                final noticia = noticiasManuales[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Si tienes imagen
                      noticia.imagenUrl.isNotEmpty
                          ? Image.network(noticia.imagenUrl,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 200,
                                color: Colors.grey[300],
                                child: Center(
                                  child: Icon(Icons.newspaper, size: 50, color: Colors.grey),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(noticia.fuente,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(noticia.fecha,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis)),
                                ),
                                Icon(Icons.open_in_new, size: 16, color: Colors.grey),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(noticia.titulo,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(height: 8),
                            Text(noticia.descripcion,
                                style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                         ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildGameCard(
    BuildContext context, {
    Color? color,
    String? title,
    String? imageUrl,
    String? imageAsset,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white.withOpacity(0.5),
        highlightColor: Colors.white.withOpacity(0.2),
        child: Ink(
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
            image: imageAsset != null
                ? DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  )
                : imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode.darken,
                        ),
                      )
                    : null,
          ),
          child: Center(
            child: Text(
              title ?? '',
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.8),
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}