class Array
  def comprehend(&block)
    return self if block.nil?
    self.collect(&block).compact
  end
end
module Jekyll
  module Paginate
    class Pagination < Generator
      def generate(site)
        if Pager.pagination_enabled?(site)
          template = template_page(site).comprehend { |x| paginate(site, x) }
        end
      end

      def self.first_page_url(site)
        if page = Pagination.new.template_page(site)
          page.url
        else
          nil
        end
      end

      def template_page(site)
        pages = site.pages.dup.select.select { |page| Pager.pagination_candidate?(site.config, page) }
        return pages
      end
    end
    class Pager
      attr_reader :page, :per_page, :posts, :total_posts, :total_pages,
        :previous_page, :previous_page_path, :next_page, :next_page_path

      # Static: Determine if a page is a possible candidate to be a template page.
      #         Page's name must be `index.html` and exist in any of the directories
      #         between the site source and `paginate_path`.
      #
      # config - the site configuration hash
      # page   - the Jekyll::Page about which we're inquiring
      #
      # Returns true if the
      def self.pagination_candidate?(config, page)
        page_dir = File.dirname(File.expand_path(remove_leading_slash(page.path), config['source']))
        paginate_config = config['paginate_config']
        paginate_config.any? { |x| self.same_page?(page, x, config['source'], page_dir)}
          
      end

      def self.same_page?(page, paginate_option, source, page_dir)
        cleaned_up_path = remove_leading_slash(paginate_option['paginate_path'])
        cleaned_up_path = File.expand_path(cleaned_up_path, source)
        page.name == paginate_option['file'] && in_hierarchy(source, page_dir, cleaned_up_path)
      end

      # Static: Return the pagination path of the page
      #
      # site     - the Jekyll::Site object
      # num_page - the pagination page number
      #
      # Returns the pagination path as a string
      def self.paginate_path(site, page, num_page)
        return nil if num_page.nil?
        return Pagination.first_page_url(site) if num_page <= 1
        format = site.config['paginate_config'].find { |x| page.name==x['file'] }
        format = format['paginate_path']
        format = format.sub(':num', num_page.to_s)
        ensure_leading_slash(format)
      end

      # Initialize a new Pager.
      #
      # site     - the Jekyll::Site object
      # page      - The Integer page number.
      # all_posts - The Array of all the site's Posts.
      # num_pages - The Integer number of pages or nil if you'd like the number
      #             of pages calculated.
      def initialize(site, page, all_posts, num_pages = nil)
        @page = page
        @per_page = site.config['paginate'].to_i
        @total_pages = num_pages || Pager.calculate_pages(all_posts, @per_page)

        if @page > @total_pages
          raise RuntimeError, "page number can't be greater than total pages: #{@page} > #{@total_pages}"
        end

        init = (@page - 1) * @per_page
        offset = (init + @per_page - 1) >= all_posts.size ? all_posts.size : (init + @per_page - 1)

        @total_posts = all_posts.size
        @posts = all_posts[init..offset]
        @previous_page = @page != 1 ? @page - 1 : nil
        @previous_page_path = Pager.paginate_path(site, page, @previous_page)
        @next_page = @page != @total_pages ? @page + 1 : nil
        @next_page_path = Pager.paginate_path(site, page, @next_page)
      end
    end
  end
end