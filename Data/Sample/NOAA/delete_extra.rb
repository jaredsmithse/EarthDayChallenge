# Author : Jared Smith
# UserID : jaredsmithse
# this will delete the extra data we don't need so there is 
# faster loading in R.
#STATE,COUNTY,DATE,DSNW,EMXP,MXSD,TPCP,TSNW,EMNT,EMXT,MMNT,MMXT,MNTM,TWND

file = File.open("version1.csv","r")

file.each do |line|
	row = line.split(',')
	newline = []
	newline << row[0..2]
	newline << row[6..7]
	newline << row[12]
	puts newline.join(',')
end

file.close
