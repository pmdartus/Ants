import os,sys
if(2==sys.argv.count):
	  mapname=sys.argv[0]
	  mapsize=sys.argv[1]
	  call = 'ants('+mapname+', '+mapsize+')'
else:
		call = 'ants'

for i in range(0,4):
	cmd = '(swipl -s main.pl -g "'+call+', halt." > games/log_'+`i`+'.txt )&'
	os.system(cmd)
