require 'sinatra'
require 'sinatra/reloader'
require 'rss/2.0'
require 'open-uri'
require 'haml'

def get_feed (source)
  content = "" 
  open(source) {|s| content = s.read }
  rss = RSS::Parser.parse(content, false)
end

# feeds
get ('/') {redirect '/feed'}
get ('/:feed') do
  feed = ""
  case params[:feed]
  when "MentalHealth"
    feed = "http://jobs.guardian.co.uk/jobsrss/?Industry=191&Salary_Min=30000&Salary_Max=39999&CountryCode=GB"
  when "Nursing"
    feed = "http://jobs.guardian.co.uk/jobsrss/?Industry=192&Salary_Min=25000&Salary_Max=29999&CountryCode=GB"
  else "SexualHealth"
    feed = "http://jobs.guardian.co.uk/jobsrss/?Industry=195&CountryCode=GB"
  end

  @feed = get_feed(feed)
  
  haml :show

end

post ('/select') {redirect("/#{params[:feed]}")}
