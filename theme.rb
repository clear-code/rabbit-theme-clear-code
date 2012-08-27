# -*- coding: utf-8 -*-

@font_family = find_font_family("MotoyaLMaru") || @font_family

@title_slide_title_font_size = @x_large_font_size * 0.75

include_theme("newline-in-slides")

@slide_logo_image = "clear-code-headline-background.png"

@block_quote_image_background_alpha = 0.3

include_theme("clear-blue")

@icon_images = ["clear-code-icon.png"]
include_theme("icon")

@lightning_talk_proc_name = "lightning-clear-code"
@lightning_talk_as_large_as_possible = true
include_theme("lightning-talk-toolkit")

include_theme("title-on-image-toolkit")

match(Slide) do |slides|
  slides.each do |slide|
    if slide.lightning_talk? and
        slide.body.elements.collect {|element| element.class} != [Image]
      slide.lightning_talk
    elsif slide.title_on_image?
      params = {}
      # slide.title_on_image(params)
    end
  end
end

match(Slide, Body) do |bodies|
  bodies.each do |body|
    if body.elements.collect {|element| element.class} == [Paragraph]
      body.elements.each do |element|
        element.horizontal_centering = true
        if element.text.size > 50
          element.prop_set("size", @large_font_size)
        else
          element.prop_set("size", @x_large_font_size)
        end
        # element.as_large_as_possible("one-paragraph")
      end
    end
    body.margin_left *= 0.7
    body.margin_right *= 0.7
  end
end

match("**", BlockQuote) do |quotes|
  quotes.each do |quote|
    quote.each do |element|
      # element.align = :center
      element.prop_set("size", @small_font_size)
    end
  end
end

match("**", CustomTag) do |tags|
  tags.each do |tag|
    case tag.name
    when "center"
      tag.parent.horizontal_centering = true
      if tag.parent.parent.elements.any? {|element| element.is_a?(Image)}
        tag.parent.margin_bottom *= 10
      end
    when "right"
      tag.parent.align = "right"
    when "x-large"
      tag.parent.prop_set("size", @x_large_font_size)
    end
  end
end
