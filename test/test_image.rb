require_relative "../image"
require "test/unit"

class TestImage < Test::Unit::TestCase
  def test_create_fill
    i = Image.new
    i.create(1, 1)
    expected = { [0, 0]=>"O" }
                 
    assert_equal(expected, i.canvas)
  end

  def test_create_with_larger_than_max_size
    assert_equal("height must be between 1 and 250, width should be > 1", Image.new.create(251, 251))
  end

  def test_create_with_size_zero
    assert_equal("height must be between 1 and 250, width should be > 1", Image.new.create(42, 0))
  end

  def test_clear
    i = Image.new
    i.canvas = {[0,0] => "C",
                [0,1] => "C",
                [1,0] => "C",
                [1,1] => "C" }
    i.m = 2
    i.n = 2
    expected = {[0,0] => "O",
                [0,1] => "O",
                [1,0] => "O",
                [1,1] => "O" }
    i.clear
    assert_equal(expected, i.canvas)
  end

  def test_color_pixel_top_left
    i = Image.new
    i.create(3,3)
    i.color_pixel(1,1,"C")
    assert_equal("C", i.canvas[[0,0]])
  end

  def test_color_pixel_bottom_right
    i = Image.new
    i.create(3,3)
    i.color_pixel(3,3,"C")
    assert_equal("C", i.canvas[[2,2]])
  end

  def test_color_pixel_out_of_image
    i = Image.new
    i.create(3,3)
    assert_equal("invalid coordinates", i.color_pixel(0,0, "C"))
  end
end
