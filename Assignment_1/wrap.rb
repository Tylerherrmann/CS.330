# Check our passed arguments, throw error and end if incorrect number of arguments.
if ARGV.length != 2
	puts "Missing arguments to run this script, please try again. Arguments should be: wrap.rb textFile.txt [Integer]"
	exit
end

# Take in the passed breakpoint value, convert that to the regex necessary for later parsing.
numDigits = "." * (((ARGV[1]).to_i)-1)
# Output our new content with the new formatting in place.
puts File.read(ARGV[0]).gsub(/(?<=#{numDigits})\s/,"\n")