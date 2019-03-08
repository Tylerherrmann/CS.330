# Check if the correct number of args are passed in
if ARGV.length != 1 
	puts "Missing argument of file containing links, please try again."
	exit
end

# Extract the filename, open and read the file
text = File.read(ARGV[0])

text.gsub!(/(http\S+ |http\S+'|http\S+$)/) {

require 'net/http'

url = $1
encoded_url = URI.encode(url)
uri = URI.parse(encoded_url)
request = Net::HTTP.new(uri.host, uri.port)
response = request.request_head(uri.path)

if response.code.to_i < 400
     print url + " :)\n"
else
     print url + " :(\n"
end
}