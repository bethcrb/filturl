# This is the base application helper module. Methods added to this helper will
# be available to all views in the application.
module ApplicationHelper
  def display_base_errors(resource)
    return '' if (resource.errors.empty?) || (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def chartbeat_head
    return '' unless chartbeat_enabled?
    javascript_tag('var _sf_startpt=(new Date()).getTime()')
  end

  def chartbeat_body
    return '' unless chartbeat_enabled?
    javascript_tag do
      <<-CHARTBEAT_JS.html_safe
      var _sf_async_config = { uid: #{ENV['CHARTBEAT_UID']}, domain: '#{ENV['CHARTBEAT_DOMAIN']}', useCanonical: true };
      (function() {
        function loadChartbeat() {
          window._sf_endpt = (new Date()).getTime();
          var e = document.createElement('script');
          e.setAttribute('language', 'javascript');
          e.setAttribute('type', 'text/javascript');
          e.setAttribute('src','//static.chartbeat.com/js/chartbeat.js');
          document.body.appendChild(e);
        };
        var oldonload = window.onload;
        window.onload = (typeof window.onload != 'function') ?
          loadChartbeat : function() { oldonload(); loadChartbeat(); };
      })();
      CHARTBEAT_JS
    end
  end

  private

  def chartbeat_enabled?
    ENV['CHARTBEAT_UID'].present? && ENV['CHARTBEAT_DOMAIN'].present?
  end
end
