# require libraries/modules here
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :doc, :name, :profile_url, :born_death_date, :age, :term_in_office, :party_affiliation, :elected_year
  
  def get_page
    
    @doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_Governors_of_Texas#Governors_of_Texas"))
    
  end 
  
   
    array_governors = []
    title = @doc.search(".wikitable")

      title[1].css("tr").each do |tr_list|
        scraped_governor = {}
        small_list = tr_list.search("small")
        scraped_governor[:name] = tr_list.css("td big").first.text
        scraped_governor[:age] = small_list[1].text.gsub(/[()]/, "")
        scraped_governor[:profile_url] = "https://en.wikipedia.org#{tr_list.css("td big b a").attribute("href").value}"
        scraped_governor[:born_death_date] = tr_list.css("td")[3].css("small").first.text  
        scraped_governor[:elected_year] = tr_list.css("td")[6].text
        scraped_governor[:term_in_office] = "#{tr_list.css("td")[4].children[0].text} - #{tr_list.css("td")[4].children[0].text.gsub(/[\n]/, '')}"
        scraped_governor[:party_affiliation] = tr_list.css("td")[5].text
        
        array_governors << scraped_governor 
    end
    array_governors
    binding.pry
  end 
end 


# def create_project_hash
#   html = File.read('fixtures/kickstarter.html')
#   kickstarter = Nokogiri::HTML(html)
 
#   projects = {}
 
#   kickstarter.css("li.project.grid_4").each do |project|
#     title = project.css("h2.bbcard_name strong a").text
#     projects[title.to_sym] = {
#       :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
#       :description => project.css("p.bbcard_blurb").text,
#       :location => project.css("ul.project-meta span.location-name").text,
#       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      
#     }
#   end
# binding.pry
#   # return the projects hash
#   projects
# end





















# # project title :project =   kickstarter.css("li.project grid_4")
#                   title = project.css("h2.bbcard_name a target").text
#                 title-image : project.css("div.project-thumbnail a img").attribute("src").value
                 
#                 location : project.css(a data-location span.location-name).text