function verifica()
{
  if(document.formaPotencia.entradaBase.value.length == 0)
  {
    alert("Falta la base");
    return false;
  }
  if(document.formaPotencia.entradaPotencia.value.length == 0)
  {
    alert("Falta la potencia");
    return false;
  }
}
