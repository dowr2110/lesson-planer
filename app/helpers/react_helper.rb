module ReactHelper
  def react_component(component_name, props = {}, html_options = {})
    html_options = html_options.with_indifferent_access
    html_options[:id] ||= component_name.parameterize

    tag.div '', **html_options, data: { react_component: component_name, react_props: props.to_json }
  end
end