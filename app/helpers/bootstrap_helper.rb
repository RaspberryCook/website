module BootstrapHelper
  def glyphicon name
    "<span class=\"glyphicon glyphicon-#{name}\" aria-hidden=\"true\"></span>".html_safe
  end


  def alert type, content
    "<div class=\"col-xs-12 alert alert-#{type}\" role=\"alert\">#{content}</div>".html_safe
  end


  def bootstrap_label color, content
    "<span class=\"label label-#{color}\">#{content}</span>".html_safe
  end


  def tags tags
    return nil unless tags
    html = ""
    tags.split(';').each { |tag| html += "<span class=\"label label-info\">#{tag}</span>" }
    html.html_safe
  end
end
