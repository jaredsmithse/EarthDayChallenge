import os
import time

def generateMakefile():
	
	stateList = []
	
	f = open('StateList.txt', 'r')
	
	for line in f:
	  line = line.strip()
	  stateList.append(line)
	
	#print stateList
	
	
	allList = []
	for state in stateList:
		download = '"http://www.epa.gov/cgi-bin/broker?_service=data&_server=134.67.99.149&_port=4072&_sessionid=/ZB22rJo4v0&areaname="' + state + '"%20%20%20%20%20%20%20%20%20%20%20%20&sumlevel=groupbycounty&event=Excluded%20(if%20any)&year=2010&type=csv&_PROGRAM=dataprog.ad_rep_con_getdata.sas"'
		
		downloadCmd = 'wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3" -O ' + state + " "
		
		print state.translate(None, ' ') + ":"
		print "\t" + downloadCmd + download
		
		allList.append(state.translate(None, ' '));
	ret = ''
	for i in allList:
		ret += i + " "

	print 'all: \t ' + ret

if __name__ == '__main__':
	generateMakefile()