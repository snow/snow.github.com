# https://gist.github.com/731597
require 'logger'

module Jekyll
  module Filters
    def summarize(str, splitstr = /\s*<!-- more -->/)
      str.split(splitstr)[0]
    end
  end
end