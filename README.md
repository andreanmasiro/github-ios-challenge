# **Criar um aplicativo iOS de consulta de CEP** #
O aplicativo deverá consultar um serviço REST público de CEP (passaremos URL e documentação).A interface deverá conter um campo para digitar o CEP, um botão de consulta e um botão de visualizar consultas anteriores.
A lista de consultas anteriores deverá ser apresentada em uma nova viewcontroller
O aplicativo deverá ter tratamento para os casos de erro (sem conexão, CEP inválido, serviço indisponível)


### **Ganha pontos se:** ###
a) [+3] o aplicativo for desenvolvido com AFNetwork ou STHTTPRequest
b) [+3] fazer o mapeamento da resposta do serviço de cep para um objeto usando Mantl
c) [+5] o aplicativo for desenvolvido com CocoaPods
d) [+2] o aplicativo suportar mudanças de orientação sem erros (portrait e landscape)
e) [+1] o campo de CEP possuir máscara
f) [+1] o aplicativo persistir a busca de CEPs
g) [+3] criar um projeto de testes automatizados
g) [+8] usar frameworks de testes : Specta| Expecta | OCMock

### **URL e Documentação de um serviço de consulta de CEP RESTful:** ###
Documentação da API: http://correiosapi.apphb.com
Exemplo de uso da API: http://correiosapi.apphb.com/cep/76873274

### **Processo de submissão** ###
O candidato deverá implementar a solução e enviar um pull request para este repositório com a solução.