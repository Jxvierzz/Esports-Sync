import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Obtener usuario actual
  User? get currentUser => _auth.currentUser;
  
  // Stream de cambios de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  // Registrar nuevo usuario
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _getSpanishErrorMessage(e.code);
    }
  }
  
  // Iniciar sesión
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _getSpanishErrorMessage(e.code);
    }
  }
  
  // Cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  // Recuperar contraseña
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _getSpanishErrorMessage(e.code);
    }
  }
  
  // Mensajes de error en español
  String _getSpanishErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'La contraseña debe tener al menos 6 caracteres';
      case 'email-already-in-use':
        return 'Este correo ya está registrado';
      case 'user-not-found':
        return 'Usuario no encontrado';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'invalid-email':
        return 'Correo electrónico inválido';
      case 'invalid-credential':
        return 'Credenciales inválidas';
      default:
        return 'Error: $code';
    }
  }
}
