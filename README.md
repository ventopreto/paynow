 
# Projeto final: Paynow - Treinadev 6
 
 
## Sobre
Uma escola de programação, a CodePlay, decidiu lançar uma plataforma de cursos online de
programação. Você já está trabalhando nesse projeto e agora vamos começar uma nova etapa:
uma ferramenta de pagamentos capaz de configurar os meios de pagamentos e registrar as
cobranças referentes a cada venda de curso na CodePlay. O objetivo deste projeto é construir
o mínimo produto viável (MVP) dessa plataforma de pagamentos.
Na plataforma de pagamentos temos dois perfis de usuários: os administradores da plataforma
e os donos de negócios que querem vender seus produtos por meio da plataforma, como as
pessoas da CodePlay, por exemplo. Os administradores devem cadastrar os meios de
pagamento disponíveis, como boletos bancários, cartões de crédito, PIX etc, especificando
detalhes de cada formato. Administradores também podem consultar os clientes da plataforma,
consultar e avaliar solicitações de reembolso, bloquear compras por suspeita de fraudes etc.
Já os donos de negócios devem ser capazes de cadastrar suas empresas e ativar uma conta
escolhendo quais meios de pagamento serão utilizados. Devem ser cadastrados também os
planos disponíveis para venda, incluindo seus valores e condições de desconto de acordo com
o meio de pagamento. E a cada nova venda realizada, devem ser armazenados dados do
cliente, do produto selecionado e do meio de pagamento escolhido. Um recibo deve ser emitido
para cada pagamento e esse recibo deve ser acessível para os clientes finais, alunos da
CodePlay no nosso contexto.
A seguir, estão detalhadas as funcionalidades básicas para o funcionamento da plataforma.
Logo depois, são apresentadas funcionalidades extras que você pode codificar, caso tenha
tempo ou até mesmo após o fim do prazo estabelecido para entrega do projeto, como forma de
desafio.
 
### Conteudo
=================
 
   * [Sobre o projeto](#sobre)
   * [Tabela de Conteúdo](#conteudo)
   * [Instalação](#instalação)
   * [Como usar](#como-usar)
   * [Features](#features)
   * [Testes](#testes)
   * [Tecnologias](#tecnologias)
   * [Api](#api)
 
 
## Instalação 
### Pré-requisitos
 
Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:
[Git](https://git-scm.com), [Ruby 3.0.1](https://www.ruby-lang.org/en/news/2021/04/05/ruby-3-0-1-released/), [Rails 6.1.3.2](https://weblog.rubyonrails.org/2021/5/5/Rails-versions-6-1-3-2-6-0-3-7-5-2-4-6-and-5-2-6-have-been-released/), [Yarn](https://yarnpkg.com/). 
 
Além disto é bom ter um editor para trabalhar com o código como [VSCode](https://code.visualstudio.com/)
 
```bash
# Clone este repositório
$ git clone <https://github.com/ventopreto/paynow.git>
 
# Acesse a pasta do projeto no terminal/cmd
$ cd paynow
 
# Instale as dependências
$ bundle install
$ yarn install
 
# Criação do Banco de dados
$ rails db:migrate
 
# Execute a aplicação em modo de desenvolvimento
$ rails s
 
# O servidor iniciará na porta:3000 - acesse <http://localhost:3000>
```
    
## Como usar
 
Com o servidor rodando visite http://localhost:3000/
No sistema podemos criar 2 tipos de usuário: **Administradores** e **Clientes**, 
o primeiro é criado via console, 
para acessar o console use o comando abaixo.
```ruby 
rails c
```
Em seguida crie o administrador utilizando
```ruby 
Admin.create(email: teste@paynow.com.br, password:'123456')
```
O 'teste' pode ser substituído por qualquer outra palavra, 
mas o que vem depois de @ obrigatoriamente precisa ser paynow.com.br, 
do contrário não será possível fazer login. Para fazer login como administrador visite
http://localhost:3000/admins/sign_in utilize o email e senha criados acima.
 
A criação de um cliente pode ser feita acessando http://localhost:3000/
e clicando em 'Cadastre-se', preencha o formulário, emails com domínio @gmail, @yahoo, @hotmail, não são emails validos.
Uma vez logado, o usuário pode cadastrar sua empresa.
 
 
 
 
  ### Features
 
- [x]  Acesso de Administradores
- [x]  Cadastro de Meios de Pagamento
- [x]  Acesso de Clientes
- [x]  Token de Integração
- [x]  Administração de Clientes
- [x]  Gestão de Meios de Pagamento (Cliente)
- [x]  Cadastro de Produtos (Cliente)
- [x]  Endpoint de Criação de Token de Cliente Final (Cliente do cliente)
- [x]  Endpoint para emissão de cobrança
- [x]  Confirmação Manual de Pagamentos
- [x]  Emissão de Recibos
- [ ]  API para consulta de cobranças
- [ ]  Cliente consulta cobranças
 

### Testes
Para rodar todos os testes utilize o comando 
~~~ruby 
rspec
~~~
 
Também é possível rodar os testes em grupos específicos, basta passar o caminho do grupo de testes desejado. Exemplo: para rodar todos os teste referentes ao usuário basta utilizar 
~~~ruby 
rspec ./spec/system/user/
~~~
### 🛠Tecnologias
 
As seguintes ferramentas foram usadas na construção do projeto:
- [Ruby](https://www.ruby-lang.org/pt/)
- [Rails](https://rubyonrails.org/)
- [Yarn](https://www.ruby-lang.org/pt/)
- [Bootstrap](https://getbootstrap.com/)
 
gem's utilizadas:
 
Autenticação:
 - [Devise](https://github.com/heartcombo/devise)
 
Testes:
 
- [Rspec](https://github.com/rspec/rspec-rails)
 
- [Capybara](https://github.com/heartcombo/devise)
 
## API
 
## Criando um Usuário Final
 
```http
  POST /api/v1/end_user
```
O nosso endpoint acima espera receber uma requisição
com os seguintes parâmetros
```json
{
"cpf": "12345678910",
"fullname": "Test2e",
"company_token": "vdjTMxzbOSmn/UWcU4ii"
}
```
Se os parâmetros estão corretos e válidos, o usuário final é criando
e a requisição retorna o status 201.
 
### Erros Comuns
 
#### Ausencia de parâmetro
 
```http
  POST /api/v1/end_user
```
A mesma requisição do exemplo anterior, sem o fullname
```json
{
"cpf": "12345678910",
"company_token": "vdjTMxzbOSmn/UWcU4ii"
}
```
Nesse caso como um dos parâmetros estão faltando,
a requisição retorna com status 422 e uma mensagem informando
que fullname não pode ficar em branco.
 
```json
{
"cpf": "12345678910",
"fullname": "Test2e"
}
```
 
 
#### Json Vazio
 
```http
  POST /api/v1/end_user
```
 
```json
{
 
}
```
No caso de uma requisição vazia a requisição retorna
com o status 412 e a mensagem "Parâmetros inválidos"
 
## Criando uma cobrança
```http
POST /api/v1/charges
```
 
Esse endpoint aceita 3 tipos de pagamento(Boleto, Pix e Cartão de Crédito), cada um desses
precisa de payment_category, que nada mais é do que o tipo de pagamento,
o token da empresa, o token do produto
, o token do usuário final, alguns 
pagamentos precisam de dados específicos
no caso do boleto, precisamos passar o endereço.
 
#### Exemplo Cobrança com Boleto
```json
{
   "charge":{
      "end_user_token":"PPBGLaVLaueRh57i4TUcx24x",
      "product_token":"Si5u0LtQivzI83JgqYDVxhqeuiE=",
      "company_token":"gsVXGugQDyuzfY4dfEIGx5Vod4g=",
      "address":"Rua tal 42",
    "payment_category":"Boleto"}
}
```
A cobrança via boleto é criada e retorna com um status 201
#### Exemplo Cobrança com Pix
```json
{
    "charge":{
      "end_user_token":"PPBGLaVLaueRh57i4TUcx24x",
      "product_token":"Si5u0LtQivzI83JgqYDVxhqeuiE=",
      "company_token":"gsVXGugQDyuzfY4dfEIGx5Vod4g=",
      "payment_category": "Pix"}
}
```
A cobrança via pix é criada e retorna com um status 201
 
No caso do pix nenhum parâmetro adicional precisa ser passado
 
#### Exemplo requisição com Cartão de Crédito
```json
{
    "charge":{
        "end_user_token":"PPBGLaVLaueRh57i4TUcx24x",
        "product_token":"Si5u0LtQivzI83JgqYDVxhqeuiE=",
        "company_token":"gsVXGugQDyuzfY4dfEIGx5Vod4g=",
        "payment_category": "Cartão",
        "cvv": "123",
        "cardholder_name": "Fulano Sicrano",
        "credit_card_number": "1234567890123456"}
}
```
No caso da cobrança via cartão são necessários 3 parâmetros:
cvv, nome impresso no cartão e número do cartão
 
### Erros Comuns
 
#### Ausência de parâmetro
 
Nesse exemplo faço a mesma requisição para o cartão de Crédito
sem passar o cvv
 
```json
{
    "charge":{
        "end_user_token":"PPBGLaVLaueRh57i4TUcx24x",
        "product_token":"Si5u0LtQivzI83JgqYDVxhqeuiE=",
        "company_token":"gsVXGugQDyuzfY4dfEIGx5Vod4g=",
        "payment_category": "Cartão",
        "cardholder_name": "Fulano Sicrano",
        "credit_card_number": "1234567890123456",
            }
}
```
Como um dos parâmetros está faltando a requisição vai retornar com o status 422
 
#### Json Vazio
 
```json
{
 
}
```
Nesse exemplo é a requisição retorna com o status 412, dado que os parâmetros estão inválidos


