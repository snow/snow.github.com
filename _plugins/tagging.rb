require 'jekyll/tagging'

module Jekyll
  module Filters
    def tag_cloud(site, base_url='')
      site['tag_data'].map { |tag, set|
        tag_link(tag, tag_url(tag, base_url), { :class => "set-#{set}" })
      }.join(' ')
    end
  
    def tag_url(tag, base_url='')
      "#{base_url}/#{Tagger::TAG_PAGE_DIR}/#{ERB::Util.u(tag)}#{'.html' unless PRETTY_URL}"
    end
  end
end