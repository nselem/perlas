README

Dejar la .004 para PROFAR
Para PRA no poner cutoff

En cada paso, sacar el delta, de las mutaciones, sacar promedio y desviación estandar 
EN las x cada mutación, y en las y promedio mas desviación estándar.


Procedimiento:
Datos 
Tabla provista por Lianet de actividades de ProFAr y PRA de 89 las mutantes
Para graficar cambiamos a los valores


Funciona bien para todos ya que todos tienen valores menor que 1,
excepto para la mutante 6.6 Manda el maximo 1.36->-7.488454206 a un negativo

## Obtener todas las rutas
perl LiaMut2.pl
Escogiendo como final a variante 9.3 $final="9.3";
sin restricciones obtengo 534 rutas
if ($PROFAR{$key}>=.004)  -> 110 rutas
if ($PROFAR{$key}>=.004 and $PRA{$key}>=.0001) -> 41 rutas

##Dibujar las rutas
SOLOCIRCULOS 
perl 2.3DrawFig2.pl RUTAS_534

SolocirculosPRO
perl 2.3DrawFig2.pl RUTAS_110
my $flagPRO=1;

SoloCirculosPRA
my $flagPRA=1;
perl 2.3DrawFig2.pl RUTAS_110

## Graficar deltas en R

