open (FILE, "blast/listilla");
while (<FILE>){
chomp;
#@a=split(/\-/,$_);
system "cp /var/www/newevomining/blast/backup/$_\-gb /home/fbg/lalo/Pabloaln/";
#<STDIN>;
}
