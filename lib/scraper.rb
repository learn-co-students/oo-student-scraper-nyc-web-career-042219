require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []

    html = File.read(index_url)
    index = Nokogiri::HTML(html)

    index.css("div.student-card").each do |s|
      name = s.css("div.card-text-container h4.student-name").text
      location = s.css("div.card-text-container p.student-location").text
      profile_url = s.css("a").attribute("href").text

      student_index_array << {name: name, location: location, profile_url: profile_url}
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {twitter:nil, linkedin:nil, github:nil, blog:nil, profile_quote:nil, bio:nil}

    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)

    links = profile.css("div.main-wrapper div.vitals-container div.social-icon-container a")
    link_list = []
    link_list = links.map do |l|
      l.attribute("href").text
    end

    link_list.each do |l|
      if l.include?("twitter")
        student_hash[:twitter] = l
      elsif l.include?("linkedin")
        student_hash[:linkedin] = l
      elsif l.include?("github")
        student_hash[:github] = l
      else
        student_hash[:blog] = l
      end
    end
    student_hash[:profile_quote] = profile.css("div.main-wrapper div.vitals-container div.vitals-text-container div.profile-quote").text
    student_hash[:bio]  = profile.css("div.main-wrapper div.details-container div.bio-block p").text


    student_hash.select { |attr| student_hash[attr] != nil}
  end

end
