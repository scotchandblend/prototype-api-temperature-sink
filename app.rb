require 'sinatra'
require 'json'

post '/temperature' do
  halt 401 unless authenticated?(params)

  if params['f'] == nil || params['f'].empty?
    halt 400
  end

  if params['ts'] == nil || params['ts'].empty?
    halt 400
  end

  temp_in_f = params['f']
  timestamp = params['ts']
  result = {
    value: temp_in_f,
    unit: 'f',
    timestamp: timestamp
  }

  request.body.rewind
  body = request.body.read
  puts "DEBUG Content-Length: #{request.content_length} - RequestBody: #{body}"

  puts JSON.generate(result)

end

def authenticated?(params)
  if params['secret'] == ENV['SECRET']
    return true
  else
    return false
  end
end
