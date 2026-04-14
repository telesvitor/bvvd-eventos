class AppStrings {
  // Títulos e Cabeçalhos
  static const String appName = "Gerenciamento de Festas";
  static const String tituloListaClientes = "Clientes Cadastrados";
  static const String tituloListaEventos = "Meus Eventos";
  static const String tituloNovoEvento = "Cadastrar Novo Evento";
  static const String tituloCantores = "Atrações e Cantores"; // Novo

  // Labels de Campos (Formulários)
  static const String labelNome = "Nome Completo";
  static const String labelEmail = "E-mail";
  static const String labelCidade = "Cidade";
  static const String labelEstado = "Estado";
  static const String labelData = "Data do Evento";
  static const String labelCapacidade = "Capacidade de Pessoas";
  
  // Campos específicos para Cantores
  static const String labelNomeCantor = "Nome do Cantor/Banda"; // Novo
  static const String labelGeneroMusical = "Gênero Musical";    // Novo
  static const String labelCache = "Valor do Cachê";           // Novo

  // Placeholders / Dicas
  static const String hintNome = "Digite o nome completo";
  static const String hintEmail = "exemplo@email.com";
  static const String hintCantor = "Ex: Jorge & Mateus";       // Novo
  
  // Botões
  static const String btnSalvar = "Salvar";
  static const String btnCancelar = "Cancelar";
  static const String btnAtualizar = "Atualizar Lista";
  static const String btnAdicionar = "Adicionar";

  // Mensagens de Estado
  static const String msgVazio = "Nenhum registro encontrado no banco de dados.";
  static const String msgCarregando = "Carregando dados...";
  static const String msgErroConexao = "Erro de conexão com o servidor.";
  static const String msgSucessoSalvar = "Salvo com sucesso!";

  // Erros específicos
  static const String erroCampoObrigatorio = "Este campo é obrigatório";
  static const String erroEmailInvalido = "Insira um e-mail válido";
  
  // Informações de Fallback (N/A)
  static const String naoInformado = "Não informado";
  static const String cidadeNA = "Cidade: N/A";
  static const String cantorNA = "Cantor não definido";        // Novo
}