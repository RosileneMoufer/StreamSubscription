# Adição de nome de usuários em uma lista com StreamSubscription.

<p>
Esta aplicação usa o StreamSubscription para exibir instantaneamente os valores inseridos através de um formulário. <br />
O StreamSubscription recebe o StreamController<>.brodcast() e fica escutando com o listen do brodcast os novos valores adicionados na lista. Assim que um novo usuário é escutado, ele é adicionado em uma lista de widgets que pussui o design de cada célula da lista.<br />
Quando a função de inserção de usúario é chamada, ela invoca streamController.sink.add() e passa o novo usuário como parâmetro de add(). <br />
</p>

![image1068](https://user-images.githubusercontent.com/9465347/175112807-ccf93ddd-f4ad-4321-a700-2ded8f375d29.png)
