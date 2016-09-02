require 'sinatra'

get '/' do
  return '<html><body><h1 class="title">Hello</h1></body></html>'
end

get '/click' do
  return '<html><body><a href="/">ClickMe</a></body></html>'
end

get '/fill_in' do
  return '<html><body><input name="input_box"></body></html>'
end

get '/alert' do
  return '<html><body><script>alert("hogehoge")</script></body></html>'
end

get '/select' do
  return '<html><body><select name="select_box"><option>an option</option></select></body></html>'
end

get '/search' do
  return '<html><body><table><tr><th>title</th><td>Hello</td></tr><table></body></html>'
end

