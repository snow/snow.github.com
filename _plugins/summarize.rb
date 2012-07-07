# https://gist.github.com/731597
require 'logger'

module Jekyll
  module Filters
    def summarize(str, full_url, base_url='', splitstr = /\s*<!-- more -->/)
      str.split(splitstr)[0] + %Q(<a class="hp-fullpost" href="#{base_url}#{full_url}">more</a>)
    end
  end
end