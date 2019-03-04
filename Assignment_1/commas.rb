# Check if the correct number of args are passed in
if ARGV.length != 1
	puts "Missing argument of a number please try again."
	exit(0)
end

# Print out the formatted version of the number we are passed in.
puts ARGV[0].reverse.scan(/\d{3}|.+/).join(",").reverse

exit