# Weather App

Código bruto de um app desenvolvido em Flutter com integração da api Weatherforecast.

## Finalidade

Verificar detalhes climáticos em diversas regiões apenas determinando a localização.

## Funcionalidades

- Pesquisa por região
- Portabilidade
- Mudanças de unidades de medida
- Gráficos informativos
- Previsões dos dias seguintes

## Estrutura de pastas

```
lib/
├── models/        # Modelos de dados
├── view/          # Telas do aplicativo
├── controllers/   # Integração com Weatherforecast
├── stores/        # Controle de estados da conexão com apis
├── widgets/       # Widgets personalizados para o app
└── main.dart      # Ponto de entrada
```

## Como utilizar

```bash
# 1. Clone o repositório
git clone https://github.com/Roger-snts/weather_app.git

# 2. Acesse a pasta do projeto
cd weather_app

# 3. Instale as dependências
flutter pub get

# 4. Execute o app
flutter run
```

## Como acessar

É possível acessar a aplicação web do Weather App por meio do link: [Wheather App](index.html)

## O que eu aprendi

Testei por meio deste app a integração com apis que requerem senhas e autenticação para serem utilizadas. A manipulação dos dados de retorno e também a criação de widgets próprios, controles básicos de estados da conexão e padronização das pastas e arquivos do sistema.

Aprendi a manipular dados recebidos por meio de uma api autenticada, fazer pesquisas em tempo real e trabalhar com diversos estados da aplicação.
