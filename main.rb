require 'sinatra'
#require 'sinatra/reloader'
require 'rss/2.0'
require 'open-uri'
require 'haml'

def get_rss (source)
  content = "" 
  open(source) {|s| content = s.read }
  rss = RSS::Parser.parse(content, false)
end
def get_feed (feed_name)
  case feed_name
  when "MentalHealth"
    feed = "http://jobs.guardian.co.uk/jobsrss/?Industry=191&Salary_Min=30000&Salary_Max=39999&CountryCode=GB"
  when "Nursing"
    feed = "http://jobs.guardian.co.uk/jobsrss/?Industry=192&Salary_Min=25000&Salary_Max=29999&CountryCode=GB"
  else "SexualHealth"
    feed = "http://jobs.guardian.co.uk/jobsrss/?Industry=195&CountryCode=GB"
  end

end

# feeds
get ('/') {redirect '/sample/MentalHealth'}
get ('/style.css') { sass :style }
get ('/jobs/:feed') do
  feed = get_feed(params[:feed])
  @feed = get_rss(feed)  
  haml :show
end
post ('/jobs/select') {redirect("/jobs/#{params[:feed]}")}
get ('/sample') {redirect("/sample/Nursing")}
get ('/sample/:feed') do
  @feed = get_rss(get_feed(params[:feed]))
  haml :sample
end
post ('/sample/select') {redirect("/sample/#{params[:feed]}")}

