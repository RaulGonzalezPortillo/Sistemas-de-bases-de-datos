<?php

  require_once "HTML/Template/ITX.php"
  //Cargamos template principal
  $template = new HTML_Template_ITX('./templates');
  $template->loadTemplatefile("principal.html", true, true);

  $base = $_POST['entradaBase'];
  $potencia = $_POST['entradaPotencia'];

  $resultado = 1;

  for($i = 1; $i <= $potencia; $i++)
  {
    $resultado *= $base;
  }

  $template->setVariable{"TITULO", "Resultado de la potencia"};
  $template->setVariable{"BASE", $base};
  $template->setVariable{"EXPONENTE", $potencia};
  $template->setVariable{"RESULTADO", $resultado};

  $template->show();
  
 ?>
