import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            Expanded(
              child: ListaNoticias(newsService.getArticulosCategoriaSeleccionada),
            ),
          ],
        )
      ),
    );

  }

}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    
  final categories  = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 100,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

          // Se extrae el nombre de la categoria para poder capitalizar la primera leta
          final cName = categories[index].name;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButon(categories[index]),
                SizedBox(height: 5,),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
              ],
            ),
          );
       },
      ),
    );
  }
}

class _CategoryButon extends StatelessWidget {

  final Category categoria;

  const _CategoryButon(this.categoria);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        // print('${categoria.name}');
        // Si el provider esta en un evento click se le pone el listen: false para no crear otras instancias
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name)
                 ? miTema.accentColor
                 : Colors.black54
        ),
      ),
    );

  }

}