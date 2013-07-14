module WebpageRequestsHelper
  def display_html(raw_html)
    xsl_file = Rails.root.join("lib/templates/pretty_print.xsl")
    xsl = Nokogiri::XSLT(File.open(xsl_file))
    html = Nokogiri::HTML(raw_html)
    xsl.apply_to(html).to_s.encode!('UTF-8', 'UTF-8', :invalid => :replace)
  end
end
