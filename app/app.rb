
module Microsites
  class App < Sinatra::Base
    get "/" do
      "<div id='hello'>hello world there</div>"
    end
  end
end
