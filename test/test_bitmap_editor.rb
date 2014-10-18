require_relative "../bitmap_editor"
require "test/unit"

class TestBitmapEditor < Test::Unit::TestCase
  def test_interpret_line_exiting_command
    assert_equal({:status => :success}, BitmapEditor.new.interpret_line("I 1 2"))
  end

  def test_interpret_line_non_exiting_command
    assert_equal({:status => :failed,
                  :msg => "not recognized command"}, BitmapEditor.new.interpret_line("W 1 2"))
  end

  def test_interpret_line_wrong_params_count
    assert_equal({:status => :failed,
                  :msg => "Command I has 2 parameters"}, BitmapEditor.new.interpret_line("I 1 2 2"))
  end

  def test_interpret_line_wrong_type_params
    assert_equal({:status => :failed,
                  :msg => "Command I doesn't match parameters type"}, BitmapEditor.new.interpret_line("I 1 S"))
  end
end
