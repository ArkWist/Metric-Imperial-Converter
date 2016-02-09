=begin ===========================================
// Title:  SI-Calc v1.1
// Author: Daniel Lilley (github.com/ArkWist)
=end

CALC_WIDTH = 160
BUTTON_WIDTH = CALC_WIDTH/2
WINDOW_MARGIN = 10
APP_WIDTH = CALC_WIDTH + WINDOW_MARGIN*2
APP_HEIGHT = CALC_WIDTH*1.6
LABEL_SIZE = 10

KG_TO_LB = 2.20462
KM_TO_MI = 0.620137
M_TO_FT = 3.28084

def convert_to_imperial(figure, unit, decimal="0")
  return (figure.to_f*conversion_value(unit)).round(decimal.to_i)
end
def convert_to_metric(figure, unit, decimal="0")
  return (figure.to_f/conversion_value(unit)).round(decimal.to_i)
end

def convert_pace_to_imperial(time, unit)
  seconds = split_time(time)
  seconds = convert_to_imperial(seconds, unit)
  return join_time(seconds)
end
def convert_pace_to_metric(time, unit)
  seconds = split_time(time)
  seconds = convert_to_metric(seconds, unit)
  return join_time(seconds)
end

def convert_downwards(figure, unit)
  case unit
  when :km
    return figure*M_IN_KM
  when :miles
    return figure*FT_IN_MI
  else
    puts '"#{unit.to_s.capitalize!}" cannot be converted downwards.'
    return 0
  end
end
def convert_upwards(figure, unit)
  case unit
  when :m
    return figure/M_IN_KM
  when :ft
    return figure/FT_IN_MI
  else
    puts 'Error: "#{unit.to_s.capitalize!}" cannot be converted upwards.'
    return 0
  end
end

def conversion_value(unit)
  case unit
  when :kg, :lb
    return KG_TO_LB
  when :km, :miles
    return KM_TO_MI
  when :m, :ft
    return M_TO_FT
  else
    puts 'Error: "#{unit.to_s.capitalize!}" cannot be converted.'
    return 0
  end
end

def split_time(time)
  time = time.split(":").to_i.reverse!
  seconds = 0
  time.each_with_index do |value, i|
    if i > 2
      puts "Error: Too many units of time."
      return 0
    end
    seconds += value * 60**i
  end
  return seconds
end
def join_time(seconds)
  seconds.round!(0).to_i
  hours = seconds/3600
  seconds -= hours
  minutes = seconds/60
  seconds -= minutes
  return "#{time_pad(hours, true)}:#{time_pad(minutes)}:#{time_pad(seconds)}"
end
def time_pad(value, colon=false)
  if value >= 10
    time = value.to_s
  elsif value >= 1
    time = "0#{value.to_s}"
  else
    time = "00"
  end
  if colon { time += ":" }
  return time
end

Shoes.app :width => APP_WIDTH, :height => APP_HEIGHT, :title => "SI-Calc" do

  flow(margin: WINDOW_MARGIN, margin_bottom: 0) do
    stack width: BUTTON_WIDTH do
      para strong("Input:"), :size => LABEL_SIZE
    end
    stack width: BUTTON_WIDTH do
      para strong("Result:"), :size => LABEL_SIZE
    end
  end

  flow(margin: WINDOW_MARGIN, margin_top: 0, margin_bottom: WINDOW_MARGIN/2, width: APP_WIDTH) do
    @calc = edit_line :width => BUTTON_WIDTH
    @result = edit_line :width => BUTTON_WIDTH
  end

  flow(margin: WINDOW_MARGIN, margin_top: 0) do
    @kg_to_lb = button "kg > lb", :width => BUTTON_WIDTH
    @lb_to_kg = button "lb > kg", :width => BUTTON_WIDTH

    @km_to_mi = button "km > mi", :width => BUTTON_WIDTH
    @mi_to_km = button "mi > km", :width => BUTTON_WIDTH

    @m_to_ft = button "m > ft", :width => BUTTON_WIDTH
    @ft_to_m = button "ft > m", :width => BUTTON_WIDTH
    
    @pace_km_to_mi = button "t/ km > mi", :width => BUTTON_WIDTH
    @pace_mi_to_km = button "t/ mi > km", :width => BUTTON_WIDTH
  end
  
  flow(margin: WINDOW_MARGIN, margin_top: WINDOW_MARGIN/2) do
    stack do
      flow do
        @decimals = edit_line :width => BUTTON_WIDTH/2
        @decimals.text = "2"
        para "decimal points", :size => LABEL_SIZE+2
      end
      flow do
        @autocopy = check
        para "auto copy result", :size => LABEL_SIZE+2
      end
    end
  end
  
  copy_to_clipboard = lambda { app.clipboard = @result.text.to_s }
  
  @kg_to_lb.click do
    @result.text = convert_to_imperial(@calc.text, :kg, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  @lb_to_kg.click do
    @result.text = convert_to_metric(@calc.text, :lb, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  
  @km_to_mi.click do
    @result.text = convert_to_imperial(@calc.text, :km, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  @mi_to_km.click do
    @result.text = convert_to_metric(@calc.text, :miles, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  
  @m_to_ft.click do
    @result.text = convert_to_imperial(@calc.text, :m, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  @ft_to_m.click do
    @result.text = convert_to_metric(@calc.text, :ft, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  
  @pace_km_to_mi.click do
    @result.text = convert_pace_to_imperial(@calc.text, :km, @decimals.text)
    copy_to_clipboard call if @autocopy.checked?
  end
  @pace_mi_to_km.click do
    @result.text = convert_pace_to_metric(@calc.text, :miles, @decimals.text)
    copy_to_clipboard call if @autocopy.checked?
  end
  
end
