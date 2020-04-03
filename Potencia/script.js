function verifica()
{
  if(document.formaPotencia.entradaBase.value.length == 0)
  {
    alert("Ingrese la base");
    return false;
  }
  if(document.formaPotencia.entradaPotencia.value.length == 0)
  {
    alert("Ingrese la potencia");
    return false;
  }
}
