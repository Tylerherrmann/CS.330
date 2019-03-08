# Check our passed arguments, throw error and end if incorrect number of arguments.
if ARGV.length != 2
	puts "Missing arguments to run this script, please try again. Arguments should be: wrap.rb textFile.txt [Integer]"
	exit
end

# Take in the passed breakpoint value, convert that to the regex necessary for later parsing.
numDigits = "." * (((ARGV[1]).to_i)-1)

# Format our text using Regex
output = File.read(ARGV[0]).gsub(/(?<=#{numDigits})\s/,"\n")
# Strip extra blank lines that get added as part of earlier formatting
puts output.gsub(/\n+|\r+/, "\n").squeeze("\n").strip