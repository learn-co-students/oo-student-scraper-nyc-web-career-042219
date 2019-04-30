require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    index.css("div.roster-cards-container").each_with_object([]) do |student_card, students_array|
      student_card.css(".student-card a").each do |stu|
        name = stu.css(".card-text-container h4.student-name").text
        location = stu.css(".card-text-container p.student-location").text
        link = "#{stu.attr('href')}"
        students_array << { :location => location, :name => name, :profile_url => link }
      end
    end
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    link_array = page.css(".social-icon-container").children.css("a").map { |link| link.attribute("href").text }
    link_array.each_with_object({}) do |link, hash|
      if link.include?('linkedin')
        hash[:linkedin] = link
      elsif link.include?('github')
        hash[:github] = link 
      elsif link.include?('twitter')
        hash[:twitter] = link 
      else
        hash[:blog] = link
      end
      hash[:profile_quote] = page.css(".profile-quote").text if page.css(".profile-quote")
      hash[:bio] = page.css("div.bio-content.content-holder div.description-holder p").text if page.css("div.bio-content.content-holder div.description-holder p")
    end
  end

end

