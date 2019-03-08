# Check if the correct number of args are passed in
if ARGV.length != 1
	puts "Missing argument of a file containing imperial measurements."
	exit(0)
end

# Extract the filename, open and read the file
text = File.read(ARGV[0])

# Convert all of our units
text.gsub!(/(\d+\.?(\d*))\s(pounds|pound|lbs)/) {"%.#{$2.length}f kg" % ($1.to_i * 0.453592)}
text.gsub!(/(\d+\.?(\d*))\s(yards|yard|yd)/) {"%.#{$2.length}f m" % ($1.to_i * 0.9144)}
text.gsub!(/(\d+\.?(\d*))\s(miles|mile)/) {"%.#{$2.length}f km" % ($1.to_i * 1.60934)}
text.gsub!(/(\d+\.?(\d*))\s(mph)/) {"%.#{$2.length}f kph" % ($1.to_i * 1.60934)}
text.gsub!(/(\d+\.?(\d*))\s(inches|inch|in)/) {"%.#{$2.length}f cm" % ($1.to_i * 2.54)}

# Output to stdout
puts text
