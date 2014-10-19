class Image
  MAX_HEIGHT = 250
  def initialize
    @canvas = Hash.new
    @m = 0
    @n = 0
  end

  def create(width, height)
    return "height must be between 1 and #{MAX_HEIGHT}, width should be > 1" if width < 1 || ! height.between?(1,250)
    @m, @n = width, height
    self.clear
  end

  def clear
    for x in 0..n-1
      for y in 0..m-1
        @canvas[[x, y]] = 'O'
      end
    end
  end

  def color_pixel(x, y, color)
    return "invalid coordinates" unless x.between?(1, @m) && y.between?(1, @n)
    @canvas[[x-1, y-1]] = color
  end

  def draw_vertical_segment(column, row_start, row_end, color)
    return "invalid coordinates" unless row_start.between?(1, @n) &&
                                        row_end.between?(1, @n) &&
                                        row_end > row_start &&
                                        column.between?(1, @m)
    for i in row_start..row_end
      @canvas[[i-1, column-1]] = color
    end
  end

  def draw_horizontal_segment
  end

  def show
  end

  def canvas=(canvas)
    @canvas = canvas
  end

  def canvas
    @canvas
  end

  def m=(m)
    @m = m
  end

  def m
    @m
  end

  def n=(n)
    @n = n
  end

  def n
    @n
  end
end
