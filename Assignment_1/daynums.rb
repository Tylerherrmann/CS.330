# Check if the correct number of args are passed in
if ARGV.length != 1 
	puts "Missing argument of .txt file, please try again."
	exit
end

# Read our file, pull out the numbers matching the regex, print it to stdout.
File.read(ARGV[0]).gsub!(/\D(3[0-1]|[1-2][0-9]|0?[1-9])\D/) {puts $1}