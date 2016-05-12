`perl -p -i -e 'if(/\<polygon/)\{s/title=\"/\>\n\<title\>/g;if(m{\/\>\$})\{s{\" \/\>}{\<\/title\>\<\/polygon\>};\}\}else\{if((!/^\t/) and m{\/\>})\{s{\" \/>}{<\/title><\/polygon>};\}\}' cont.svg`;

