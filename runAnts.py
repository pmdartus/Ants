import os,sys
if(1==sys.argv.count):
    mapname=sys.argv[0]
else:
    mapname=''

for i in range(0,10):
	cmd = 'swipl -s main.pl -g "ants'+mapname+' , halt." > games/log_'+`i`+'.txt '
	os.system(cmd)
