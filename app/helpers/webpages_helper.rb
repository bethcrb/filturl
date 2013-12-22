# This helper module includes methods common to the Webpages views.
module WebpagesHelper
  def display_html(raw_html)
    xsl_file = Rails.root.join('lib/templates/pretty_print.xsl')
    xslt = Nokogiri.XSLT(File.open(xsl_file))
    html = Nokogiri.HTML(raw_html)
    xsl = xslt.apply_to(html).to_s.encode!('UTF-8', 'UTF-8', invalid: :replace)
    xsl.strip!
    CodeRay.scan(xsl, :html).div(
      tab_width: 4,
      wrap: :div
    )
  end
end
