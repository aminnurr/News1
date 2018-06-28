require"nokogiri"
require'open-uri'

doc = Nokogiri::HTML(open('http://c.files.bbci.co.uk/2876/production/_102185301_p06c00c0.jpg'))
