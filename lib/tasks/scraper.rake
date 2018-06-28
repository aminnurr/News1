require 'rss'
require 'open-uri'
require 'nokogiri'
#require 'carrier-wave'

namespace :db do

  desc "rss_scraper"
   task :rss_scraper,[:url] => [:environment] do|t,args|
     url = args.url  # how to you pass arugments to tasks
  #  url = ('http://feeds.bbci.co.uk/news/world/africa/rss.xml')
     doc= Nokogiri::HTML(open(url))
      items = doc.xpath('//item')
       items.each  do |item|
         @title      = item.xpath('//title')
         @descrption = item.xpath('//descrption')
         @link       = item.xpath('//media')
         @pubDate    = item.xpath('//pubDate')
         @image_url       = item.xpath('//media')
        #db = SQLite3::Database.new "test.db"

        @image_url.each do |picture|
         picture = @image_url.attribute('url')
         @image  = Nokogiri::HTML(open("#{picture}"))
        data=  User.new(:title => @title , :description => @descrption , :link => @link , :pubDate => @pubDate , :image_url => @image_url, :image => @image )
        data.save
      end
end

desc " scrapping bbc for paragraph content"
 task bbc_scraper: :environment do [:rss_scraper]
  :link.each do |link|
    puts :link

     if /^https?:\/\/www\.voasomali/.match(link)
        page    = open("#{link}")
     content = page.xpath('//*[@id="article-content"]/div[1]/p')
     data = User.new(:content => content)
     data.save

   elsif
        /^https?:\/\/www\.aljazeera/.match(link)
          page    = open("#{link}")
         content = page.xpath('//*[@id=""body-200771816342556199""]/p')
         data = User.new(:content =>content)
         data.save


   else
     /^https?:\/\/www\.voasomali/.match(link)
      page = open (link)
      content = page.xpath('//*[@id=""article-content""]/div[1]/p')
      data = User.new(:content =>content)
      data.save

    end
  end
end


desc'removing data duplication'
task remove_data_duplication: :environment  do
  loop do
    duplicates = User.select("MAX(id) as id, ids in the table").group(:title,:description,:link,:pubDate,:image_url).having("count(*) > 1")
    break if duplicates.length == 0
    duplicates.destroy_all
  end
end
end

end
