import 'package:flutter/material.dart';

// Ajuste os caminhos conforme seu projeto
import 'core/constants/app_colors.dart';
import 'core/constants/app_strings.dart';
import 'date/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.backgroundTop,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.buttonPrimary,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> _eventos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarDados();
  }

  Future<void> _buscarDados() async {
    setState(() => _carregando = true);
    try {
      final dados = await apiService.listarClientes();
      if (mounted) {
        setState(() {
          _eventos = dados;
          _carregando = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _carregando = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppStrings.msgErroConexao}: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- CABEÇALHO ---
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // HEADER COM LOGO + TEXTO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'imagens/logo.png', // <-- sua logo aqui
                              height: 40,
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "BVVD-EVENTOS",
                                  style: TextStyle(
                                    color: AppColors.buttonPrimary,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(
                                  AppStrings.appName,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh,
                              color: AppColors.buttonPrimary),
                          onPressed: _buscarDados,
                        )
                      ],
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "Seja bem vindo!",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "A BVVD é especialista em transformar celebrações em momentos inesquecíveis. "
                      "Nossa plataforma simplifica a conexão entre grandes talentos e eventos exclusivos, "
                      "garantindo gestão e qualidade de ponta a ponta.",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        const Text(
                          "Eventos Recentes",
                          style: TextStyle(
                            color: AppColors.buttonPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Divider(
                            color: AppColors.buttonPrimary.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // --- LISTA ---
              Expanded(
                child: _carregando
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.buttonPrimary))
                    : _eventos.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            itemCount: _eventos.length,
                            itemBuilder: (context, index) {
                              final item = _eventos[index];
                              return _buildEventoCard(item);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonPrimary,
        onPressed: () {
          // abrir tela de cadastro
        },
        child: const Icon(Icons.add, color: AppColors.textOnGreen),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy,
              size: 60, color: AppColors.textSecondary.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text(
            AppStrings.msgVazio,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildEventoCard(dynamic item) {
    return Card(
      color: AppColors.inputBackground.withOpacity(0.8),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: AppColors.buttonPrimary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.buttonPrimary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.mic_external_on,
              color: AppColors.buttonPrimary),
        ),
        title: Text(
          item['nomeEvento'] ??
              item['nomeCompleto'] ??
              AppStrings.naoInformado,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            "🎤 ${item['nomeCantor'] ?? AppStrings.cantorNA}\n📍 ${item['cidade'] ?? 'Local não informado'}",
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: AppColors.buttonPrimary.withOpacity(0.5),
        ),
        onTap: () {
          // detalhes
        },
      ),
    );
  }
}