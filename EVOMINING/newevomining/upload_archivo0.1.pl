#!/usr/bin/perl -w
#####################################################
# CODIGO PARA UPLOAD-FILE
#
#####################################################

#use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI;

my %Input;

my $query = new CGI;
my @pairs = $query->param;

foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}


#--------------------------------hash nombres-------------
$hashNOMBRES{'Bifidobacteriumanimalissubsp.lactisAD011'}="Bifidobacterium animalislactisADO11";
$hashNOMBRES{BifidobacteriumadolescentisATCC15703}="Bifidobacterium adolescentisATC15703";
$hashNOMBRES{BifidobacteriumlongumDJO10A}="Bifidobacterium longumDJO10A";
$hashNOMBRES{'Clavibactermichiganensissubsp.michiganensisNCPPB382'}="Clavibacter michiganensis";
$hashNOMBRES{'Leifsoniaxylisubsp.xylistr.CTCB07'}="Leifsonia xyli CTCB07";
$hashNOMBRES{BrevibacteriumlinensBL2}="Brevibacterium linens BL2";
$hashNOMBRES{RenibacteriumsalmoninarumATCC33209}="Renibacterium salmoninarumATCC33209";
$hashNOMBRES{ArthrobacterchlorophenolicusA6}="Arthrobacter chlorophenolicusA6";
$hashNOMBRES{ArthrobacteraurescensTC1}="Arthrobacter aurescens TC1";
$hashNOMBRES{ArthrobacterphenanthrenivoransSphe3}="Arthrobacter phenanthrenivorans Sphe3";
$hashNOMBRES{ArthrobacterarilaitensisRe117}="Arthrobacter arilaitensis Re117";
$hashNOMBRES{KocuriarhizophilaDC2201}="Kocuria rhizophilaDC2201";
$hashNOMBRES{MicrococcusluteusNCTC2665}="Micrococcus luteus NCTC2665";
$hashNOMBRES{'Citricoccussp.CH26A'}="Citricoccus CH26A";
$hashNOMBRES{KineococcusradiotoleransSRS30216}="Kineococcus radiotoleransSRS30216";
$hashNOMBRES{'Janibactersp.HTCC2649'}="Janibacter HTCC2649";
$hashNOMBRES{'Nocardioidessp.JS614'}="Nocardioides JS614";
$hashNOMBRES{'Propionibacteriumfreudenreichiisubsp.shermaniiCIRM-BIA1'}="Propionibacterium freudenreichii CIRMBIA1";
$hashNOMBRES{PropionibacteriumhumerusiiP08}="Propionibacterium humerusii P08";
$hashNOMBRES{PropionibacteriumacnesKPA171202}="Propionebacterium acnesKPA171202";
$hashNOMBRES{CatenulisporaacidiphilaDSM44928}="Catenulispora acidiphila DSM44928";
$hashNOMBRES{KitasatosporasetaeKM-6054}="Kitasatospora setae KM6054";
$hashNOMBRES{'StreptomycescattleyaNRRL8057=DSM46488'}="Streptomyces cattleya DSM46488";
$hashNOMBRES{StreptomycesauratusAGR0001}="Streptomyces auratus AGR0001";
$hashNOMBRES{StreptomyceshygroscopicusATCC53653}="Streptomyces hygroscopicusATCC53653";
$hashNOMBRES{StreptomycesbingchenggensisBCW-1}="Streptomyces bingchenggensis BCW1";
$hashNOMBRES{StreptomycesviolaceusnigerTu4113}="Streptomyces violaceusniger Tu4113";
$hashNOMBRES{StreptomycesclavuligerusATCC27064}="Streptomyces clavuligerus ATCC27064";
$hashNOMBRES{StreptomycestsukubaensisNRRL18488}="Streptomyces tsukubaensis NRRL18488";
$hashNOMBRES{StreptomycespristinaespiralisATCC25486}="Streptomyces pristinaespiralis ATCC 25486";
$hashNOMBRES{StreptomycesflavogriseusATCC33331}="Streptomyces flavogriseus ATCC33331";
$hashNOMBRES{'Streptomycessp.SirexAA-E'}="Streptomyces spSirexAAE";
$hashNOMBRES{'Streptomycessp.W007'}="Streptomyces spW007";
$hashNOMBRES{StreptomycesglobisporusC-1027}="Streptomyces globisporus C1027";
$hashNOMBRES{'Streptomycesgriseussubsp.griseusNBRC13350'}="Streptomyces griseus";
$hashNOMBRES{StreptomycesgriseusXylebKG-1}="Streptomyces griseus XylebKG1";
$hashNOMBRES{StreptomycesroseosporusNRRL11379}="Streptomyces roseosporus NRRL11379";
$hashNOMBRES{StreptomycesroseosporusNRRL15998}="Streptomyces roseosporusNRRL15998";
$hashNOMBRES{'Streptomycesscabiei87.22'}="Streptomyces scabiei";
$hashNOMBRES{'Streptomycessp.Mg1'}="Streptomyces spMg1";
$hashNOMBRES{StreptomycesspC}="Streptomyces spC";
$hashNOMBRES{StreptomycesvenezuelaeATCC10712}="Streptomyces venezuelae ATCC10712";
$hashNOMBRES{StreptomycesavermitilisMA-4680}="Streptomyces avermitilis";
$hashNOMBRES{StreptomycesalbusJ1074}="Streptomyces albus J1074";
$hashNOMBRES{'Streptomycessp.SPB74'}="Streptomyces spSPB74";
$hashNOMBRES{'Streptomycessp.SPB78'}="Streptomyces spSPB78";
$hashNOMBRES{'Streptomycessp.SA3'}="Streptomyces spSA3actG";
$hashNOMBRES{'Streptomycessp.Tu6071'}="Streptomyces spTu6071";
$hashNOMBRES{StreptomycesgriseoflavusTu4000}="Streptomyces griseoflavusTu4000";
$hashNOMBRES{StreptomycescoelicoflavusZG0656}="Streptomyces coelicoflavus ZG0656";
$hashNOMBRES{'StreptomycescoelicolorA3(2)'}="Streptomyces coelicolorM145";
$hashNOMBRES{StreptomyceslividansTK24}="Streptomyces lividans TK24";
$hashNOMBRES{StreptomycessviceusATCC29083}="Streptomyces sviceus ATCC29083";
$hashNOMBRES{Streptomyceslividans1326}="Streptomyces lividans 1326";
$hashNOMBRES{'Streptomycessp.e14'}="Streptomyces spe14";
$hashNOMBRES{StreptomycesgriseoaurantiacusM045}="Streptomyces griseoaurantiacus M045";
$hashNOMBRES{StreptomyceszinciresistensK42}="Streptomyces zinciresistens K42";
$hashNOMBRES{StreptomycesdavawensisJCM4913}="Streptomyces davawensis JCM4913";
$hashNOMBRES{Streptomycesacidiscabies84-104}="Streptomyces acidiscabies 84104";
$hashNOMBRES{Streptomycesipomoeae91-03}="Streptomyces ipomoeae 9103";
$hashNOMBRES{StreptomycesviridochromogenesDSM40736}="Streptomyces viridochromogenes DSM40736";
$hashNOMBRES{StreptomyceschartreusisNRRL12338}="Streptomyces chartreusis NRRL12338";
$hashNOMBRES{StreptomycesghanaensisATCC14672}="Streptomyces ghanaensis ATCC14672";
$hashNOMBRES{StreptomycessomaliensisDSM40738}="Streptomyces somaliensis DSM40738";
$hashNOMBRES{StreptomycesviridochromogenesTue57}="Streptomyces viridochromogenes Tue57";
#$hashNOMBRES{}="Acydothermus cellulolyticus11B";*****************************************************************
$hashNOMBRES{ThermomonosporacurvataDSM43183}="Thermomonospora curvata DSM43183";
$hashNOMBRES{StreptosporangiumroseumDSM43021}="Streptosporangium roseum DSM43021";
$hashNOMBRES{ThermobisporabisporaDSM43833}="Thermobispora bispora DSM43833";
$hashNOMBRES{FrankiasymbiontofDatiscaglomerata}="Frankia Datisca";
$hashNOMBRES{'Frankiasp.EAN1pec'}="Frankia EAN1pec";
$hashNOMBRES{FrankiaalniACN14a}="Frankia alniACN14a";
$hashNOMBRES{'Frankiasp.CcI3'}="Frankia SPCcI3";
$hashNOMBRES{SalinisporatropicaCNB-440}="Salinispora tropica";
$hashNOMBRES{SalinisporaarenicolaCNS-205}="Salinispora arenicola";
#$hashNOMBRES{}="Verrucosispora maris AB18032";************************************************************
$hashNOMBRES{'Micromonosporasp.ATCC39149'}="Micromonospora spATCC39149";
$hashNOMBRES{'Micromonosporalupinistr.Lupac08'}="Micromonospora lupini Lupac08";
$hashNOMBRES{'Micromonosporasp.L5'}="Micromonospora spL5";
$hashNOMBRES{MicromonosporaaurantiacaATCC27029}="Micromonospora aurantiaca ATCC27029";
$hashNOMBRES{Modestobactermarinus}="Modestobacter marinus";
$hashNOMBRES{NakamurellamultipartitaDSM44233}="Nakamurella multipartita DSM44233";
$hashNOMBRES{PseudonocardiadioxanivoransCB1190}="Pseudonocardia dioxanivorans CB1190";
$hashNOMBRES{SaccharopolysporaerythraeaNRRL2338}="Saccharopolyspora erythraea";
$hashNOMBRES{SaccharopolysporaspinosaNRRL18395}="Saccharopolyspora spinosa NRRL18395";
$hashNOMBRES{SaccharothrixespanaensisDSM44229}="Saccharothrix espanaensis DSM44229";
#$hashNOMBRES{}="Amycolatopsis AA4";********************************************************************
$hashNOMBRES{AmycolatopsismediterraneiU32}="Amycolatopsis mediterraneiU32";
$hashNOMBRES{AmycolatopsismediterraneiS699}="Amycolatopsis mediterranei S699";
$hashNOMBRES{'Amycolatopsissp.ATCC39116'}="Amycolatopsis ATCC39116";
$hashNOMBRES{SaccharomonosporamarinaXMU15}="Saccharomonospora marina XMU15";
$hashNOMBRES{SaccharomonosporapaurometabolicaYIM90007}="Saccharomonospora paurometabolica YIM90007";
$hashNOMBRES{SaccharomonosporaviridisDSM43017}="Saccharomonospora viridisDSM43017";
$hashNOMBRES{SaccharomonosporaxinjiangensisXJ-54}="Saccharomonospora xinjiangensis XJ54";
$hashNOMBRES{SaccharomonosporacyaneaNA-134}="Saccharomonospora cyanea NA134";
$hashNOMBRES{SaccharomonosporaglaucaK62}="Saccharomonospora glauca K62";
$hashNOMBRES{SaccharomonosporaazureaNA-128}="Saccharomonospora azurea NA128";
$hashNOMBRES{SaccharomonosporaazureaSZMC14600}="Saccharomonospora azurea SZMC14600";
$hashNOMBRES{DietziacinnameaP4}="Dietzia cinnamea P4";
$hashNOMBRES{CorynebacteriumamycolatumSK46}="Corynebacterium amycolatum SK46";
$hashNOMBRES{CorynebacteriumkroppenstedtiiDSM44385}="Corynebacterium kroppenstedtii DSM44385";
$hashNOMBRES{CorynebacteriumurealyticumDSM7109}="Corynebacterium urealyticum DSM7109";
$hashNOMBRES{CorynebacteriumjeikeiumATCC43734}="Corynebacterium jeikeium ATCC43734";
$hashNOMBRES{CorynebacteriumjeikeiumK411}="Corynebacterium jeikenium K411";
$hashNOMBRES{CorynebacteriumglutamicumR}="Corynebacterium glutamicum R";
$hashNOMBRES{CorynebacteriumglutamicumATCC13032}="Corynebacterium glutamicum ATCC13032";
$hashNOMBRES{Corynebacteriumdiphtheriae}="Corynebacterium diphteriae";
$hashNOMBRES{CorynebacteriumefficiensYS-314}="Corynebacterium efficiens YS314";
$hashNOMBRES{CorynebacteriumglucuronolyticumATCC51867}="Corynebacterium glucuronolyticum ATCC51867";
$hashNOMBRES{CorynebacteriumaccolensATCC49725}="Corynebacterium accolens ATCC49725";
$hashNOMBRES{CorynebacteriumstriatumATCC6940}="Corynebacterium striatum ATCC6940";
#$hashNOMBRES{}="Tsukamurella paurometabola DSM20162";***************************************************************
$hashNOMBRES{GordoniapolyisoprenivoransVH2}="Gordonia polyisoprenivorans VH2";
#$hashNOMBRES{}="Rhodococcus pyridinivorans AK37";**************************************************
#$hashNOMBRES{}="Rhodococcus equi ATCC33707";*********************************************************
#$hashNOMBRES{}="Rhodococcus erythropolis PR4";********************************************************
#$hashNOMBRES{}="Rhodococcus erythropolis SK121";*********************************************************
#$hashNOMBRES{}="Rhodococcus jostii RHA1";**************************************************************
#$hashNOMBRES{}="Rhodococcus opacus B4";*****************************************************************
#$hashNOMBRES{}="Rhodococcus imtechensis RKJ300";*******************************************************
$hashNOMBRES{NocardiabrasiliensisATCC700358}="Nocardia brasiliensis ATCC700358";
$hashNOMBRES{NocardiacyriacigeorgicaGUH-2}="Nocardia cyriacigeorgica";
$hashNOMBRES{NocardiafarcinicaIFM10152}="Nocardia farcinicaIFM10152";
$hashNOMBRES{MycobacteriumabscessusATCC19977}="Mycobacterium abscessus ATCC19977";
$hashNOMBRES{'Mycobacteriumsmegmatisstr.MC2155'}="Mycobacterium smegmatis MC2155";
$hashNOMBRES{MycobacteriumthermoresistibileATCC19527}="Mycobacterium thermoresistibile ATCC19527";
$hashNOMBRES{MycobacteriumrhodesiaeNBB3}="Mycobacterium rhodesiae NBB3";
$hashNOMBRES{MycobacteriumvanbaaleniiPYR-1}="Mycobacterium vanbaalenii PYR1";
$hashNOMBRES{MycobacteriumgilvumPYR-GCK}="Mycobacterium gilvum PYRGCK";
$hashNOMBRES{'Mycobacteriumsp.JLS'}="Mycobacterium spJLS";
$hashNOMBRES{'Mycobacteriumsp.MCS'}="Mycobacterium sp MCS";
$hashNOMBRES{'Mycobacteriumsp.KMS'}="Mycobacterium sp KMS";
$hashNOMBRES{MycobacteriumparascrofulaceumATCCBAA-614}="Mycobacterium parascrofulaceum ATCCBAA614";
$hashNOMBRES{MycobacteriumulceransAgy99}="Mycobacterium ulcerans Agy99";
$hashNOMBRES{MycobacteriummarinumM}="Mycobacterium marinum M";
$hashNOMBRES{MycobacteriumkansasiiATCC12478}="Mycobacterium kansasii 12478";
$hashNOMBRES{Mycobacteriumleprae}="Mycobacterium leprae";
$hashNOMBRES{MycobacteriumtuberculosisCDC1551}="Mycobacterium tuberculosis CDC1551";
$hashNOMBRES{MycobacteriumafricanumGM041182}="Mycobacterium africanum GM041182";
$hashNOMBRES{'MycobacteriumbovisBCGstr.Mexico'}="Mycobacterium bovis BCG Mexico";
###############################################################################
#   hash orden nombres
$hashOrdenNOMBRES{"Bifidobacterium animalislactisADO11"}=0;
$hashOrdenNOMBRES2{0}="Bifidobacterium animalislactisADO11";
$hashOrdenNOMBRES{"Bifidobacterium adolescentisATC15703"}=1;
$hashOrdenNOMBRES2{1}="Bifidobacterium adolescentisATC15703";
$hashOrdenNOMBRES{"Bifidobacterium longumDJO10A"}=2;
$hashOrdenNOMBRES2{2}="Bifidobacterium longumDJO10A";
$hashOrdenNOMBRES{"Clavibacter michiganensis"}=3;
$hashOrdenNOMBRES2{3}="Clavibacter michiganensis";
$hashOrdenNOMBRES{"Leifsonia xyli CTCB07"}=4;
$hashOrdenNOMBRES2{4}="Leifsonia xyli CTCB07";
$hashOrdenNOMBRES{"Brevibacterium linens BL2"}=5;
$hashOrdenNOMBRES2{5}="Brevibacterium linens BL2";
$hashOrdenNOMBRES{"Renibacterium salmoninarumATCC33209"}=6;
$hashOrdenNOMBRES2{6}="Renibacterium salmoninarumATCC33209";
$hashOrdenNOMBRES{"Arthrobacter chlorophenolicusA6"}=7;
$hashOrdenNOMBRES2{7}="Arthrobacter chlorophenolicusA6";
$hashOrdenNOMBRES{"Arthrobacter aurescens TC1"}=8;
$hashOrdenNOMBRES2{8}="Arthrobacter aurescens TC1";
$hashOrdenNOMBRES{"Arthrobacter phenanthrenivorans Sphe3"}=9;
$hashOrdenNOMBRES2{9}="Arthrobacter phenanthrenivorans Sphe3";
$hashOrdenNOMBRES{"Arthrobacter arilaitensis Re117"}=10;
$hashOrdenNOMBRES2{10}="Arthrobacter arilaitensis Re117";
$hashOrdenNOMBRES{"Kocuria rhizophilaDC2201"}=11;
$hashOrdenNOMBRES2{11}="Kocuria rhizophilaDC2201";
$hashOrdenNOMBRES{"Micrococcus luteus NCTC2665"}=12;
$hashOrdenNOMBRES2{12}="Micrococcus luteus NCTC2665";
$hashOrdenNOMBRES{"Citricoccus CH26A"}=13;
$hashOrdenNOMBRES2{13}="Citricoccus CH26A";
$hashOrdenNOMBRES{"Kineococcus radiotoleransSRS30216"}=14;
$hashOrdenNOMBRES2{14}="Kineococcus radiotoleransSRS30216";
$hashOrdenNOMBRES{"Janibacter HTCC2649"}=15;
$hashOrdenNOMBRES2{15}="Janibacter HTCC2649";
$hashOrdenNOMBRES{"Nocardioides JS614"}=16;
$hashOrdenNOMBRES2{16}="Nocardioides JS614";
$hashOrdenNOMBRES{"Propionibacterium freudenreichii CIRMBIA1"}=17;
$hashOrdenNOMBRES2{17}="Propionibacterium freudenreichii CIRMBIA1";
$hashOrdenNOMBRES{"Propionibacterium humerusii P08"}=18;
$hashOrdenNOMBRES2{18}="Propionibacterium humerusii P08";
$hashOrdenNOMBRES{"Propionebacterium acnesKPA171202"}=19;
$hashOrdenNOMBRES2{19}="Propionebacterium acnesKPA171202";
$hashOrdenNOMBRES{"Catenulispora acidiphila DSM44928"}=20;
$hashOrdenNOMBRES2{20}="Catenulispora acidiphila DSM44928";
$hashOrdenNOMBRES{"Kitasatospora setae KM6054"}=21;
$hashOrdenNOMBRES2{21}="Kitasatospora setae KM6054";
$hashOrdenNOMBRES{"Streptomyces cattleya DSM46488"}=22;
$hashOrdenNOMBRES2{22}="Streptomyces cattleya DSM46488";
$hashOrdenNOMBRES{"Streptomyces auratus AGR0001"}=23;
$hashOrdenNOMBRES2{23}="Streptomyces auratus AGR0001";
$hashOrdenNOMBRES{"Streptomyces hygroscopicusATCC53653"}=24;
$hashOrdenNOMBRES2{24}="Streptomyces hygroscopicusATCC53653";
$hashOrdenNOMBRES{"Streptomyces bingchenggensis BCW1"}=25;
$hashOrdenNOMBRES2{25}="Streptomyces bingchenggensis BCW1";
$hashOrdenNOMBRES{"Streptomyces violaceusniger Tu4113"}=26;
$hashOrdenNOMBRES2{26}="Streptomyces violaceusniger Tu4113";
$hashOrdenNOMBRES{"Streptomyces clavuligerus ATCC27064"}=27;
$hashOrdenNOMBRES2{27}="Streptomyces clavuligerus ATCC27064";
$hashOrdenNOMBRES{"Streptomyces tsukubaensis NRRL18488"}=28;
$hashOrdenNOMBRES2{28}="Streptomyces tsukubaensis NRRL18488";
$hashOrdenNOMBRES{"Streptomyces pristinaespiralis ATCC 25486"}=29;
$hashOrdenNOMBRES2{29}="Streptomyces pristinaespiralis ATCC 25486";
$hashOrdenNOMBRES{"Streptomyces flavogriseus ATCC33331"}=30;
$hashOrdenNOMBRES2{30}="Streptomyces flavogriseus ATCC33331";
$hashOrdenNOMBRES{"Streptomyces spSirexAAE"}=31;
$hashOrdenNOMBRES2{31}="Streptomyces spSirexAAE";
$hashOrdenNOMBRES{"Streptomyces spW007"}=32;
$hashOrdenNOMBRES2{32}="Streptomyces spW007";
$hashOrdenNOMBRES{"Streptomyces globisporus C1027"}=33;
$hashOrdenNOMBRES2{33}="Streptomyces globisporus C1027";
$hashOrdenNOMBRES{"Streptomyces griseus"}=34;
$hashOrdenNOMBRES2{34}="Streptomyces griseus";
$hashOrdenNOMBRES{"Streptomyces griseus XylebKG1"}=35;
$hashOrdenNOMBRES2{35}="Streptomyces griseus XylebKG1";
$hashOrdenNOMBRES{"Streptomyces roseosporus NRRL11379"}=36;
$hashOrdenNOMBRES2{36}="Streptomyces roseosporus NRRL11379";
$hashOrdenNOMBRES{"Streptomyces roseosporusNRRL15998"}=37;
$hashOrdenNOMBRES2{37}="Streptomyces roseosporusNRRL15998";
$hashOrdenNOMBRES{"Streptomyces scabiei"}=38;
$hashOrdenNOMBRES2{38}="Streptomyces scabiei";
$hashOrdenNOMBRES{"Streptomyces spMg1"}=39;
$hashOrdenNOMBRES2{39}="Streptomyces spMg1";
$hashOrdenNOMBRES{"Streptomyces spC"}=40;
$hashOrdenNOMBRES2{40}="Streptomyces spC";
$hashOrdenNOMBRES{"Streptomyces venezuelae ATCC10712"}=41;
$hashOrdenNOMBRES2{41}="Streptomyces venezuelae ATCC10712";
$hashOrdenNOMBRES{"Streptomyces avermitilis"}=42;
$hashOrdenNOMBRES2{42}="Streptomyces avermitilis";
$hashOrdenNOMBRES{"Streptomyces albus J1074"}=43;
$hashOrdenNOMBRES2{43}="Streptomyces albus J1074";
$hashOrdenNOMBRES{"Streptomyces spSPB74"}=44;
$hashOrdenNOMBRES2{44}="Streptomyces spSPB74";
$hashOrdenNOMBRES{"Streptomyces spSPB78"}=45;
$hashOrdenNOMBRES2{45}="Streptomyces spSPB78";
$hashOrdenNOMBRES{"Streptomyces spSA3actG"}=46;
$hashOrdenNOMBRES2{46}="Streptomyces spSA3actG";
$hashOrdenNOMBRES{"Streptomyces spTu6071"}=47;
$hashOrdenNOMBRES2{47}="Streptomyces spTu6071";
$hashOrdenNOMBRES{"Streptomyces griseoflavusTu4000"}=48;
$hashOrdenNOMBRES2{48}="Streptomyces griseoflavusTu4000";
$hashOrdenNOMBRES{"Streptomyces coelicoflavus ZG0656"}=49;
$hashOrdenNOMBRES2{49}="Streptomyces coelicoflavus ZG0656";
$hashOrdenNOMBRES{"Streptomyces coelicolorM145"}=50;
$hashOrdenNOMBRES2{50}="Streptomyces coelicolorM145";
$hashOrdenNOMBRES{"Streptomyces lividans TK24"}=51;
$hashOrdenNOMBRES2{51}="Streptomyces lividans TK24";
$hashOrdenNOMBRES{"Streptomyces sviceus ATCC29083"}=52;
$hashOrdenNOMBRES2{52}="Streptomyces sviceus ATCC29083";
$hashOrdenNOMBRES{"Streptomyces lividans 1326"}=53;
$hashOrdenNOMBRES2{53}="Streptomyces lividans 1326";
$hashOrdenNOMBRES{"Streptomyces spe14"}=54;
$hashOrdenNOMBRES2{54}="Streptomyces spe14";
$hashOrdenNOMBRES{"Streptomyces griseoaurantiacus M045"}=55;
$hashOrdenNOMBRES2{55}="Streptomyces griseoaurantiacus M045";
$hashOrdenNOMBRES{"Streptomyces zinciresistens K42"}=56;
$hashOrdenNOMBRES2{56}="Streptomyces zinciresistens K42";
$hashOrdenNOMBRES{"Streptomyces davawensis JCM4913"}=57;
$hashOrdenNOMBRES2{57}="Streptomyces davawensis JCM4913";
$hashOrdenNOMBRES{"Streptomyces acidiscabies 84104"}=58;
$hashOrdenNOMBRES2{58}="Streptomyces acidiscabies 84104";
$hashOrdenNOMBRES{"Streptomyces ipomoeae 9103"}=59;
$hashOrdenNOMBRES2{59}="Streptomyces ipomoeae 9103";
$hashOrdenNOMBRES{"Streptomyces viridochromogenes DSM40736"}=60;
$hashOrdenNOMBRES2{60}="Streptomyces viridochromogenes DSM40736";
$hashOrdenNOMBRES{"Streptomyces chartreusis NRRL12338"}=61;
$hashOrdenNOMBRES2{61}="Streptomyces chartreusis NRRL12338";
$hashOrdenNOMBRES{"Streptomyces ghanaensis ATCC14672"}=62;
$hashOrdenNOMBRES2{62}="Streptomyces ghanaensis ATCC14672";
$hashOrdenNOMBRES{"Streptomyces somaliensis DSM40738"}=63;
$hashOrdenNOMBRES2{63}="Streptomyces somaliensis DSM40738";
$hashOrdenNOMBRES{"Streptomyces viridochromogenes Tue57"}=64;
$hashOrdenNOMBRES2{64}="Streptomyces viridochromogenes Tue57";
$hashOrdenNOMBRES{"Thermomonospora curvata DSM43183"}=65;
$hashOrdenNOMBRES2{65}="Thermomonospora curvata DSM43183";
$hashOrdenNOMBRES{"Streptosporangium roseum DSM43021"}=66;
$hashOrdenNOMBRES2{66}="Streptosporangium roseum DSM43021";
$hashOrdenNOMBRES{"Thermobispora bispora DSM43833"}=67;
$hashOrdenNOMBRES2{67}="Thermobispora bispora DSM43833";
$hashOrdenNOMBRES{"Frankia Datisca"}=68;
$hashOrdenNOMBRES2{68}="Frankia Datisca";
$hashOrdenNOMBRES{"Frankia EAN1pec"}=69;
$hashOrdenNOMBRES2{69}="Frankia EAN1pec";
$hashOrdenNOMBRES{"Frankia alniACN14a"}=70;
$hashOrdenNOMBRES2{70}="Frankia alniACN14a";
$hashOrdenNOMBRES{"Frankia SPCcI3"}=71;
$hashOrdenNOMBRES2{71}="Frankia SPCcI3";
$hashOrdenNOMBRES{"Salinispora tropica"}=72;
$hashOrdenNOMBRES2{72}="Salinispora tropica";
$hashOrdenNOMBRES{"Salinispora arenicola"}=73;
$hashOrdenNOMBRES2{73}="Salinispora arenicola";
$hashOrdenNOMBRES{"Micromonospora spATCC39149"}=74;
$hashOrdenNOMBRES2{74}="Micromonospora spATCC39149";
$hashOrdenNOMBRES{"Micromonospora lupini Lupac08"}=75;
$hashOrdenNOMBRES2{75}="Micromonospora lupini Lupac08";
$hashOrdenNOMBRES{"Micromonospora spL5"}=76;
$hashOrdenNOMBRES2{76}="Micromonospora spL5";
$hashOrdenNOMBRES{"Micromonospora aurantiaca ATCC27029"}=77;
$hashOrdenNOMBRES2{77}="Micromonospora aurantiaca ATCC27029";
$hashOrdenNOMBRES{"Modestobacter marinus"}=78;
$hashOrdenNOMBRES2{78}="Modestobacter marinus";
$hashOrdenNOMBRES{"Nakamurella multipartita DSM44233"}=79;
$hashOrdenNOMBRES2{79}="Nakamurella multipartita DSM44233";
$hashOrdenNOMBRES{"Pseudonocardia dioxanivorans CB1190"}=80;
$hashOrdenNOMBRES2{80}="Pseudonocardia dioxanivorans CB1190";
$hashOrdenNOMBRES{"Saccharopolyspora erythraea"}=81;
$hashOrdenNOMBRES2{81}="Saccharopolyspora erythraea";
$hashOrdenNOMBRES{"Saccharopolyspora spinosa NRRL18395"}=82;
$hashOrdenNOMBRES2{82}="Saccharopolyspora spinosa NRRL18395";
$hashOrdenNOMBRES{"Saccharothrix espanaensis DSM44229"}=83;
$hashOrdenNOMBRES2{83}="Saccharothrix espanaensis DSM44229";
$hashOrdenNOMBRES{"Amycolatopsis mediterraneiU32"}=84;
$hashOrdenNOMBRES2{84}="Amycolatopsis mediterraneiU32";
$hashOrdenNOMBRES{"Amycolatopsis mediterranei S699"}=85;
$hashOrdenNOMBRES2{85}="Amycolatopsis mediterranei S699";
$hashOrdenNOMBRES{"Amycolatopsis ATCC39116"}=86;
$hashOrdenNOMBRES2{86}="Amycolatopsis ATCC39116";
$hashOrdenNOMBRES{"Saccharomonospora marina XMU15"}=87;
$hashOrdenNOMBRES2{87}="Saccharomonospora marina XMU15";
$hashOrdenNOMBRES{"Saccharomonospora paurometabolica YIM90007"}=88;
$hashOrdenNOMBRES2{88}="Saccharomonospora paurometabolica YIM90007";
$hashOrdenNOMBRES{"Saccharomonospora viridisDSM43017"}=89;
$hashOrdenNOMBRES2{89}="Saccharomonospora viridisDSM43017";
$hashOrdenNOMBRES{"Saccharomonospora xinjiangensis XJ54"}=90;
$hashOrdenNOMBRES2{90}="Saccharomonospora xinjiangensis XJ54";
$hashOrdenNOMBRES{"Saccharomonospora cyanea NA134"}=91;
$hashOrdenNOMBRES2{91}="Saccharomonospora cyanea NA134";
$hashOrdenNOMBRES{"Saccharomonospora glauca K62"}=92;
$hashOrdenNOMBRES2{92}="Saccharomonospora glauca K62";
$hashOrdenNOMBRES{"Saccharomonospora azurea NA128"}=93;
$hashOrdenNOMBRES2{93}="Saccharomonospora azurea NA128";
$hashOrdenNOMBRES{"Saccharomonospora azurea SZMC14600"}=94;
$hashOrdenNOMBRES2{94}="Saccharomonospora azurea SZMC14600";
$hashOrdenNOMBRES{"Dietzia cinnamea P4"}=95;
$hashOrdenNOMBRES2{95}="Dietzia cinnamea P4";
$hashOrdenNOMBRES{"Corynebacterium amycolatum SK46"}=96;
$hashOrdenNOMBRES2{96}="Corynebacterium amycolatum SK46";
$hashOrdenNOMBRES{"Corynebacterium kroppenstedtii DSM44385"}=97;
$hashOrdenNOMBRES2{97}="Corynebacterium kroppenstedtii DSM44385";
$hashOrdenNOMBRES{"Corynebacterium urealyticum DSM7109"}=98;
$hashOrdenNOMBRES2{98}="Corynebacterium urealyticum DSM7109";
$hashOrdenNOMBRES{"Corynebacterium jeikeium ATCC43734"}=99;
$hashOrdenNOMBRES2{99}="Corynebacterium jeikeium ATCC43734";
$hashOrdenNOMBRES{"Corynebacterium jeikenium K411"}=100;
$hashOrdenNOMBRES2{100}="Corynebacterium jeikenium K411";
$hashOrdenNOMBRES{"Corynebacterium glutamicum R"}=101;
$hashOrdenNOMBRES2{101}="Corynebacterium glutamicum R";
$hashOrdenNOMBRES{"Corynebacterium glutamicum ATCC13032"}=102;
$hashOrdenNOMBRES2{102}="Corynebacterium glutamicum ATCC13032";
$hashOrdenNOMBRES{"Corynebacterium diphteriae"}=103;
$hashOrdenNOMBRES2{103}="Corynebacterium diphteriae";
$hashOrdenNOMBRES{"Corynebacterium efficiens YS314"}=104;
$hashOrdenNOMBRES2{104}="Corynebacterium efficiens YS314";
$hashOrdenNOMBRES{"Corynebacterium glucuronolyticum ATCC51867"}=105;
$hashOrdenNOMBRES2{105}="Corynebacterium glucuronolyticum ATCC51867";
$hashOrdenNOMBRES{"Corynebacterium accolens ATCC49725"}=106;
$hashOrdenNOMBRES2{106}="Corynebacterium accolens ATCC49725";
$hashOrdenNOMBRES{"Corynebacterium striatum ATCC6940"}=107;
$hashOrdenNOMBRES2{107}="Corynebacterium striatum ATCC6940";
$hashOrdenNOMBRES{"Gordonia polyisoprenivorans VH2"}=108;
$hashOrdenNOMBRES2{108}="Gordonia polyisoprenivorans VH2";
$hashOrdenNOMBRES{"Nocardia brasiliensis ATCC700358"}=109;
$hashOrdenNOMBRES2{109}="Nocardia brasiliensis ATCC700358";
$hashOrdenNOMBRES{"Nocardia cyriacigeorgica"}=110;
$hashOrdenNOMBRES2{110}="Nocardia cyriacigeorgica";
$hashOrdenNOMBRES{"Nocardia farcinicaIFM10152"}=111;
$hashOrdenNOMBRES2{111}="Nocardia farcinicaIFM10152";
$hashOrdenNOMBRES{"Mycobacterium abscessus ATCC19977"}=112;
$hashOrdenNOMBRES2{112}="Mycobacterium abscessus ATCC19977";
$hashOrdenNOMBRES{"Mycobacterium smegmatis MC2155"}=113;
$hashOrdenNOMBRES2{113}="Mycobacterium smegmatis MC2155";
$hashOrdenNOMBRES{"Mycobacterium thermoresistibile ATCC19527"}=114;
$hashOrdenNOMBRES2{114}="Mycobacterium thermoresistibile ATCC19527";
$hashOrdenNOMBRES{"Mycobacterium rhodesiae NBB3"}=115;
$hashOrdenNOMBRES2{115}="Mycobacterium rhodesiae NBB3";
$hashOrdenNOMBRES{"Mycobacterium vanbaalenii PYR1"}=116;
$hashOrdenNOMBRES2{116}="Mycobacterium vanbaalenii PYR1";
$hashOrdenNOMBRES{"Mycobacterium gilvum PYRGCK"}=117;
$hashOrdenNOMBRES2{117}="Mycobacterium gilvum PYRGCK";
$hashOrdenNOMBRES{"Mycobacterium spJLS"}=118;
$hashOrdenNOMBRES2{118}="Mycobacterium spJLS";
$hashOrdenNOMBRES{"Mycobacterium sp MCS"}=119;
$hashOrdenNOMBRES2{119}="Mycobacterium sp MCS";
$hashOrdenNOMBRES{"Mycobacterium sp KMS"}=120;
$hashOrdenNOMBRES2{120}="Mycobacterium sp KMS";
$hashOrdenNOMBRES{"Mycobacterium parascrofulaceum ATCCBAA614"}=121;
$hashOrdenNOMBRES2{121}="Mycobacterium parascrofulaceum ATCCBAA614";
$hashOrdenNOMBRES{"Mycobacterium ulcerans Agy99"}=122;
$hashOrdenNOMBRES2{122}="Mycobacterium ulcerans Agy99";
$hashOrdenNOMBRES{"Mycobacterium marinum M"}=123;
$hashOrdenNOMBRES2{123}="Mycobacterium marinum M";
$hashOrdenNOMBRES{"Mycobacterium kansasii 12478"}=124;
$hashOrdenNOMBRES2{124}="Mycobacterium kansasii 12478";
$hashOrdenNOMBRES{"Mycobacterium leprae"}=125;
$hashOrdenNOMBRES2{125}="Mycobacterium leprae";
$hashOrdenNOMBRES{"Mycobacterium tuberculosis CDC1551"}=126;
$hashOrdenNOMBRES2{126}="Mycobacterium tuberculosis CDC1551";
$hashOrdenNOMBRES{"Mycobacterium africanum GM041182"}=127;
$hashOrdenNOMBRES2{127}="Mycobacterium africanum GM041182";
$hashOrdenNOMBRES{"Mycobacterium bovis BCG Mexico"}=128;
$hashOrdenNOMBRES2{128}="Mycobacterium bovis BCG Mexico";

#Directorio donde queremos estacionar los archivos
my $dir = "/var/www/newevomining/querys";
my $dirDB = "/var/www/newevomining/DB";
my $dirPB = "/var/www/newevomining/PasosBioSin";
my $blastdir = "/opt/ncbi-blast-2.2.28+/bin/";
my $OUTblast = "/var/www/newevomining/blast";
#Array con extensiones de archivos que podemos recibir
my @extensiones = ('gif','jpg','jpeg','bmp','prot_fasta.2', 'fasta');


my $file_name=recepcion_de_archivo(); #Iniciar la recepcion del archivo

#TODO SALIO BIEN
print "Content-type: text/html\n\n";
print "<h1>El archivo fue recibido correctamente $file_name </h1>\n";

################  END UPLOAD-FILE######################
#------------------------------------------------------------
#######################################################
# CODIGO INSERTA DATOS EN bd
#######################################################
#------valida longitud de seq > 50 y seq!= nucleotidos---
#open (NEW, "/var/www/evomining/newevomining/querys/$file_name") or die "<h1>*$file_name*$!</h1>";
#open (ERROR, ">/var/www/evomining/newevomining/error/$file_name.ERRORLOG") or die "<h1>$!</h1>";
#$file_name =~ s/\s|\W//g; #elimina espacio y caracteres noletras/digitos del nombre

$cont=0;
$valida=1;
#while (<NEW>){
# chomp;
# 
#   if ($_ =~ />/){
#      $header=$_;
#      @longSeq=split("",$seq);
#      if($cont >0 and $#longSeq < 50){
#         #secuencia corta meno a 50 aminoacidos
#	 print "<h1>$header</h1> <h1>$seq</h1><h1>ERROR secuencia muy corta</h1>";
#	 $valida=0;
#      }
#   }
#   else{
#   
#      if( $_ !~ /G|A|T|C/){
#         #solo nucleotidos
#	 print  "<h1>ERROR secuencia de nucleotidos:</h1><h1>$_</h1>,<h1> se requiere secuencia de aminoaciods</h1>";
#	 $valida=0;
#      }
#      $seq=$seq.$_;
#   }
#   
#  $cont++; 
#}#end while
#close NEW;
#-----------------termina validacion----------------------
#--------------da formato a genoma query-----------------
#               anexando nombre del genoma
#               tomado del nombre del archivo
#
open (QUE, "$dir/$file_name")or die $!;
open (QUERY, ">$dir/$file_name\ConNombre") or die $!;
$tempname=$file_name;
$tempname =~ s/\..*fasta.*//;
while(<QUE>){
chomp;
  if ($_ =~ />/){
    $_ =$_."|$tempname|";
    print QUERY "$_\n";
  }
  else{
    print QUERY "$_\n";
  }
}



close QUE;
close QUERY;





#--------- concatena archivo en bd------------------------
if ($valida ==1){
  #print  "<h1>Concatenando...</h1>";
	
  #system "cat $dir/$file_name $dirDB/ALLv3SINAA4.out  > $dirDB/ALL_$file_name.out ";
  #print  "<h1>aRCHIVO Concatenado:ALL_$file_name.out</h1>";
}


#--------- Indexa bd para blast --------------------------
print "<h1>Indexando nuevo Genoma...</h1>";
system "$blastdir/makeblastdb -dbtype prot -in $dir/$file_name -out $dirDB/$file_name.db";
print "<h1>Done...</h1>";
print "<h1>Blast  Central Met./NP VS Genome DB...</h1>";
system "$blastdir/blastp -db $dirDB/$file_name.db -query $dirPB/GlycolysisnewHEADER.fasta -outfmt 6 -num_threads 4 -evalue 0.0001 -out $OUTblast/$file_name.blast";
print "<h1>Done...</h1>"; 
 print  "<h1>Concatenando blast...</h1>";
	
  system "cat $OUTblast/$file_name.blast $OUTblast/centralMetVSgenomeBASE.blast  >  $OUTblast/centralMetVSgenomeW$file_name.blast";
  print  "<h1>aRCHIVO Concatenado:$file_name.out</h1>";

open (BLA, "/var/www/newevomining/blast/centralMetVSgenomeW$file_name.blast");
while (<BLA>){
chomp;
@datblast=split("\t", $_);


}
close BLA;

#---------------------pinta tabla--------------
open (BLA, "/var/www/newevomining/blast/centralMetVSgenomeW$file_name.blast");
open (LOG, ">log.blast") or die $!;
while (<BLA>){
chomp;
  @datblast=split("\t", $_);
  @datpasosBIO=split(/\|/, $datblast[0]);
  @datGenomas=split(/\|/, $datblast[1]);
 # print "$datblast[0]***$datblast[1]\n";
 # print "$datpasosBIO[1]_$datGenomas[5]\n";
  if(!exists $hashUniqGI{$datGenomas[1]}){
    if ($datblast[11] >= 150){
     $llave="$datpasosBIO[1]_$datGenomas[5]";
     $hashGenomas{$llave}++;
     $hashUniqGI{$datGenomas[1]}=1;
     print LOG "$_\n";
    }
    else{
     #$llave="$datpasosBIO[1]_$datGenomas[5]";
     #$hashGenomas{$llave}=0;
    } 
  }
 
}#end while
$contador=0;
foreach my $x (keys %hashGenomas){
 #print "-----------------\n";
 @datllave=split("_", $x );
 #print "$x -> $hashGenomas{$x} --- $datllave[0]\n";
 #@datllave=split("_", $x );
# if(!exists $numGenoma{$datllave[1]}){
   $contador++;
#   $numGenoma{$datllave[1]}=$contador;
#   $numGenoma2{$contador}=$datllave[1];
# }
#$tabla[$numGenoma{$datllave[1]}][$datllave[0]]=$hashGenomas{$x};Bifidobacteriumanimalissubsp.lactisAD011
$tabla[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]="[$datllave[1]][$datllave[0]]=$hashGenomas{$x}";
$numGenoma2{$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}}=$datllave[1];
#print "$numGenoma{$datllave[1]}, $datllave[0]] =$hashGenomas{$x}\n ";
#<STDIN>;
}
close LOG;

#print scalar keys %hashGenomas;
close BLA;
#print "filas $#tabla comunas $#{$tabla[1]}\n";

print qq|<table BORDER="1" CELLSPACING="1" ALIGN="center" CELLPADDING="0" WIDTH="15">|;
#print "<tr>";
for (my $x=0; $x<=$#tabla; $x++){#***filas****
print "<tr>";
#if($x ==0){
    print "<td>$numGenoma2{$x}</td>";
     print "<td>$x</td>";
     print "<td>$hashOrdenNOMBRES2{$x}</td>";
 #   }
  for(my $y=0; $y<=$#{$tabla[1]}; $y++){ #columnas******
    #if(!$tabla[$x][$y]){
    #  $tabla[$x][$y]=0;
    #}
    print "<td>$tabla[$x][$y]</td>";
    
  }#end for filas
  print "</tr>";
}#end for columnas



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

my $nombre_en_servidor = $Input{'archivo'};
$nombre_en_servidor =~ s/ /_/gi;
$nombre_en_servidor =~ s!^.*(\\|\/)!!;


my $extension_correcta = 0;

foreach (@extensiones){
if($nombre_en_servidor =~ /\.$_$/i){
$extension_correcta = 1;
last;
}
}


if($extension_correcta){

#Abrimos el nuevo archivo
open (OUTFILE, ">$dir/$nombre_en_servidor") || die "$! $dir No se puedo crear el archivo";
binmode(OUTFILE); #Para no tener problemas en Windows

#Transferimos byte por byte el archivo
while (my $bytesread = read($Input{'archivo'}, my $buffer, 1024)) {
print OUTFILE $buffer;
}

#Cerramos el archivo creado
close (OUTFILE);

}else{
print "Content-type: text/html\n\n";
print "<h1>Extension incorrecta</h1>";
print "Sólo se reciben archivo con extension:";
print join(",", @extensiones);
exit(0);
}
return $nombre_en_servidor;

} #sub recepcion_de_archivo
