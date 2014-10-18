class BitmapEditor
  COMMANDS = [{name: "I", params: [/\d+/, /\d+/], action: :create },
              {name: "C", params: [], action: :clear },
              {name: "L", params: [/\d+/, /\d+/, /\w/],
                          action: :color_pixel },
              {name: "V", params: [/\d+/, /\d+/, /\d+/, /\w/],
                          action: :draw_vertical_segment },
              {name: "H", params: [/\d+/, /\d+/, /\d+/, /\w/],
                          action: :draw_horizontal_segment },
              {name: "F", params: [/\d+/, /\d+/, /\w/],
                          action: :fill_region },
              {name: "S", params: [], action: :show },
              {name: "X", params: [], action: :terminate }]

  def initialize
  end

  def read_lines
    while line = STDIN.gets
      break if line == "X\n"
    end
  end

  def interpret_line(line)
    chars = line.gsub(/s+/m, ' ').strip.split(' ')
    COMMANDS.each do |command|
      if chars[0] == command[:name]
        if chars.count - 1 == command[:params].count
          command[:params].each_with_index do |param, i|
            return {status: :failed, msg: "Command #{command[:name]} doesn't match parameters type"} unless chars[i+1].match(param)
          end
          return { status: :success }
        else
          return {status: :failed, msg: "Command #{command[:name]} has #{command[:params].count} parameters"}
        end
      end
    end
    return { status: :failed, msg: "not recognized command" }
  end
end

#editor = BitmapEditor.new
#editor.read_lines
