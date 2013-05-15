#!/usr/bin/awk -f
BEGIN{
  print "This is begin"
  }

$5 ~/MA/{
  print $1
  }

$5 ~/CHINA/{
  print "This is china"
  }

END{
  print "This is end"
  }
