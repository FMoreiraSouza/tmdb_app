# TMDB App

![Flutter](https://img.shields.io/badge/Flutter-3.22.3-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.4.3-blue?logo=dart)

## 📃 Descrição

O **TMDB App** é um aplicativo mobile desenvolvido em **Flutter** que utiliza a API do **The Movie Database (TMDB)** para oferecer uma experiência interativa de exploração e busca de filmes. O aplicativo permite aos usuários visualizar uma lista de filmes populares com detalhes como título, duração, nota média e pôster, além de oferecer uma funcionalidade de busca por filmes com base em palavras-chave. Com um design moderno, transições suaves e feedback visual claro, o app prioriza a experiência do usuário, garantindo robustez e escalabilidade por meio de uma arquitetura modular, injeção de dependências e tratamento de erros abrangente.

O projeto foi estruturado seguindo boas práticas de desenvolvimento, com separação clara entre camadas de apresentação, lógica de negócio e acesso a dados. Ele é ideal para desenvolvedores que desejam estudar uma implementação prática de Flutter com integração de APIs externas, gerenciamento de estado reativo e otimização de performance.

---

## 💻 Tecnologias Utilizadas

- **Flutter**: Framework para construção de interfaces de usuário multiplataforma, garantindo consistência visual em Android e iOS.
- **Dart**: Linguagem de programação utilizada para lógica e interface do aplicativo.
- **Dio**: Cliente HTTP para chamadas à API do TMDB, com suporte a interceptadores para logging e tratamento de erros.
- **CachedNetworkImage**: Carregamento eficiente de imagens com cache para reduzir uso de rede e melhorar performance.
- **Flutter SpinKit**: Animações de carregamento para feedback visual durante requisições.
- **ChangeNotifier**: Gerenciamento de estado reativo para atualizar a interface com base em mudanças nos dados.
- **Dependency Injection (DI)**: Estrutura modular para injeção de dependências, facilitando manutenção e testes.
- **TMDB API**: API pública para obtenção de dados de filmes, incluindo listas de filmes populares, detalhes e resultados de busca.

---

## 🛎️ Funcionalidades

O **TMDB App** oferece as seguintes funcionalidades:

### ✅ Exploração de Filmes Populares
- Exibe uma lista de filmes populares obtida do endpoint `movie/popular` da API do TMDB.
- Cada filme é apresentado em um cartão com:
  - **Pôster**: Carregado via `CachedNetworkImage` com placeholder de carregamento e ícone de erro.
  - **Título**: Limitado a duas linhas com elipse para títulos longos.
  - **Duração**: Formatada como "XhYm" (ex.: 2h15m), obtida do endpoint de detalhes do filme.
  - **Nota Média**: Exibida em um círculo estilizado, calculada como a média de votos multiplicada por 10 e arredondada.
- Suporta estados de interface como carregamento, erro, sem conexão e lista vazia, com opções de retry para falhas.

### ✅ Busca de Filmes
- Permite buscar filmes por título ou palavras-chave usando o endpoint `search/movie`.
- Implementa debounce (500ms) para evitar chamadas excessivas à API durante a digitação.
- Exibe resultados em uma lista com pôster e título, com suporte a estados de carregamento, erro e lista vazia.
- O teclado é ocultado ao tocar fora do campo de busca, melhorando a usabilidade.

### ✅ Gerenciamento de Estados
- Utiliza `ChangeNotifier` para atualizar a interface de forma reativa com base em mudanças de estado.
- Suporta quatro estados principais:
  - **Loading**: Exibe uma animação de carregamento (SpinKitCircle) com mensagem.
  - **Success**: Exibe a lista de filmes.
  - **Empty**: Informa quando não há resultados.
  - **No Connection/Error**: Exibe mensagens de erro com botão de retry.

### ✅ Interface Intuitiva
- Navegação entre as seções "Filmes Populares" e "Busca" via uma barra de navegação inferior personalizada.
- Usa `AnimatedSwitcher` com `FadeTransition` para transições suaves entre telas.
- Estilização consistente com tema escuro, cores contrastantes e ícones personalizados.

### ✅ Otimização de Performance
- Cache de imagens via `CachedNetworkImage` para reduzir requisições de rede.
- Verificação de conectividade antes de cada requisição para evitar falhas desnecessárias.
- Uso de `AutomaticKeepAliveClientMixin` para manter o estado da lista de filmes populares.

---

## 📡 Integração com Back-end

### API do TMDB
O aplicativo consome a API pública do **The Movie Database (TMDB)** para obter dados de filmes. Os principais endpoints utilizados são:

- **`movie/popular`**: Retorna uma lista de filmes populares.
- **`search/movie`**: Busca filmes com base em um termo de pesquisa.
- **`movie/{movieId}`**: Obtém detalhes adicionais de um filme, como duração (`runtime`).

- **Autenticação**: Todas as requisições incluem uma chave de API (`api_key`) definida em `ApiConstants.apiKey`.
- **Base URL**: `https://api.themoviedb.org/3/`.
- **Image Base URL**: `https://image.tmdb.org/t/p/w500` para carregar pôsteres.

### Modelo de Dados
- **`MovieModel`**: Representa um filme com propriedades:
  - `id`: Identificador único.
  - `title`: Título do filme.
  - `voteAverage`: Média de votos (0 a 10).
  - `posterPath`: Caminho relativo do pôster.
  - `runtime`: Duração em minutos (opcional, obtida do endpoint de detalhes).
- **`MovieResponseDTO`**: Estrutura para mapear respostas de lista de filmes.
- **`MovieDetailsResponseDTO`**: Estrutura para mapear detalhes de um filme específico.

### Gerenciamento de Conexão e Erros
- **Conectividade**: Verifica a conectividade antes de cada requisição usando `ConnectivityDriver`. Lança `ConnectionException` se não houver conexão.
- **Tratamento de Erros**: O cliente HTTP (`DioClient`) usa interceptadores para tratar erros HTTP:
  - **401**: Erro de autenticação (chave de API inválida).
  - **404**: Recurso não encontrado.
  - **429**: Limite de requisições atingido.
  - **500+**: Serviço indisponível.
  - Outros erros são tratados como falhas genéricas (`Failure`).

---

## 🎨 Telas do Aplicativo

### Home Page
- Tela principal com uma barra de navegação inferior contendo dois ícones (`home.png` e `search.png`) para alternar entre as seções.
- Usa `Stack` para posicionar a barra de navegação sobre o conteúdo, com botões animados (`AnimatedContainer`) para indicar a seção ativa.
- Suporta transições suaves entre seções usando `AnimatedSwitcher` com `FadeTransition`.

### Filmes Populares
- Exibe uma lista de filmes populares em um `ListView.builder` com cartões (`Card`) estilizados.
- Cada cartão contém:
  - Pôster do filme (carregado via `CachedNetworkImage`).
  - Título (limitado a duas linhas com elipse).
  - Duração (ex.: "2h15m" ou "N/A" se indisponível).
  - Nota média em um círculo azul com texto em negrito.
- Estados de interface:
  - **Carregando**: Animação `SpinKitCircle` com mensagem.
  - **Erro/Sem Conexão**: Widget de estado com botão de retry.
  - **Vazio**: Mensagem informando ausência de filmes.

### Busca
- Contém um campo de texto estilizado com ícone de lupa e borda arredondada.
- A busca é acionada com debounce (500ms) para otimizar requisições.
- Resultados são exibidos em um `ListView` com pôster e título, separados por divisores.
- Suporta os mesmos estados de interface da tela de filmes populares.
- O teclado é ocultado ao tocar fora do campo de texto.

---

## 🛠️ Ambiente de Desenvolvimento

- **IDE**: Visual Studio Code ou Android Studio.
- **API**: The Movie Database (TMDB).
- **Gerenciador de Dependências**: Pub (Flutter).
- **Dispositivos de Teste**: Emulador Android/iOS ou dispositivo físico com modo de depuração ativado.
- **Ferramentas Adicionais**:
  - Flutter DevTools para depuração.
  - Postman ou similar para testar chamadas à API do TMDB (opcional).

---

## 📦 Instalação

### 🔧 Pré-requisitos
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versão 3.22.3 ou superior recomendada).
- [Dart SDK](https://dart.dev/get-dart) (incluído com o Flutter).
- Dispositivo físico ou emulador/simulador configurado para Android ou iOS.
- Chave de API do TMDB (fornecida no código, mas pode ser substituída em `ApiConstants.apiKey`).
- Conexão à internet para carregar dados da API.

### ▶️ Rodando o Projeto
```bash
git clone https://github.com/{seu_usuario}/tmdb_app.git
cd tbmdb_app
flutter pub get
flutter run
