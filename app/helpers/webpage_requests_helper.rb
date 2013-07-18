module WebpageRequestsHelper
  def display_html(raw_html)
    xsl_file = Rails.root.join("lib/templates/pretty_print.xsl")
    xslt = Nokogiri::XSLT(File.open(xsl_file))
    html = Nokogiri::HTML(raw_html)
    xsl = xslt.apply_to(html).to_s.encode!('UTF-8', 'UTF-8', :invalid => :replace)
    xsl.strip!
    formatted_html = CodeRay.scan(xsl, :html).div(:class=> :pre_scrollable, :tab_width => 4, :wrap => :div)
  end
end
