# Author : Jared Smith
# UserID : jaredsmithse
# this will delete the extra data we don't need so there is 
# faster loading in R.

file = File.open("converted_sample.csv","r")

file.each do |line|
	row = line.split(',')
	row.delete_at 13
	row.delete_at 3
	puts row.join(',')
end

file.close
