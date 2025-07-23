import 'package:flutter/material.dart';

abstract class PageDIBase {
  ///Inicializa as dependências da página
  void init();

  ///Retorna a página usada na navegação
  StatefulWidget getPage();
}
