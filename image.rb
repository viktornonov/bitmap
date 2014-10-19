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
    return "invalid coordinates" unless x.between?(1, @m+1) && y.between?(1, @n+1)
    @canvas[[x-1, y-1]] = color
  end

  def draw_vertical_segment
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
