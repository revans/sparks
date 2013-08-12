
module Microsites
  class App < Sinatra::Base
    get "/" do
      "<div id='hello'>hello world</div>"
    end
  end
end
