## README

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

## Getting routes
LiaMut2.pl script is a recursive algorithm that will give you all routes once you set a final point. This script uses binary information contain on STARTS hash, for example `$STARTS{10.1}="11101111111";`means that variant 10.1 posses all mutations except the fourth. Whit this information, once a final point is set the script will calculate all posible routes to this end. Without restrictions and setting as an end variant 9.3 `$final="9.3";` the runing  
`perl LiaMut2.pl`  
give us 534 routes.

If in addition 
if ($PROFAR{$key}>=.004)  -> 110 rutas
if ($PROFAR{$key}>=.004 and $PRA{$key}>=.0001) -> 41 rutas

##Draw routes  
 perl 2.3DrawFig2.pl RUTAS_534
### Output SOLOCIRCULOS_RUTAS_534

SolocirculosPRO
perl 2.3DrawFig2.pl RUTAS_110
my $flagPRO=1;

SoloCirculosPRA
my $flagPRA=1;
perl 2.3DrawFig2.pl RUTAS_110

## Graficar deltas en R

