#require '_plugins/redcarpet_hypo'
require 'logger'

module Jekyll
  class MarkdownConverter
    
    def markdown
      @markdown ||= Redcarpet::Markdown.new(HTML_hypo, 
                                            :no_intra_emphasis => true,
                                            :tables => true,
                                            :fenced_code_blocks => true,
                                            :strikethrough => true)
    end
    protected :markdown
  
    def convert(content)
      markdown.render(content)
    end
    
  end
end