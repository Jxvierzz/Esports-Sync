import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Guardar preferencias del usuario
  Future<void> saveUserPreferences({
    required String userId,
    required List<String> favoriteTeams,
    String? favoriteGame,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'favoriteTeams': favoriteTeams,
        'favoriteGame': favoriteGame ?? 'League of Legends',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error guardando preferencias: $e');
      throw 'No se pudieron guardar las preferencias';
    }
  }
  
  // Obtener preferencias del usuario
  Future<Map<String, dynamic>?> getUserPreferences(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();
      
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Error obteniendo preferencias: $e');
      return null;
    }
  }
  
  // Agregar equipo favorito
  Future<void> addFavoriteTeam(String userId, String teamName) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'favoriteTeams': FieldValue.arrayUnion([teamName]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error agregando equipo: $e');
      // Si el documento no existe, créalo
      await saveUserPreferences(
        userId: userId,
        favoriteTeams: [teamName],
      );
    }
  }
  
  // Eliminar equipo favorito
  Future<void> removeFavoriteTeam(String userId, String teamName) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'favoriteTeams': FieldValue.arrayRemove([teamName]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error eliminando equipo: $e');
      throw 'No se pudo eliminar el equipo';
    }
  }
  
  // Escuchar cambios en tiempo real
  Stream<DocumentSnapshot> watchUserPreferences(String userId) {
    return _firestore.collection('users').doc(userId).snapshots();
  }
  
  // Obtener lista de equipos disponibles (puedes personalizar esto)
  List<String> getAvailableTeams() {
    return [
      'T1',
      'G2 Esports',
      'Cloud9',
      'Team Liquid',
      'Fnatic',
      'Gen.G',
      'JD Gaming',
      'Bilibili Gaming',
      'DRX',
      'MAD Lions',
      'KT Rolster',
      'Dplus KIA',
      'NRG Esports',
      'FlyQuest',
    ];
  }
}
