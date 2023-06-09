import 'package:web/model/Produto.dart';
import 'package:web/page/ProdutoEditPage.dart';
import 'package:web/wsClient/ProdutoWSClient.dart';
import 'package:flutter/material.dart';

class EditarProdutoPage extends StatefulWidget {
  const EditarProdutoPage({Key? key}) : super(key: key);

  @override
  State<EditarProdutoPage> createState() => _EditarProdutoPage();
}

class _EditarProdutoPage extends State<EditarProdutoPage> {
  List<Produto> lsProduto = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loadProdutos());
  }

  void loadProdutos() async {
    lsProduto = await ProdutoWSClient().getAll();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text("Escolha um produto para editar")),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(child: ListView.builder(
                padding: EdgeInsets.all(5),
                itemCount: lsProduto.length,
                itemBuilder: (context, index) {
                  return templateRowListView(index);
                }
            ))
          ],
        )
    );
  }

  Widget templateRowListView(int index) {
    Produto produto = lsProduto[index];
    return Card(
        elevation: 10,
        child: InkWell(
            onTap: () => editarProdutoAction(produto),
            child: templateCellListView(produto))
    );
  }


  Widget templateCellListView(Produto produto) {
    return Padding(padding: EdgeInsets.all(25.0),
        child:Row(
          children: [
            Text("${produto.id}"),
            SizedBox(width: 50,),
            Text(produto.nome!),
            SizedBox(width: 50,),
            Text("${produto.preco}"),
            SizedBox(width: 50,),
            Text(produto.descricao!),
            SizedBox(width: 50,),
            Expanded(child: Text("")),
            Text("${produto.categoriaId!}"),

            //Icon(Icons.navigate_next, color: Colors.orange,)
          ],
        )
    );
  }

  void addProdutoAction() {

  }
  void editarProdutoAction(Produto produto) {
    Navigator.push(context,
      MaterialPageRoute( builder: (context) => ProdutoEditPage(produto: produto,)),
    ).then((value) => {
      loadProdutos()
    });
  }
}
