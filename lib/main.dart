import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; 

import 'package:flutter_slidable/flutter_slidable.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/twitter_feed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); 
  }

  const String PANDA_API_KEY = 'bNb9-cXoobITCt_SECQfNWY9otBsKdNeFZJuw4iR7pr15eWlR6k';

    // ← ESTO faltaba en tu main actual
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
  String titulo, descripcion, url, imagenUrl, fuente, fecha, juego;
  
  Noticia({
    required this.titulo,
    required this.descripcion,
    required this.url,
    required this.imagenUrl,
    required this.fuente,
    required this.fecha,
    required this.juego,
  });

  // ← AÑADIR ESTOS DOS MÉTODOS AL FINAL
  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'descripcion': descripcion,
    'url': url,
    'imagenUrl': imagenUrl,
    'fuente': fuente,
    'fecha': fecha,
    'juego': juego,
  };

  factory Noticia.fromJson(Map<String, dynamic> json) => Noticia(
    titulo: json['titulo'] ?? '',
    descripcion: json['descripcion'] ?? '',
    url: json['url'] ?? '',
    imagenUrl: json['imagenUrl'] ?? '',
    fuente: json['fuente'] ?? '',
    fecha: json['fecha'] ?? '',
    juego: json['juego'] ?? '',
  );
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
                  color: Color.fromARGB(255, 33, 123, 146).withOpacity(0.9),
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
                  color: Color.fromARGB(255, 33, 123, 146),
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
                        Icons.loop_outlined,
                        color: Color.fromARGB(255, 33, 123, 146),
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
                        Row(
                        children: [
                          Icon(Icons.circle, color: Colors.red, size: 8),
                          const SizedBox(width: 4),
                          Icon(Icons.sports_esports, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          const Text(
                            'EN VIVO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                        const SizedBox(height: 8),
                        Text(
                          widget.campeonNombre,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: const Color.fromARGB(255, 0, 0, 0),
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
                color: Colors.white,
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
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            nombreEquipo,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white,),
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
  return FutureBuilder<List<Partido>>(
    future: partidosFiltrados,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return AlertDialog(
          title: Text(
            widget.titulo,
            style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            ),
          ),
          content: const Center(child: CircularProgressIndicator()),
        );
      } else if (snapshot.hasError) {
        return AlertDialog(
          title: Text(widget.titulo),
          content: Text("Error: ${snapshot.error}"),
        );
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return AlertDialog(
          title: Text(
            widget.titulo,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text("No hay eventos disponibles"),
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
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              tooltip: "Cerrar",
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: partidos.length,
            itemBuilder: (context, index) {
              final p = partidos[index];
              final terminado = partidoTerminado(p.hora);
              final enVivo = esEnVivo(p.hora);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: terminado ? Colors.grey[900] : const Color(0xFF111827),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Fila superior: fecha/hora + badge EN VIVO / FINALIZADO
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              formatearHora(p.hora),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: terminado
                                    ? Colors.grey[400]
                                    : Colors.white,
                              ),
                            ),
                          ),
                          if (enVivo)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FadeTransition(
                                    opacity: pulseController,
                                    child: const Icon(
                                      Icons.circle,
                                      color: Colors.white,
                                      size: 6,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'EN VIVO',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else if (terminado)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'FINALIZADO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Fila de equipos con logos
                      if (p.equipo1.isNotEmpty && p.equipo2.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: EquipoConLogo(
                                nombreEquipo: p.equipo1,
                                urlLogo: p.logoEquipo1,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'VS',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: EquipoConLogo(
                                  nombreEquipo: p.equipo2,
                                  urlLogo: p.logoEquipo2,
                                ),
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(height: 6),
                      Text(
                        p.torneo,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        p.formato,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 11,
                        ),
                      ),
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
    builder: (dialogContext) {
      return DialogoPartidos(
        partidosAPI: partidosCsgo,
        opcionesLiga: const ['Todos'],
        filtroInicial: 'Todos',
        titulo: 'Próximos partidos CSGO / CS2',
      );
    },
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
late Future<List<Partido>> partidosCsgo;

String? avatarSheep;

  @override
  void initState() {
    super.initState();
    cargarLogosEquipos();
    partidoEnVivoDestacado = obtenerPartidoEnVivoDestacado();
    partidosLoL = obtenerPartidosLoL();
    infoMajorCsgo = fetchCsgoMajorInfo();
    partidosValorant = obtenerPartidosValorant();
    partidosFortnite = obtenerPartidosFortnite();
    partidosCsgo = obtenerPartidosCsgo();
    noticiasDinamicas = obtenerNoticiasDinamicas();
    obtenerAvatarSheep().then((url) {
    setState(() {
      avatarSheep = url;
    });
  });

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
String _formatearFechaTweet(String? fechaISO) {
  if (fechaISO == null) return 'Hoy';
  try {
    final fecha = DateTime.parse(fechaISO).toLocal();
    return '${fecha.day}/${fecha.month} ${fecha.hour.toString().padLeft(2,'0')}:${fecha.minute.toString().padLeft(2,'0')}';
  } catch (e) {
    return 'Hoy';
  }
}

late Future<List<Noticia>> noticiasDinamicas;
List<Noticia> noticiasCache = [];
List<Noticia> noticiasAnteriores = []; 
bool tieneCache = false;

Future<String?> obtenerAvatarSheep() async {
  const String X_BEARER_TOKEN = 'AAAAAAAAAAAAAAAAAAAAALKh5QEAAAAASb7J8dNp0NkASO2G7ZJ6gdZEttE%3DGQjQ3FR09svZdDNGmYkxDHaMPEQraQPrZYXOND2CFmpLi6Z3MM';

  final res = await http.get(
    Uri.parse(
      'https://api.twitter.com/2/users/by/username/Sheep_Esports'
      '?user.fields=profile_image_url',
    ),
    headers: {'Authorization': 'Bearer $X_BEARER_TOKEN'},
  );

  if (res.statusCode != 200) {
    print('Error avatar: ${res.statusCode} ${res.body}');
    return null;
  }

  final data = jsonDecode(res.body);
  return data['data']?['profile_image_url'] as String?;
}

Future<List<Noticia>> obtenerNoticiasDinamicas() async {
  List<Noticia> cache = await cargarNoticiasCache();
  if (cache.isNotEmpty) {
    noticiasCache = cache;
    return cache; 
  }
  List<Noticia> noticiasPrueba = [
    Noticia(titulo: "🔥 RAZORK → Fnatic", descripcion: "Jungler Razork 🇪🇸 será titular Fnatic 🇬🇧 LEC 2026", url: "https://twitter.com/Sheep_Esports", imagenUrl: "", fuente: "🐑 Sheep", fecha: "21/12 19:30", juego: "LEC"),
    Noticia(titulo: "G2 Academy + Markoon 🇰🇷", descripcion: "Shelfmade 🇸🇪 y Markoon 🇰🇷 a G2 NORD", url: "https://twitter.com/Sheep_Eports", imagenUrl: "", fuente: "🐑 Sheep", fecha: "21/12 18:45", juego: "LEC Academy"),
  ];

  try {
    const String X_BEARER_TOKEN = 'AAAAAAAAAAAAAAAAAAAAALKh5QEAAAAASb7J8dNp0NkASO2G7ZJ6gdZEttE%3DGQjQ3FR09svZdDNGmYkxDHaMPEQraQPrZYXOND2CFmpLi6Z3MM';
    
    // Twitter API
    final userRes = await http.get(
      Uri.parse('https://api.twitter.com/2/users/by/username/Sheep_Esports'),
      headers: {'Authorization': 'Bearer $X_BEARER_TOKEN'},
    );
    

    if (userRes.statusCode == 200) {
      final userData = jsonDecode(userRes.body);
      final userId = userData['data']?['id'];
      
      if (userId != null) {
        final tweetsRes = await http.get(
          Uri.parse('https://api.twitter.com/2/users/$userId/tweets?max_results=10&tweet.fields=created_at'),
          headers: {'Authorization': 'Bearer $X_BEARER_TOKEN'},
        );

        if (tweetsRes.statusCode == 200) {
          final tweetsData = jsonDecode(tweetsRes.body);
          final tweets = tweetsData['data'] as List? ?? [];
          
          if (tweets.isNotEmpty) {
            List<Noticia> tweetsNoticia = tweets.map<Noticia>((tweet) {
              final text = tweet['text'] ?? '';
              return Noticia(
                titulo: text.length > 60 ? '${text.substring(0, 60)}...' : text,
                descripcion: text,
                url: 'https://twitter.com/Sheep_Esports/status/${tweet['id']}',
                imagenUrl: '',
                fuente: '🐑 Sheep Esports',
                fecha: _formatearFechaTweet(tweet['created_at']),
                juego: 'Twitter',
              );
            }).toList();
            
            // ← GUARDAR TWEETS NUEVOS EN CACHÉ
            noticiasCache = [...tweetsNoticia, ...noticiasPrueba];
            await guardarNoticiasCache(noticiasCache);
            return noticiasCache;
          }
        }
      }
    }
  } catch (e) {
    print('Error Twitter: $e');
  }
  
  // ← SIEMPRE retorna algo
  noticiasCache = noticiasPrueba;
  await guardarNoticiasCache(noticiasCache);
  return noticiasCache;
}

// ← FUNCIONES CACHE
Future<List<Noticia>> cargarNoticiasCache() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('noticias_cache');
    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Noticia.fromJson(json)).toList();
  } catch (e) {
    return [];
  }
}

Future<void> guardarNoticiasCache(List<Noticia> noticias) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = noticias.map((n) => n.toJson()).toList();
    await prefs.setString('noticias_cache', jsonEncode(jsonList));
  } catch (e) {
    print('Error cache: $e');
  }
}


    
       Future<List<Partido>> obtenerPartidosValorant() async {
  final uri = Uri.parse(
    'https://api.pandascore.co/valorant/matches',
  );

  final res = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer $PANDA_API_KEY',
    },
  );

  if (res.statusCode != 200) {
    throw Exception('Error PandaScore: ${res.statusCode} ${res.body}');
  }

  final List data = jsonDecode(res.body);

  return data.map<Partido>((m) {
    final opponents = (m['opponents'] ?? []) as List;

    final teamA = opponents.isNotEmpty
        ? (opponents[0]['opponent']?['name'] ?? 'TBD')
        : 'TBD';

    final teamB = opponents.length > 1
        ? (opponents[1]['opponent']?['name'] ?? 'TBD')
        : 'TBD';

    final logoA = opponents.isNotEmpty
        ? (opponents[0]['opponent']?['image_url'] ?? '')
        : '';

    final logoB = opponents.length > 1
        ? (opponents[1]['opponent']?['image_url'] ?? '')
        : '';

    return Partido(
      hora: m['begin_at'] ?? '',
      equipo1: teamA,
      equipo2: teamB,
      torneo: m['tournament']?['name'] ?? '',
      formato: m['number_of_games'] != null
          ? 'Bo${m['number_of_games']}'
          : 'Bo3',
      logoEquipo1: logoA,
      logoEquipo2: logoB,
      scoreEquipo1: null,
      scoreEquipo2: null,
      ganador: null,
    );
  }).toList();
}


Future<List<Partido>> obtenerPartidosCsgo() async {
  final uri = Uri.parse(
    'https://api.pandascore.co/matches/upcoming?game=cs2&per_page=20',
  );

  final res = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer $PANDA_API_KEY',
    },
  );

  if (res.statusCode != 200) {
    throw Exception('Error PandaScore: ${res.statusCode} ${res.body}');
  }

  final List data = jsonDecode(res.body);

  return data.map<Partido>((m) {
    final opponents = (m['opponents'] ?? []) as List;

    final teamA = opponents.isNotEmpty
        ? (opponents[0]['opponent']?['name'] ?? 'TBD')
        : 'TBD';

    final teamB = opponents.length > 1
        ? (opponents[1]['opponent']?['name'] ?? 'TBD')
        : 'TBD';

    final logoA = opponents.isNotEmpty
        ? (opponents[0]['opponent']?['image_url'] ?? '')
        : '';

    final logoB = opponents.length > 1
        ? (opponents[1]['opponent']?['image_url'] ?? '')
        : '';

    final beginAt = m['begin_at'] ?? '';      // fecha/hora ISO
    print('CSGO: $teamA vs $teamB @ $beginAt');   // DEBUG

    return Partido(
      hora: beginAt,
      equipo1: teamA,
      equipo2: teamB,
      torneo: m['tournament']?['name'] ?? '',
      formato: m['number_of_games'] != null
          ? 'Bo${m['number_of_games']}'
          : 'Bo3',
      logoEquipo1: logoA,
      logoEquipo2: logoB,
      scoreEquipo1: null,
      scoreEquipo2: null,
      ganador: null,
    );
  }).toList();
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

  late Future<Partido?> partidoEnVivoDestacado;
  Future<Partido?> obtenerPartidoEnVivoDestacado() async {
  final uri = Uri.parse(
    'https://api.pandascore.co/matches'
    '?filter[running]=true&per_page=1',
  );

  final res = await http.get(
    uri,
    headers: {'Authorization': 'Bearer $PANDA_API_KEY'},
  );

  if (res.statusCode != 200) {
    print('Error live match: ${res.statusCode} ${res.body}');
    return null;
  }

  final List data = jsonDecode(res.body);
  if (data.isEmpty) return null;

  final m = data.first;

  final opponents = (m['opponents'] ?? []) as List;

  final teamA = opponents.isNotEmpty
      ? (opponents[0]['opponent']?['name'] ?? 'TBD')
      : 'TBD';

  final teamB = opponents.length > 1
      ? (opponents[1]['opponent']?['name'] ?? 'TBD')
      : 'TBD';

  final logoA = opponents.isNotEmpty
      ? (opponents[0]['opponent']?['image_url'] ?? '')
      : '';

  final logoB = opponents.length > 1
      ? (opponents[1]['opponent']?['image_url'] ?? '')
      : '';

  return Partido(
    hora: m['begin_at'] ?? '',
    equipo1: teamA,
    equipo2: teamB,
    torneo: m['tournament']?['name'] ?? '',
    formato: m['number_of_games'] != null
        ? 'Bo${m['number_of_games']}'
        : 'Bo3',
    logoEquipo1: logoA,
    logoEquipo2: logoB,
    scoreEquipo1: null,
    scoreEquipo2: null,
    ganador: null,
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
      pageBuilder: (dialogcontext, animation, secondaryAnimation) {
        return DialogoPartidos(
          partidosAPI: partidosValorant,
          opcionesLiga: opcionesLigaValorant,
          filtroInicial: filtroLigaValorant,
          titulo: "Proximos Partidos Valorant",
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
        FutureBuilder<Partido?>(
  future: partidoEnVivoDestacado,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CampeonCard(
        campeonNombre: 'Cargando partido en vivo...',
        campeonLogoUrl: 'https://…/placeholder.png',
      );
    }

    if (!snapshot.hasData || snapshot.data == null) {
      // Si no hay partido en vivo, puedes dejar T1 o un mensaje
      return const CampeonCard(
        campeonNombre: 'Sin partidos en vivo',
        campeonLogoUrl: 'https://…/placeholder.png',
      );
    }

    final p = snapshot.data!;
    // Usa el equipo1 como “campeón” momentáneo
    return CampeonCard(
      campeonNombre: '${p.equipo1} vs ${p.equipo2}',
      campeonLogoUrl: p.logoEquipo1.isNotEmpty
          ? p.logoEquipo1
          : 'https://…/placeholder.png',
    );
  },
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
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
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
        () => mostrarDialogoCsgo(context), // ← aquí ya conecta con la lista
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
  Widget buildPaginaNoticias() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Noticias y Rumores",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.teal),
              onPressed: () {
                setState(() {
                  noticiasDinamicas = obtenerNoticiasDinamicas(); // ← Refresh
                });
              },
            ),
          ],
        ),
      ),
      Expanded(
        child: FutureBuilder<List<Noticia>>(
          future: noticiasDinamicas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.teal),
              );
            }
            
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.newspaper, size: 64, color: Colors.grey), // ← CAMBIADO
                  SizedBox(height: 16),
                  Text('Sin noticias disponibles', style: TextStyle(color: Colors.white70, fontSize: 18)),
                  Text('Toca 🔄 para actualizar', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
            
            final noticias = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () => noticiasDinamicas,
              color: Colors.teal,
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: noticias.length,
                itemBuilder: (context, index) {
                  final noticia = noticias[index];
                  return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: InkWell(
                    onTap: () => launchUrl(Uri.parse(noticia.url)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cabecera sencilla (icono + Sheep Esports)
                        Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.teal[50],
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.sports_esports, size: 50, color: Colors.teal),
                                SizedBox(height: 8),
                                Text('🐑 Sheep Esports', style: TextStyle(color: Colors.teal[800])),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      noticia.fuente,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      noticia.fecha,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.open_in_new,
                                      size: 16, color: Colors.teal),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // TÍTULO DE LA NOTICIA
                              Text(
                                noticia.titulo,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              // DESCRIPCIÓN / TEXTO DEL TWEET
                              Text(
                                noticia.descripcion,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 14,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                },
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