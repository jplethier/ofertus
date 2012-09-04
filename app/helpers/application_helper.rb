module ApplicationHelper

  def unsorted_grouped_options_for_select(grouped_options, selected_key = nil, prompt = nil)
    body = ''
    body << content_tag(:option, prompt, { :value => "" }, true) if prompt

    #grouped_options = grouped_options.sort if grouped_options.is_a?(Hash)

    grouped_options.each do |group|
      body << content_tag(:optgroup, options_for_select(group[1], selected_key), :label => group[0])
    end

    body.html_safe
  end

  def title
    if not @title.nil?
      @title + " | OfertuS - Compartilhe Ofertas"
    else
      "OfertuS - Compartilhe Ofertas e ganhe com isso"
    end
  end

  def description
    if not @description.nil?
      @description
    else
      "Compartilhe, descubra, comente e opine sobre ofertas com seus amigos no OfertuS."
    end
  end

  def today?
    controller_name == 'deals' && action_name ==  'today'
  end

  # TODO: resolver via js
  # def link_to_active(*args, &block)
  #   if block_given?
  #     options = args.first || {}
  #     html_options = args.second
  #     link_to_active(capture(&block), options, html_options)
  #   else
  #     name = args[0]
  #     options = args[1] || {}
  #     html_options = args[2]
  #     link_to_unless_current(name, options, html_options) do
  #       link_to(name, options, html_options.try(:merge, :class => :active) || {:class => :active})
  #     end
  #   end
  # end

end
