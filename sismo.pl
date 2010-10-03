#!/usr/bin/perl

$position_file = "/sys/devices/platform/hdaps/position";

@old = (0,0);
print "$old\n" ;

$oldtime = time();
$timecount = 0;

while (1) {
  sleep(0.01);
  open(FILE, "<$position_file") or die "Error";
  $new = <FILE>;
  if ($new =~ m/\((.*),(.*)\)/) {
    #print "$1\n";
    @new = ($1, $2);
  }
  $diff1 = $new[0] - $old[0];
  if ( abs($new[0]-$old[0]) > 1 && abs($new[1]-$old[1]) > 1) {
#    print localtime() . " $new";
    @old = @new;
    if ($oldtime==time()) {
      if ($timecount>=7) {
        #system("beep");
        print localtime()." TEMBLOR!\n";
      }
      $timecount++;
    } else {
      $timecount = 0;
      
    }
    $oldtime = time();
  }
  close(FILE);
}
