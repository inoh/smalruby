# -*- coding: utf-8 -*-

module Smalruby
  # お絵かきを表現するクラス
  class Canvas < Character
    def initialize(option = {})
      defaults = {
        x: 0,
        y: 0,
        width: Window.width,
        height: Window.height,
      }
      opt = process_optional_arguments(option, defaults)

      opt[:costume] = Image.new(opt[:width], opt[:height])
      super(opt.reject { |k, v| [:width, :height].include?(k) })
      image.set_color_key([0, 0, 0])
    end

    # @!group ペン

    def draw_font(option)
      defaults = {
        x: 0,
        y: 0,
        string: "",
        size: 32,
      }.merge(DEFAULT_COLOR_OPTION)
      opt = process_optional_arguments(option, defaults)

      image.draw_font(opt[:x], opt[:y], opt[:string], new_font(opt[:size]),
                      Color.smalruby_to_dxruby(opt[:color]))
    end

    def line(option)
      opt = process_rect_option(option)

      image.line(opt[:left], opt[:top], opt[:right], opt[:bottom],
                 Color.smalruby_to_dxruby(opt[:color]))
    end

    def box(option)
      opt = process_rect_option(option)

      image.box(opt[:left], opt[:top], opt[:right], opt[:bottom],
                Color.smalruby_to_dxruby(opt[:color]))
    end

    def box_fill(option)
      opt = process_rect_option(option)

      image.box_fill(opt[:left], opt[:top], opt[:right], opt[:bottom],
                     Color.smalruby_to_dxruby(opt[:color]))
    end

    def circle(option)
      opt = process_circle_option(option)

      image.circle(opt[:x], opt[:y], opt[:r],
                   Color.smalruby_to_dxruby(opt[:color]))
    end

    def circle_fill(option)
      opt = process_circle_option(option)

      image.circle_fill(opt[:x], opt[:y], opt[:r],
                        Color.smalruby_to_dxruby(opt[:color]))
    end

    def fill(option)
      opt = process_optional_arguments(option, DEFAULT_COLOR_OPTION)

      image.box_fill(0, 0, image.width, image.height,
                     Color.smalruby_to_dxruby(opt[:color]))
    end

    def_delegators :image, :clear

    # @!endgroup

    private

    DEFAULT_COLOR_OPTION = {
      color: 'white',
    }
    private_constant :DEFAULT_COLOR_OPTION

    DEFAULT_RECT_OPTION = {
      left: nil,
      top: nil,
      right: nil,
      bottom: nil,

      x1: nil,
      y1: nil,
      x2: nil,
      y2: nil,
    }
    private_constant :DEFAULT_RECT_OPTION

    def process_rect_option(option)
      defaults = DEFAULT_COLOR_OPTION.merge(DEFAULT_RECT_OPTION)
      opt = {
        left: option[:x1],
        top: option[:y1],
        right: option[:x2],
        bottom: option[:y2],
      }.merge(option)
      process_optional_arguments(opt, defaults)
    end

    def process_circle_option(option)
      defaults = {
        x: 5,
        y: 5,
        r: 5,
      }.merge(DEFAULT_COLOR_OPTION)
      process_optional_arguments(option, defaults)
    end
  end
end
