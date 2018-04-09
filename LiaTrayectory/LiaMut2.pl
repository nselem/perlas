use strict;
use warnings;
##### 
## This script calculates the rutes between mutants
## At the end I keep by the results on rsults
my %Rutas;
my %STARTS;
my %PROFAR;
my %PRA;
my %RESULT;

$PRA{2.1}="0.0002319";
$PRA{2.2}="0.0001485";
$PRA{2.3}="0";
$PRA{2.4}="0";
$PRA{2.5}="0.000138";
$PRA{3.1}="0.00026";
$PRA{3.2}="0.00069";
$PRA{3.3}="0.00046";
$PRA{3.4}="0.00025";
$PRA{3.5}="0.00051";
$PRA{3.6}="0.00027";
$PRA{4.1}="0.00062";
$PRA{4.2}="0.0005";
$PRA{4.3}="0.00053";
$PRA{4.4}="0.00055";
$PRA{4.5}="0.00053";
$PRA{4.6}="0.00047";
$PRA{4.7}="0.00049";
$PRA{4.8}="0.00084";
$PRA{4.9}="0.00067";
$PRA{4.101}="0.00036";
$PRA{4.11}="0.00033";
$PRA{4.12}="0.00047";
$PRA{4.13}="0.00063";
$PRA{5.1}="0.00017";
$PRA{5.2}="0.00025";
$PRA{5.3}="0.00025";
$PRA{5.4}="0.0001";
$PRA{5.5}="0.00042";
$PRA{5.6}="0.00029";
$PRA{5.7}="0.00044";
$PRA{5.8}="0.00026";
$PRA{5.9}="0.00032";
$PRA{5.101}="0.00028";
$PRA{5.11}="0.00008";
$PRA{5.12}="0.00012";
$PRA{5.13}="0.003";
$PRA{5.14}="0.0002";
$PRA{5.15}="0.0016";
$PRA{5.16}="0";
$PRA{5.17}="0.0004";
$PRA{5.18}="0.000095";
$PRA{6.1}="0.0003";
$PRA{6.2}="0.0005";
$PRA{6.3}="0.0003";
$PRA{6.4}="0.0005";
$PRA{6.5}="0.0004";
$PRA{6.6}="0.0003";
$PRA{6.7}="0.00013";
$PRA{6.8}="0.000078";
$PRA{6.9}="0.0001";
$PRA{6.101}="0.0002";
$PRA{6.11}="0";
$PRA{6.12}="0.00012";
$PRA{6.13}="0.00046";
$PRA{6.14}="0.0013";
$PRA{6.15}="0.00071";
$PRA{6.16}="0.00088";
$PRA{6.17}="0";
$PRA{6.18}="0.000075";
$PRA{7.1}="0.00021";
$PRA{7.2}="0.00025";
$PRA{7.3}="0.00027";
$PRA{7.4}="0.00015";
$PRA{7.5}="0.00019";
$PRA{7.6}="0.00036";
$PRA{7.14}="0.00027";
$PRA{7.7}="0.00022";
$PRA{7.8}="0.0000692";
$PRA{7.9}="0.00037";
$PRA{7.101}="0.00013";
$PRA{7.11}="0.000063";
$PRA{7.12}="0.000051";
$PRA{7.13}="0.00057";
$PRA{8.1}="0.000315";
$PRA{8.2}="0.00092";
$PRA{8.3}="0.00057";
$PRA{8.4}="0.00086";
$PRA{8.5}="0.00067";
$PRA{8.6}="0.00065";
$PRA{8.7}="0.00046";
$PRA{8.8}="0.0003";
$PRA{9.1}="0.0047";
$PRA{9.2}="0.0016";
$PRA{9.3}="0.012";
$PRA{9.4}="0.00088";
$PRA{10.1}="0.0023";
$PRA{10.2}="0.0046";
$PRA{11.1}="0.0001537";

$PROFAR{2.1}="0.25";
$PROFAR{2.2}="0.001";
$PROFAR{2.3}="0.01";
$PROFAR{2.4}="0.31";
$PROFAR{2.5}="0.21";
$PROFAR{3.1}="0.5";
$PROFAR{3.2}="0";
$PROFAR{3.3}="0.05";
$PROFAR{3.4}="0.07";
$PROFAR{3.5}="0.15";
$PROFAR{3.6}="0.064";
$PROFAR{4.1}="0.02";
$PROFAR{4.2}="0.0079";
$PROFAR{4.3}="0.0014";
$PROFAR{4.4}="0.0074";
$PROFAR{4.5}="0.02";
$PROFAR{4.6}="0.08";
$PROFAR{4.7}="0.02";
$PROFAR{4.8}="0.01";
$PROFAR{4.9}="0.07";
$PROFAR{4.101}="0.00012";
$PROFAR{4.11}="0.0013";
$PROFAR{4.12}="0.0046";
$PROFAR{4.13}="0.0174";
$PROFAR{5.1}="0.25";
$PROFAR{5.2}="0.18";
$PROFAR{5.3}="0.018";
$PROFAR{5.4}="0.0075";
$PROFAR{5.5}="0.014";
$PROFAR{5.6}="0.0047";
$PROFAR{5.7}="0.038";
$PROFAR{5.8}="0.0066";
$PROFAR{5.9}="0.031";
$PROFAR{5.101}="0.05";
$PROFAR{5.11}="0.036";
$PROFAR{5.12}="0.052";
$PROFAR{5.13}="0.007";
$PROFAR{5.14}="0.041";
$PROFAR{5.15}="0.00038";
$PROFAR{5.16}="0.00061";
$PROFAR{5.17}="0";
$PROFAR{5.18}="0.015";
$PROFAR{6.1}="0.038";
$PROFAR{6.2}="0.036";
$PROFAR{6.3}="0.04";
$PROFAR{6.4}="0.08";
$PROFAR{6.5}="0.0064";
$PROFAR{6.6}="1.36";
$PROFAR{6.7}="0.0049";
$PROFAR{6.8}="0.02";
$PROFAR{6.9}="0.02";
$PROFAR{6.101}="0.064";
$PROFAR{6.11}="0.0044";
$PROFAR{6.12}="0.043";
$PROFAR{6.13}="0.00034";
$PROFAR{6.14}="0.00017";
$PROFAR{6.15}="0.00023";
$PROFAR{6.16}="0.00017";
$PROFAR{6.17}="0.023";
$PROFAR{6.18}="0";
$PROFAR{7.1}="0.035";
$PROFAR{7.2}="0.026";
$PROFAR{7.3}="0.066";
$PROFAR{7.4}="0.033";
$PROFAR{7.5}="0.056";
$PROFAR{7.6}="0.00036";
$PROFAR{7.14}="0.0057";
$PROFAR{7.7}="0.00062";
$PROFAR{7.8}="0.011";
$PROFAR{7.9}="0.000034";
$PROFAR{7.101}="0.015";
$PROFAR{7.11}="0.013";
$PROFAR{7.12}="0.0017";
$PROFAR{7.13}="0.00038";
$PROFAR{8.1}="0.00086";
$PROFAR{8.2}="0.0049";
$PROFAR{8.3}="0.00061";
$PROFAR{8.4}="0.00065";
$PROFAR{8.5}="0.004";
$PROFAR{8.6}="0.000052";
$PROFAR{8.7}="0.000178";
$PROFAR{8.8}="0.0068";
$PROFAR{9.1}="0.0156";
$PROFAR{9.2}="0.000025";
$PROFAR{9.3}="0.013";
$PROFAR{9.4}="0.0018";
$PROFAR{10.1}="0.0044";
$PROFAR{10.2}="0";
$PROFAR{11.1}="0.00042";

$RESULT{1}="2.2	3.2	4.8	5.15	6.15	7.13	8.2";
$RESULT{2}="2.5	3.2	4.8	5.15	6.15	7.13	8.2";
$RESULT{3}="2.2	3.3	4.11	5.17	6.15	7.13	8.2";
$RESULT{4}="2.2	3.2	4.5	5.17	6.15	7.13	8.2";
$RESULT{5}="2.5	3.2	4.5	5.17	6.15	7.13	8.2";
$RESULT{6}="2.2	3.3	4.5	5.17	6.15	7.13	8.2";
$RESULT{7}="2.2	3.2	4.8	5.17	6.15	7.13	8.2";
$RESULT{8}="2.5	3.2	4.8	5.17	6.15	7.13	8.2";
$RESULT{9}="2.1	3.1	4.1	5.1	6.1	7.3	8.2";
$RESULT{10}="2.3	3.1	4.1	5.1	6.1	7.3	8.2";
$RESULT{11}="2.3	3.4	4.1	5.1	6.1	7.3	8.2";
$RESULT{12}="2.5	3.4	4.1	5.1	6.1	7.3	8.2";
$RESULT{13}="2.1	3.1	4.2	5.1	6.1	7.3	8.2";
$RESULT{14}="2.3	3.1	4.2	5.1	6.1	7.3	8.2";
$RESULT{15}="2.3	3.4	4.13	5.11	6.1	7.3	8.2";
$RESULT{16}="2.5	3.4	4.13	5.11	6.1	7.3	8.2";
$RESULT{17}="2.3	3.6	4.13	5.11	6.1	7.3	8.2";
$RESULT{18}="2.4	3.6	4.13	5.11	6.1	7.3	8.2";
$RESULT{19}="2.1	3.1	4.1	5.2	6.1	7.3	8.2";
$RESULT{20}="2.3	3.1	4.1	5.2	6.1	7.3	8.2";
$RESULT{21}="2.3	3.4	4.1	5.2	6.1	7.3	8.2";
$RESULT{22}="2.5	3.4	4.1	5.2	6.1	7.3	8.2";
$RESULT{23}="2.3	3.4	4.13	5.2	6.1	7.3	8.2";
$RESULT{24}="2.5	3.4	4.13	5.2	6.1	7.3	8.2";
$RESULT{25}="2.3	3.6	4.13	5.2	6.1	7.3	8.2";
$RESULT{26}="2.4	3.6	4.13	5.2	6.1	7.3	8.2";
$RESULT{27}="2.1	3.1	4.4	5.2	6.1	7.3	8.2";
$RESULT{28}="2.3	3.1	4.4	5.2	6.1	7.3	8.2";
$RESULT{29}="2.1	3.5	4.4	5.2	6.1	7.3	8.2";
$RESULT{30}="2.4	3.5	4.4	5.2	6.1	7.3	8.2";
$RESULT{31}="2.3	3.6	4.4	5.2	6.1	7.3	8.2";
$RESULT{32}="2.4	3.6	4.4	5.2	6.1	7.3	8.2";
$RESULT{33}="2.1	3.1	4.2	5.5	6.1	7.3	8.2";
$RESULT{34}="2.3	3.1	4.2	5.5	6.1	7.3	8.2";
$RESULT{35}="2.1	3.1	4.4	5.5	6.1	7.3	8.2";
$RESULT{36}="2.3	3.1	4.4	5.5	6.1	7.3	8.2";
$RESULT{37}="2.1	3.5	4.4	5.5	6.1	7.3	8.2";
$RESULT{38}="2.4	3.5	4.4	5.5	6.1	7.3	8.2";
$RESULT{39}="2.3	3.6	4.4	5.5	6.1	7.3	8.2";
$RESULT{40}="2.4	3.6	4.4	5.5	6.1	7.3	8.2";
$RESULT{41}="2.1	3.5	4.9	5.5	6.1	7.3	8.2";
$RESULT{42}="2.4	3.5	4.9	5.5	6.1	7.3	8.2";
$RESULT{43}="2.1	3.1	4.2	5.12	6.12	7.3	8.2";
$RESULT{44}="2.3	3.1	4.2	5.12	6.12	7.3	8.2";
$RESULT{45}="2.1	3.1	4.6	5.12	6.12	7.3	8.2";
$RESULT{46}="2.3	3.1	4.6	5.12	6.12	7.3	8.2";
$RESULT{47}="2.1	3.1	4.2	5.5	6.12	7.3	8.2";
$RESULT{48}="2.3	3.1	4.2	5.5	6.12	7.3	8.2";
$RESULT{49}="2.1	3.1	4.4	5.5	6.12	7.3	8.2";
$RESULT{50}="2.3	3.1	4.4	5.5	6.12	7.3	8.2";
$RESULT{51}="2.1	3.5	4.4	5.5	6.12	7.3	8.2";
$RESULT{52}="2.4	3.5	4.4	5.5	6.12	7.3	8.2";
$RESULT{53}="2.3	3.6	4.4	5.5	6.12	7.3	8.2";
$RESULT{54}="2.4	3.6	4.4	5.5	6.12	7.3	8.2";
$RESULT{55}="2.1	3.5	4.9	5.5	6.12	7.3	8.2";
$RESULT{56}="2.4	3.5	4.9	5.5	6.12	7.3	8.2";
$RESULT{57}="2.3	3.6	4.12	5.9	6.12	7.3	8.2";
$RESULT{58}="2.4	3.6	4.12	5.9	6.12	7.3	8.2";
$RESULT{59}="2.1	3.1	4.4	5.9	6.12	7.3	8.2";
$RESULT{60}="2.3	3.1	4.4	5.9	6.12	7.3	8.2";
$RESULT{61}="2.1	3.5	4.4	5.9	6.12	7.3	8.2";
$RESULT{62}="2.4	3.5	4.4	5.9	6.12	7.3	8.2";
$RESULT{63}="2.3	3.6	4.4	5.9	6.12	7.3	8.2";
$RESULT{64}="2.4	3.6	4.4	5.9	6.12	7.3	8.2";
$RESULT{65}="2.1	3.1	4.6	5.9	6.12	7.3	8.2";
$RESULT{66}="2.3	3.1	4.6	5.9	6.12	7.3	8.2";
$RESULT{67}="2.3	3.6	4.12	5.14	6.4	7.3	8.2";
$RESULT{68}="2.4	3.6	4.12	5.14	6.4	7.3	8.2";
$RESULT{69}="2.3	3.4	4.13	5.14	6.4	7.3	8.2";
$RESULT{70}="2.5	3.4	4.13	5.14	6.4	7.3	8.2";
$RESULT{71}="2.3	3.6	4.13	5.14	6.4	7.3	8.2";
$RESULT{72}="2.4	3.6	4.13	5.14	6.4	7.3	8.2";
$RESULT{73}="2.1	3.1	4.1	5.2	6.4	7.3	8.2";
$RESULT{74}="2.3	3.1	4.1	5.2	6.4	7.3	8.2";
$RESULT{75}="2.3	3.4	4.1	5.2	6.4	7.3	8.2";
$RESULT{76}="2.5	3.4	4.1	5.2	6.4	7.3	8.2";
$RESULT{77}="2.3	3.4	4.13	5.2	6.4	7.3	8.2";
$RESULT{78}="2.5	3.4	4.13	5.2	6.4	7.3	8.2";
$RESULT{79}="2.3	3.6	4.13	5.2	6.4	7.3	8.2";
$RESULT{80}="2.4	3.6	4.13	5.2	6.4	7.3	8.2";
$RESULT{81}="2.1	3.1	4.4	5.2	6.4	7.3	8.2";
$RESULT{82}="2.3	3.1	4.4	5.2	6.4	7.3	8.2";
$RESULT{83}="2.1	3.5	4.4	5.2	6.4	7.3	8.2";
$RESULT{84}="2.4	3.5	4.4	5.2	6.4	7.3	8.2";
$RESULT{85}="2.3	3.6	4.4	5.2	6.4	7.3	8.2";
$RESULT{86}="2.4	3.6	4.4	5.2	6.4	7.3	8.2";
$RESULT{87}="2.1	3.1	4.1	5.7	6.4	7.3	8.2";
$RESULT{88}="2.3	3.1	4.1	5.7	6.4	7.3	8.2";
$RESULT{89}="2.3	3.4	4.1	5.7	6.4	7.3	8.2";
$RESULT{90}="2.5	3.4	4.1	5.7	6.4	7.3	8.2";
$RESULT{91}="2.1	3.1	4.6	5.7	6.4	7.3	8.2";
$RESULT{92}="2.3	3.1	4.6	5.7	6.4	7.3	8.2";
$RESULT{93}="2.3	3.6	4.12	5.9	6.4	7.3	8.2";
$RESULT{94}="2.4	3.6	4.12	5.9	6.4	7.3	8.2";
$RESULT{95}="2.1	3.1	4.4	5.9	6.4	7.3	8.2";
$RESULT{96}="2.3	3.1	4.4	5.9	6.4	7.3	8.2";
$RESULT{97}="2.1	3.5	4.4	5.9	6.4	7.3	8.2";
$RESULT{98}="2.4	3.5	4.4	5.9	6.4	7.3	8.2";
$RESULT{99}="2.3	3.6	4.4	5.9	6.4	7.3	8.2";
$RESULT{100}="2.4	3.6	4.4	5.9	6.4	7.3	8.2";
$RESULT{101}="2.1	3.1	4.6	5.9	6.4	7.3	8.2";
$RESULT{102}="2.3	3.1	4.6	5.9	6.4	7.3	8.2";
$RESULT{103}="2.1	3.1	4.1	5.1	6.6	7.3	8.2";
$RESULT{104}="2.3	3.1	4.1	5.1	6.6	7.3	8.2";
$RESULT{105}="2.3	3.4	4.1	5.1	6.6	7.3	8.2";
$RESULT{106}="2.5	3.4	4.1	5.1	6.6	7.3	8.2";
$RESULT{107}="2.1	3.1	4.2	5.1	6.6	7.3	8.2";
$RESULT{108}="2.3	3.1	4.2	5.1	6.6	7.3	8.2";
$RESULT{109}="2.1	3.1	4.2	5.12	6.6	7.3	8.2";
$RESULT{110}="2.3	3.1	4.2	5.12	6.6	7.3	8.2";
$RESULT{111}="2.1	3.1	4.6	5.12	6.6	7.3	8.2";
$RESULT{112}="2.3	3.1	4.6	5.12	6.6	7.3	8.2";
$RESULT{113}="2.1	3.1	4.1	5.7	6.6	7.3	8.2";
$RESULT{114}="2.3	3.1	4.1	5.7	6.6	7.3	8.2";
$RESULT{115}="2.3	3.4	4.1	5.7	6.6	7.3	8.2";
$RESULT{116}="2.5	3.4	4.1	5.7	6.6	7.3	8.2";
$RESULT{117}="2.1	3.1	4.6	5.7	6.6	7.3	8.2";
$RESULT{118}="2.3	3.1	4.6	5.7	6.6	7.3	8.2";
$RESULT{119}="2.1	3.1	4.1	5.13	6.13	7.6	8.2";
$RESULT{120}="2.3	3.1	4.1	5.13	6.13	7.6	8.2";
$RESULT{121}="2.3	3.4	4.1	5.13	6.13	7.6	8.2";
$RESULT{122}="2.5	3.4	4.1	5.13	6.13	7.6	8.2";
$RESULT{123}="2.2	3.3	4.101	5.13	6.13	7.6	8.2";
$RESULT{124}="2.2	3.2	4.5	5.13	6.13	7.6	8.2";
$RESULT{125}="2.5	3.2	4.5	5.13	6.13	7.6	8.2";
$RESULT{126}="2.2	3.3	4.5	5.13	6.13	7.6	8.2";
$RESULT{127}="2.1	3.1	4.1	5.7	6.13	7.6	8.2";
$RESULT{128}="2.3	3.1	4.1	5.7	6.13	7.6	8.2";
$RESULT{129}="2.3	3.4	4.1	5.7	6.13	7.6	8.2";
$RESULT{130}="2.5	3.4	4.1	5.7	6.13	7.6	8.2";
$RESULT{131}="2.1	3.1	4.6	5.7	6.13	7.6	8.2";
$RESULT{132}="2.3	3.1	4.6	5.7	6.13	7.6	8.2";
$RESULT{133}="2.1	3.1	4.1	5.1	6.16	7.6	8.2";
$RESULT{134}="2.3	3.1	4.1	5.1	6.16	7.6	8.2";
$RESULT{135}="2.3	3.4	4.1	5.1	6.16	7.6	8.2";
$RESULT{136}="2.5	3.4	4.1	5.1	6.16	7.6	8.2";
$RESULT{137}="2.1	3.1	4.2	5.1	6.16	7.6	8.2";
$RESULT{138}="2.3	3.1	4.2	5.1	6.16	7.6	8.2";
$RESULT{139}="2.1	3.1	4.1	5.13	6.16	7.6	8.2";
$RESULT{140}="2.3	3.1	4.1	5.13	6.16	7.6	8.2";
$RESULT{141}="2.3	3.4	4.1	5.13	6.16	7.6	8.2";
$RESULT{142}="2.5	3.4	4.1	5.13	6.16	7.6	8.2";
$RESULT{143}="2.2	3.3	4.101	5.13	6.16	7.6	8.2";
$RESULT{144}="2.2	3.2	4.5	5.13	6.16	7.6	8.2";
$RESULT{145}="2.5	3.2	4.5	5.13	6.16	7.6	8.2";
$RESULT{146}="2.2	3.3	4.5	5.13	6.16	7.6	8.2";
$RESULT{147}="2.2	3.3	4.11	5.17	6.16	7.6	8.2";
$RESULT{148}="2.2	3.2	4.5	5.17	6.16	7.6	8.2";
$RESULT{149}="2.5	3.2	4.5	5.17	6.16	7.6	8.2";
$RESULT{150}="2.2	3.3	4.5	5.17	6.16	7.6	8.2";
$RESULT{151}="2.2	3.2	4.8	5.17	6.16	7.6	8.2";
$RESULT{152}="2.5	3.2	4.8	5.17	6.16	7.6	8.2";
$RESULT{153}="2.1	3.1	4.1	5.1	6.6	7.6	8.2";
$RESULT{154}="2.3	3.1	4.1	5.1	6.6	7.6	8.2";
$RESULT{155}="2.3	3.4	4.1	5.1	6.6	7.6	8.2";
$RESULT{156}="2.5	3.4	4.1	5.1	6.6	7.6	8.2";
$RESULT{157}="2.1	3.1	4.2	5.1	6.6	7.6	8.2";
$RESULT{158}="2.3	3.1	4.2	5.1	6.6	7.6	8.2";
$RESULT{159}="2.1	3.1	4.2	5.12	6.6	7.6	8.2";
$RESULT{160}="2.3	3.1	4.2	5.12	6.6	7.6	8.2";
$RESULT{161}="2.1	3.1	4.6	5.12	6.6	7.6	8.2";
$RESULT{162}="2.3	3.1	4.6	5.12	6.6	7.6	8.2";
$RESULT{163}="2.1	3.1	4.1	5.7	6.6	7.6	8.2";
$RESULT{164}="2.3	3.1	4.1	5.7	6.6	7.6	8.2";
$RESULT{165}="2.3	3.4	4.1	5.7	6.6	7.6	8.2";
$RESULT{166}="2.5	3.4	4.1	5.7	6.6	7.6	8.2";
$RESULT{167}="2.1	3.1	4.6	5.7	6.6	7.6	8.2";
$RESULT{168}="2.3	3.1	4.6	5.7	6.6	7.6	8.2";
$RESULT{169}="2.1	3.1	4.1	5.13	6.13	7.7	8.2";
$RESULT{170}="2.3	3.1	4.1	5.13	6.13	7.7	8.2";
$RESULT{171}="2.3	3.4	4.1	5.13	6.13	7.7	8.2";
$RESULT{172}="2.5	3.4	4.1	5.13	6.13	7.7	8.2";
$RESULT{173}="2.2	3.3	4.101	5.13	6.13	7.7	8.2";
$RESULT{174}="2.2	3.2	4.5	5.13	6.13	7.7	8.2";
$RESULT{175}="2.5	3.2	4.5	5.13	6.13	7.7	8.2";
$RESULT{176}="2.2	3.3	4.5	5.13	6.13	7.7	8.2";
$RESULT{177}="2.1	3.1	4.1	5.7	6.13	7.7	8.2";
$RESULT{178}="2.3	3.1	4.1	5.7	6.13	7.7	8.2";
$RESULT{179}="2.3	3.4	4.1	5.7	6.13	7.7	8.2";
$RESULT{180}="2.5	3.4	4.1	5.7	6.13	7.7	8.2";
$RESULT{181}="2.1	3.1	4.6	5.7	6.13	7.7	8.2";
$RESULT{182}="2.3	3.1	4.6	5.7	6.13	7.7	8.2";
$RESULT{183}="2.1	3.1	4.1	5.13	6.14	7.7	8.2";
$RESULT{184}="2.3	3.1	4.1	5.13	6.14	7.7	8.2";
$RESULT{185}="2.3	3.4	4.1	5.13	6.14	7.7	8.2";
$RESULT{186}="2.5	3.4	4.1	5.13	6.14	7.7	8.2";
$RESULT{187}="2.2	3.3	4.101	5.13	6.14	7.7	8.2";
$RESULT{188}="2.2	3.2	4.5	5.13	6.14	7.7	8.2";
$RESULT{189}="2.5	3.2	4.5	5.13	6.14	7.7	8.2";
$RESULT{190}="2.2	3.3	4.5	5.13	6.14	7.7	8.2";
$RESULT{191}="2.1	3.1	4.1	5.2	6.14	7.7	8.2";
$RESULT{192}="2.3	3.1	4.1	5.2	6.14	7.7	8.2";
$RESULT{193}="2.3	3.4	4.1	5.2	6.14	7.7	8.2";
$RESULT{194}="2.5	3.4	4.1	5.2	6.14	7.7	8.2";
$RESULT{195}="2.3	3.4	4.13	5.2	6.14	7.7	8.2";
$RESULT{196}="2.5	3.4	4.13	5.2	6.14	7.7	8.2";
$RESULT{197}="2.3	3.6	4.13	5.2	6.14	7.7	8.2";
$RESULT{198}="2.4	3.6	4.13	5.2	6.14	7.7	8.2";
$RESULT{199}="2.1	3.1	4.4	5.2	6.14	7.7	8.2";
$RESULT{200}="2.3	3.1	4.4	5.2	6.14	7.7	8.2";
$RESULT{201}="2.1	3.5	4.4	5.2	6.14	7.7	8.2";
$RESULT{202}="2.4	3.5	4.4	5.2	6.14	7.7	8.2";
$RESULT{203}="2.3	3.6	4.4	5.2	6.14	7.7	8.2";
$RESULT{204}="2.4	3.6	4.4	5.2	6.14	7.7	8.2";
$RESULT{205}="2.3	3.6	4.12	5.14	6.4	7.7	8.2";
$RESULT{206}="2.4	3.6	4.12	5.14	6.4	7.7	8.2";
$RESULT{207}="2.3	3.4	4.13	5.14	6.4	7.7	8.2";
$RESULT{208}="2.5	3.4	4.13	5.14	6.4	7.7	8.2";
$RESULT{209}="2.3	3.6	4.13	5.14	6.4	7.7	8.2";
$RESULT{210}="2.4	3.6	4.13	5.14	6.4	7.7	8.2";
$RESULT{211}="2.1	3.1	4.1	5.2	6.4	7.7	8.2";
$RESULT{212}="2.3	3.1	4.1	5.2	6.4	7.7	8.2";
$RESULT{213}="2.3	3.4	4.1	5.2	6.4	7.7	8.2";
$RESULT{214}="2.5	3.4	4.1	5.2	6.4	7.7	8.2";
$RESULT{215}="2.3	3.4	4.13	5.2	6.4	7.7	8.2";
$RESULT{216}="2.5	3.4	4.13	5.2	6.4	7.7	8.2";
$RESULT{217}="2.3	3.6	4.13	5.2	6.4	7.7	8.2";
$RESULT{218}="2.4	3.6	4.13	5.2	6.4	7.7	8.2";
$RESULT{219}="2.1	3.1	4.4	5.2	6.4	7.7	8.2";
$RESULT{220}="2.3	3.1	4.4	5.2	6.4	7.7	8.2";
$RESULT{221}="2.1	3.5	4.4	5.2	6.4	7.7	8.2";
$RESULT{222}="2.4	3.5	4.4	5.2	6.4	7.7	8.2";
$RESULT{223}="2.3	3.6	4.4	5.2	6.4	7.7	8.2";
$RESULT{224}="2.4	3.6	4.4	5.2	6.4	7.7	8.2";
$RESULT{225}="2.1	3.1	4.1	5.7	6.4	7.7	8.2";
$RESULT{226}="2.3	3.1	4.1	5.7	6.4	7.7	8.2";
$RESULT{227}="2.3	3.4	4.1	5.7	6.4	7.7	8.2";
$RESULT{228}="2.5	3.4	4.1	5.7	6.4	7.7	8.2";
$RESULT{229}="2.1	3.1	4.6	5.7	6.4	7.7	8.2";
$RESULT{230}="2.3	3.1	4.6	5.7	6.4	7.7	8.2";
$RESULT{231}="2.3	3.6	4.12	5.9	6.4	7.7	8.2";
$RESULT{232}="2.4	3.6	4.12	5.9	6.4	7.7	8.2";
$RESULT{233}="2.1	3.1	4.4	5.9	6.4	7.7	8.2";
$RESULT{234}="2.3	3.1	4.4	5.9	6.4	7.7	8.2";
$RESULT{235}="2.1	3.5	4.4	5.9	6.4	7.7	8.2";
$RESULT{236}="2.4	3.5	4.4	5.9	6.4	7.7	8.2";
$RESULT{237}="2.3	3.6	4.4	5.9	6.4	7.7	8.2";
$RESULT{238}="2.4	3.6	4.4	5.9	6.4	7.7	8.2";
$RESULT{239}="2.1	3.1	4.6	5.9	6.4	7.7	8.2";
$RESULT{240}="2.3	3.1	4.6	5.9	6.4	7.7	8.2";
$RESULT{241}="2.1	3.1	4.1	5.1	6.1	7.9	8.2";
$RESULT{242}="2.3	3.1	4.1	5.1	6.1	7.9	8.2";
$RESULT{243}="2.3	3.4	4.1	5.1	6.1	7.9	8.2";
$RESULT{244}="2.5	3.4	4.1	5.1	6.1	7.9	8.2";
$RESULT{245}="2.1	3.1	4.2	5.1	6.1	7.9	8.2";
$RESULT{246}="2.3	3.1	4.2	5.1	6.1	7.9	8.2";
$RESULT{247}="2.3	3.4	4.13	5.11	6.1	7.9	8.2";
$RESULT{248}="2.5	3.4	4.13	5.11	6.1	7.9	8.2";
$RESULT{249}="2.3	3.6	4.13	5.11	6.1	7.9	8.2";
$RESULT{250}="2.4	3.6	4.13	5.11	6.1	7.9	8.2";
$RESULT{251}="2.1	3.1	4.1	5.2	6.1	7.9	8.2";
$RESULT{252}="2.3	3.1	4.1	5.2	6.1	7.9	8.2";
$RESULT{253}="2.3	3.4	4.1	5.2	6.1	7.9	8.2";
$RESULT{254}="2.5	3.4	4.1	5.2	6.1	7.9	8.2";
$RESULT{255}="2.3	3.4	4.13	5.2	6.1	7.9	8.2";
$RESULT{256}="2.5	3.4	4.13	5.2	6.1	7.9	8.2";
$RESULT{257}="2.3	3.6	4.13	5.2	6.1	7.9	8.2";
$RESULT{258}="2.4	3.6	4.13	5.2	6.1	7.9	8.2";
$RESULT{259}="2.1	3.1	4.4	5.2	6.1	7.9	8.2";
$RESULT{260}="2.3	3.1	4.4	5.2	6.1	7.9	8.2";
$RESULT{261}="2.1	3.5	4.4	5.2	6.1	7.9	8.2";
$RESULT{262}="2.4	3.5	4.4	5.2	6.1	7.9	8.2";
$RESULT{263}="2.3	3.6	4.4	5.2	6.1	7.9	8.2";
$RESULT{264}="2.4	3.6	4.4	5.2	6.1	7.9	8.2";
$RESULT{265}="2.1	3.1	4.2	5.5	6.1	7.9	8.2";
$RESULT{266}="2.3	3.1	4.2	5.5	6.1	7.9	8.2";
$RESULT{267}="2.1	3.1	4.4	5.5	6.1	7.9	8.2";
$RESULT{268}="2.3	3.1	4.4	5.5	6.1	7.9	8.2";
$RESULT{269}="2.1	3.5	4.4	5.5	6.1	7.9	8.2";
$RESULT{270}="2.4	3.5	4.4	5.5	6.1	7.9	8.2";
$RESULT{271}="2.3	3.6	4.4	5.5	6.1	7.9	8.2";
$RESULT{272}="2.4	3.6	4.4	5.5	6.1	7.9	8.2";
$RESULT{273}="2.1	3.5	4.9	5.5	6.1	7.9	8.2";
$RESULT{274}="2.4	3.5	4.9	5.5	6.1	7.9	8.2";
$RESULT{275}="2.1	3.1	4.1	5.13	6.14	7.9	8.2";
$RESULT{276}="2.3	3.1	4.1	5.13	6.14	7.9	8.2";
$RESULT{277}="2.3	3.4	4.1	5.13	6.14	7.9	8.2";
$RESULT{278}="2.5	3.4	4.1	5.13	6.14	7.9	8.2";
$RESULT{279}="2.2	3.3	4.101	5.13	6.14	7.9	8.2";
$RESULT{280}="2.2	3.2	4.5	5.13	6.14	7.9	8.2";
$RESULT{281}="2.5	3.2	4.5	5.13	6.14	7.9	8.2";
$RESULT{282}="2.2	3.3	4.5	5.13	6.14	7.9	8.2";
$RESULT{283}="2.1	3.1	4.1	5.2	6.14	7.9	8.2";
$RESULT{284}="2.3	3.1	4.1	5.2	6.14	7.9	8.2";
$RESULT{285}="2.3	3.4	4.1	5.2	6.14	7.9	8.2";
$RESULT{286}="2.5	3.4	4.1	5.2	6.14	7.9	8.2";
$RESULT{287}="2.3	3.4	4.13	5.2	6.14	7.9	8.2";
$RESULT{288}="2.5	3.4	4.13	5.2	6.14	7.9	8.2";
$RESULT{289}="2.3	3.6	4.13	5.2	6.14	7.9	8.2";
$RESULT{290}="2.4	3.6	4.13	5.2	6.14	7.9	8.2";
$RESULT{291}="2.1	3.1	4.4	5.2	6.14	7.9	8.2";
$RESULT{292}="2.3	3.1	4.4	5.2	6.14	7.9	8.2";
$RESULT{293}="2.1	3.5	4.4	5.2	6.14	7.9	8.2";
$RESULT{294}="2.4	3.5	4.4	5.2	6.14	7.9	8.2";
$RESULT{295}="2.3	3.6	4.4	5.2	6.14	7.9	8.2";
$RESULT{296}="2.4	3.6	4.4	5.2	6.14	7.9	8.2";
$RESULT{297}="2.2	3.2	4.8	5.15	6.15	7.9	8.2";
$RESULT{298}="2.5	3.2	4.8	5.15	6.15	7.9	8.2";
$RESULT{299}="2.2	3.3	4.11	5.17	6.15	7.9	8.2";
$RESULT{300}="2.2	3.2	4.5	5.17	6.15	7.9	8.2";
$RESULT{301}="2.5	3.2	4.5	5.17	6.15	7.9	8.2";
$RESULT{302}="2.2	3.3	4.5	5.17	6.15	7.9	8.2";
$RESULT{303}="2.2	3.2	4.8	5.17	6.15	7.9	8.2";
$RESULT{304}="2.5	3.2	4.8	5.17	6.15	7.9	8.2";
$RESULT{305}="2.1	3.1	4.1	5.1	6.16	7.9	8.2";
$RESULT{306}="2.3	3.1	4.1	5.1	6.16	7.9	8.2";
$RESULT{307}="2.3	3.4	4.1	5.1	6.16	7.9	8.2";
$RESULT{308}="2.5	3.4	4.1	5.1	6.16	7.9	8.2";
$RESULT{309}="2.1	3.1	4.2	5.1	6.16	7.9	8.2";
$RESULT{310}="2.3	3.1	4.2	5.1	6.16	7.9	8.2";
$RESULT{311}="2.1	3.1	4.1	5.13	6.16	7.9	8.2";
$RESULT{312}="2.3	3.1	4.1	5.13	6.16	7.9	8.2";
$RESULT{313}="2.3	3.4	4.1	5.13	6.16	7.9	8.2";
$RESULT{314}="2.5	3.4	4.1	5.13	6.16	7.9	8.2";
$RESULT{315}="2.2	3.3	4.101	5.13	6.16	7.9	8.2";
$RESULT{316}="2.2	3.2	4.5	5.13	6.16	7.9	8.2";
$RESULT{317}="2.5	3.2	4.5	5.13	6.16	7.9	8.2";
$RESULT{318}="2.2	3.3	4.5	5.13	6.16	7.9	8.2";
$RESULT{319}="2.2	3.3	4.11	5.17	6.16	7.9	8.2";
$RESULT{320}="2.2	3.2	4.5	5.17	6.16	7.9	8.2";
$RESULT{321}="2.5	3.2	4.5	5.17	6.16	7.9	8.2";
$RESULT{322}="2.2	3.3	4.5	5.17	6.16	7.9	8.2";
$RESULT{323}="2.2	3.2	4.8	5.17	6.16	7.9	8.2";
$RESULT{324}="2.5	3.2	4.8	5.17	6.16	7.9	8.2";
$RESULT{325}="2.1	3.1	4.1	5.13	6.14	7.101	8.5";
$RESULT{326}="2.3	3.1	4.1	5.13	6.14	7.101	8.5";
$RESULT{327}="2.3	3.4	4.1	5.13	6.14	7.101	8.5";
$RESULT{328}="2.5	3.4	4.1	5.13	6.14	7.101	8.5";
$RESULT{329}="2.2	3.3	4.101	5.13	6.14	7.101	8.5";
$RESULT{330}="2.2	3.2	4.5	5.13	6.14	7.101	8.5";
$RESULT{331}="2.5	3.2	4.5	5.13	6.14	7.101	8.5";
$RESULT{332}="2.2	3.3	4.5	5.13	6.14	7.101	8.5";
$RESULT{333}="2.1	3.1	4.1	5.2	6.14	7.101	8.5";
$RESULT{334}="2.3	3.1	4.1	5.2	6.14	7.101	8.5";
$RESULT{335}="2.3	3.4	4.1	5.2	6.14	7.101	8.5";
$RESULT{336}="2.5	3.4	4.1	5.2	6.14	7.101	8.5";
$RESULT{337}="2.3	3.4	4.13	5.2	6.14	7.101	8.5";
$RESULT{338}="2.5	3.4	4.13	5.2	6.14	7.101	8.5";
$RESULT{339}="2.3	3.6	4.13	5.2	6.14	7.101	8.5";
$RESULT{340}="2.4	3.6	4.13	5.2	6.14	7.101	8.5";
$RESULT{341}="2.1	3.1	4.4	5.2	6.14	7.101	8.5";
$RESULT{342}="2.3	3.1	4.4	5.2	6.14	7.101	8.5";
$RESULT{343}="2.1	3.5	4.4	5.2	6.14	7.101	8.5";
$RESULT{344}="2.4	3.5	4.4	5.2	6.14	7.101	8.5";
$RESULT{345}="2.3	3.6	4.4	5.2	6.14	7.101	8.5";
$RESULT{346}="2.4	3.6	4.4	5.2	6.14	7.101	8.5";
$RESULT{347}="2.1	3.1	4.1	5.2	6.18	7.101	8.5";
$RESULT{348}="2.3	3.1	4.1	5.2	6.18	7.101	8.5";
$RESULT{349}="2.3	3.4	4.1	5.2	6.18	7.101	8.5";
$RESULT{350}="2.5	3.4	4.1	5.2	6.18	7.101	8.5";
$RESULT{351}="2.3	3.4	4.13	5.2	6.18	7.101	8.5";
$RESULT{352}="2.5	3.4	4.13	5.2	6.18	7.101	8.5";
$RESULT{353}="2.3	3.6	4.13	5.2	6.18	7.101	8.5";
$RESULT{354}="2.4	3.6	4.13	5.2	6.18	7.101	8.5";
$RESULT{355}="2.1	3.1	4.4	5.2	6.18	7.101	8.5";
$RESULT{356}="2.3	3.1	4.4	5.2	6.18	7.101	8.5";
$RESULT{357}="2.1	3.5	4.4	5.2	6.18	7.101	8.5";
$RESULT{358}="2.4	3.5	4.4	5.2	6.18	7.101	8.5";
$RESULT{359}="2.3	3.6	4.4	5.2	6.18	7.101	8.5";
$RESULT{360}="2.4	3.6	4.4	5.2	6.18	7.101	8.5";
$RESULT{361}="2.1	3.1	4.1	5.1	6.16	7.14	8.5";
$RESULT{362}="2.3	3.1	4.1	5.1	6.16	7.14	8.5";
$RESULT{363}="2.3	3.4	4.1	5.1	6.16	7.14	8.5";
$RESULT{364}="2.5	3.4	4.1	5.1	6.16	7.14	8.5";
$RESULT{365}="2.1	3.1	4.2	5.1	6.16	7.14	8.5";
$RESULT{366}="2.3	3.1	4.2	5.1	6.16	7.14	8.5";
$RESULT{367}="2.1	3.1	4.1	5.13	6.16	7.14	8.5";
$RESULT{368}="2.3	3.1	4.1	5.13	6.16	7.14	8.5";
$RESULT{369}="2.3	3.4	4.1	5.13	6.16	7.14	8.5";
$RESULT{370}="2.5	3.4	4.1	5.13	6.16	7.14	8.5";
$RESULT{371}="2.2	3.3	4.101	5.13	6.16	7.14	8.5";
$RESULT{372}="2.2	3.2	4.5	5.13	6.16	7.14	8.5";
$RESULT{373}="2.5	3.2	4.5	5.13	6.16	7.14	8.5";
$RESULT{374}="2.2	3.3	4.5	5.13	6.16	7.14	8.5";
$RESULT{375}="2.2	3.3	4.11	5.17	6.16	7.14	8.5";
$RESULT{376}="2.2	3.2	4.5	5.17	6.16	7.14	8.5";
$RESULT{377}="2.5	3.2	4.5	5.17	6.16	7.14	8.5";
$RESULT{378}="2.2	3.3	4.5	5.17	6.16	7.14	8.5";
$RESULT{379}="2.2	3.2	4.8	5.17	6.16	7.14	8.5";
$RESULT{380}="2.5	3.2	4.8	5.17	6.16	7.14	8.5";
$RESULT{381}="2.1	3.1	4.1	5.1	6.1	7.9	8.5";
$RESULT{382}="2.3	3.1	4.1	5.1	6.1	7.9	8.5";
$RESULT{383}="2.3	3.4	4.1	5.1	6.1	7.9	8.5";
$RESULT{384}="2.5	3.4	4.1	5.1	6.1	7.9	8.5";
$RESULT{385}="2.1	3.1	4.2	5.1	6.1	7.9	8.5";
$RESULT{386}="2.3	3.1	4.2	5.1	6.1	7.9	8.5";
$RESULT{387}="2.3	3.4	4.13	5.11	6.1	7.9	8.5";
$RESULT{388}="2.5	3.4	4.13	5.11	6.1	7.9	8.5";
$RESULT{389}="2.3	3.6	4.13	5.11	6.1	7.9	8.5";
$RESULT{390}="2.4	3.6	4.13	5.11	6.1	7.9	8.5";
$RESULT{391}="2.1	3.1	4.1	5.2	6.1	7.9	8.5";
$RESULT{392}="2.3	3.1	4.1	5.2	6.1	7.9	8.5";
$RESULT{393}="2.3	3.4	4.1	5.2	6.1	7.9	8.5";
$RESULT{394}="2.5	3.4	4.1	5.2	6.1	7.9	8.5";
$RESULT{395}="2.3	3.4	4.13	5.2	6.1	7.9	8.5";
$RESULT{396}="2.5	3.4	4.13	5.2	6.1	7.9	8.5";
$RESULT{397}="2.3	3.6	4.13	5.2	6.1	7.9	8.5";
$RESULT{398}="2.4	3.6	4.13	5.2	6.1	7.9	8.5";
$RESULT{399}="2.1	3.1	4.4	5.2	6.1	7.9	8.5";
$RESULT{400}="2.3	3.1	4.4	5.2	6.1	7.9	8.5";
$RESULT{401}="2.1	3.5	4.4	5.2	6.1	7.9	8.5";
$RESULT{402}="2.4	3.5	4.4	5.2	6.1	7.9	8.5";
$RESULT{403}="2.3	3.6	4.4	5.2	6.1	7.9	8.5";
$RESULT{404}="2.4	3.6	4.4	5.2	6.1	7.9	8.5";
$RESULT{405}="2.1	3.1	4.2	5.5	6.1	7.9	8.5";
$RESULT{406}="2.3	3.1	4.2	5.5	6.1	7.9	8.5";
$RESULT{407}="2.1	3.1	4.4	5.5	6.1	7.9	8.5";
$RESULT{408}="2.3	3.1	4.4	5.5	6.1	7.9	8.5";
$RESULT{409}="2.1	3.5	4.4	5.5	6.1	7.9	8.5";
$RESULT{410}="2.4	3.5	4.4	5.5	6.1	7.9	8.5";
$RESULT{411}="2.3	3.6	4.4	5.5	6.1	7.9	8.5";
$RESULT{412}="2.4	3.6	4.4	5.5	6.1	7.9	8.5";
$RESULT{413}="2.1	3.5	4.9	5.5	6.1	7.9	8.5";
$RESULT{414}="2.4	3.5	4.9	5.5	6.1	7.9	8.5";
$RESULT{415}="2.1	3.1	4.1	5.13	6.14	7.9	8.5";
$RESULT{416}="2.3	3.1	4.1	5.13	6.14	7.9	8.5";
$RESULT{417}="2.3	3.4	4.1	5.13	6.14	7.9	8.5";
$RESULT{418}="2.5	3.4	4.1	5.13	6.14	7.9	8.5";
$RESULT{419}="2.2	3.3	4.101	5.13	6.14	7.9	8.5";
$RESULT{420}="2.2	3.2	4.5	5.13	6.14	7.9	8.5";
$RESULT{421}="2.5	3.2	4.5	5.13	6.14	7.9	8.5";
$RESULT{422}="2.2	3.3	4.5	5.13	6.14	7.9	8.5";
$RESULT{423}="2.1	3.1	4.1	5.2	6.14	7.9	8.5";
$RESULT{424}="2.3	3.1	4.1	5.2	6.14	7.9	8.5";
$RESULT{425}="2.3	3.4	4.1	5.2	6.14	7.9	8.5";
$RESULT{426}="2.5	3.4	4.1	5.2	6.14	7.9	8.5";
$RESULT{427}="2.3	3.4	4.13	5.2	6.14	7.9	8.5";
$RESULT{428}="2.5	3.4	4.13	5.2	6.14	7.9	8.5";
$RESULT{429}="2.3	3.6	4.13	5.2	6.14	7.9	8.5";
$RESULT{430}="2.4	3.6	4.13	5.2	6.14	7.9	8.5";
$RESULT{431}="2.1	3.1	4.4	5.2	6.14	7.9	8.5";
$RESULT{432}="2.3	3.1	4.4	5.2	6.14	7.9	8.5";
$RESULT{433}="2.1	3.5	4.4	5.2	6.14	7.9	8.5";
$RESULT{434}="2.4	3.5	4.4	5.2	6.14	7.9	8.5";
$RESULT{435}="2.3	3.6	4.4	5.2	6.14	7.9	8.5";
$RESULT{436}="2.4	3.6	4.4	5.2	6.14	7.9	8.5";
$RESULT{437}="2.2	3.2	4.8	5.15	6.15	7.9	8.5";
$RESULT{438}="2.5	3.2	4.8	5.15	6.15	7.9	8.5";
$RESULT{439}="2.2	3.3	4.11	5.17	6.15	7.9	8.5";
$RESULT{440}="2.2	3.2	4.5	5.17	6.15	7.9	8.5";
$RESULT{441}="2.5	3.2	4.5	5.17	6.15	7.9	8.5";
$RESULT{442}="2.2	3.3	4.5	5.17	6.15	7.9	8.5";
$RESULT{443}="2.2	3.2	4.8	5.17	6.15	7.9	8.5";
$RESULT{444}="2.5	3.2	4.8	5.17	6.15	7.9	8.5";
$RESULT{445}="2.1	3.1	4.1	5.1	6.16	7.9	8.5";
$RESULT{446}="2.3	3.1	4.1	5.1	6.16	7.9	8.5";
$RESULT{447}="2.3	3.4	4.1	5.1	6.16	7.9	8.5";
$RESULT{448}="2.5	3.4	4.1	5.1	6.16	7.9	8.5";
$RESULT{449}="2.1	3.1	4.2	5.1	6.16	7.9	8.5";
$RESULT{450}="2.3	3.1	4.2	5.1	6.16	7.9	8.5";
$RESULT{451}="2.1	3.1	4.1	5.13	6.16	7.9	8.5";
$RESULT{452}="2.3	3.1	4.1	5.13	6.16	7.9	8.5";
$RESULT{453}="2.3	3.4	4.1	5.13	6.16	7.9	8.5";
$RESULT{454}="2.5	3.4	4.1	5.13	6.16	7.9	8.5";
$RESULT{455}="2.2	3.3	4.101	5.13	6.16	7.9	8.5";
$RESULT{456}="2.2	3.2	4.5	5.13	6.16	7.9	8.5";
$RESULT{457}="2.5	3.2	4.5	5.13	6.16	7.9	8.5";
$RESULT{458}="2.2	3.3	4.5	5.13	6.16	7.9	8.5";
$RESULT{459}="2.2	3.3	4.11	5.17	6.16	7.9	8.5";
$RESULT{460}="2.2	3.2	4.5	5.17	6.16	7.9	8.5";
$RESULT{461}="2.5	3.2	4.5	5.17	6.16	7.9	8.5";
$RESULT{462}="2.2	3.3	4.5	5.17	6.16	7.9	8.5";
$RESULT{463}="2.2	3.2	4.8	5.17	6.16	7.9	8.5";
$RESULT{464}="2.5	3.2	4.8	5.17	6.16	7.9	8.5";
$RESULT{465}="2.1	3.1	4.1	5.1	6.16	7.14	8.8";
$RESULT{466}="2.3	3.1	4.1	5.1	6.16	7.14	8.8";
$RESULT{467}="2.3	3.4	4.1	5.1	6.16	7.14	8.8";
$RESULT{468}="2.5	3.4	4.1	5.1	6.16	7.14	8.8";
$RESULT{469}="2.1	3.1	4.2	5.1	6.16	7.14	8.8";
$RESULT{470}="2.3	3.1	4.2	5.1	6.16	7.14	8.8";
$RESULT{471}="2.1	3.1	4.1	5.13	6.16	7.14	8.8";
$RESULT{472}="2.3	3.1	4.1	5.13	6.16	7.14	8.8";
$RESULT{473}="2.3	3.4	4.1	5.13	6.16	7.14	8.8";
$RESULT{474}="2.5	3.4	4.1	5.13	6.16	7.14	8.8";
$RESULT{475}="2.2	3.3	4.101	5.13	6.16	7.14	8.8";
$RESULT{476}="2.2	3.2	4.5	5.13	6.16	7.14	8.8";
$RESULT{477}="2.5	3.2	4.5	5.13	6.16	7.14	8.8";
$RESULT{478}="2.2	3.3	4.5	5.13	6.16	7.14	8.8";
$RESULT{479}="2.2	3.3	4.11	5.17	6.16	7.14	8.8";
$RESULT{480}="2.2	3.2	4.5	5.17	6.16	7.14	8.8";
$RESULT{481}="2.5	3.2	4.5	5.17	6.16	7.14	8.8";
$RESULT{482}="2.2	3.3	4.5	5.17	6.16	7.14	8.8";
$RESULT{483}="2.2	3.2	4.8	5.17	6.16	7.14	8.8";
$RESULT{484}="2.5	3.2	4.8	5.17	6.16	7.14	8.8";
$RESULT{485}="2.1	3.1	4.1	5.13	6.13	7.6	8.8";
$RESULT{486}="2.3	3.1	4.1	5.13	6.13	7.6	8.8";
$RESULT{487}="2.3	3.4	4.1	5.13	6.13	7.6	8.8";
$RESULT{488}="2.5	3.4	4.1	5.13	6.13	7.6	8.8";
$RESULT{489}="2.2	3.3	4.101	5.13	6.13	7.6	8.8";
$RESULT{490}="2.2	3.2	4.5	5.13	6.13	7.6	8.8";
$RESULT{491}="2.5	3.2	4.5	5.13	6.13	7.6	8.8";
$RESULT{492}="2.2	3.3	4.5	5.13	6.13	7.6	8.8";
$RESULT{493}="2.1	3.1	4.1	5.7	6.13	7.6	8.8";
$RESULT{494}="2.3	3.1	4.1	5.7	6.13	7.6	8.8";
$RESULT{495}="2.3	3.4	4.1	5.7	6.13	7.6	8.8";
$RESULT{496}="2.5	3.4	4.1	5.7	6.13	7.6	8.8";
$RESULT{497}="2.1	3.1	4.6	5.7	6.13	7.6	8.8";
$RESULT{498}="2.3	3.1	4.6	5.7	6.13	7.6	8.8";
$RESULT{499}="2.1	3.1	4.1	5.1	6.16	7.6	8.8";
$RESULT{500}="2.3	3.1	4.1	5.1	6.16	7.6	8.8";
$RESULT{501}="2.3	3.4	4.1	5.1	6.16	7.6	8.8";
$RESULT{502}="2.5	3.4	4.1	5.1	6.16	7.6	8.8";
$RESULT{503}="2.1	3.1	4.2	5.1	6.16	7.6	8.8";
$RESULT{504}="2.3	3.1	4.2	5.1	6.16	7.6	8.8";
$RESULT{505}="2.1	3.1	4.1	5.13	6.16	7.6	8.8";
$RESULT{506}="2.3	3.1	4.1	5.13	6.16	7.6	8.8";
$RESULT{507}="2.3	3.4	4.1	5.13	6.16	7.6	8.8";
$RESULT{508}="2.5	3.4	4.1	5.13	6.16	7.6	8.8";
$RESULT{509}="2.2	3.3	4.101	5.13	6.16	7.6	8.8";
$RESULT{510}="2.2	3.2	4.5	5.13	6.16	7.6	8.8";
$RESULT{511}="2.5	3.2	4.5	5.13	6.16	7.6	8.8";
$RESULT{512}="2.2	3.3	4.5	5.13	6.16	7.6	8.8";
$RESULT{513}="2.2	3.3	4.11	5.17	6.16	7.6	8.8";
$RESULT{514}="2.2	3.2	4.5	5.17	6.16	7.6	8.8";
$RESULT{515}="2.5	3.2	4.5	5.17	6.16	7.6	8.8";
$RESULT{516}="2.2	3.3	4.5	5.17	6.16	7.6	8.8";
$RESULT{517}="2.2	3.2	4.8	5.17	6.16	7.6	8.8";
$RESULT{518}="2.5	3.2	4.8	5.17	6.16	7.6	8.8";
$RESULT{519}="2.1	3.1	4.1	5.1	6.6	7.6	8.8";
$RESULT{520}="2.3	3.1	4.1	5.1	6.6	7.6	8.8";
$RESULT{521}="2.3	3.4	4.1	5.1	6.6	7.6	8.8";
$RESULT{522}="2.5	3.4	4.1	5.1	6.6	7.6	8.8";
$RESULT{523}="2.1	3.1	4.2	5.1	6.6	7.6	8.8";
$RESULT{524}="2.3	3.1	4.2	5.1	6.6	7.6	8.8";
$RESULT{525}="2.1	3.1	4.2	5.12	6.6	7.6	8.8";
$RESULT{526}="2.3	3.1	4.2	5.12	6.6	7.6	8.8";
$RESULT{527}="2.1	3.1	4.6	5.12	6.6	7.6	8.8";
$RESULT{528}="2.3	3.1	4.6	5.12	6.6	7.6	8.8";
$RESULT{529}="2.1	3.1	4.1	5.7	6.6	7.6	8.8";
$RESULT{530}="2.3	3.1	4.1	5.7	6.6	7.6	8.8";
$RESULT{531}="2.3	3.4	4.1	5.7	6.6	7.6	8.8";
$RESULT{532}="2.5	3.4	4.1	5.7	6.6	7.6	8.8";
$RESULT{533}="2.1	3.1	4.6	5.7	6.6	7.6	8.8";
$RESULT{534}="2.3	3.1	4.6	5.7	6.6	7.6	8.8";
#	Mutated Residue										
#Variant	20	48	50	66	80	97	127	129	139	214	230
#PriA_Anc	1	1	1	1	1	1	1	1	1	1	1
#subHisA_Anc	0	0	0	0	0	0	0	0	0	0	0
#i	2.1	0	0	1	0	1	0	0	0	0	0	0
## Rutas contains information about which residue was mutated
### Manually constructed
$Rutas{2.1}="00101000000";$STARTS{2.1}="00101000000";
$Rutas{2.2}="10000010000";$STARTS{2.2}="10000010000";
$Rutas{2.3}="00100000100";$STARTS{2.3}="00100000100";
$Rutas{2.4}="01100000000";$STARTS{2.4}="01100000000";
$Rutas{2.5}="10100000000";$STARTS{2.5}="10100000000";
$Rutas{3.1}="00101000100";$STARTS{3.1}="00101000100";
$Rutas{3.2}="10100010000";$STARTS{3.2}="10100010000";
$Rutas{3.3}="10001010000";$STARTS{3.3}="10001010000";
$Rutas{3.4}="10100000100";$STARTS{3.4}="10100000100";
$Rutas{3.5}="01101000000";$STARTS{3.5}="01101000000";
$Rutas{3.6}="01100000100";$STARTS{3.6}="01100000100";
$Rutas{4.1}="10101000100";$STARTS{4.1}="10101000100";
$Rutas{4.2}="00101100100";$STARTS{4.2}="00101100100";
$Rutas{4.3}="00101000101";$STARTS{4.3}="00101000101";
$Rutas{4.4}="01101000100";$STARTS{4.4}="01101000100";
$Rutas{4.5}="10101010000";$STARTS{4.5}="10101010000";
$Rutas{4.6}="00101000110";$STARTS{4.6}="00101000110";
$Rutas{4.7}="00111000100";$STARTS{4.7}="00111000100";
$Rutas{4.8}="10100110000";$STARTS{4.8}="10100110000";
$Rutas{4.9}="01101100000";$STARTS{4.9}="01101100000";
$Rutas{4.101}="10001010100";$STARTS{4.101}="10001010100";
$Rutas{4.11}="10001110000";$STARTS{4.11}="10001110000";
$Rutas{4.12}="01100000110";$STARTS{4.12}="01100000110";
$Rutas{4.13}="11100000100";$STARTS{4.13}="11100000100";
$Rutas{5.1}="10101100100";$STARTS{5.1}="10101100100";
$Rutas{5.2}="11101000100";$STARTS{5.2}="11101000100";
$Rutas{5.3}="10101000101";$STARTS{5.3}="10101000101";
$Rutas{5.4}="01101000101";$STARTS{5.4}="01101000101";
$Rutas{5.5}="01101100100";$STARTS{5.5}="01101100100";
$Rutas{5.6}="00101100101";$STARTS{5.6}="00101100101";
$Rutas{5.7}="10101000110";$STARTS{5.7}="10101000110";
$Rutas{5.8}="00101000111";$STARTS{5.8}="00101000111";
$Rutas{5.9}="01101000110";$STARTS{5.9}="01101000110";
$Rutas{5.101}="10111000100";$STARTS{5.101}="10111000100";
$Rutas{5.11}="11100100100";$STARTS{5.11}="11100100100";
$Rutas{5.12}="00101100110";$STARTS{5.12}="00101100110";
$Rutas{5.13}="10101010100";$STARTS{5.13}="10101010100";
$Rutas{5.14}="11100000110";$STARTS{5.14}="11100000110";
$Rutas{5.15}="11100110000";$STARTS{5.15}="11100110000";
$Rutas{5.16}="00111000101";$STARTS{5.16}="00111000101";
$Rutas{5.17}="10101110000";$STARTS{5.17}="10101110000";
$Rutas{5.18}="11110000100";$STARTS{5.18}="11110000100";
$Rutas{6.1}="11101100100";$STARTS{6.1}="11101100100";
$Rutas{6.2}="11101000101";$STARTS{6.2}="11101000101";
$Rutas{6.3}="10111100100";$STARTS{6.3}="10111100100";
$Rutas{6.4}="11101000110";$STARTS{6.4}="11101000110";
$Rutas{6.5}="01101100101";$STARTS{6.5}="01101100101";
$Rutas{6.6}="10101100110";$STARTS{6.6}="10101100110";
$Rutas{6.7}="01101000111";$STARTS{6.7}="01101000111";
$Rutas{6.8}="10101000111";$STARTS{6.8}="10101000111";
$Rutas{6.9}="10101100101";$STARTS{6.9}="10101100101";
$Rutas{6.101}="11111000100";$STARTS{6.101}="11111000100";
$Rutas{6.11}="00101100111";$STARTS{6.11}="00101100111";
$Rutas{6.12}="01101100110";$STARTS{6.12}="01101100110";
$Rutas{6.13}="10101010110";$STARTS{6.13}="10101010110";
$Rutas{6.14}="11101010100";$STARTS{6.14}="11101010100";
$Rutas{6.15}="11101110000";$STARTS{6.15}="11101110000";
$Rutas{6.16}="10101110100";$STARTS{6.16}="10101110100";
$Rutas{6.17}="10111000101";$STARTS{6.17}="10111000101";
$Rutas{6.18}="11101001100";$STARTS{6.18}="11101001100";
$Rutas{7.1}="11101000111";$STARTS{7.1}="11101000111";
$Rutas{7.2}="11101100101";$STARTS{7.2}="11101100101";
$Rutas{7.3}="11101100110";$STARTS{7.3}="11101100110";
$Rutas{7.4}="10101100111";$STARTS{7.4}="10101100111";
$Rutas{7.5}="11111100100";$STARTS{7.5}="11111100100";
$Rutas{7.6}="10101110110";$STARTS{7.6}="10101110110";
$Rutas{7.14}="10101111100";$STARTS{7.14}="10101111100";
$Rutas{7.7}="11101010110";$STARTS{7.7}="11101010110";
$Rutas{7.8}="01101100111";$STARTS{7.8}="01101100111";
$Rutas{7.9}="11101110100";$STARTS{7.9}="11101110100";
$Rutas{7.101}="11101011100";$STARTS{7.101}="11101011100";
$Rutas{7.11}="10111100101";$STARTS{7.11}="10111100101";
$Rutas{7.12}="01111100101";$STARTS{7.12}="01111100101";
$Rutas{7.13}="11101110010";$STARTS{7.13}="11101110010";
$Rutas{8.1}="11101100111";$STARTS{8.1}="11101100111";
$Rutas{8.2}="11101110110";$STARTS{8.2}="11101110110";
$Rutas{8.3}="11111000111";$STARTS{8.3}="11111000111";
$Rutas{8.4}="11111100101";$STARTS{8.4}="11111100101";
$Rutas{8.5}="11101111100";$STARTS{8.5}="11101111100";
$Rutas{8.6}="11101011101";$STARTS{8.6}="11101011101";
$Rutas{8.7}="11101110011";$STARTS{8.7}="11101110011";
$Rutas{8.8}="10101111110";$STARTS{8.8}="10101111110";
$Rutas{9.1}="11111100111";$STARTS{9.1}="11111100111";
$Rutas{9.2}="11101110111";$STARTS{9.2}="11101110111";
$Rutas{9.3}="11101111110";$STARTS{9.3}="11101111110";
$Rutas{9.4}="11101011111";$STARTS{9.4}="11101011111";
$Rutas{10.1}="11101111111";$STARTS{10.1}="11101111111";
$Rutas{10.2}="11111110111";$STARTS{10.2}="11111110111";
$Rutas{11.1}="11111111111";$STARTS{11.1}="11111111111";

my $final="11.1";
my $sec="";
Ruta($final,$sec);  ## Triunfé en la recursión
## Descomentar ipara imprimir todas las posibles rutas
my $count=0;
sub Ruta{
	my $goal=shift; ## donde quiero llegar
	my $sec=shift; 
	$count++;
	foreach my $key(sort keys %STARTS){
	 ## Aui selecciono que rutas quiero
###	if ($PROFAR{$key}>=.004){
##	if ($PROFAR{$key}>=-1){
##        if ($PROFAR{$key}>=.004 and $PRA{$key}>=.0001){
#		print "$key->¡$STARTS{$key}!\n";
#		my $pause=<STDIN>;
		 my @sp=split("",$STARTS{$key});
	         my $size=scalar @sp;
		 for (my $i=0;$i<$size;$i++){
		    my @ruta_modificar=@sp;
		    my $mut=($sp[$i]+1)%2;
			#   print "$i: $sp[$i] -> $mut\n"; 
		    $ruta_modificar[$i]=$mut;
		    my $posible=join('',@ruta_modificar);
		    if (($key< (int $goal)) and $Rutas{$goal} eq $posible){
          		#print "->$key->$goal";
			#print "Count: $count \n";
			#print "key $key goal $goal\n";
			$sec.="\t$key";
			#$sec.=" $goal<-$key ";
			my $temp=$sec;
			#print "Temp $temp\n";
			#print "llamo ruta de $key, Sec $sec\n";
			#print "$sec\n";	
			if ($key < 3){
			#print $sec;
			print "$sec\n";# @RUTA\n";
				$count=0;
				#print"Fin de  ruta\n";
				#$sec="";
				}
			else {
				Ruta($key,$sec);
				}
			#$sec=~s/ $goal<-$key //;
			$sec=~s/\t$key//;
			


          		} ## end if 
    		    } ## end for
	###	} ## End if PROFAR
		} ## end for
	}## end sub
exit;
### ME falta buscar Darwinianas
foreach my $key (keys %RESULT){
my @sp=split(" ",$RESULT{$key});
	for (my $i=1;$i< scalar @sp;$i++){ 
 	print "key $key List $RESULT{$key} i $i sp: $sp[$i] profar $PROFAR{$sp[$i]} pra $PRA{$sp[$i]}\n";
	}
}
