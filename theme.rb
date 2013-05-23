# -*- coding: utf-8 -*-
#
# Copyright (C) 2012  Kouhei Sutou <kou@clear-code.com>
#
# License: GPLv3+, GFDL and/or CC BY-SA 3.0
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

@clear_code_font_family ||= nil
@font_family =
  @clear_code_font_family ||
  find_font_family("MotoyaLMaru") ||
  @font_family

@title_slide_title_font_size = @x_large_font_size * 0.75

@slide_logo_image = "clear-code-headline-background.png"

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
    elsif slide.title_on_image? and slide["enable-title-on-image"] != "false"
      slide.headline.padding_top = @space
      slide.headline.padding_bottom = @space

      params = {}
      slide.title_on_image(params)
    end
  end
end

match(Slide, Body) do |bodies|
  bodies.each do |body|
    if body.elements.collect {|element| element.class} == [Paragraph]
      body.elements.each do |element|
        element.horizontal_centering = true
        if element.text.size < 50 or element.elements.any? {|e| e.is_a?(Note)}
          element.prop_set("size", @x_large_font_size)
        else
          element.prop_set("size", @large_font_size)
        end
        # element.as_large_as_possible("one-paragraph")
      end
    end
    body.margin_left *= 0.7
    body.margin_right *= 0.7
  end
end

match("**", CustomTag) do |tags|
  tags.each do |tag|
    case tag.name
    when "center"
      if tag.parent.parent.elements.any? {|element| element.is_a?(Image)}
        tag.parent.margin_bottom *= 10
      end
    end
  end
end
