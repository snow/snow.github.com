module Jekyll
  class ArchivePage < Page
    def initialize(site, years_months_posts)
      @site = site
      @base = site.source
      @dir = ''
      @name = 'archive.html'

      self.process(@name)
      self.read_yaml(@base, 'archive.html')
      self.data['title'] = 'Archive'
      self.data['years_months_posts'] = years_months_posts
    end
  end
  
  class ArchivePageGenerator < Generator
    def generate(site)
      years_months_posts = {}
      
      for post in site.posts.reverse
        year = post.date.year
        month = Date::ABBR_MONTHNAMES[post.date.month]
      
        unless years_months_posts.has_key? year
          years_months_posts[year] = {}
        end
        
        unless years_months_posts[year].has_key? month
          years_months_posts[year][month] = []
        end
        
        years_months_posts[year][month] << post
      end
      
      site.pages << ArchivePage.new(site, years_months_posts)
    end
  end
end