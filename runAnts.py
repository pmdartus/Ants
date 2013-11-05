import os
MAPNAME=''
for i in range(0,10):
	cmd = 'swipl -s main.pl -g "ants'+MAPNAME+' , halt." > games/log_'+`i`+'.txt '
	os.system(cmd)
