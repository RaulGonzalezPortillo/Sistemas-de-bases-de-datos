<?php

  require_once "HTML/Template/ITX.php";
  //Carga del template principal
  $template = new HTML_Template_ITX('./templates');
  $template->loadTemplatefile("principal.html", true, true);
	
		$Base = $_POST['entradaBase'];
		$Exponente = $_POST['entradaPotencia'];
		$Resultado = pow($Base,$Exponente);
	
		$template->setVariable("TITULO", "Resultado"); 
		$template->setVariable("BASE", $Base);
		$template->setVariable("EXPONENTE", $Exponente);
		$template->setVariable("RESULTADO", $Resultado);

	// Mostramos la pagina con los templates que llenamos
	$template->show();
 
 ?>
