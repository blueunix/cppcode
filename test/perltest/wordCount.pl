#!/usr/bin/perl

if(! open FILEHADNLDE, 'word')
{
    die "Can not open word $!"
}
while(<FILEHADNLDE>)
{
    chomp;
    $word2Count{$_}++;
}

foreach my $word (sort keys %word2Count)
{
    print "$word 's count is $word2Count{$word}" ."\n";
    
}
