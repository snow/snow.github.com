#require '_plugins/redcarpet_hypo'
# require 'logger'

class Jekyll::Converters::Markdown::CustomMarkdownProcessor
  def initialize config
    @config = config
    @markdown = Redcarpet::Markdown.new(CustomRender, 
                                        no_intra_emphasis: true,
                                        tables: true,
                                        fenced_code_blocks: true,
                                        strikethrough: true,
                                        autolink: true)
  end

  def convert content
    @markdown.render content
  end
end