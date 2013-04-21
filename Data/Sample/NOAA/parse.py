# Author : Jared Smith
# UserID : jaredsmithse
#this took the station_index file and simplified it to the three
#columns we needed : ID, State, County
f = open('station_index.txt','r')

for line in f:
	if len(line[62:82].strip()) == 0:
		continue
	print line[:6] + ', ' + line[59:61] + ', ' + line[62:82].replace('(CITY)','')