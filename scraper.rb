require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper

    # URL of Puppet's jobs page
    url = "https://puppet.com/company/careers/jobs/"

    # GET request page
    unparsed_page = HTTParty.get(url)

    # Parse HTML from GET response
    parsed_page = Nokogiri::HTML(unparsed_page.body)

    # Create boolean to store if intern is found in job titles
    intern = false

    # Find job posting titles with CSS selectors and iterate through them
    puts "\nCurrent Jobs:\n============="
    parsed_page.css('#gatsby-focus-wrapper > div > div.container.pm-padding-bottom--xl > div > div.pm-column.pm-column--base-span-12.pm-column--above-md-span-5.pm-column--above-md-offset-1 > div > div > ul > li > a > div').each do |job|

        # If job titles contain substring 'intern', change intern boolean to true
        if job.content.downcase.include? "intern"
            intern = true
            # Put job titles to console for human review, Intern Posistions are 'highlighted'
            puts "\n==> " + job.content + " <==\n "
        else
            puts job.content
        end

    end

    # Put results to command line
    intern ? (puts "==================================\nINTERN POSITION HAS BEEN POSTED!!!\n ") : (puts "====================\nNope, no Interns yet\n ")

end

scraper