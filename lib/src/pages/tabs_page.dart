
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:provider/provider.dart';


class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // El Scaffold esta envuelto en el ChangeNotifierProvider para poder mandar y escuchar info
    // a todos sus hijos
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );

  }

}

class _Navegacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) => navegacionModel.paginaActual = value,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('Para ti')),
        BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Encabezados')),
      ]
    );
  }

}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[

        Tab1Page(),
        
        Tab2Page(),

      ],
    );

  }

}

/**
 * Esta clase es la encargada de gestionar la navegación de nuestro bottom nav bar
 * es como un patron Bloc pero más limpio.
 */

class _NavegacionModel with ChangeNotifier {

  int _paginaActual = 0;
  PageController _pageController = new PageController(initialPage: 0);

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    
    // Cambia de página
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;

}