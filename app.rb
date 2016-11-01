require 'sinatra'
require 'json'

post '/temperature' do
  halt 401 unless authenticated?(params)

  temp_in_f = params['f']
  timestamp = params['ts']
  result = {
    value: temp_in_f,
    unit: 'f',
    timestamp: timestamp
  }

  puts JSON.generate(result)
end

def authenticated?(params)
  if params['secret'] == ENV['SECRET']
    return true
  else
    return false
  end
end
