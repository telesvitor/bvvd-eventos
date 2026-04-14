import 'package:flutter/material.dart';
import 'package:b_v_v_d_eventos_app/core/constants/app_colors.dart';
import 'package:b_v_v_d_eventos_app/core/constants/app_strings.dart';
import 'package:b_v_v_d_eventos_app/date/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  int totalEventos = 0;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarResumo();
  }

  // Busca dados da API para atualizar o resumo
  Future<void> _buscarResumo() async {
    try {
      final dados = await apiService.listarClientes(); 
      if (mounted) {
        setState(() {
          totalEventos = dados.length;
          _carregando = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SEÇÃO DE CABEÇALHO ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "BVVD",
                      style: TextStyle(
                        color: AppColors.buttonPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const Text(
                      AppStrings.appName,
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                    ),
                    const SizedBox(height: 30),
                    
                    // MENSAGEM DE BOAS-VINDAS
                    const Text(
                      "Olá, Administrador!",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Bem-vindo ao seu painel de eventos.",
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                    ),
                    const SizedBox(height: 25),
                    
                    // CARD DE RESUMO (STATUS DA API)
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.inputBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.buttonPrimary.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.insights, color: AppColors.buttonPrimary),
                          const SizedBox(width: 12),
                          Text(
                            _carregando ? "Sincronizando..." : "Você tem $totalEventos eventos ativos.",
                            style: const TextStyle(
                              color: AppColors.textPrimary, 
                              fontWeight: FontWeight.w500,
                              fontSize: 15
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- GRADE DE OPÇÕES (MENU PRINCIPAL) ---
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildHomeCard(
                      icon: Icons.event_note,
                      label: AppStrings.tituloListaEventos,
                      onTap: () {
                        // Lógica de navegação futura
                      },
                    ),
                    _buildHomeCard(
                      icon: Icons.group,
                      label: AppStrings.tituloListaClientes,
                      onTap: () {},
                    ),
                    _buildHomeCard(
                      icon: Icons.mic_external_on,
                      label: AppStrings.tituloCantores,
                      onTap: () {},
                    ),
                    _buildHomeCard(
                      icon: Icons.add_circle_outline,
                      label: AppStrings.tituloNovoEvento,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // BOTÃO DE ATUALIZAR MANUALMENTE
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: AppColors.buttonPrimary,
        onPressed: _buscarResumo,
        child: const Icon(Icons.refresh, color: AppColors.textOnGreen),
      ),
    );
  }

  // Widget personalizado para os botões do menu
  Widget _buildHomeCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.inputBackground.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.borderInactive, width: 0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.buttonPrimary, size: 42),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}