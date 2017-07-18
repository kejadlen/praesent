require "sinatra"

require_relative "praesent"

module Praesent
  class Web < Sinatra::Base
    enable :sessions

    get "/slide" do
      current_slide
    end

    private

    def current_slide
      i = current_index[0]
      j = current_index[1]
      settings.slides[i].transitions[j]
    end

    def current_index
      session[:index] ||= [0, 0]
    end
  end
end
