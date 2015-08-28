class PageContent < ActiveRecord::Base
  require 'open-uri'

  validates :link, uniqueness: true

  class << self
    def import_database link, start_id, end_id
      diff = end_id - start_id + 1

      logger = Logger.new Rails.root + "log/import_page_content#{Time.now.to_s.gsub(' ', '_')}.log"

      if diff <= 0
        nokogiri = Nokogiri::HTML(open(link))
        content = nokogiri.css("p").text.squeeze.strip.gsub /\t|\r\n|\r|\n/, ""

        create content: content, link: link

        logger.info "Import from #{link}"
      else
        diff.times do |i|
          id = start_id + i
          _link = link + id.to_s
          begin
            case
            when link.include?("govap.hochiminhcity.gov.vn")
              import_govap_hochiminhcity _link, logger
            when link.include?("http://docbao.vn/")
              import_docbao _link, logger
            end
          rescue
          end
        end
      end
    end

    def import_govap_hochiminhcity _link, logger
      nokogiri = Nokogiri::HTML(open(_link))
      content = nokogiri.css("p").text.squeeze.strip.gsub /\t|\r\n|\r|\n/, ""

      create content: content, link: _link

      logger.info "Import from #{_link}"
    end

    def import_docbao _link, logger
      # 108414 => 314816
      nokogiri = Nokogiri::HTML(open(_link))
      return unless nokogiri.css(".news_top").text == ""
      content = nokogiri.css("#ContentPlaceHolder1_lblTitle").text.squeeze.strip.gsub(/\t|\r\n|\r|\n/, "") + nokogiri.css(".detail_content").text.squeeze.strip.gsub(/\t|\r\n|\r|\n/, "")

      create content: content, link: _link

      logger.info "Import from #{_link}"
    end
  end
end
