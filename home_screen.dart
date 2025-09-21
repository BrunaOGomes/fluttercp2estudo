import 'package:cp2tentativa1/explorer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  //aqui declara um formulario
  late GlobalKey _formKey;
  //aqui geramos uma lista para colocar os elementos dela,colocamos vazia
  //chamado quando o widget é criado
  //widget é a unidade básica da interface de usuário (UI). Toda a UI do aplicativo Flutter é composta por widgets. Tudo, desde botões, textos, campos de texto, até o layout da tela, é um widget.
  final List<Explorer> listexplores = [];
  //aqui serve para realizar tarefas de configuração e inicialização únicas e necessárias para um StatefulWidget antes que ele seja exibido na tela.
  @override
  void initState() {
    _formKey = GlobalKey();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // Limpa os controladores para evitar vazamento de memória
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  //metodo que constroi a interface
  Widget build(BuildContext context) {
    //estrutura de layout que será retornada
    return Scaffold(
      //cria barra superior,mostratitulo passado no parametro(title no caso)
      appBar: AppBar(title: Text(widget.title)),
      //onde fica o conteudo
      //row= coloca os elementos lado a lado
      body: Row(
        children: [
          //serve para que um widget filho ocupe todo o espaço disponível em um eixo principal
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              color: Color.fromARGB(255, 255, 0, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Formulário"),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            label: Text("Informe o nome do explorador"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            label: Text("Informe a idade do explorador"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            final name = _nameController.text;
                            final age = _ageController.text;
                            final explorer = Explorer(name: name, age: age);
                                                        //abaixo faz com que redesenhe

                            setState(() {
                              listexplores.add(explorer);
                            });
                            _nameController.clear();
                            _ageController.clear();
                          },
                          child: Text("Salvar"),
                           /* setState(() {
                              _name = _nameController.text;
                              _age = _ageController.text;
                            });*/
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromARGB(255, 0, 119, 255),
              child: Column(
                children: [
                  Text("Exploradores"),
                  Expanded(
                    child: ListView.builder(
                      //responsavel pela contagem de itens(conta a qt de itens da lista)
                      itemCount: listexplores.length,
                      //contexto é tipo guarda isso na tela  para nao se perder ao ser redesenhado
                      itemBuilder: (context, index) {
                        final explorer = listexplores[index];
                        //retorna ncada elemento da list
                        return ListTile(
                          title: Text(explorer.name),
                          subtitle: Text(explorer.age),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
