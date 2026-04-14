import 'package:flutter/material.dart';

class AppColors {
  // --- 1. CORES DE FUNDO E DEGRADÊ ---
  static const Color backgroundTop = Color(0xFF000000);    // Preto (Topo)
  static const Color backgroundBottom = Color(0xFF39FF14); // Verde Vibrante (Base)
  
  static const Gradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundTop, backgroundBottom],
    stops: [0.4, 1.0], // Faz o preto ocupar 40% antes de começar a transição
  );

  // --- 2. CORES DE TEXTO (LETRAS) ---
  static const Color textPrimary = Color(0xFFFFFFFF);      // Branco (Títulos/Principal)
  static const Color textSecondary = Color(0xFFB0B0B0);    // Cinza Claro (Dicas/Subtítulos)
  static const Color textOnGreen = Color(0xFF000000);      // Preto (Para ler dentro de botões verdes)

  // --- 3. CORES DE STATUS (ERRO E SUCESSO) ---
  static const Color error = Color.fromARGB(255, 188, 17, 17);           // Vermelho Vibrante (Erro)
  static const Color success = Color(0xFF00C853);         // Verde Esmeralda (Confirmação/Sucesso)

  // --- 4. CORES DE COMPONENTES (BOTÕES E INPUTS) ---
  static const Color inputBackground = Color(0xFF1A1A1A);  // Cinza Escuro (Fundo dos campos)
  static const Color buttonPrimary = Color(0xFF39FF14);    // Verde Neon (Botões)
  static const Color borderInactive = Color(0xFF444444);   // Borda discreta
}