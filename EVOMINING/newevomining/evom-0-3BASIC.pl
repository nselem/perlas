#!/usr/bin/perl -w
#####################################################
# CODIGO PARA UPLOAD-FILE
#
#####################################################

#use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI;
use Statistics::Basic qw(:all);
############################## def-DBM #################################
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR
;
############################## def-SUB  ################################
my $tfm2 = "mi_hashNUMVia.db" ;
$hand2 = tie my %hashNUMVia, $tipoDB , "$tfm2" , $RWC , 0644 ;
print "$! \nerror tie para $tfm2 \n" if ($hand2 eq "");



my %Input;

my $query = new CGI;
print $query->header,
      $query->start_html(-style => {-src => '/newevomining/css/tabla.css'} );
my @pairs = $query->param;

foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}	



#--------------------------------------
$date = `date`;
@divDate=split(/ /,$date);

$pid_fecha=$$."_".$divDate[0].$divDate[1].$divDate[2].$divDate[$#divDate];
$outdir="$pid_fecha";

chomp($outdir);
#system "mkdir $outdir";
$la="/var/www/newevomining/blast/";
#mkdir( $la ) or die "Couldn't create $la directory, $!";
#mkdir ("/var/www/newevomining/blast/seqf");
#
#mkdir ("/var/www/newevomining/blast/seqf/tree");
#mkdir ("/var/www/newevomining/FASTASparaNP");
#mkdir ("/var/www/newevomining/NewFASTASparaNP");
#--------------------------------------




### no estan en la ultima BD: 21
### Brevibacterium linens BL2,Janibacter HTCC2649,Propionibacterium humerusii P08, Streptomyces hygroscopicusATCC53653,
### Streptomyces flavogriseus ATCC33331, Streptomyces coelicolorM145, Streptomyces ipomoeae 9103, Thermobispora bispora DSM43833
### Amycolatopsis ATCC39116, Saccharomonospora marina XMU15, Saccharomonospora azurea NA128
### Corynebacterium jeikeium ATCC43734, Corynebacterium glucuronolyticum ATCC51867, Corynebacterium accolens ATCC49725,
### Corynebacterium striatum ATCC6940, Mycobacterium abscessus ATCC19977,Mycobacterium thermoresistibile ATCC19527
### Mycobacterium rhodesiae NBB3, Mycobacterium parascrofulaceum ATCCBAA614, Mycobacterium marinum M, Mycobacterium kansasii 12478,
###
### 


#
##--------------------------------hash nombres-------------
#$hashNOMBRES{'BifidobacteriumanimalissubsplactisAD011'}="Bifidobacterium animalislactisADO11";
#$hashNOMBRES{BifidobacteriumadolescentisATCC15703}="Bifidobacterium adolescentisATC15703";
#$hashNOMBRES{BifidobacteriumlongumDJO10A}="Bifidobacterium longumDJO10A";
#$hashNOMBRES{'ClavibactermichiganensissubspmichiganensisNCPPB382'}="Clavibacter michiganensis";
#$hashNOMBRES{'LeifsoniaxylisubspxylistrCTCB07'}="Leifsonia xyli CTCB07";
####$hashNOMBRES{BrevibacteriumlinensBL2}="Brevibacterium linens BL2";
#$hashNOMBRES{RenibacteriumsalmoninarumATCC33209}="Renibacterium salmoninarumATCC33209";
#$hashNOMBRES{ArthrobacterchlorophenolicusA6}="Arthrobacter chlorophenolicusA6";
#$hashNOMBRES{ArthrobacteraurescensTC1}="Arthrobacter aurescens TC1";
#$hashNOMBRES{ArthrobacterphenanthrenivoransSphe3}="Arthrobacter phenanthrenivorans Sphe3";
#$hashNOMBRES{ArthrobacterarilaitensisRe117}="Arthrobacter arilaitensis Re117";
#$hashNOMBRES{KocuriarhizophilaDC2201}="Kocuria rhizophilaDC2201";
#$hashNOMBRES{MicrococcusluteusNCTC2665}="Micrococcus luteus NCTC2665";
#$hashNOMBRES{'CitricoccusspCH26A'}="Citricoccus CH26A";
#$hashNOMBRES{KineococcusradiotoleransSRS30216}="Kineococcus radiotoleransSRS30216";
####$hashNOMBRES{'JanibacterspHTCC2649'}="Janibacter HTCC2649";
#$hashNOMBRES{'NocardioidesspJS614'}="Nocardioides JS614";
#$hashNOMBRES{'PropionibacteriumfreudenreichiisubspshermaniiCIRMBIA1'}="Propionibacterium freudenreichii CIRMBIA1";
####$hashNOMBRES{PropionibacteriumhumerusiiP08}="Propionibacterium humerusii P08";
#$hashNOMBRES{PropionibacteriumacnesKPA171202}="Propionebacterium acnesKPA171202";
#$hashNOMBRES{CatenulisporaacidiphilaDSM44928}="Catenulispora acidiphila DSM44928";
#$hashNOMBRES{'KitasatosporasetaeKM6054'}="Kitasatospora setae KM6054";
#$hashNOMBRES{'StreptomycescattleyaNRRL8057DSM46488'}="Streptomyces cattleya DSM46488";
#$hashNOMBRES{StreptomycesauratusAGR0001}="Streptomyces auratus AGR0001";
####$hashNOMBRES{StreptomyceshygroscopicusATCC53653}="Streptomyces hygroscopicusATCC53653";
#$hashNOMBRES{'StreptomycesbingchenggensisBCW1'}="Streptomyces bingchenggensis BCW1";
#$hashNOMBRES{StreptomycesviolaceusnigerTu4113}="Streptomyces violaceusniger Tu4113";
#$hashNOMBRES{StreptomycesclavuligerusATCC27064}="Streptomyces clavuligerus ATCC27064";
#$hashNOMBRES{StreptomycestsukubaensisNRRL18488}="Streptomyces tsukubaensis NRRL18488";
#$hashNOMBRES{StreptomycespristinaespiralisATCC25486}="Streptomyces pristinaespiralis ATCC 25486";
####$hashNOMBRES{StreptomycesflavogriseusATCC33331}="Streptomyces flavogriseus ATCC33331";
#$hashNOMBRES{'StreptomycesspSirexAAE'}="Streptomyces spSirexAAE";
#$hashNOMBRES{'StreptomycesspW007'}="Streptomyces spW007";
#$hashNOMBRES{'StreptomycesglobisporusC1027'}="Streptomyces globisporus C1027";
#$hashNOMBRES{'StreptomycesgriseussubspgriseusNBRC13350'}="Streptomyces griseus";
#$hashNOMBRES{'StreptomycesgriseusXylebKG1'}="Streptomyces griseus XylebKG1";
#$hashNOMBRES{StreptomycesroseosporusNRRL11379}="Streptomyces roseosporus NRRL11379";
#$hashNOMBRES{StreptomycesroseosporusNRRL15998}="Streptomyces roseosporusNRRL15998";
#$hashNOMBRES{'Streptomycesscabiei8722'}="Streptomyces scabiei";
#$hashNOMBRES{'StreptomycesspMg1'}="Streptomyces spMg1";
#$hashNOMBRES{StreptomycesspC}="Streptomyces spC";
#$hashNOMBRES{StreptomycesvenezuelaeATCC10712}="Streptomyces venezuelae ATCC10712";
#$hashNOMBRES{'StreptomycesavermitilisMA4680'}="Streptomyces avermitilis";
#$hashNOMBRES{StreptomycesalbusJ1074}="Streptomyces albus J1074";
#$hashNOMBRES{'StreptomycesspSPB74'}="Streptomyces spSPB74";
#$hashNOMBRES{'StreptomycesspSPB78'}="Streptomyces spSPB78";
#$hashNOMBRES{'StreptomycesspSA3'}="Streptomyces spSA3actG";
#$hashNOMBRES{'StreptomycesspTu6071'}="Streptomyces spTu6071";
#$hashNOMBRES{StreptomycesgriseoflavusTu4000}="Streptomyces griseoflavusTu4000";
#$hashNOMBRES{StreptomycescoelicoflavusZG0656}="Streptomyces coelicoflavus ZG0656";
##$hashNOMBRES{'StreptomycescoelicolorA3(2)'}="Streptomyces coelicolorM145";
#$hashNOMBRES{StreptomyceslividansTK24}="Streptomyces lividans TK24";
#$hashNOMBRES{StreptomycessviceusATCC29083}="Streptomyces sviceus ATCC29083";
#$hashNOMBRES{Streptomyceslividans1326}="Streptomyces lividans 1326";
#$hashNOMBRES{'Streptomycesspe14'}="Streptomyces spe14";
#$hashNOMBRES{StreptomycesgriseoaurantiacusM045}="Streptomyces griseoaurantiacus M045";
#$hashNOMBRES{StreptomyceszinciresistensK42}="Streptomyces zinciresistens K42";
#$hashNOMBRES{StreptomycesdavawensisJCM4913}="Streptomyces davawensis JCM4913";
#$hashNOMBRES{'Streptomycesacidiscabies84104'}="Streptomyces acidiscabies 84104";
####$hashNOMBRES{'Streptomycesipomoeae9103'}="Streptomyces ipomoeae 9103";
#$hashNOMBRES{StreptomycesviridochromogenesDSM40736}="Streptomyces viridochromogenes DSM40736";
#$hashNOMBRES{StreptomyceschartreusisNRRL12338}="Streptomyces chartreusis NRRL12338";
#$hashNOMBRES{StreptomycesghanaensisATCC14672}="Streptomyces ghanaensis ATCC14672";
#$hashNOMBRES{StreptomycessomaliensisDSM40738}="Streptomyces somaliensis DSM40738";
#$hashNOMBRES{StreptomycesviridochromogenesTue57}="Streptomyces viridochromogenes Tue57";
##$hashNOMBRES{}="Acydothermus cellulolyticus11B";*****************************************************************
#$hashNOMBRES{ThermomonosporacurvataDSM43183}="Thermomonospora curvata DSM43183";
#$hashNOMBRES{StreptosporangiumroseumDSM43021}="Streptosporangium roseum DSM43021";
####$hashNOMBRES{ThermobisporabisporaDSM43833}="Thermobispora bispora DSM43833";
#$hashNOMBRES{FrankiasymbiontofDatiscaglomerata}="Frankia Datisca";
#$hashNOMBRES{'FrankiaspEAN1pec'}="Frankia EAN1pec";
#$hashNOMBRES{FrankiaalniACN14a}="Frankia alniACN14a";
#$hashNOMBRES{'FrankiaspCcI3'}="Frankia SPCcI3";
#$hashNOMBRES{'SalinisporatropicaCNB440'}="Salinispora tropica";
#$hashNOMBRES{'SalinisporaarenicolaCNS205'}="Salinispora arenicola";
##$hashNOMBRES{}="Verrucosispora maris AB18032";************************************************************
#$hashNOMBRES{'MicromonosporaspATCC39149'}="Micromonospora spATCC39149";
#$hashNOMBRES{'MicromonosporalupinistrLupac08'}="Micromonospora lupini Lupac08";
#$hashNOMBRES{'MicromonosporaspL5'}="Micromonospora spL5";
#$hashNOMBRES{MicromonosporaaurantiacaATCC27029}="Micromonospora aurantiaca ATCC27029";
#$hashNOMBRES{Modestobactermarinus}="Modestobacter marinus";
#$hashNOMBRES{NakamurellamultipartitaDSM44233}="Nakamurella multipartita DSM44233";
#$hashNOMBRES{PseudonocardiadioxanivoransCB1190}="Pseudonocardia dioxanivorans CB1190";
#$hashNOMBRES{SaccharopolysporaerythraeaNRRL2338}="Saccharopolyspora erythraea";
#$hashNOMBRES{SaccharopolysporaspinosaNRRL18395}="Saccharopolyspora spinosa NRRL18395";
#$hashNOMBRES{SaccharothrixespanaensisDSM44229}="Saccharothrix espanaensis DSM44229";
#$hashNOMBRES{'AmycolatopsisspAA4'}="Amycolatopsis AA4";#********************************************************************
#$hashNOMBRES{AmycolatopsismediterraneiU32}="Amycolatopsis mediterraneiU32";
#$hashNOMBRES{AmycolatopsismediterraneiS699}="Amycolatopsis mediterranei S699";
####$hashNOMBRES{'AmycolatopsisspATCC39116'}="Amycolatopsis ATCC39116";
####$hashNOMBRES{SaccharomonosporamarinaXMU15}="Saccharomonospora marina XMU15";
#$hashNOMBRES{SaccharomonosporapaurometabolicaYIM90007}="Saccharomonospora paurometabolica YIM90007";
#$hashNOMBRES{SaccharomonosporaviridisDSM43017}="Saccharomonospora viridisDSM43017";
#$hashNOMBRES{'SaccharomonosporaxinjiangensisXJ54'}="Saccharomonospora xinjiangensis XJ54";
#$hashNOMBRES{'SaccharomonosporacyaneaNA134'}="Saccharomonospora cyanea NA134";
#$hashNOMBRES{SaccharomonosporaglaucaK62}="Saccharomonospora glauca K62";
####$hashNOMBRES{'SaccharomonosporaazureaNA128'}="Saccharomonospora azurea NA128";
#$hashNOMBRES{SaccharomonosporaazureaSZMC14600}="Saccharomonospora azurea SZMC14600";
#$hashNOMBRES{DietziacinnameaP4}="Dietzia cinnamea P4";
#$hashNOMBRES{CorynebacteriumamycolatumSK46}="Corynebacterium amycolatum SK46";
#$hashNOMBRES{CorynebacteriumkroppenstedtiiDSM44385}="Corynebacterium kroppenstedtii DSM44385";
#$hashNOMBRES{CorynebacteriumurealyticumDSM7109}="Corynebacterium urealyticum DSM7109";
####$hashNOMBRES{CorynebacteriumjeikeiumATCC43734}="Corynebacterium jeikeium ATCC43734";
#$hashNOMBRES{CorynebacteriumjeikeiumK411}="Corynebacterium jeikenium K411";
#$hashNOMBRES{CorynebacteriumglutamicumR}="Corynebacterium glutamicum R";
#$hashNOMBRES{CorynebacteriumglutamicumATCC13032}="Corynebacterium glutamicum ATCC13032";
#$hashNOMBRES{Corynebacteriumdiphtheriae}="Corynebacterium diphteriae";
#$hashNOMBRES{'CorynebacteriumefficiensYS314'}="Corynebacterium efficiens YS314";
####$hashNOMBRES{CorynebacteriumglucuronolyticumATCC51867}="Corynebacterium glucuronolyticum ATCC51867";
####$hashNOMBRES{CorynebacteriumaccolensATCC49725}="Corynebacterium accolens ATCC49725";
####$hashNOMBRES{CorynebacteriumstriatumATCC6940}="Corynebacterium striatum ATCC6940";
##$hashNOMBRES{}="Tsukamurella paurometabola DSM20162";***************************************************************
#$hashNOMBRES{GordoniapolyisoprenivoransVH2}="Gordonia polyisoprenivorans VH2";
##$hashNOMBRES{}="Rhodococcus pyridinivorans AK37";**************************************************
##$hashNOMBRES{}="Rhodococcus equi ATCC33707";*********************************************************
##$hashNOMBRES{}="Rhodococcus erythropolis PR4";********************************************************
##$hashNOMBRES{}="Rhodococcus erythropolis SK121";*********************************************************
##$hashNOMBRES{}="Rhodococcus jostii RHA1";**************************************************************
##$hashNOMBRES{}="Rhodococcus opacus B4";*****************************************************************
##$hashNOMBRES{}="Rhodococcus imtechensis RKJ300";*******************************************************
#$hashNOMBRES{NocardiabrasiliensisATCC700358}="Nocardia brasiliensis ATCC700358";
#$hashNOMBRES{'NocardiacyriacigeorgicaGUH2'}="Nocardia cyriacigeorgica";
#$hashNOMBRES{NocardiafarcinicaIFM10152}="Nocardia farcinicaIFM10152";
####$hashNOMBRES{MycobacteriumabscessusATCC19977}="Mycobacterium abscessus ATCC19977";
#$hashNOMBRES{'MycobacteriumsmegmatisstrMC2155'}="Mycobacterium smegmatis MC2155";
####$hashNOMBRES{MycobacteriumthermoresistibileATCC19527}="Mycobacterium thermoresistibile ATCC19527";
####$hashNOMBRES{MycobacteriumrhodesiaeNBB3}="Mycobacterium rhodesiae NBB3";
#$hashNOMBRES{'MycobacteriumvanbaaleniiPYR1'}="Mycobacterium vanbaalenii PYR1";
#$hashNOMBRES{'MycobacteriumgilvumPYRGCK'}="Mycobacterium gilvum PYRGCK";
#$hashNOMBRES{'MycobacteriumspJLS'}="Mycobacterium spJLS";
#$hashNOMBRES{'MycobacteriumspMCS'}="Mycobacterium sp MCS";
#$hashNOMBRES{'MycobacteriumspKMS'}="Mycobacterium sp KMS";
####$hashNOMBRES{'MycobacteriumparascrofulaceumATCCBAA614'}="Mycobacterium parascrofulaceum ATCCBAA614";
#$hashNOMBRES{MycobacteriumulceransAgy99}="Mycobacterium ulcerans Agy99";
####$hashNOMBRES{MycobacteriummarinumM}="Mycobacterium marinum M";
####$hashNOMBRES{MycobacteriumkansasiiATCC12478}="Mycobacterium kansasii 12478";
#$hashNOMBRES{Mycobacteriumleprae}="Mycobacterium leprae";
#$hashNOMBRES{MycobacteriumtuberculosisCDC1551}="Mycobacterium tuberculosis CDC1551";
#$hashNOMBRES{MycobacteriumafricanumGM041182}="Mycobacterium africanum GM041182";
#$hashNOMBRES{'MycobacteriumbovisBCGstrMexico'}="Mycobacterium bovis BCG Mexico";
################################################################################
##   hash orden nombres
#$hashOrdenNOMBRES{"Bifidobacterium animalislactisADO11"}=0;
#$hashOrdenNOMBRES2{0}="Bifidobacterium animalislactisADO11";
#$hashOrdenNOMBRES{"Bifidobacterium adolescentisATC15703"}=1;
#$hashOrdenNOMBRES2{1}="Bifidobacterium adolescentisATC15703";
#$hashOrdenNOMBRES{"Bifidobacterium longumDJO10A"}=2;
#$hashOrdenNOMBRES2{2}="Bifidobacterium longumDJO10A";
#$hashOrdenNOMBRES{"Clavibacter michiganensis"}=3;
#$hashOrdenNOMBRES2{3}="Clavibacter michiganensis";
#$hashOrdenNOMBRES{"Leifsonia xyli CTCB07"}=4;
#$hashOrdenNOMBRES2{4}="Leifsonia xyli CTCB07";
####$hashOrdenNOMBRES{"Brevibacterium linens BL2"}=5;
####$hashOrdenNOMBRES2{5}="Brevibacterium linens BL2";
#$hashOrdenNOMBRES{"Renibacterium salmoninarumATCC33209"}=5;
#$hashOrdenNOMBRES2{5}="Renibacterium salmoninarumATCC33209";
#$hashOrdenNOMBRES{"Arthrobacter chlorophenolicusA6"}=6;
#$hashOrdenNOMBRES2{6}="Arthrobacter chlorophenolicusA6";
#$hashOrdenNOMBRES{"Arthrobacter aurescens TC1"}=7;
#$hashOrdenNOMBRES2{7}="Arthrobacter aurescens TC1";
#$hashOrdenNOMBRES{"Arthrobacter phenanthrenivorans Sphe3"}=8;
#$hashOrdenNOMBRES2{8}="Arthrobacter phenanthrenivorans Sphe3";
#$hashOrdenNOMBRES{"Arthrobacter arilaitensis Re117"}=9;
#$hashOrdenNOMBRES2{9}="Arthrobacter arilaitensis Re117";
#$hashOrdenNOMBRES{"Kocuria rhizophilaDC2201"}=10;
#$hashOrdenNOMBRES2{10}="Kocuria rhizophilaDC2201";
#$hashOrdenNOMBRES{"Micrococcus luteus NCTC2665"}=11;
#$hashOrdenNOMBRES2{11}="Micrococcus luteus NCTC2665";
#$hashOrdenNOMBRES{"Citricoccus CH26A"}=12;
#$hashOrdenNOMBRES2{12}="Citricoccus CH26A";
#$hashOrdenNOMBRES{"Kineococcus radiotoleransSRS30216"}=13;
#$hashOrdenNOMBRES2{13}="Kineococcus radiotoleransSRS30216";
####$hashOrdenNOMBRES{"Janibacter HTCC2649"}=15;
####$hashOrdenNOMBRES2{15}="Janibacter HTCC2649";
#$hashOrdenNOMBRES{"Nocardioides JS614"}=14;
#$hashOrdenNOMBRES2{14}="Nocardioides JS614";
#$hashOrdenNOMBRES{"Propionibacterium freudenreichii CIRMBIA1"}=15;
#$hashOrdenNOMBRES2{15}="Propionibacterium freudenreichii CIRMBIA1";
####$hashOrdenNOMBRES{"Propionibacterium humerusii P08"}=18;
####$hashOrdenNOMBRES2{18}="Propionibacterium humerusii P08";
#$hashOrdenNOMBRES{"Propionebacterium acnesKPA171202"}=16;
#$hashOrdenNOMBRES2{16}="Propionebacterium acnesKPA171202";
#$hashOrdenNOMBRES{"Catenulispora acidiphila DSM44928"}=17;
#$hashOrdenNOMBRES2{17}="Catenulispora acidiphila DSM44928";
#$hashOrdenNOMBRES{"Kitasatospora setae KM6054"}=18;
#$hashOrdenNOMBRES2{18}="Kitasatospora setae KM6054";
#$hashOrdenNOMBRES{"Streptomyces cattleya DSM46488"}=19;
#$hashOrdenNOMBRES2{19}="Streptomyces cattleya DSM46488";
#$hashOrdenNOMBRES{"Streptomyces auratus AGR0001"}=20;
#$hashOrdenNOMBRES2{20}="Streptomyces auratus AGR0001";
####$hashOrdenNOMBRES{"Streptomyces hygroscopicusATCC53653"}=24;
####$hashOrdenNOMBRES2{24}="Streptomyces hygroscopicusATCC53653";
#$hashOrdenNOMBRES{"Streptomyces bingchenggensis BCW1"}=21;
#$hashOrdenNOMBRES2{21}="Streptomyces bingchenggensis BCW1";
#$hashOrdenNOMBRES{"Streptomyces violaceusniger Tu4113"}=22;
#$hashOrdenNOMBRES2{22}="Streptomyces violaceusniger Tu4113";
#$hashOrdenNOMBRES{"Streptomyces clavuligerus ATCC27064"}=23;
#$hashOrdenNOMBRES2{23}="Streptomyces clavuligerus ATCC27064";
#$hashOrdenNOMBRES{"Streptomyces tsukubaensis NRRL18488"}=24;
#$hashOrdenNOMBRES2{24}="Streptomyces tsukubaensis NRRL18488";
#$hashOrdenNOMBRES{"Streptomyces pristinaespiralis ATCC 25486"}=25;
#$hashOrdenNOMBRES2{25}="Streptomyces pristinaespiralis ATCC 25486";
####$hashOrdenNOMBRES{"Streptomyces flavogriseus ATCC33331"}=30;
####$hashOrdenNOMBRES2{30}="Streptomyces flavogriseus ATCC33331";
#$hashOrdenNOMBRES{"Streptomyces spSirexAAE"}=26;
#$hashOrdenNOMBRES2{26}="Streptomyces spSirexAAE";
#$hashOrdenNOMBRES{"Streptomyces spW007"}=27;
#$hashOrdenNOMBRES2{27}="Streptomyces spW007";
#$hashOrdenNOMBRES{"Streptomyces globisporus C1027"}=28;
#$hashOrdenNOMBRES2{28}="Streptomyces globisporus C1027";
#$hashOrdenNOMBRES{"Streptomyces griseus"}=29;
#$hashOrdenNOMBRES2{29}="Streptomyces griseus";
#$hashOrdenNOMBRES{"Streptomyces griseus XylebKG1"}=30;
#$hashOrdenNOMBRES2{30}="Streptomyces griseus XylebKG1";
#$hashOrdenNOMBRES{"Streptomyces roseosporus NRRL11379"}=31;
#$hashOrdenNOMBRES2{31}="Streptomyces roseosporus NRRL11379";
#$hashOrdenNOMBRES{"Streptomyces roseosporusNRRL15998"}=32;
#$hashOrdenNOMBRES2{32}="Streptomyces roseosporusNRRL15998";
#$hashOrdenNOMBRES{"Streptomyces scabiei"}=33;
#$hashOrdenNOMBRES2{33}="Streptomyces scabiei";
#$hashOrdenNOMBRES{"Streptomyces spMg1"}=34;
#$hashOrdenNOMBRES2{34}="Streptomyces spMg1";
#$hashOrdenNOMBRES{"Streptomyces spC"}=35;
#$hashOrdenNOMBRES2{35}="Streptomyces spC";
#$hashOrdenNOMBRES{"Streptomyces venezuelae ATCC10712"}=36;
#$hashOrdenNOMBRES2{36}="Streptomyces venezuelae ATCC10712";
#$hashOrdenNOMBRES{"Streptomyces avermitilis"}=37;
#$hashOrdenNOMBRES2{37}="Streptomyces avermitilis";
#$hashOrdenNOMBRES{"Streptomyces albus J1074"}=38;
#$hashOrdenNOMBRES2{38}="Streptomyces albus J1074";
#$hashOrdenNOMBRES{"Streptomyces spSPB74"}=39;
#$hashOrdenNOMBRES2{39}="Streptomyces spSPB74";
#$hashOrdenNOMBRES{"Streptomyces spSPB78"}=40;
#$hashOrdenNOMBRES2{40}="Streptomyces spSPB78";
####$hashOrdenNOMBRES{"Streptomyces spSA3actG"}=41;
####$hashOrdenNOMBRES2{41}="Streptomyces spSA3actG";
#$hashOrdenNOMBRES{"Streptomyces spTu6071"}=41;
#$hashOrdenNOMBRES2{41}="Streptomyces spTu6071";
#$hashOrdenNOMBRES{"Streptomyces griseoflavusTu4000"}=42;
#$hashOrdenNOMBRES2{42}="Streptomyces griseoflavusTu4000";
#$hashOrdenNOMBRES{"Streptomyces coelicoflavus ZG0656"}=43;
#$hashOrdenNOMBRES2{43}="Streptomyces coelicoflavus ZG0656";
####$hashOrdenNOMBRES{"Streptomyces coelicolorM145"}=50;
####$hashOrdenNOMBRES2{50}="Streptomyces coelicolorM145";
#$hashOrdenNOMBRES{"Streptomyces lividans TK24"}=44;
#$hashOrdenNOMBRES2{44}="Streptomyces lividans TK24";
#$hashOrdenNOMBRES{"Streptomyces sviceus ATCC29083"}=45;
#$hashOrdenNOMBRES2{45}="Streptomyces sviceus ATCC29083";
#$hashOrdenNOMBRES{"Streptomyces lividans 1326"}=46;
#$hashOrdenNOMBRES2{46}="Streptomyces lividans 1326";
#$hashOrdenNOMBRES{"Streptomyces spe14"}=47;
#$hashOrdenNOMBRES2{47}="Streptomyces spe14";
#$hashOrdenNOMBRES{"Streptomyces griseoaurantiacus M045"}=48;
#$hashOrdenNOMBRES2{48}="Streptomyces griseoaurantiacus M045";
#$hashOrdenNOMBRES{"Streptomyces zinciresistens K42"}=49;
#$hashOrdenNOMBRES2{49}="Streptomyces zinciresistens K42";
#$hashOrdenNOMBRES{"Streptomyces davawensis JCM4913"}=50;
#$hashOrdenNOMBRES2{50}="Streptomyces davawensis JCM4913";
#$hashOrdenNOMBRES{"Streptomyces acidiscabies 84104"}=51;
#$hashOrdenNOMBRES2{51}="Streptomyces acidiscabies 84104";
####$hashOrdenNOMBRES{"Streptomyces ipomoeae 9103"}=59;
####$hashOrdenNOMBRES2{59}="Streptomyces ipomoeae 9103";
#$hashOrdenNOMBRES{"Streptomyces viridochromogenes DSM40736"}=52;
#$hashOrdenNOMBRES2{52}="Streptomyces viridochromogenes DSM40736";
#$hashOrdenNOMBRES{"Streptomyces chartreusis NRRL12338"}=53;
#$hashOrdenNOMBRES2{53}="Streptomyces chartreusis NRRL12338";
#$hashOrdenNOMBRES{"Streptomyces ghanaensis ATCC14672"}=54;
#$hashOrdenNOMBRES2{54}="Streptomyces ghanaensis ATCC14672";
#$hashOrdenNOMBRES{"Streptomyces somaliensis DSM40738"}=55;
#$hashOrdenNOMBRES2{55}="Streptomyces somaliensis DSM40738";
#$hashOrdenNOMBRES{"Streptomyces viridochromogenes Tue57"}=56;
#$hashOrdenNOMBRES2{56}="Streptomyces viridochromogenes Tue57";
##$hashOrdenNOMBRES{"Thermomonospora curvata DSM43183"}=58;
##$hashOrdenNOMBRES2{58}="Thermomonospora curvata DSM43183";
#$hashOrdenNOMBRES{"Streptosporangium roseum DSM43021"}=57;
#$hashOrdenNOMBRES2{57}="Streptosporangium roseum DSM43021";
####$hashOrdenNOMBRES{"Thermobispora bispora DSM43833"}=67;
####$hashOrdenNOMBRES2{67}="Thermobispora bispora DSM43833";
#$hashOrdenNOMBRES{"Frankia Datisca"}=58;
#$hashOrdenNOMBRES2{58}="Frankia Datisca";
#$hashOrdenNOMBRES{"Frankia EAN1pec"}=59;
#$hashOrdenNOMBRES2{59}="Frankia EAN1pec";
#$hashOrdenNOMBRES{"Frankia alniACN14a"}=60;
#$hashOrdenNOMBRES2{60}="Frankia alniACN14a";
#$hashOrdenNOMBRES{"Frankia SPCcI3"}=61;
#$hashOrdenNOMBRES2{61}="Frankia SPCcI3";
#$hashOrdenNOMBRES{"Salinispora tropica"}=62;
#$hashOrdenNOMBRES2{62}="Salinispora tropica";
#$hashOrdenNOMBRES{"Salinispora arenicola"}=63;
#$hashOrdenNOMBRES2{63}="Salinispora arenicola";
#$hashOrdenNOMBRES{"Micromonospora spATCC39149"}=64;
#$hashOrdenNOMBRES2{64}="Micromonospora spATCC39149";
#$hashOrdenNOMBRES{"Micromonospora lupini Lupac08"}=65;
#$hashOrdenNOMBRES2{65}="Micromonospora lupini Lupac08";
#$hashOrdenNOMBRES{"Micromonospora spL5"}=66;
#$hashOrdenNOMBRES2{66}="Micromonospora spL5";
#$hashOrdenNOMBRES{"Micromonospora aurantiaca ATCC27029"}=67;
#$hashOrdenNOMBRES2{67}="Micromonospora aurantiaca ATCC27029";
#$hashOrdenNOMBRES{"Modestobacter marinus"}=68;
#$hashOrdenNOMBRES2{68}="Modestobacter marinus";
#$hashOrdenNOMBRES{"Nakamurella multipartita DSM44233"}=69;
#$hashOrdenNOMBRES2{69}="Nakamurella multipartita DSM44233";
#$hashOrdenNOMBRES{"Pseudonocardia dioxanivorans CB1190"}=70;
#$hashOrdenNOMBRES2{70}="Pseudonocardia dioxanivorans CB1190";
#$hashOrdenNOMBRES{"Saccharopolyspora erythraea"}=71;
#$hashOrdenNOMBRES2{71}="Saccharopolyspora erythraea";
#$hashOrdenNOMBRES{"Saccharopolyspora spinosa NRRL18395"}=72;
#$hashOrdenNOMBRES2{72}="Saccharopolyspora spinosa NRRL18395";
#$hashOrdenNOMBRES{"Saccharothrix espanaensis DSM44229"}=73;
#$hashOrdenNOMBRES2{73}="Saccharothrix espanaensis DSM44229";
####$hashOrdenNOMBRES{"Amycolatopsis AA4"}=76;
####$hashOrdenNOMBRES2{76}="Amycolatopsis AA4";
#$hashOrdenNOMBRES{"Amycolatopsis mediterraneiU32"}=74;
#$hashOrdenNOMBRES2{74}="Amycolatopsis mediterraneiU32";
#$hashOrdenNOMBRES{"Amycolatopsis mediterranei S699"}=75;
#$hashOrdenNOMBRES2{75}="Amycolatopsis mediterranei S699";
####$hashOrdenNOMBRES{"Amycolatopsis ATCC39116"}=87;
####$hashOrdenNOMBRES2{87}="Amycolatopsis ATCC39116";
####$hashOrdenNOMBRES{"Saccharomonospora marina XMU15"}=88;
####$hashOrdenNOMBRES2{88}="Saccharomonospora marina XMU15";
#$hashOrdenNOMBRES{"Saccharomonospora paurometabolica YIM90007"}=76;
#$hashOrdenNOMBRES2{76}="Saccharomonospora paurometabolica YIM90007";
#$hashOrdenNOMBRES{"Saccharomonospora viridisDSM43017"}=77;
#$hashOrdenNOMBRES2{77}="Saccharomonospora viridisDSM43017";
#$hashOrdenNOMBRES{"Saccharomonospora xinjiangensis XJ54"}=78;
#$hashOrdenNOMBRES2{78}="Saccharomonospora xinjiangensis XJ54";
#$hashOrdenNOMBRES{"Saccharomonospora cyanea NA134"}=79;
#$hashOrdenNOMBRES2{79}="Saccharomonospora cyanea NA134";
#$hashOrdenNOMBRES{"Saccharomonospora glauca K62"}=80;
#$hashOrdenNOMBRES2{80}="Saccharomonospora glauca K62";
####$hashOrdenNOMBRES{"Saccharomonospora azurea NA128"}=94;
####$hashOrdenNOMBRES2{94}="Saccharomonospora azurea NA128";
#$hashOrdenNOMBRES{"Saccharomonospora azurea SZMC14600"}=81;
#$hashOrdenNOMBRES2{81}="Saccharomonospora azurea SZMC14600";
#$hashOrdenNOMBRES{"Dietzia cinnamea P4"}=82;
#$hashOrdenNOMBRES2{82}="Dietzia cinnamea P4";
####$hashOrdenNOMBRES{"Corynebacterium amycolatum SK46"}=86;
####$hashOrdenNOMBRES2{86}="Corynebacterium amycolatum SK46";
#$hashOrdenNOMBRES{"Corynebacterium kroppenstedtii DSM44385"}=83;
#$hashOrdenNOMBRES2{83}="Corynebacterium kroppenstedtii DSM44385";
#$hashOrdenNOMBRES{"Corynebacterium urealyticum DSM7109"}=84;
#$hashOrdenNOMBRES2{84}="Corynebacterium urealyticum DSM7109";
####$hashOrdenNOMBRES{"Corynebacterium jeikeium ATCC43734"}=100;
####$hashOrdenNOMBRES2{100}="Corynebacterium jeikeium ATCC43734";
#$hashOrdenNOMBRES{"Corynebacterium jeikenium K411"}=85;
#$hashOrdenNOMBRES2{85}="Corynebacterium jeikenium K411";
#$hashOrdenNOMBRES{"Corynebacterium glutamicum R"}=86;
#$hashOrdenNOMBRES2{86}="Corynebacterium glutamicum R";
#$hashOrdenNOMBRES{"Corynebacterium glutamicum ATCC13032"}=87;
#$hashOrdenNOMBRES2{87}="Corynebacterium glutamicum ATCC13032";
####$hashOrdenNOMBRES{"Corynebacterium diphteriae"}=92;
####$hashOrdenNOMBRES2{92}="Corynebacterium diphteriae";
#$hashOrdenNOMBRES{"Corynebacterium efficiens YS314"}=88;
#$hashOrdenNOMBRES2{88}="Corynebacterium efficiens YS314";
####$hashOrdenNOMBRES{"Corynebacterium glucuronolyticum ATCC51867"}=106;
####$hashOrdenNOMBRES2{106}="Corynebacterium glucuronolyticum ATCC51867";
####$hashOrdenNOMBRES{"Corynebacterium accolens ATCC49725"}=107;
####$hashOrdenNOMBRES2{107}="Corynebacterium accolens ATCC49725";
####$hashOrdenNOMBRES{"Corynebacterium striatum ATCC6940"}=108;
####$hashOrdenNOMBRES2{108}="Corynebacterium striatum ATCC6940";
#$hashOrdenNOMBRES{"Gordonia polyisoprenivorans VH2"}=89;
#$hashOrdenNOMBRES2{89}="Gordonia polyisoprenivorans VH2";
#$hashOrdenNOMBRES{"Nocardia brasiliensis ATCC700358"}=90;
#$hashOrdenNOMBRES2{90}="Nocardia brasiliensis ATCC700358";
#$hashOrdenNOMBRES{"Nocardia cyriacigeorgica"}=91;
#$hashOrdenNOMBRES2{91}="Nocardia cyriacigeorgica";
#$hashOrdenNOMBRES{"Nocardia farcinicaIFM10152"}=92;
#$hashOrdenNOMBRES2{92}="Nocardia farcinicaIFM10152";
####$hashOrdenNOMBRES{"Mycobacterium abscessus ATCC19977"}=113;
####$hashOrdenNOMBRES2{113}="Mycobacterium abscessus ATCC19977";
#$hashOrdenNOMBRES{"Mycobacterium smegmatis MC2155"}=93;
#$hashOrdenNOMBRES2{93}="Mycobacterium smegmatis MC2155";
####$hashOrdenNOMBRES{"Mycobacterium thermoresistibile ATCC19527"}=115;
####$hashOrdenNOMBRES2{115}="Mycobacterium thermoresistibile ATCC19527";
####$hashOrdenNOMBRES{"Mycobacterium rhodesiae NBB3"}=116;
####$hashOrdenNOMBRES2{116}="Mycobacterium rhodesiae NBB3";
#$hashOrdenNOMBRES{"Mycobacterium vanbaalenii PYR1"}=94;
#$hashOrdenNOMBRES2{94}="Mycobacterium vanbaalenii PYR1";
#$hashOrdenNOMBRES{"Mycobacterium gilvum PYRGCK"}=95;
#$hashOrdenNOMBRES2{95}="Mycobacterium gilvum PYRGCK";
#$hashOrdenNOMBRES{"Mycobacterium spJLS"}=96;
#$hashOrdenNOMBRES2{96}="Mycobacterium spJLS";
#$hashOrdenNOMBRES{"Mycobacterium sp MCS"}=97;
#$hashOrdenNOMBRES2{97}="Mycobacterium sp MCS";
#$hashOrdenNOMBRES{"Mycobacterium sp KMS"}=98;
#$hashOrdenNOMBRES2{98}="Mycobacterium sp KMS";
####$hashOrdenNOMBRES{"Mycobacterium parascrofulaceum ATCCBAA614"}=122;
####$hashOrdenNOMBRES2{122}="Mycobacterium parascrofulaceum ATCCBAA614";
#$hashOrdenNOMBRES{"Mycobacterium ulcerans Agy99"}=99;
#$hashOrdenNOMBRES2{99}="Mycobacterium ulcerans Agy99";
####$hashOrdenNOMBRES{"Mycobacterium marinum M"}=124;
####$hashOrdenNOMBRES2{124}="Mycobacterium marinum M";
####$hashOrdenNOMBRES{"Mycobacterium kansasii 12478"}=125;
####$hashOrdenNOMBRES2{125}="Mycobacterium kansasii 12478";
##$hashOrdenNOMBRES{"Mycobacterium leprae"}=105;
##$hashOrdenNOMBRES2{105}="Mycobacterium leprae";
#$hashOrdenNOMBRES{"Mycobacterium tuberculosis CDC1551"}=100;
#$hashOrdenNOMBRES2{100}="Mycobacterium tuberculosis CDC1551";
##$hashOrdenNOMBRES{"Mycobacterium africanum GM041182"}=107;
##$hashOrdenNOMBRES2{107}="Mycobacterium africanum GM041182";
#$hashOrdenNOMBRES{"Mycobacterium bovis BCG Mexico"}=101;
#$hashOrdenNOMBRES2{101}="Mycobacterium bovis BCG Mexico";
#-----------------------------------------------------------

$hashNOMBRES{'LeifsoniaxylisubspxylistrCTCB07'}="Leifsonia xyli subsp xyli str CTCB07";
$hashOrdenNOMBRES{"Leifsonia xyli subsp xyli str CTCB07"}=1;
$hashOrdenNOMBRES2{1}="Leifsonia xyli subsp xyli str CTCB07";

$hashNOMBRES{'ClavibactermichiganensissubspmichiganensisNCPPB382'}="Clavibacter michiganensis subsp michiganensis NCPPB 382";
$hashOrdenNOMBRES{"Clavibacter michiganensis subsp michiganensis NCPPB 382"}=2;
$hashOrdenNOMBRES2{2}="Clavibacter michiganensis subsp michiganensis NCPPB 382";

$hashNOMBRES{'MicrobacteriumtestaceumStLB037'}="Microbacterium testaceum StLB037";
$hashOrdenNOMBRES{"Microbacterium testaceum StLB037"}=3;
$hashOrdenNOMBRES2{3}="Microbacterium testaceum StLB037";

$hashNOMBRES{'MicrobacteriumspCCA4'}="Microbacterium sp CCA4";
$hashOrdenNOMBRES{"Microbacterium sp CCA4"}=4;
$hashOrdenNOMBRES2{4}="Microbacterium sp CCA4";

$hashNOMBRES{'MicrobacteriumspAER1'}="Microbacterium sp AER 1";
$hashOrdenNOMBRES{"Microbacterium sp AER 1"}=5;
$hashOrdenNOMBRES2{5}="Microbacterium sp AER 1";

$hashNOMBRES{'RenibacteriumsalmoninarumATCC33209'}="Renibacterium salmoninarum ATCC 33209";
$hashOrdenNOMBRES{"Renibacterium salmoninarum ATCC 33209"}=6;
$hashOrdenNOMBRES2{6}="Renibacterium salmoninarum ATCC 33209";

$hashNOMBRES{'ArthrobacteraurescensTC1'}="Arthrobacter aurescens TC1";
$hashOrdenNOMBRES{"Arthrobacter aurescens TC1"}=7;
$hashOrdenNOMBRES2{7}="Arthrobacter aurescens TC1";

$hashNOMBRES{'ArthrobacterphenanthrenivoransSphe3'}="Arthrobacter phenanthrenivorans Sphe3";
$hashOrdenNOMBRES{"Arthrobacter phenanthrenivorans Sphe3"}=8;
$hashOrdenNOMBRES2{8}="Arthrobacter phenanthrenivorans Sphe3";

$hashNOMBRES{'ArthrobacterchlorophenolicusA6'}="Arthrobacter chlorophenolicus A6";
$hashOrdenNOMBRES{"Arthrobacter chlorophenolicus A6"}=9;
$hashOrdenNOMBRES2{9}="Arthrobacter chlorophenolicus A6";

$hashNOMBRES{'KOCURIASPCH10'}="KOCURIA SP CH10";
$hashOrdenNOMBRES{"KOCURIA SP CH10"}=10;
$hashOrdenNOMBRES2{10}="KOCURIA SP CH10";

$hashNOMBRES{'KocuriarhizophilaDC2201'}="Kocuria rhizophila DC2201";
$hashOrdenNOMBRES{"Kocuria rhizophila DC2201"}=11;
$hashOrdenNOMBRES2{11}="Kocuria rhizophila DC2201";

$hashNOMBRES{'ArthrobacterarilaitensisRe117'}="Arthrobacter arilaitensis Re117";
$hashOrdenNOMBRES{"Arthrobacter arilaitensis Re117"}=12;
$hashOrdenNOMBRES2{12}="Arthrobacter arilaitensis Re117";

$hashNOMBRES{'CitricoccusspCH26A'}="Citricoccus sp CH26A";
$hashOrdenNOMBRES{"Citricoccus sp CH26A"}=13;
$hashOrdenNOMBRES2{13}="Citricoccus sp CH26A";

$hashNOMBRES{'MicrococcusluteusNCTC2665'}="Micrococcus luteus NCTC 2665";
$hashOrdenNOMBRES{"Micrococcus luteus NCTC 2665"}=14;
$hashOrdenNOMBRES2{14}="Micrococcus luteus NCTC 2665";

$hashNOMBRES{'MicrococaceaespCH7'}="Micrococaceae sp CH7";
$hashOrdenNOMBRES{"Micrococaceae sp CH7"}=15;
$hashOrdenNOMBRES2{15}="Micrococaceae sp CH7";

$hashNOMBRES{'MicrococcusspCCA18'}="Micrococcus sp CCA18";
$hashOrdenNOMBRES{"Micrococcus sp CCA18"}=16;
$hashOrdenNOMBRES2{16}="Micrococcus sp CCA18";

$hashNOMBRES{'KineococcusradiotoleransSRS30216'}="Kineococcus radiotolerans SRS30216";
$hashOrdenNOMBRES{"Kineococcus radiotolerans SRS30216"}=17;
$hashOrdenNOMBRES2{17}="Kineococcus radiotolerans SRS30216";

$hashNOMBRES{'NocardioidesspJS614'}="Nocardioides sp JS614";
$hashOrdenNOMBRES{"Nocardioides sp JS614"}=18;
$hashOrdenNOMBRES2{18}="Nocardioides sp JS614";

$hashNOMBRES{'PropionibacteriumpropionicumF0230a'}="Propionibacterium propionicum F0230a";
$hashOrdenNOMBRES{"Propionibacterium propionicum F0230a"}=19;
$hashOrdenNOMBRES2{19}="Propionibacterium propionicum F0230a";

$hashNOMBRES{'PropionibacteriumfreudenreichiisubspshermaniiCIRMBIA1'}="Propionibacterium freudenreichii subsp shermanii CIRMBIA1";
$hashOrdenNOMBRES{"Propionibacterium freudenreichii subsp shermanii CIRMBIA1"}=20;
$hashOrdenNOMBRES2{20}="Propionibacterium freudenreichii subsp shermanii CIRMBIA1";

$hashNOMBRES{'PropionibacteriumacidipropioniciATCC4875'}="Propionibacterium acidipropionici ATCC 4875";
$hashOrdenNOMBRES{"Propionibacterium acidipropionici ATCC 4875"}=21;
$hashOrdenNOMBRES2{21}="Propionibacterium acidipropionici ATCC 4875";

$hashNOMBRES{'PropionibacteriumacnesKPA171202'}="Propionibacterium acnes KPA171202";
$hashOrdenNOMBRES{"Propionibacterium acnes KPA171202"}=22;
$hashOrdenNOMBRES2{22}="Propionibacterium acnes KPA171202";

$hashNOMBRES{'Propionibacteriumavidum44067'}="Propionibacterium avidum 44067";
$hashOrdenNOMBRES{"Propionibacterium avidum 44067"}=23;
$hashOrdenNOMBRES2{23}="Propionibacterium avidum 44067";

$hashNOMBRES{'CatenulisporaacidiphilaDSM44928'}="Catenulispora acidiphila DSM 44928";
$hashOrdenNOMBRES{"Catenulispora acidiphila DSM 44928"}=24;
$hashOrdenNOMBRES2{24}="Catenulispora acidiphila DSM 44928";

$hashNOMBRES{'StreptomycesscabrisporusDSM41855'}="Streptomyces scabrisporus DSM 41855";
$hashOrdenNOMBRES{"Streptomyces scabrisporus DSM 41855"}=25;
$hashOrdenNOMBRES2{25}="Streptomyces scabrisporus DSM 41855";

$hashNOMBRES{'Streptacidiphilusjeojiense'}="Streptacidiphilus jeojiense";
$hashOrdenNOMBRES{"Streptacidiphilus jeojiense"}=26;
$hashOrdenNOMBRES2{26}="Streptacidiphilus jeojiense";

$hashNOMBRES{'Streptomycesaureofaciens'}="Streptomyces aureofaciens";
$hashOrdenNOMBRES{"Streptomyces aureofaciens"}=27;
$hashOrdenNOMBRES2{27}="Streptomyces aureofaciens";

$hashNOMBRES{'Streptomycesavellaneus'}="Streptomyces avellaneus";
$hashOrdenNOMBRES{"Streptomyces avellaneus"}=28;
$hashOrdenNOMBRES2{28}="Streptomyces avellaneus";

$hashNOMBRES{'KitasatosporasetaeKM6054'}="Kitasatospora setae KM6054";
$hashOrdenNOMBRES{"Kitasatospora setae KM6054"}=29;
$hashOrdenNOMBRES2{29}="Kitasatospora setae KM6054";

$hashNOMBRES{'KitasatosporacheerisanensisKCTC2395'}="Kitasatospora cheerisanensis KCTC 2395";
$hashOrdenNOMBRES{"Kitasatospora cheerisanensis KCTC 2395"}=30;
$hashOrdenNOMBRES2{30}="Kitasatospora cheerisanensis KCTC 2395";

$hashNOMBRES{'StreptomycesvitaminophilusDSM41686'}="Streptomyces vitaminophilus DSM 41686";
$hashOrdenNOMBRES{"Streptomyces vitaminophilus DSM 41686"}=31;
$hashOrdenNOMBRES2{31}="Streptomyces vitaminophilus DSM 41686";

$hashNOMBRES{'StreptomycescattleyaNRRL8057DSM46488'}="Streptomyces cattleya NRRL 8057  DSM 46488";
$hashOrdenNOMBRES{"Streptomyces cattleya NRRL 8057  DSM 46488"}=32;
$hashOrdenNOMBRES2{32}="Streptomyces cattleya NRRL 8057  DSM 46488";

$hashNOMBRES{'Streptomycesmegasporus'}="Streptomyces megasporus";
$hashOrdenNOMBRES{"Streptomyces megasporus"}=33;
$hashOrdenNOMBRES2{33}="Streptomyces megasporus";

$hashNOMBRES{'StreptomycesbingchenggensisBCW1'}="Streptomyces bingchenggensis BCW1";
$hashOrdenNOMBRES{"Streptomyces bingchenggensis BCW1"}=34;
$hashOrdenNOMBRES2{34}="Streptomyces bingchenggensis BCW1";

$hashNOMBRES{'StreptomycesviolaceusnigerTu4113'}="Streptomyces violaceusniger Tu 4113";
$hashOrdenNOMBRES{"Streptomyces violaceusniger Tu 4113"}=35;
$hashOrdenNOMBRES2{35}="Streptomyces violaceusniger Tu 4113";

$hashNOMBRES{'StreptomycesrapamycinicusNRRL5491'}="Streptomyces rapamycinicus NRRL 5491";
$hashOrdenNOMBRES{"Streptomyces rapamycinicus NRRL 5491"}=36;
$hashOrdenNOMBRES2{36}="Streptomyces rapamycinicus NRRL 5491";

$hashNOMBRES{'StreptomyceshimastatinicusATCC53653'}="Streptomyces himastatinicus ATCC 53653";
$hashOrdenNOMBRES{"Streptomyces himastatinicus ATCC 53653"}=37;
$hashOrdenNOMBRES2{37}="Streptomyces himastatinicus ATCC 53653";

$hashNOMBRES{'StreptomycesmobaraensisNBRC13819DSM40847'}="Streptomyces mobaraensis NBRC 13819  DSM 40847";
$hashOrdenNOMBRES{"Streptomyces mobaraensis NBRC 13819  DSM 40847"}=38;
$hashOrdenNOMBRES2{38}="Streptomyces mobaraensis NBRC 13819  DSM 40847";

$hashNOMBRES{'Streptomycesroseoverticillatus'}="Streptomyces roseoverticillatus";
$hashOrdenNOMBRES{"Streptomyces roseoverticillatus"}=39;
$hashOrdenNOMBRES2{39}="Streptomyces roseoverticillatus";

$hashNOMBRES{'StreptomycessulphureusL180'}="Streptomyces sulphureus L180";
$hashOrdenNOMBRES{"Streptomyces sulphureus L180"}=40;
$hashOrdenNOMBRES2{40}="Streptomyces sulphureus L180";

$hashNOMBRES{'Streptomycesalbulus'}="Streptomyces albulus";
$hashOrdenNOMBRES{"Streptomyces albulus"}=41;
$hashOrdenNOMBRES2{41}="Streptomyces albulus";

$hashNOMBRES{'StreptomycesnigrescensATCC23941'}="Streptomyces nigrescens ATCC 23941";
$hashOrdenNOMBRES{"Streptomyces nigrescens ATCC 23941"}=42;
$hashOrdenNOMBRES2{42}="Streptomyces nigrescens ATCC 23941";

$hashNOMBRES{'Streptomycescatenulae'}="Streptomyces catenulae";
$hashOrdenNOMBRES{"Streptomyces catenulae"}=43;
$hashOrdenNOMBRES2{43}="Streptomyces catenulae";

$hashNOMBRES{'StreptomycesauratusAGR0001'}="Streptomyces auratus AGR0001";
$hashOrdenNOMBRES{"Streptomyces auratus AGR0001"}=44;
$hashOrdenNOMBRES2{44}="Streptomyces auratus AGR0001";

$hashNOMBRES{'Streptomycessclerotialus'}="Streptomyces sclerotialus";
$hashOrdenNOMBRES{"Streptomyces sclerotialus"}=45;
$hashOrdenNOMBRES2{45}="Streptomyces sclerotialus";

$hashNOMBRES{'Streptomycesochraceiscleroticus'}="Streptomyces ochraceiscleroticus";
$hashOrdenNOMBRES{"Streptomyces ochraceiscleroticus"}=46;
$hashOrdenNOMBRES2{46}="Streptomyces ochraceiscleroticus";

$hashNOMBRES{'Streptomycesviolens'}="Streptomyces violens";
$hashOrdenNOMBRES{"Streptomyces violens"}=47;
$hashOrdenNOMBRES2{47}="Streptomyces violens";

$hashNOMBRES{'Streptomycesrimosussubsprimosus'}="Streptomyces rimosus subsp rimosus";
$hashOrdenNOMBRES{"Streptomyces rimosus subsp rimosus"}=48;
$hashOrdenNOMBRES2{48}="Streptomyces rimosus subsp rimosus";

$hashNOMBRES{'Streptomycescapuensis'}="Streptomyces capuensis";
$hashOrdenNOMBRES{"Streptomyces capuensis"}=49;
$hashOrdenNOMBRES2{49}="Streptomyces capuensis";

$hashNOMBRES{'StreptomycesrimosussubsprimosusATCC10970'}="Streptomyces rimosus subsp rimosus ATCC 10970";
$hashOrdenNOMBRES{"Streptomyces rimosus subsp rimosus ATCC 10970"}=50;
$hashOrdenNOMBRES2{50}="Streptomyces rimosus subsp rimosus ATCC 10970";

$hashNOMBRES{'Streptomyceslavendulaesubsplavendulae'}="Streptomyces lavendulae subsp lavendulae";
$hashOrdenNOMBRES{"Streptomyces lavendulae subsp lavendulae"}=51;
$hashOrdenNOMBRES2{51}="Streptomyces lavendulae subsp lavendulae";

$hashNOMBRES{'StreptomycesniveusNCIMB11891'}="Streptomyces niveus NCIMB 11891";
$hashOrdenNOMBRES{"Streptomyces niveus NCIMB 11891"}=52;
$hashOrdenNOMBRES2{52}="Streptomyces niveus NCIMB 11891";

$hashNOMBRES{'StreptomycestsukubaensisNRRL18488'}="Streptomyces tsukubaensis NRRL18488";
$hashOrdenNOMBRES{"Streptomyces tsukubaensis NRRL18488"}=53;
$hashOrdenNOMBRES2{53}="Streptomyces tsukubaensis NRRL18488";

$hashNOMBRES{'StreptomycesclavuligerusATCC27064'}="Streptomyces clavuligerus ATCC 27064";
$hashOrdenNOMBRES{"Streptomyces clavuligerus ATCC 27064"}=54;
$hashOrdenNOMBRES2{54}="Streptomyces clavuligerus ATCC 27064";

$hashNOMBRES{'StreptomyceskatsurahamenasMU'}="Streptomyces katsurahamenas MU";
$hashOrdenNOMBRES{"Streptomyces katsurahamenas MU"}=55;
$hashOrdenNOMBRES2{55}="Streptomyces katsurahamenas MU";

$hashNOMBRES{'StreptomycesjumonjinensisMU'}="Streptomyces jumonjinensis MU";
$hashOrdenNOMBRES{"Streptomyces jumonjinensis MU"}=56;
$hashOrdenNOMBRES2{56}="Streptomyces jumonjinensis MU";

$hashNOMBRES{'StreptomycespristinaespiralisATCC25486'}="Streptomyces pristinaespiralis ATCC 25486";
$hashOrdenNOMBRES{"Streptomyces pristinaespiralis ATCC 25486"}=57;
$hashOrdenNOMBRES2{57}="Streptomyces pristinaespiralis ATCC 25486";

$hashNOMBRES{'Streptomycesmauvecolor'}="Streptomyces mauvecolor";
$hashOrdenNOMBRES{"Streptomyces mauvecolor"}=58;
$hashOrdenNOMBRES2{58}="Streptomyces mauvecolor";

$hashNOMBRES{'Streptomycesgriseolus'}="Streptomyces griseolus";
$hashOrdenNOMBRES{"Streptomyces griseolus"}=59;
$hashOrdenNOMBRES2{59}="Streptomyces griseolus";

$hashNOMBRES{'StreptomycesspSirexAAE'}="Streptomyces sp SirexAAE";
$hashOrdenNOMBRES{"Streptomyces sp SirexAAE"}=60;
$hashOrdenNOMBRES2{60}="Streptomyces sp SirexAAE";

$hashNOMBRES{'Streptomycesflavovirens'}="Streptomyces flavovirens";
$hashOrdenNOMBRES{"Streptomyces flavovirens"}=61;
$hashOrdenNOMBRES2{61}="Streptomyces flavovirens";

$hashNOMBRES{'Kitasatosporapapulosa'}="Kitasatospora papulosa";
$hashOrdenNOMBRES{"Kitasatospora papulosa"}=62;
$hashOrdenNOMBRES2{62}="Kitasatospora papulosa";

$hashNOMBRES{'StreptomycesspPAMC26508'}="Streptomyces sp PAMC26508";
$hashOrdenNOMBRES{"Streptomyces sp PAMC26508"}=63;
$hashOrdenNOMBRES2{63}="Streptomyces sp PAMC26508";

$hashNOMBRES{'StreptomycespratensisATCC33331'}="Streptomyces pratensis ATCC 33331";
$hashOrdenNOMBRES{"Streptomyces pratensis ATCC 33331"}=64;
$hashOrdenNOMBRES2{64}="Streptomyces pratensis ATCC 33331";

$hashNOMBRES{'StreptomycesfulvissimusDSM40593'}="Streptomyces fulvissimus DSM 40593";
$hashOrdenNOMBRES{"Streptomyces fulvissimus DSM 40593"}=65;
$hashOrdenNOMBRES2{65}="Streptomyces fulvissimus DSM 40593";

$hashNOMBRES{'Streptomycescyaneofuscatus'}="Streptomyces cyaneofuscatus";
$hashOrdenNOMBRES{"Streptomyces cyaneofuscatus"}=66;
$hashOrdenNOMBRES2{66}="Streptomyces cyaneofuscatus";

$hashNOMBRES{'StreptomycesspScaeMPe10'}="Streptomyces sp ScaeMPe10";
$hashOrdenNOMBRES{"Streptomyces sp ScaeMPe10"}=67;
$hashOrdenNOMBRES2{67}="Streptomyces sp ScaeMPe10";

$hashNOMBRES{'Streptomycesmediolani'}="Streptomyces mediolani";
$hashOrdenNOMBRES{"Streptomyces mediolani"}=68;
$hashOrdenNOMBRES2{68}="Streptomyces mediolani";

$hashNOMBRES{'StreptomycesspCNB091'}="Streptomyces sp CNB091";
$hashOrdenNOMBRES{"Streptomyces sp CNB091"}=69;
$hashOrdenNOMBRES2{69}="Streptomyces sp CNB091";

$hashNOMBRES{'StreptomycesspW007'}="Streptomyces sp W007";
$hashOrdenNOMBRES{"Streptomyces sp W007"}=70;
$hashOrdenNOMBRES2{70}="Streptomyces sp W007";

$hashNOMBRES{'StreptomycesglobisporusC1027'}="Streptomyces globisporus C1027";
$hashOrdenNOMBRES{"Streptomyces globisporus C1027"}=71;
$hashOrdenNOMBRES2{71}="Streptomyces globisporus C1027";

$hashNOMBRES{'StreptomycesspCcalMP8W'}="Streptomyces sp CcalMP8W";
$hashOrdenNOMBRES{"Streptomyces sp CcalMP8W"}=72;
$hashOrdenNOMBRES2{72}="Streptomyces sp CcalMP8W";

$hashNOMBRES{'StreptomycesroseosporusNRRL11379'}="Streptomyces roseosporus NRRL 11379";
$hashOrdenNOMBRES{"Streptomyces roseosporus NRRL 11379"}=73;
$hashOrdenNOMBRES2{73}="Streptomyces roseosporus NRRL 11379";

$hashNOMBRES{'StreptomycesroseosporusNRRL15998'}="Streptomyces roseosporus NRRL 15998";
$hashOrdenNOMBRES{"Streptomyces roseosporus NRRL 15998"}=74;
$hashOrdenNOMBRES2{74}="Streptomyces roseosporus NRRL 15998";

$hashNOMBRES{'StreptomycesgriseusXylebKG1'}="Streptomyces griseus XylebKG1";
$hashOrdenNOMBRES{"Streptomyces griseus XylebKG1"}=75;
$hashOrdenNOMBRES2{75}="Streptomyces griseus XylebKG1";

$hashNOMBRES{'StreptomycesgriseussubspgriseusNBRC13350'}="Streptomyces griseus subsp griseus NBRC 13350";
$hashOrdenNOMBRES{"Streptomyces griseus subsp griseus NBRC 13350"}=76;
$hashOrdenNOMBRES2{76}="Streptomyces griseus subsp griseus NBRC 13350";

$hashNOMBRES{'Streptomycesfloridae'}="Streptomyces floridae";
$hashOrdenNOMBRES{"Streptomyces floridae"}=77;
$hashOrdenNOMBRES2{77}="Streptomyces floridae";

$hashNOMBRES{'Streptomycespuniceus'}="Streptomyces puniceus";
$hashOrdenNOMBRES{"Streptomyces puniceus"}=78;
$hashOrdenNOMBRES2{78}="Streptomyces puniceus";

$hashNOMBRES{'Streptomycescalifornicus'}="Streptomyces californicus";
$hashOrdenNOMBRES{"Streptomyces californicus"}=79;
$hashOrdenNOMBRES2{79}="Streptomyces californicus";

$hashNOMBRES{'Streptomycesruber'}="Streptomyces ruber";
$hashOrdenNOMBRES{"Streptomyces ruber"}=80;
$hashOrdenNOMBRES2{80}="Streptomyces ruber";

$hashNOMBRES{'StreptomycesaurantiacusJA4570'}="Streptomyces aurantiacus JA 4570";
$hashOrdenNOMBRES{"Streptomyces aurantiacus JA 4570"}=81;
$hashOrdenNOMBRES2{81}="Streptomyces aurantiacus JA 4570";

$hashNOMBRES{'StreptomycesturgidiscabiesCar8'}="Streptomyces turgidiscabies Car8";
$hashOrdenNOMBRES{"Streptomyces turgidiscabies Car8"}=82;
$hashOrdenNOMBRES2{82}="Streptomyces turgidiscabies Car8";

$hashNOMBRES{'StreptomycesavermitilisMA4680'}="Streptomyces avermitilis MA4680";
$hashOrdenNOMBRES{"Streptomyces avermitilis MA4680"}=83;
$hashOrdenNOMBRES2{83}="Streptomyces avermitilis MA4680";

$hashNOMBRES{'StreptomycesprunicolorNBRC13075'}="Streptomyces prunicolor NBRC 13075";
$hashOrdenNOMBRES{"Streptomyces prunicolor NBRC 13075"}=84;
$hashOrdenNOMBRES2{84}="Streptomyces prunicolor NBRC 13075";

$hashNOMBRES{'StreptomycespurpureusKA281'}="Streptomyces purpureus KA281";
$hashOrdenNOMBRES{"Streptomyces purpureus KA281"}=85;
$hashOrdenNOMBRES2{85}="Streptomyces purpureus KA281";

$hashNOMBRES{'Streptomycesbikiniensis'}="Streptomyces bikiniensis";
$hashOrdenNOMBRES{"Streptomyces bikiniensis"}=86;
$hashOrdenNOMBRES2{86}="Streptomyces bikiniensis";

$hashNOMBRES{'Streptomycesgriseoluteus'}="Streptomyces griseoluteus";
$hashOrdenNOMBRES{"Streptomyces griseoluteus"}=87;
$hashOrdenNOMBRES2{87}="Streptomyces griseoluteus";

$hashNOMBRES{'StreptomycesvenezuelaeATCC10712'}="Streptomyces venezuelae ATCC 10712";
$hashOrdenNOMBRES{"Streptomyces venezuelae ATCC 10712"}=88;
$hashOrdenNOMBRES2{88}="Streptomyces venezuelae ATCC 10712";

$hashNOMBRES{'StreptomycesspC'}="Streptomyces sp C";
$hashOrdenNOMBRES{"Streptomyces sp C"}=89;
$hashOrdenNOMBRES2{89}="Streptomyces sp C";

$hashNOMBRES{'Streptomyceserythrochromogenes'}="Streptomyces erythrochromogenes";
$hashOrdenNOMBRES{"Streptomyces erythrochromogenes"}=90;
$hashOrdenNOMBRES2{90}="Streptomyces erythrochromogenes";

$hashNOMBRES{'Streptomycesvirginiae'}="Streptomyces virginiae";
$hashOrdenNOMBRES{"Streptomyces virginiae"}=91;
$hashOrdenNOMBRES2{91}="Streptomyces virginiae";

$hashNOMBRES{'Streptomyceskatrae'}="Streptomyces katrae";
$hashOrdenNOMBRES{"Streptomyces katrae"}=92;
$hashOrdenNOMBRES2{92}="Streptomyces katrae";

$hashNOMBRES{'Streptomycesroseus'}="Streptomyces roseus";
$hashOrdenNOMBRES{"Streptomyces roseus"}=93;
$hashOrdenNOMBRES2{93}="Streptomyces roseus";

$hashNOMBRES{'StreptomycesspSPB74'}="Streptomyces sp SPB74";
$hashOrdenNOMBRES{"Streptomyces sp SPB74"}=94;
$hashOrdenNOMBRES2{94}="Streptomyces sp SPB74";

$hashNOMBRES{'StreptomycesspTu6071'}="Streptomyces sp Tu6071";
$hashOrdenNOMBRES{"Streptomyces sp Tu6071"}=95;
$hashOrdenNOMBRES2{95}="Streptomyces sp Tu6071";

$hashNOMBRES{'StreptomycesspSA3actG'}="Streptomyces sp SA3 actG";
$hashOrdenNOMBRES{"Streptomyces sp SA3 actG"}=96;
$hashOrdenNOMBRES2{96}="Streptomyces sp SA3 actG";

$hashNOMBRES{'StreptomycesspSPB78'}="Streptomyces sp SPB78";
$hashOrdenNOMBRES{"Streptomyces sp SPB78"}=97;
$hashOrdenNOMBRES2{97}="Streptomyces sp SPB78";

$hashNOMBRES{'StreptomycesalbusJ1074'}="Streptomyces albus J1074";
$hashOrdenNOMBRES{"Streptomyces albus J1074"}=98;
$hashOrdenNOMBRES2{98}="Streptomyces albus J1074";

$hashNOMBRES{'StreptomycesspCS100'}="Streptomyces sp CS100";
$hashOrdenNOMBRES{"Streptomyces sp CS100"}=99;
$hashOrdenNOMBRES2{99}="Streptomyces sp CS100";

$hashNOMBRES{'Streptomycesalbidoflavus'}="Streptomyces albidoflavus";
$hashOrdenNOMBRES{"Streptomyces albidoflavus"}=100;
$hashOrdenNOMBRES2{100}="Streptomyces albidoflavus";

$hashNOMBRES{'StreptomycesfradieaeCC53'}="Streptomyces fradieae CC53";
$hashOrdenNOMBRES{"Streptomyces fradieae CC53"}=101;
$hashOrdenNOMBRES2{101}="Streptomyces fradieae CC53";

$hashNOMBRES{'StreptomycessomaliensisDSM40738'}="Streptomyces somaliensis DSM 40738";
$hashOrdenNOMBRES{"Streptomyces somaliensis DSM 40738"}=102;
$hashOrdenNOMBRES2{102}="Streptomyces somaliensis DSM 40738";

$hashNOMBRES{'StreptomycesthermolilacinusSPC6'}="Streptomyces thermolilacinus SPC6";
$hashOrdenNOMBRES{"Streptomyces thermolilacinus SPC6"}=103;
$hashOrdenNOMBRES2{103}="Streptomyces thermolilacinus SPC6";

$hashNOMBRES{'Streptomycesyokosukanensis'}="Streptomyces yokosukanensis";
$hashOrdenNOMBRES{"Streptomyces yokosukanensis"}=104;
$hashOrdenNOMBRES2{104}="Streptomyces yokosukanensis";

$hashNOMBRES{'Streptomycesviolaceoruber'}="Streptomyces violaceoruber";
$hashOrdenNOMBRES{"Streptomyces violaceoruber"}=105;
$hashOrdenNOMBRES2{105}="Streptomyces violaceoruber";

$hashNOMBRES{'StreptomycesgancidicusBKS1315'}="Streptomyces gancidicus BKS 1315";
$hashOrdenNOMBRES{"Streptomyces gancidicus BKS 1315"}=106;
$hashOrdenNOMBRES2{106}="Streptomyces gancidicus BKS 1315";

$hashNOMBRES{'Streptomycesgriseorubens'}="Streptomyces griseorubens";
$hashOrdenNOMBRES{"Streptomyces griseorubens"}=107;
$hashOrdenNOMBRES2{107}="Streptomyces griseorubens";

$hashNOMBRES{'Streptomycestoyocaensis'}="Streptomyces toyocaensis";
$hashOrdenNOMBRES{"Streptomyces toyocaensis"}=108;
$hashOrdenNOMBRES2{108}="Streptomyces toyocaensis";

$hashNOMBRES{'StreptomycesgriseoflavusTu4000'}="Streptomyces griseoflavus Tu4000";
$hashOrdenNOMBRES{"Streptomyces griseoflavus Tu4000"}=109;
$hashOrdenNOMBRES2{109}="Streptomyces griseoflavus Tu4000";

$hashNOMBRES{'Streptomycesviolaceorubidus'}="Streptomyces violaceorubidus";
$hashOrdenNOMBRES{"Streptomyces violaceorubidus"}=110;
$hashOrdenNOMBRES2{110}="Streptomyces violaceorubidus";

$hashNOMBRES{'Streptomycesmutabilis'}="Streptomyces mutabilis";
$hashOrdenNOMBRES{"Streptomyces mutabilis"}=111;
$hashOrdenNOMBRES2{111}="Streptomyces mutabilis";

$hashNOMBRES{'StreptomycesrocheiCC71'}="Streptomyces rochei CC71";
$hashOrdenNOMBRES{"Streptomyces rochei CC71"}=112;
$hashOrdenNOMBRES2{112}="Streptomyces rochei CC71";

$hashNOMBRES{'StreptomycesrocheiCC36'}="Streptomyces rochei CC36";
$hashOrdenNOMBRES{"Streptomyces rochei CC36"}=113;
$hashOrdenNOMBRES2{113}="Streptomyces rochei CC36";

$hashNOMBRES{'StreptomycesrocheiCC48'}="Streptomyces rochei CC48";
$hashOrdenNOMBRES{"Streptomyces rochei CC48"}=114;
$hashOrdenNOMBRES2{114}="Streptomyces rochei CC48";

$hashNOMBRES{'Streptomycesolivaceus'}="Streptomyces olivaceus";
$hashOrdenNOMBRES{"Streptomyces olivaceus"}=115;
$hashOrdenNOMBRES2{115}="Streptomyces olivaceus";

$hashNOMBRES{'StreptomycescoelicoflavusZG0656'}="Streptomyces coelicoflavus ZG0656";
$hashOrdenNOMBRES{"Streptomyces coelicoflavus ZG0656"}=116;
$hashOrdenNOMBRES2{116}="Streptomyces coelicoflavus ZG0656";

$hashNOMBRES{'Streptomyceslividans1326'}="Streptomyces lividans 1326";
$hashOrdenNOMBRES{"Streptomyces lividans 1326"}=117;
$hashOrdenNOMBRES2{117}="Streptomyces lividans 1326";

$hashNOMBRES{'StreptomyceslividansTK24'}="Streptomyces lividans TK24";
$hashOrdenNOMBRES{"Streptomyces lividans TK24"}=118;
$hashOrdenNOMBRES2{118}="Streptomyces lividans TK24";

$hashNOMBRES{'StreptomycescoelicolorA32'}="Streptomyces coelicolor A32";
$hashOrdenNOMBRES{"Streptomyces coelicolor A32"}=119;
$hashOrdenNOMBRES2{119}="Streptomyces coelicolor A32";

$hashNOMBRES{'StreptomycesgriseoaurantiacusM045'}="Streptomyces griseoaurantiacus M045";
$hashOrdenNOMBRES{"Streptomyces griseoaurantiacus M045"}=120;
$hashOrdenNOMBRES2{120}="Streptomyces griseoaurantiacus M045";

$hashNOMBRES{'StreptomycessviceusATCC29083'}="Streptomyces sviceus ATCC 29083";
$hashOrdenNOMBRES{"Streptomyces sviceus ATCC 29083"}=121;
$hashOrdenNOMBRES2{121}="Streptomyces sviceus ATCC 29083";

$hashNOMBRES{'Streptomycescanus299MFChir41'}="Streptomyces canus 299MFChir41";
$hashOrdenNOMBRES{"Streptomyces canus 299MFChir41"}=122;
$hashOrdenNOMBRES2{122}="Streptomyces canus 299MFChir41";

$hashNOMBRES{'StreptomycesphaeofaciensCC34'}="Streptomyces phaeofaciens CC34";
$hashOrdenNOMBRES{"Streptomyces phaeofaciens CC34"}=123;
$hashOrdenNOMBRES2{123}="Streptomyces phaeofaciens CC34";

$hashNOMBRES{'StreptomyceszinciresistensK42'}="Streptomyces zinciresistens K42";
$hashOrdenNOMBRES{"Streptomyces zinciresistens K42"}=124;
$hashOrdenNOMBRES2{124}="Streptomyces zinciresistens K42";

$hashNOMBRES{'StreptomycesdavawensisJCM4913'}="Streptomyces davawensis JCM 4913";
$hashOrdenNOMBRES{"Streptomyces davawensis JCM 4913"}=125;
$hashOrdenNOMBRES2{125}="Streptomyces davawensis JCM 4913";

$hashNOMBRES{'Streptomycesfulvoviolaceus'}="Streptomyces fulvoviolaceus";
$hashOrdenNOMBRES{"Streptomyces fulvoviolaceus"}=126;
$hashOrdenNOMBRES2{126}="Streptomyces fulvoviolaceus";

$hashNOMBRES{'Streptomycesacidiscabies84104'}="Streptomyces acidiscabies 84104";
$hashOrdenNOMBRES{"Streptomyces acidiscabies 84104"}=127;
$hashOrdenNOMBRES2{127}="Streptomyces acidiscabies 84104";

$hashNOMBRES{'Streptomycesscabiei8722'}="Streptomyces scabiei 8722";
$hashOrdenNOMBRES{"Streptomyces scabiei 8722"}=128;
$hashOrdenNOMBRES2{128}="Streptomyces scabiei 8722";

$hashNOMBRES{'StreptomycescollinusTu365'}="Streptomyces collinus Tu 365";
$hashOrdenNOMBRES{"Streptomyces collinus Tu 365"}=129;
$hashOrdenNOMBRES2{129}="Streptomyces collinus Tu 365";

$hashNOMBRES{'Streptomyceshygroscopicussubspjinggangensis5008'}="Streptomyces hygroscopicus subsp jinggangensis 5008";
$hashOrdenNOMBRES{"Streptomyces hygroscopicus subsp jinggangensis 5008"}=130;
$hashOrdenNOMBRES2{130}="Streptomyces hygroscopicus subsp jinggangensis 5008";

$hashNOMBRES{'StreptomyceshygroscopicussubspjinggangensisTL01'}="Streptomyces hygroscopicus subsp jinggangensis TL01";
$hashOrdenNOMBRES{"Streptomyces hygroscopicus subsp jinggangensis TL01"}=131;
$hashOrdenNOMBRES2{131}="Streptomyces hygroscopicus subsp jinggangensis TL01";

$hashNOMBRES{'Streptomyceslavenduligriseus'}="Streptomyces lavenduligriseus";
$hashOrdenNOMBRES{"Streptomyces lavenduligriseus"}=132;
$hashOrdenNOMBRES2{132}="Streptomyces lavenduligriseus";

$hashNOMBRES{'Streptomycesflaveus'}="Streptomyces flaveus";
$hashOrdenNOMBRES{"Streptomyces flaveus"}=133;
$hashOrdenNOMBRES2{133}="Streptomyces flaveus";

$hashNOMBRES{'StreptomycesviridochromogenesDSM40736'}="Streptomyces viridochromogenes DSM 40736";
$hashOrdenNOMBRES{"Streptomyces viridochromogenes DSM 40736"}=134;
$hashOrdenNOMBRES2{134}="Streptomyces viridochromogenes DSM 40736";

$hashNOMBRES{'Streptomycesolindensis'}="Streptomyces olindensis";
$hashOrdenNOMBRES{"Streptomyces olindensis"}=135;
$hashOrdenNOMBRES2{135}="Streptomyces olindensis";

$hashNOMBRES{'Streptomycesafghaniensis772'}="Streptomyces afghaniensis 772";
$hashOrdenNOMBRES{"Streptomyces afghaniensis 772"}=136;
$hashOrdenNOMBRES2{136}="Streptomyces afghaniensis 772";

$hashNOMBRES{'StreptomyceschartreusisNRRL12338'}="Streptomyces chartreusis NRRL 12338";
$hashOrdenNOMBRES{"Streptomyces chartreusis NRRL 12338"}=137;
$hashOrdenNOMBRES2{137}="Streptomyces chartreusis NRRL 12338";

$hashNOMBRES{'StreptomycesviridochromogenesTue57'}="Streptomyces viridochromogenes Tue57";
$hashOrdenNOMBRES{"Streptomyces viridochromogenes Tue57"}=138;
$hashOrdenNOMBRES2{138}="Streptomyces viridochromogenes Tue57";

$hashNOMBRES{'StreptomycesviridosporusT7A'}="Streptomyces viridosporus T7A";
$hashOrdenNOMBRES{"Streptomyces viridosporus T7A"}=139;
$hashOrdenNOMBRES2{139}="Streptomyces viridosporus T7A";

$hashNOMBRES{'StreptomycesghanaensisATCC14672'}="Streptomyces ghanaensis ATCC 14672";
$hashOrdenNOMBRES{"Streptomyces ghanaensis ATCC 14672"}=140;
$hashOrdenNOMBRES2{140}="Streptomyces ghanaensis ATCC 14672";

$hashNOMBRES{'Acidothermuscellulolyticus11B'}="Acidothermus cellulolyticus 11B";
$hashOrdenNOMBRES{"Acidothermus cellulolyticus 11B"}=141;
$hashOrdenNOMBRES2{141}="Acidothermus cellulolyticus 11B";

$hashNOMBRES{'ActinomaduraatramentariaDSM43919'}="Actinomadura atramentaria DSM 43919";
$hashOrdenNOMBRES{"Actinomadura atramentaria DSM 43919"}=142;
$hashOrdenNOMBRES2{142}="Actinomadura atramentaria DSM 43919";

$hashNOMBRES{'ActinomaduramaduraeLIIDAJ290'}="Actinomadura madurae LIIDAJ290";
$hashOrdenNOMBRES{"Actinomadura madurae LIIDAJ290"}=143;
$hashOrdenNOMBRES2{143}="Actinomadura madurae LIIDAJ290";

$hashNOMBRES{'StreptosporangiumroseumDSM43021'}="Streptosporangium roseum DSM 43021";
$hashOrdenNOMBRES{"Streptosporangium roseum DSM 43021"}=144;
$hashOrdenNOMBRES2{144}="Streptosporangium roseum DSM 43021";

$hashNOMBRES{'NocardiopsishalophilaDSM44494'}="Nocardiopsis halophila DSM 44494";
$hashOrdenNOMBRES{"Nocardiopsis halophila DSM 44494"}=145;
$hashOrdenNOMBRES2{145}="Nocardiopsis halophila DSM 44494";

$hashNOMBRES{'NocardiopsisalbaATCCBAA2165'}="Nocardiopsis alba ATCC BAA2165";
$hashOrdenNOMBRES{"Nocardiopsis alba ATCC BAA2165"}=146;
$hashOrdenNOMBRES2{146}="Nocardiopsis alba ATCC BAA2165";

$hashNOMBRES{'NocardiopsisdassonvilleisubspdassonvilleiDSM43111'}="Nocardiopsis dassonvillei subsp dassonvillei DSM 43111";
$hashOrdenNOMBRES{"Nocardiopsis dassonvillei subsp dassonvillei DSM 43111"}=147;
$hashOrdenNOMBRES2{147}="Nocardiopsis dassonvillei subsp dassonvillei DSM 43111";

$hashNOMBRES{'NocardiopsisprasinaDSM43845'}="Nocardiopsis prasina DSM 43845";
$hashOrdenNOMBRES{"Nocardiopsis prasina DSM 43845"}=148;
$hashOrdenNOMBRES2{148}="Nocardiopsis prasina DSM 43845";

$hashNOMBRES{'NocardiopsisvalliformisDSM45023'}="Nocardiopsis valliformis DSM 45023";
$hashOrdenNOMBRES{"Nocardiopsis valliformis DSM 45023"}=149;
$hashOrdenNOMBRES2{149}="Nocardiopsis valliformis DSM 45023";

$hashNOMBRES{'FrankiaspEuI1c'}="Frankia sp EuI1c";
$hashOrdenNOMBRES{"Frankia sp EuI1c"}=150;
$hashOrdenNOMBRES2{150}="Frankia sp EuI1c";

$hashNOMBRES{'FrankiasymbiontofDatiscaglomerata'}="Frankia symbiont of Datisca glomerata";
$hashOrdenNOMBRES{"Frankia symbiont of Datisca glomerata"}=151;
$hashOrdenNOMBRES2{151}="Frankia symbiont of Datisca glomerata";

$hashNOMBRES{'FrankiaspEAN1pec'}="Frankia sp EAN1pec";
$hashOrdenNOMBRES{"Frankia sp EAN1pec"}=152;
$hashOrdenNOMBRES2{152}="Frankia sp EAN1pec";

$hashNOMBRES{'FrankiaalniACN14a'}="Frankia alni ACN14a";
$hashOrdenNOMBRES{"Frankia alni ACN14a"}=153;
$hashOrdenNOMBRES2{153}="Frankia alni ACN14a";

$hashNOMBRES{'FrankiaspCcI3'}="Frankia sp CcI3";
$hashOrdenNOMBRES{"Frankia sp CcI3"}=154;
$hashOrdenNOMBRES2{154}="Frankia sp CcI3";

$hashNOMBRES{'ActinoplanesfriuliensisDSM7358'}="Actinoplanes friuliensis DSM 7358";
$hashOrdenNOMBRES{"Actinoplanes friuliensis DSM 7358"}=155;
$hashOrdenNOMBRES2{155}="Actinoplanes friuliensis DSM 7358";

$hashNOMBRES{'ActinoplanesspN902109'}="Actinoplanes sp N902109";
$hashOrdenNOMBRES{"Actinoplanes sp N902109"}=156;
$hashOrdenNOMBRES2{156}="Actinoplanes sp N902109";

$hashNOMBRES{'ActinoplanesglobisporusDSM43857'}="Actinoplanes globisporus DSM 43857";
$hashOrdenNOMBRES{"Actinoplanes globisporus DSM 43857"}=157;
$hashOrdenNOMBRES2{157}="Actinoplanes globisporus DSM 43857";

$hashNOMBRES{'ActinoplanesspSE50/110'}="Actinoplanes sp SE50/110";
$hashOrdenNOMBRES{"Actinoplanes sp SE50/110"}=158;
$hashOrdenNOMBRES2{158}="Actinoplanes sp SE50/110";

$hashNOMBRES{'Actinoplanesmissouriensis431'}="Actinoplanes missouriensis 431";
$hashOrdenNOMBRES{"Actinoplanes missouriensis 431"}=159;
$hashOrdenNOMBRES2{159}="Actinoplanes missouriensis 431";

$hashNOMBRES{'MicromonosporaaurantiacaATCC27029'}="Micromonospora aurantiaca ATCC 27029";
$hashOrdenNOMBRES{"Micromonospora aurantiaca ATCC 27029"}=160;
$hashOrdenNOMBRES2{160}="Micromonospora aurantiaca ATCC 27029";

$hashNOMBRES{'MicromonosporaspL5'}="Micromonospora sp L5";
$hashOrdenNOMBRES{"Micromonospora sp L5"}=161;
$hashOrdenNOMBRES2{161}="Micromonospora sp L5";

$hashNOMBRES{'MicromonosporaspATCC39149'}="Micromonospora sp ATCC 39149";
$hashOrdenNOMBRES{"Micromonospora sp ATCC 39149"}=162;
$hashOrdenNOMBRES2{162}="Micromonospora sp ATCC 39149";

$hashNOMBRES{'MicromonosporalupinistrLupac08'}="Micromonospora lupini str Lupac 08";
$hashOrdenNOMBRES{"Micromonospora lupini str Lupac 08"}=163;
$hashOrdenNOMBRES2{163}="Micromonospora lupini str Lupac 08";

$hashNOMBRES{'VerrucosisporamarisAB18032'}="Verrucosispora maris AB18032";
$hashOrdenNOMBRES{"Verrucosispora maris AB18032"}=164;
$hashOrdenNOMBRES2{164}="Verrucosispora maris AB18032";

$hashNOMBRES{'SalinisporaarenicolaCNS205'}="Salinispora arenicola CNS205";
$hashOrdenNOMBRES{"Salinispora arenicola CNS205"}=165;
$hashOrdenNOMBRES2{165}="Salinispora arenicola CNS205";

$hashNOMBRES{'SalinisporatropicaCNB440'}="Salinispora tropica CNB440";
$hashOrdenNOMBRES{"Salinispora tropica CNB440"}=166;
$hashOrdenNOMBRES2{166}="Salinispora tropica CNB440";

$hashNOMBRES{'SalinisporapacificaCNT609'}="Salinispora pacifica CNT609";
$hashOrdenNOMBRES{"Salinispora pacifica CNT609"}=167;
$hashOrdenNOMBRES2{167}="Salinispora pacifica CNT609";

$hashNOMBRES{'SalinisporapacificaDSM45547'}="Salinispora pacifica DSM 45547";
$hashOrdenNOMBRES{"Salinispora pacifica DSM 45547"}=168;
$hashOrdenNOMBRES2{168}="Salinispora pacifica DSM 45547";

$hashNOMBRES{'Modestobactermarinus'}="Modestobacter marinus";
$hashOrdenNOMBRES{"Modestobacter marinus"}=169;
$hashOrdenNOMBRES2{169}="Modestobacter marinus";

$hashNOMBRES{'NakamurellamultipartitaDSM44233'}="Nakamurella multipartita DSM 44233";
$hashOrdenNOMBRES{"Nakamurella multipartita DSM 44233"}=170;
$hashOrdenNOMBRES2{170}="Nakamurella multipartita DSM 44233";

$hashNOMBRES{'ActinomycetosporachiangmaiensisDSM45062'}="Actinomycetospora chiangmaiensis DSM 45062";
$hashOrdenNOMBRES{"Actinomycetospora chiangmaiensis DSM 45062"}=171;
$hashOrdenNOMBRES2{171}="Actinomycetospora chiangmaiensis DSM 45062";

$hashNOMBRES{'ActinoalloteichusspitiensisRMV1378'}="Actinoalloteichus spitiensis RMV1378";
$hashOrdenNOMBRES{"Actinoalloteichus spitiensis RMV1378"}=172;
$hashOrdenNOMBRES2{172}="Actinoalloteichus spitiensis RMV1378";

$hashNOMBRES{'PseudonocardiadioxanivoransCB1190'}="Pseudonocardia dioxanivorans CB1190";
$hashOrdenNOMBRES{"Pseudonocardia dioxanivorans CB1190"}=173;
$hashOrdenNOMBRES2{173}="Pseudonocardia dioxanivorans CB1190";

$hashNOMBRES{'Allokutzneriaalbata'}="Allokutzneria albata";
$hashOrdenNOMBRES{"Allokutzneria albata"}=174;
$hashOrdenNOMBRES2{174}="Allokutzneria albata";

$hashNOMBRES{'SaccharopolysporaerythraeaNRRL2338'}="Saccharopolyspora erythraea NRRL 2338";
$hashOrdenNOMBRES{"Saccharopolyspora erythraea NRRL 2338"}=175;
$hashOrdenNOMBRES2{175}="Saccharopolyspora erythraea NRRL 2338";

$hashNOMBRES{'SaccharopolysporaspinosaNRRL18395'}="Saccharopolyspora spinosa NRRL 18395";
$hashOrdenNOMBRES{"Saccharopolyspora spinosa NRRL 18395"}=176;
$hashOrdenNOMBRES2{176}="Saccharopolyspora spinosa NRRL 18395";

$hashNOMBRES{'ActinokineosporaenzanensisDSM44649'}="Actinokineospora enzanensis DSM 44649";
$hashOrdenNOMBRES{"Actinokineospora enzanensis DSM 44649"}=177;
$hashOrdenNOMBRES2{177}="Actinokineospora enzanensis DSM 44649";

$hashNOMBRES{'ActinokineosporaspEG49'}="Actinokineospora sp EG49";
$hashOrdenNOMBRES{"Actinokineospora sp EG49"}=178;
$hashOrdenNOMBRES2{178}="Actinokineospora sp EG49";

$hashNOMBRES{'ActinokieosporaspCCPR83'}="Actinokieospora sp CCPR83";
$hashOrdenNOMBRES{"Actinokieospora sp CCPR83"}=179;
$hashOrdenNOMBRES2{179}="Actinokieospora sp CCPR83";

$hashNOMBRES{'KutzneriaalbidaDSM43870'}="Kutzneria albida DSM 43870";
$hashOrdenNOMBRES{"Kutzneria albida DSM 43870"}=180;
$hashOrdenNOMBRES2{180}="Kutzneria albida DSM 43870";

$hashNOMBRES{'SaccharothrixespanaensisDSM44229'}="Saccharothrix espanaensis DSM 44229";
$hashOrdenNOMBRES{"Saccharothrix espanaensis DSM 44229"}=181;
$hashOrdenNOMBRES2{181}="Saccharothrix espanaensis DSM 44229";

$hashNOMBRES{'ActinosynnemamirumDSM43827'}="Actinosynnema mirum DSM 43827";
$hashOrdenNOMBRES{"Actinosynnema mirum DSM 43827"}=182;
$hashOrdenNOMBRES2{182}="Actinosynnema mirum DSM 43827";

$hashNOMBRES{'Lentzeasp'}="Lentzea sp";
$hashOrdenNOMBRES{"Lentzea sp"}=183;
$hashOrdenNOMBRES2{183}="Lentzea sp";

$hashNOMBRES{'Lechevalieriaaerocolonigenes'}="Lechevalieria aerocolonigenes";
$hashOrdenNOMBRES{"Lechevalieria aerocolonigenes"}=184;
$hashOrdenNOMBRES2{184}="Lechevalieria aerocolonigenes";

$hashNOMBRES{'Lentzeaalbidocapillata'}="Lentzea albidocapillata";
$hashOrdenNOMBRES{"Lentzea albidocapillata"}=185;
$hashOrdenNOMBRES2{185}="Lentzea albidocapillata";

$hashNOMBRES{'SciscionellamarinaDSM45152'}="Sciscionella marina DSM 45152";
$hashOrdenNOMBRES{"Sciscionella marina DSM 45152"}=186;
$hashOrdenNOMBRES2{186}="Sciscionella marina DSM 45152";

$hashNOMBRES{'AmycolatopsisorientalisHCCB10007'}="Amycolatopsis orientalis HCCB10007";
$hashOrdenNOMBRES{"Amycolatopsis orientalis HCCB10007"}=187;
$hashOrdenNOMBRES2{187}="Amycolatopsis orientalis HCCB10007";

$hashNOMBRES{'AmycolatopsisdecaplaninaDSM44594'}="Amycolatopsis decaplanina DSM 44594";
$hashOrdenNOMBRES{"Amycolatopsis decaplanina DSM 44594"}=188;
$hashOrdenNOMBRES2{188}="Amycolatopsis decaplanina DSM 44594";

$hashNOMBRES{'StreptomycesspAA4'}="Streptomyces sp AA4";
$hashOrdenNOMBRES{"Streptomyces sp AA4"}=189;
$hashOrdenNOMBRES2{189}="Streptomyces sp AA4";

$hashNOMBRES{'AmycolatopsismediterraneiRB'}="Amycolatopsis mediterranei RB";
$hashOrdenNOMBRES{"Amycolatopsis mediterranei RB"}=190;
$hashOrdenNOMBRES2{190}="Amycolatopsis mediterranei RB";

$hashNOMBRES{'AmycolatopsismediterraneiS699'}="Amycolatopsis mediterranei S699";
$hashOrdenNOMBRES{"Amycolatopsis mediterranei S699"}=191;
$hashOrdenNOMBRES2{191}="Amycolatopsis mediterranei S699";

$hashNOMBRES{'AmycolatopsismediterraneiU32'}="Amycolatopsis mediterranei U32";
$hashOrdenNOMBRES{"Amycolatopsis mediterranei U32"}=192;
$hashOrdenNOMBRES2{192}="Amycolatopsis mediterranei U32";

$hashNOMBRES{'Prauserellarugosa'}="Prauserella rugosa";
$hashOrdenNOMBRES{"Prauserella rugosa"}=193;
$hashOrdenNOMBRES2{193}="Prauserella rugosa";

$hashNOMBRES{'SaccharomonosporasaliphilaYIM90502'}="Saccharomonospora saliphila YIM 90502";
$hashOrdenNOMBRES{"Saccharomonospora saliphila YIM 90502"}=194;
$hashOrdenNOMBRES2{194}="Saccharomonospora saliphila YIM 90502";

$hashNOMBRES{'SaccharomonosporapaurometabolicaYIM90007'}="Saccharomonospora paurometabolica YIM 90007";
$hashOrdenNOMBRES{"Saccharomonospora paurometabolica YIM 90007"}=195;
$hashOrdenNOMBRES2{195}="Saccharomonospora paurometabolica YIM 90007";

$hashNOMBRES{'SaccharomonosporaviridisDSM43017'}="Saccharomonospora viridis DSM 43017";
$hashOrdenNOMBRES{"Saccharomonospora viridis DSM 43017"}=196;
$hashOrdenNOMBRES2{196}="Saccharomonospora viridis DSM 43017";

$hashNOMBRES{'SaccharomonosporaazureaSZMC14600'}="Saccharomonospora azurea SZMC 14600";
$hashOrdenNOMBRES{"Saccharomonospora azurea SZMC 14600"}=197;
$hashOrdenNOMBRES2{197}="Saccharomonospora azurea SZMC 14600";

$hashNOMBRES{'SaccharomonosporaxinjiangensisXJ54'}="Saccharomonospora xinjiangensis XJ54";
$hashOrdenNOMBRES{"Saccharomonospora xinjiangensis XJ54"}=198;
$hashOrdenNOMBRES2{198}="Saccharomonospora xinjiangensis XJ54";

$hashNOMBRES{'SaccharomonosporaglaucaK62'}="Saccharomonospora glauca K62";
$hashOrdenNOMBRES{"Saccharomonospora glauca K62"}=199;
$hashOrdenNOMBRES2{199}="Saccharomonospora glauca K62";

$hashNOMBRES{'SaccharomonosporacyaneaNA134'}="Saccharomonospora cyanea NA134";
$hashOrdenNOMBRES{"Saccharomonospora cyanea NA134"}=200;
$hashOrdenNOMBRES2{200}="Saccharomonospora cyanea NA134";

$hashNOMBRES{'DietziacinnameaP4'}="Dietzia cinnamea P4";
$hashOrdenNOMBRES{"Dietzia cinnamea P4"}=201;
$hashOrdenNOMBRES2{201}="Dietzia cinnamea P4";

$hashNOMBRES{'Dietziaalimentaria72'}="Dietzia alimentaria 72";
$hashOrdenNOMBRES{"Dietzia alimentaria 72"}=202;
$hashOrdenNOMBRES2{202}="Dietzia alimentaria 72";

$hashNOMBRES{'CorynebacteriumkroppenstedtiiDSM44385'}="Corynebacterium kroppenstedtii DSM 44385";
$hashOrdenNOMBRES{"Corynebacterium kroppenstedtii DSM 44385"}=203;
$hashOrdenNOMBRES2{203}="Corynebacterium kroppenstedtii DSM 44385";

$hashNOMBRES{'CorynebacteriumjeikeiumK411'}="Corynebacterium jeikeium K411";
$hashOrdenNOMBRES{"Corynebacterium jeikeium K411"}=204;
$hashOrdenNOMBRES2{204}="Corynebacterium jeikeium K411";

$hashNOMBRES{'CorynebacteriumurealyticumDSM7109'}="Corynebacterium urealyticum DSM 7109";
$hashOrdenNOMBRES{"Corynebacterium urealyticum DSM 7109"}=205;
$hashOrdenNOMBRES2{205}="Corynebacterium urealyticum DSM 7109";

$hashNOMBRES{'CorynebacteriumdiphtheriaeNCTC13129'}="Corynebacterium diphtheriae NCTC 13129";
$hashOrdenNOMBRES{"Corynebacterium diphtheriae NCTC 13129"}=206;
$hashOrdenNOMBRES2{206}="Corynebacterium diphtheriae NCTC 13129";

$hashNOMBRES{'CorynebacteriumefficiensYS314'}="Corynebacterium efficiens YS314";
$hashOrdenNOMBRES{"Corynebacterium efficiens YS314"}=207;
$hashOrdenNOMBRES2{207}="Corynebacterium efficiens YS314";

$hashNOMBRES{'CorynebacteriumglutamicumR'}="Corynebacterium glutamicum R";
$hashOrdenNOMBRES{"Corynebacterium glutamicum R"}=208;
$hashOrdenNOMBRES2{208}="Corynebacterium glutamicum R";

$hashNOMBRES{'CorynebacteriumglutamicumATCC13032'}="Corynebacterium glutamicum ATCC 13032";
$hashOrdenNOMBRES{"Corynebacterium glutamicum ATCC 13032"}=209;
$hashOrdenNOMBRES2{209}="Corynebacterium glutamicum ATCC 13032";

$hashNOMBRES{'NocardiacyriacigeorgicaGUH2'}="Nocardia cyriacigeorgica GUH2";
$hashOrdenNOMBRES{"Nocardia cyriacigeorgica GUH2"}=210;
$hashOrdenNOMBRES2{210}="Nocardia cyriacigeorgica GUH2";

$hashNOMBRES{'NocardiabrasiliensisATCC700358'}="Nocardia brasiliensis ATCC 700358";
$hashOrdenNOMBRES{"Nocardia brasiliensis ATCC 700358"}=211;
$hashOrdenNOMBRES2{211}="Nocardia brasiliensis ATCC 700358";

$hashNOMBRES{'NocardiafarcinicaIFM10152'}="Nocardia farcinica IFM 10152";
$hashOrdenNOMBRES{"Nocardia farcinica IFM 10152"}=212;
$hashOrdenNOMBRES2{212}="Nocardia farcinica IFM 10152";

$hashNOMBRES{'Rhodococcusequi103S'}="Rhodococcus equi 103S";
$hashOrdenNOMBRES{"Rhodococcus equi 103S"}=213;
$hashOrdenNOMBRES2{213}="Rhodococcus equi 103S";

$hashNOMBRES{'RhodococcusjostiiRHA1'}="Rhodococcus jostii RHA1";
$hashOrdenNOMBRES{"Rhodococcus jostii RHA1"}=214;
$hashOrdenNOMBRES2{214}="Rhodococcus jostii RHA1";

$hashNOMBRES{'RhodococcusopacusB4'}="Rhodococcus opacus B4";
$hashOrdenNOMBRES{"Rhodococcus opacus B4"}=215;
$hashOrdenNOMBRES2{215}="Rhodococcus opacus B4";

$hashNOMBRES{'RhodococcuserythropolisPR4'}="Rhodococcus erythropolis PR4";
$hashOrdenNOMBRES{"Rhodococcus erythropolis PR4"}=216;
$hashOrdenNOMBRES2{216}="Rhodococcus erythropolis PR4";

$hashNOMBRES{'RhodococcuserythropolisCCM2595'}="Rhodococcus erythropolis CCM2595";
$hashOrdenNOMBRES{"Rhodococcus erythropolis CCM2595"}=217;
$hashOrdenNOMBRES2{217}="Rhodococcus erythropolis CCM2595";

$hashNOMBRES{'GordoniabronchialisDSM43247'}="Gordonia bronchialis DSM 43247";
$hashOrdenNOMBRES{"Gordonia bronchialis DSM 43247"}=218;
$hashOrdenNOMBRES2{218}="Gordonia bronchialis DSM 43247";

$hashNOMBRES{'GordoniapolyisoprenivoransVH2'}="Gordonia polyisoprenivorans VH2";
$hashOrdenNOMBRES{"Gordonia polyisoprenivorans VH2"}=219;
$hashOrdenNOMBRES2{219}="Gordonia polyisoprenivorans VH2";

$hashNOMBRES{'Mycobacteriumabscessus'}="Mycobacterium abscessus";
$hashOrdenNOMBRES{"Mycobacterium abscessus"}=220;
$hashOrdenNOMBRES2{220}="Mycobacterium abscessus";

$hashNOMBRES{'Mycobacteriumavium104'}="Mycobacterium avium 104";
$hashOrdenNOMBRES{"Mycobacterium avium 104"}=221;
$hashOrdenNOMBRES2{221}="Mycobacterium avium 104";

$hashNOMBRES{'MycobacteriumlepraeTN'}="Mycobacterium leprae TN";
$hashOrdenNOMBRES{"Mycobacterium leprae TN"}=222;
$hashOrdenNOMBRES2{222}="Mycobacterium leprae TN";

$hashNOMBRES{'MycobacteriumulceransAgy99'}="Mycobacterium ulcerans Agy99";
$hashOrdenNOMBRES{"Mycobacterium ulcerans Agy99"}=223;
$hashOrdenNOMBRES2{223}="Mycobacterium ulcerans Agy99";

$hashNOMBRES{'MycobacteriumbovisBCGstrMexico'}="Mycobacterium bovis BCG str Mexico";
$hashOrdenNOMBRES{"Mycobacterium bovis BCG str Mexico"}=224;
$hashOrdenNOMBRES2{224}="Mycobacterium bovis BCG str Mexico";

$hashNOMBRES{'MycobacteriumtuberculosisH37Rv'}="Mycobacterium tuberculosis H37Rv";
$hashOrdenNOMBRES{"Mycobacterium tuberculosis H37Rv"}=225;
$hashOrdenNOMBRES2{225}="Mycobacterium tuberculosis H37Rv";

$hashNOMBRES{'MycobacteriumtuberculosisCDC1551'}="Mycobacterium tuberculosis CDC1551";
$hashOrdenNOMBRES{"Mycobacterium tuberculosis CDC1551"}=226;
$hashOrdenNOMBRES2{226}="Mycobacterium tuberculosis CDC1551";

$hashNOMBRES{'MycobacteriumsmegmatisstrMC2155'}="Mycobacterium smegmatis str MC2 155";
$hashOrdenNOMBRES{"Mycobacterium smegmatis str MC2 155"}=227;
$hashOrdenNOMBRES2{227}="Mycobacterium smegmatis str MC2 155";

$hashNOMBRES{'MycobacteriumvanbaaleniiPYR1'}="Mycobacterium vanbaalenii PYR1";
$hashOrdenNOMBRES{"Mycobacterium vanbaalenii PYR1"}=228;
$hashOrdenNOMBRES2{228}="Mycobacterium vanbaalenii PYR1";

$hashNOMBRES{'MycobacteriumgilvumPYRGCK'}="Mycobacterium gilvum PYRGCK";
$hashOrdenNOMBRES{"Mycobacterium gilvum PYRGCK"}=229;
$hashOrdenNOMBRES2{229}="Mycobacterium gilvum PYRGCK";

$hashNOMBRES{'MycobacteriumspKMS'}="Mycobacterium sp KMS";
$hashOrdenNOMBRES{"Mycobacterium sp KMS"}=230;
$hashOrdenNOMBRES2{230}="Mycobacterium sp KMS";

$hashNOMBRES{'MycobacteriumspMCS'}="Mycobacterium sp MCS";
$hashOrdenNOMBRES{"Mycobacterium sp MCS"}=231;
$hashOrdenNOMBRES2{231}="Mycobacterium sp MCS";




$max=129;

#Directorio donde queremos estacionar los archivos
my $dir = "/var/www/newevomining/querys";
my $dirDB = "/var/www/newevomining/DB";
my $dirPB = "/var/www/newevomining/PasosBioSin";
my $blastdir = "/opt/ncbi-blast-2.2.28+/bin/";
my $OUTblast = "/var/www/newevomining/blast";
#my $viaMet="ALL_curado.fasta";
my $viaMet="ALL_curado020715.fasta";
#Array con extensiones de archivos que podemos recibir
my @extensiones = ('gif','jpg','jpeg','prot_fasta.2ConNombre','prot_fasta.2', 'fasta');
#my $db = "prueba.db";
my $db = "ALL_curadoHEADER2.db";
 ($eval,$score2)=recepcion_de_archivo(); #Iniciar la recepcion del archivo


$cont=0;
$valida=1;
$cuentaVia=1;
open (CHECK, ">check.hash");
open (VIAS, "$dirPB/$viaMet");
$cuantasViasvan=0;
while (<VIAS>){
chomp;
#print CHECK "$_\n";
  if($_ =~ />/){
    $_ =~ s/>//;
   print CHECK "$_\n"; 
    @viaPaso= split (/\|/, $_);
    $llaveViaPaso="$viaPaso[0]_$viaPaso[1]";
   #  print CHECK "-$llaveViaPaso\n";
     if(!exists $hashViaPaso{$llaveViaPaso}){ 
    #  print CHECK "PASOOOOOO$llaveViaPaso\n";
      if($ViaAnterior ne $viaPaso[0]){
       #$llaveViaPaso="$viaPaso[0]_0";                #
       # print CHECK "$cuentaVia**$llaveViaPaso*anterior: +++$ViaAnterior, actual:$viaPaso[0]\n";       
      
       $hashCeros{$cuentaVia}=$cuentaVia; # Esta seccion es para agregar unla columna vacia entre cada via en el HIT PLOT
       # $cuentaVia++;                          #
      }
      $cuantasViasvan++;
      $hashViaPaso{$llaveViaPaso}=$cuentaVia; ## contiee los detalles de las vias "3PGA_AMINOACIDS|4" y el valor es el numero de la columna de la tablaheatplot
      $hashDetallesvias{$cuentaVia}=$llaveViaPaso;# contiene lo mismo del hash anterior pero invertido en llave valor
      #print CHECK "$cuentaVia->>$viaPaso[2]\n";
      $hashNUMVia{$cuentaVia}=$viaPaso[2];#$viaPaso[0]? esto ser[ia para el nombre del paso
      $hashDescripcionvia{$llaveViaPaso}=$viaPaso[2];
     # print CHECK "$cuantasViasvan-$llaveViaPaso -aa-->  $cuentaVia ===$hashViaPaso{$llaveViaPaso} ---- $viaPaso[2]\n";
      $cuentaVia++;
      $ViaAnterior=$viaPaso[0];
     }     

  }

}

#close CHECK;
#--------- Indexa bd para blast --------------------------
#print "<h1>Indexando nuevo Genoma...</h1>";
##system "$blastdir/makeblastdb -dbtype prot -in $dir/$file_name\ConNombre -out $dirDB/$file_name\ConNombre.db";
# se ejecuto en lina de comando con lo siguiente: makeblastdb -dbtype prot -in GENOMES_DBrepaired.fasta -out GENOMES_DBrepaired.db
#print "<h1>Done...</h1>";
#print "<h1>Blast  Central Met./NP VS Genome DB...</h1>";
##system "$blastdir/blastp -db $dirDB/ALLv3.db -query $dirPB/GlycolysisnewHEADER.fasta -outfmt 6 -num_threads 4 -evalue $eval -out $OUTblast/pscp.blast";
#se ejecuto en lina de comando con lo siguiente:blastp -db DB/GENOMES_DBrepaired.db -query PasosBioSin/GlycolysisnewHEADER.fasta -outfmt 6 -num_threads 4 -evalue 0.0001 -out pscp.blast 
#blastp -db GENOMESDB_300120015.db -query ../PasosBioSin/ALL_curadoHEADER.fast -outfmt 6 -num_threads 4 -evalue 0.0001 -out ../blast/pscp30012015.blast
###################weekend############################system "$blastdir/blastp -db $dirDB/$db -query $dirPB/$viaMet -outfmt 6 -evalue $eval -out $OUTblast/pscp.blast";

#print "<h1>Done...</h1>"; 
# print  "<h1>Concatenando blast...</h1>";
	
#  system "cat $OUTblast/$file_name\ConNombre.blast $OUTblast/centralMetVSgenomeBASE.blast  >  $OUTblast/centralMetVSgenomeW$file_name\ConNombre.blast";
#  print  "<h1>aRCHIVO Concatenado:$file_name.out</h1>";

#open (BLA, "/var/www/newevomining/blast/pscp.blast");
#while (<BLA>){
#chomp;
#@datblast=split("\t", $_);


#}#
#close BLA;

#---------------------pinta tabla--------------
#open (BLA, "/var/www/newevomining/blast/pscp10rep3.blast");
open (BLA, "/var/www/newevomining/blast/pscp030715.blast");
$directory="/var/www/newevomining/log.blast";

open (LOG, ">$directory") or die $directory;
$co=1;
while (<BLA>){
chomp;
  @datblast=split("\t", $_);
  @datpasosBIO=split(/\|/, $datblast[0]);
  @datGenomas=split(/\|/, $datblast[1]);
 # print "$datblast[0]***$datblast[1]\n";
 # print "$datpasosBIO[1]_$datGenomas[5]\n";
 $porcentaje=$datblast[9]*100/$datblast[7];
 $cuatrillave=$datpasosBIO[0]."_".$datpasosBIO[1]."_".$datGenomas[1]."_".$datGenomas[5]; # esto es para qeu se selecciones un solo un GI por genoma, por via y por paso, sin redundancia entre esos 4 criterios
   
  if(!exists $hashUniqGI{$cuatrillave}){
    if ($datblast[11] >= $score2 and $porcentaje >50){
     #if(!exists $hashUniqGI{$trillave}){
      $llaveNVia="$datpasosBIO[0]_$datpasosBIO[1]";
      #$hashViaPaso{$llaveNVia}
      $llave="$hashViaPaso{$llaveNVia}"."_"."$datGenomas[5]";
      print LOG "$hashGenomas{$llave}\n";#"$llaveNVia--->$hashViaPaso{$llaveNVia}-->$llave\n";
      $hashGenomas{$llave}++;
      $hashGIs{$llave}=$hashGIs{$llave}."\t".$datGenomas[1];
      $hashUniqGI{$cuatrillave}=$datblast[2]; #indexa los detalles de la via, y el GI al valor del % de identidfad obtenido del blast
     
      if( !exists$hashpasos{$hashViaPaso{$llaveNVia}}){
        $hashpasos{$co} =$hashViaPaso{$llaveNVia}; #quiza haya que concatenar el numero al a via cuando se agreguen las demas vias
        $co++;
      }
     #print LOG "$_\n";
     #}
    }
    
  }#end if $hashUniqGI{$cuatrillave}
  

 
}#end while

print LOG "\n\n____________________________________\n\n\n";
$contador=0;
open (NUEVO, ">/var/www/newevomining/busca.Gintroducido") or die $!;
$firsttime=1; # esta bandera indica qeu hay un organismo mas ademas de los registrados en el hash y es la primera vez que entra en el proceso
$cuentaOrgdemas=101;
$cuentaOrgdemas=237;

foreach my $x (keys %hashGenomas){
 #print "-----------------\n";
 @datllave=split("_", $x );
    
    print LOG "$x*****$datllave[0]\n";
    if(!exists $hashNOMBRES{$datllave[1]}){
      $hashNOMBRES{$datllave[1]}=$datllave[1];
        ######### first time ?????#######
	 #if($firsttime==1){
          #  $cuentaOrgdemas=130;
         #   $firsttime=0;
         #}
         #else{
	 $contadordeGenomas++;
           $cuentaOrgdemas++;
         #}
	################################## 
	$hashOrdenNOMBRES2{$cuentaOrgdemas}=$datllave[1];
	$hashOrdenNOMBRES{$datllave[1]}=$cuentaOrgdemas;
	#print NUEVO " $hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}--$hashNOMBRES{$datllave[1]}--$datllave[1]/ $hashNOMBRES{$datllave[1]} / [$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]--$hashGenomas{$x}/$xllave:$cuentaOrgdemas, valor:$datllave[1] hashgenomas:$x\n";
	$hashNOMBRESActual{$cuentaOrgdemas}=1; 
        print LOG "siiiiii entro[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]\n";
    } 
    else{
    $contadordeGenomas++;
    $hashNOMBRESActual{$datllave[1]}=1;
    #print NUEVO "EXISTEEEEEN[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}--$hashNOMBRES{$datllave[1]}--$datllave[1]][$datllave[0]]-$hashNOMBRES{$datllave[1]}}][$datllave[0]-$hashGenomas{$x}/$xllave:$cuentaOrgdemas, valor:$datllave[1] hashgenomas:$x\n";
      #$hashNOMBRES{$datllave[1]} =~ s/ //g;
      if(!exists $hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}){
        $hashNOMBRES{$datllave[1]} =~ s/ //g;
      }
      print LOG "noooooo entro[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]-$hashNOMBRES{$datllave[1]}-$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}-\n";
    }
    #$hashNOMBRESActual{$datllave[1]}=1; #registra los nombres qeu provienen del blast para posteterioemente compraralos con el hashNombres
    #print NUEVO "$cuentaOrgdemas**$datllave[1]/*/[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]--$hashGenomas{$x}/$x\n";#"$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}__$datllave[0]**$datllave[1]\n";#**$hashGenomas{$x}++\n";#$hashGIs{$x}\n";
    $numGenoma2{$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}}="$datllave[1]";
    $tabla[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]="$hashGenomas{$x}";
    $tabla2[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]="$hashGIs{$x}";
    $tablanombrevia[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]="$hashDetallesvias{$datllave[0]}--$hashDescripcionvia{$hashDetallesvias{$datllave[0]}}/$hashNOMBRES{$datllave[1]}";
   #
#	print LOG "/$x/$#{$tabla[1]}+$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}+$datllave[0]+$tabla[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]\n";
$arrpasos[$datllave[0]]=$arrpasos[$datllave[0]].",".$hashGenomas{$x};

$sumarray[$datllave[0]]=$sumarray[$datllave[0]]+$hashGenomas{$x};
#print "$numGenoma{$datllave[1]}, $datllave[0]] =$hashGenomas{$x}\n ";
#<STDIN>;
}#end foreach %hashGenomas
print LOG "TERMINO EN:$cuentaOrgdemas. total:$contadordeGenomas.\n";
#close LOG;
#print LOG "**filas $#tabla2 columnas $#{$tabla2[1]}\n";
####################################################
##    CALCULO DE DESVIACION ESTANDAR
##
  $contstd=1;
  #print "<h1>$sumarray[1]</h1>";
  foreach my $x ( @arrpasos ){
     @arregloPROm=split(",",$x);
      my @v1  = vector(@arregloPROm);
      my $std = stddev(@v1);
    #  $arrSTD[$contstd]=$std;
    
 
   $numgenomas=$#tabla;
   $promediO=$sumarray[$contstd]/$numgenomas;
 
   $arrSTD[$contstd]=$promediO+$std;
   $sumPROM='';
   $contstd++;
}
##
##
######################################################
print qq |

<div class="encabezado">
<div class="expanded">Expanded enzyme families</div>
</p>
<form method="post" action="/cgi-bin/newevomining/evomBlastNp2.0BASIC.pl"
name="foma">
<table BORDER="0" CELLSPACING="0" ALIGN="center"  WIDTH="15">
<div class="subtitulo" ALIGN="center">Blast option:</div>
	<div class="campo1">e-value:</div>
    <div class="campo-1"><textarea style="width: 65px; height: 25px;" cols="1" rows="1" name="evalue">0.0001</textarea></div>
    <div class="campo2">Minimum Score:</div>
    <div class="campo2-2"><textarea style="width: 50px; height: 25px;" cols="1" rows="1" name="score">100</textarea></div>
    <input type="hidden" name="pidfecha" value="$outdir">
    <div class="boton"><button  value="Submit" name="Submit">SUBMIT</button></div>
</table>
<br>
</form>
|;

#print scalar keys %hashGenomas;
close BLA;
###print  LOG "paso 1 filas $#tabla comunas $#{$tabla[1]}\n";
#print "<h1>$tabla2[3][1]</h1>"; 
print qq|<table cellpadding="1" cellspacing="0" class="tabla">|;
#print "<tr>";
$tope=$#tabla+1;

for (my $x=1; $x<=$tope; $x++){#***filas****
#print LOG "$x--$hashOrdenNOMBRES2{$x}-$#{$tabla[1]}\n";
    if(!exists $hashNOMBRESActual{$x}){
       print NUEVO "$hashOrdenNOMBRES2{$x}\n";
       #next;
    }
    if(!exists $hashOrdenNOMBRES2{$x}){
      next;
    }
print "<tr>";
#if($x ==0){
    
    #print "<td>$numGenoma2{$x}</td>";
    # print "<td>$x</td>";
      if(exists $hashNOMBRES{$hashOrdenNOMBRES2{$x}}){
        print qq|<td>$hashNOMBRES{$hashOrdenNOMBRES2{$x}}</td>|;
	#print qq|<td>/*$hashOrdenNOMBRES2{$x}*/$#{$tabla[1]}/$tope/$x/$y/$hashOrdenNOMBRES{$hashOrdenNOMBRES2{$x}}/$x</td>|;
	
      }
      else{
        print qq|<td>$hashOrdenNOMBRES2{$x}</td>|;
        #print qq|<td>/*$hashOrdenNOMBRES2{$x}*/$#{$tabla[1]}/$tope/$x/$y/$hashOrdenNOMBRES{$hashOrdenNOMBRES2{$x}}/$x</td>|;
      }
      #print qq|<td>/*$hashOrdenNOMBRES2{$x}*/$#{$tabla[1]}/$tope/$x/$y/$hashOrdenNOMBRES{$hashOrdenNOMBRES2{$x}}/$x</td>|;
     #print LOG 
 #   }
# print LOG "$#{$tabla[1]}\n";
  for(my $y=1; $y<=$#{$tabla[1]}; $y++){ #columnas******
    if(!$tabla[$x][$y] ){
      $tabla[$x][$y]=0;
    }
    if(exists $hashCeros{$y}){
     print qq |<td  bgcolor="#585858"></td>|; #escribe division de vias en tabla
    }
    
   if($tabla[$x][$y] >= $arrSTD[$y]){
    # print qq| <td bgcolor= "#8A0808" >$tabla[$x][$y]</td>|;
     $tabla2[$x][$y] =~ s/E/ E/g;# para los casos en qeu no viene co GI agrega un espacio, pues sal[ian pegados
    print qq |<td bgcolor= "#a02b2b" title=" $tablanombrevia[$x][$y] / $tabla2[$x][$y]" >$tabla[$x][$y]</td>|;
    $tabla3[$x][$y]=$tabla2[$x][$y]; ######selecciona ROJOS del heatplot en tabla3 para el caso de qeu se ocupe mas adelante
     $keyExpanded="$x_$y";
     $hashEXPANDED{$keyExpanded}=1;
   }
   else {
      if ($x == $tope){ 
        # print "<td>$arrSTD[$y]</td>"; #IMPRIME ULTIMA FILA COM DATOS
       }
       else {
        print qq |<td title=" $tablanombrevia[$x][$y] / $tabla2[$x][$y]">$tabla[$x][$y]</td>|;
      #  print LOG "***$tabla[$x][$y]-$x-$y\n";
      }
   } 
  }#end for columnas=  
  print "</tr>";
#pLOGrint "</table>";
}#end for filas
print "</table>";
open(SALE, ">/var/www/newevomining/vacio.hash");
$tope2=$#tabla2+1;
####print LOG "paso antes columas $tabla2{$tabla2[1]} filas $tope2\n";
#------------------EXTRAE gi y genera fastas-----------------
for(my $y=1; $y<=$#{$tabla2[1]}; $y++){ #columnas******

# print "++columna $y \n";
   for (my $x=1; $x<=$tope2; $x++){#***filas****
      ####print LOG "-columna $y  fila $x $tabla2[$x][$y]\n";
       ###selecciona ROJOS del heatplot##@losGIs=split("\t",$tabla3[$x][$y]);
       $keyExpanded2="$x_$y";
       #if(exists $hashEXPANDED{$keyExpanded2}){
         @losGIs=split("\t",$tabla2[$x][$y]);
       #}
       #####selecciona ROJOS del heatplot#if($tabla3[$x][$y] eq ''){
       #####selecciona ROJOS del heatplot#  next;
       #####selecciona ROJOS del heatplot#}
       foreach my $r (@losGIs){
         if($r){
	   $Allgis{$r}=1;
	  #### print LOG "SIIIIIIIIII*$r*\n";
	 }
       }
   }
   $siH=0; 
   # open (FAST, "$dirDB/GENOMES_DBrepaired.fasta") or die $!;
   open (FAST, "$dirDB/GENOMESDB_300120015repaired.fasta") or die $!;
  # open (FASTA, ">/var/www/newevomining/FASTASparaNP/$hashpasos{$y}.fasta"; 
   open (FASTA, ">/var/www/newevomining/FASTASparaNP/$y.fasta") or die  $!;
   while(<FAST>){
   chomp;
   
     if($_ =~ />gi\|(\w+)\|/){
       $Header=$_;
      #print FASTA "ENTRADA $1\n";
       if(exists $Allgis{$1}){
         $siH=1;
	 print FASTA "$_\n";
       }
       else{
         $siH=0;
       }
     }
     else{
      if ($siH ==1){
        print FASTA "$_\n";
      }
     }
   
   
   
   }
   close FAST;
   close FASTA;
   %Allgis='';
   close LOG;
   close CHECK;
}

close SALE;
#--------------------------
#<table>
#<tr>
#<td>Celda 1</td>
#<td>Celda 2</td>
#<td>Celda 3</td>
#</tr>
#<tr>
#<td>Celda 4</td>
#<td>Celda 5</td>
#<td>Celda 6</td>
#</tr>
#</table>

#---------------------------


#0---------------------end pinta tabla---------

#1.- calcular numero de hits (homologos) por genoma por pasos biosinteticos
#2.- calcular media y desviacion estandar para cada paso biosintetico 
  #2.1.- la media + la deviacion estandar es el punto de corte para seleccionar los que se analizan en el siguente paso
#3.- visualizar en tabla 
#4.- mouse over de GI de cada hit porgenoma y paso biosintetico


exit(1);






#######################################################
# funciones para upload
#######################################################
sub recepcion_de_archivo{

my $evalue = $Input{'evalue'};
my $score1 = $Input{'score'};
#my $nombre_en_servidor = $Input{'archivo'};

$evalue =~ s/ /_/gi;
$evalue =~ s!^.*(\\|\/)!!;
$score1=~ s/ /_/gi;
$score1 =~ s!^.*(\\|\/)!!;


my $extension_correcta = 1;

#foreach (@extensiones){
#if($nombre_en_servidor =~ /\.$_$/i){
#$extension_correcta = 1;
#last;
#}
#}


#if($extension_correcta){3
#
##Abrimos el nuevo archivo
#open (OUTFILE, ">$dir/$nombre_en_servidor") || die "$! $dir No se puedo crear el archivo";
#binmode(OUTFILE); #Para no tener problemas en Windows#
#
##Transferimos byte por byte el archivo
#while (my $bytesread = read($Input{'archivo'}, my $buffer, 1024)) {
#print OUTFILE $buffer;
#}

##Cerramos el archivo creado
#close (OUTFILE);#
#
#}else{
#print "Content-type: text/html\n\n";
#print "<h1>Extension incorrecta</h1>";
#print "Sólo se reciben archivo con extension:";
#print join(",", @extensiones);
#exit(0);
#}
return $evalue,$score1;

} #sub recepcion_de_archivo
