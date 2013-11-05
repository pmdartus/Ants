import os,sys

if(3==len(sys.argv)):
	  mapname=sys.argv[1]
	  mapsize=sys.argv[2]
	  call = "ants('"+mapname+"', "+mapsize+")"
else:
		call = "ants"

print call

for i in range(0,4):
	cmd = '(swipl -s main.pl -g "'+call+', halt." > games/log_'+`i`+'.txt)&'
	os.system(cmd)