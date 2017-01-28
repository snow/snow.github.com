module Jekyll
  class ArchivePage < Page
    def initialize(site, years_months_posts)
      @site = site
      @base = site.source
      @dir = ''
      @name = 'archive.html'

      process(@name)
      read_yaml(@base, 'archive.html')
      data['title'] = 'Archive'
      data['years_months_posts'] = years_months_posts
    end
  end

  class ArchivePageGenerator < Generator
    def generate(site)
      years_months_posts = {}

      site.posts.docs.reverse.each do |post|
        year = post.date.year
        month = Date::ABBR_MONTHNAMES[post.date.month]

        years_months_posts[year] ||= {}
        years_months_posts[year][month] ||= []

        years_months_posts[year][month] << post
      end

      site.pages << ArchivePage.new(site, years_months_posts)
    end
  end
end
