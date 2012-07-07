#require 'lib/redcarpet'
require 'redcarpet.rb'
require 'logger'

class HTML_hypo < Redcarpet::Render::SmartyHTML
  
  def hrule
    '<!-- more -->'
  end
  
  def image(link, title='', alt_text='')
    
    unless alt_text && alt_text.strip.length then
      alt_text = "image at #{link}"
    end
    
    if title && title.strip.length
      <<-HTML
        <figure>
          <img src="#{link}" 
               alt="#{alt_text}" 
               title="#{title}" />
          <figcaption>#{title}</figcaption>
        </figure>
      HTML
    else
      <<-HTML
        <figure>
          <img src="#{link}" 
               alt="#{alt_text}" />
        </figure>
      HTML
    end
    
  end
  
end
