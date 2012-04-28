ENV["REDISTOGO_URL"] ||= "redis://redistogo:dbfc9fbbae2b3a319bc56c54137f7220@gar.redistogo.com:9200//"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

Dir["/app/app/jobs/*.rb"].each { |file| require file }