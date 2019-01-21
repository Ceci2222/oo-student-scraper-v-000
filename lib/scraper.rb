require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open('./fixtures/student-site/index.html'))
   
    doc.css(".student-card").each do |student|
      s = {
        :name => student.css("h4").text, :location => student.css('p').text, :profile_url => student.css('a').attribute("href").value
        }
      students << s
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    
    student = {}
    profile.css('div.social-icon-container a').each do |link|
      
      if link.values.include?('twitter') 
        student[:twitter] = link 
        
      elsif link.include?('linkedin') 
        student[:linkedin] = link
      
       
      end
      student
      binding.pry
    end
    
    # student = {
    # :linkedin => profile.css('div.social-icon-container a')[1]['href'], :github => profile.css('div.social-icon-container a')[2]['href'], :blog => profile.css('div.social-icon-container a')[3]['href'], :twitter => profile.css('div.social-icon-container a')[0]['href'], :profile_quote => profile.css(".profile-quote").text, :bio => profile.css("p").text,
    # }

  end
end

