CALC_WIDTH = 160
BUTTON_WIDTH = CALC_WIDTH/2
WINDOW_MARGIN = 10
APP_WIDTH = CALC_WIDTH + WINDOW_MARGIN*2
APP_HEIGHT = CALC_WIDTH*1.6
LABEL_SIZE = 10

KG_TO_LB = 2.20462
KM_TO_MI = 0.620137
M_TO_FT = 3.28084

KG = "kg"
KM = "km"
M = "m"
LB = "lb"
MI = "mi"
FT = "ft"


def convert_to_imperial(figure, unit, decimal="0")
  return (figure.to_f*conversion_value(unit)).round(decimal.to_i)
end
  
def convert_to_metric(figure, unit, decimal="0")
  return (figure.to_f/conversion_value(unit)).round(decimal.to_i)
end

def convert_downwards(figure, unit)
  case unit
  when KM
    return figure*M_IN_KM
  when MI
    return figure*FT_IN_MI
  else
    puts '"{#unit}" cannot be converted downwards.'
    return 0
  end
end

def convert_upwards(figure, unit)
  case unit
  when M
    return figure/M_IN_KM
  when FT
    return figure/FT_IN_MI
  else
    puts 'Error: "{#unit}" cannot be converted upwards.'
    return 0
  end
end

def conversion_value(unit)
  case unit
  when KG, LB
    return KG_TO_LB
  when KM, MI
    return KM_TO_MI
  when M, FT
    return M_TO_FT
  else
    puts 'Error: "#{unit}" cannot be converted.'
    return 0
  end
end


Shoes.app :width => APP_WIDTH, :height => APP_HEIGHT do

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
  end
  
  flow(margin: WINDOW_MARGIN, margin_top: WINDOW_MARGIN/2) do
    stack do
      flow do
        @decimals = edit_line :width => BUTTON_WIDTH/2
        @decimals.text = "2"
        para "decimal points"
      end
      flow { check; para "copy to clipboard"}
    end
  end
  
  @kg_to_lb.click { @result.text = convert_to_imperial(@calc.text, KG, @decimals.text) }
  
end

=begin
      @result.text = convert_to_imperial(@calc.text, KG, @decimals)
=end
=begin
      return (figure.to_f*conversion_value(unit)).round(decimals.to_i)
=end


=begin
  flow(margin: WINDOW_MARGIN, margin_top: WINDOW_MARGIN/2) do
    para strong("Decimals: "), :align => "center", :size => LABEL_SIZE
    @decimals = edit_line :width => BUTTON_WIDTH/2, :right => 0
    @decimals.text = "2"
  end
=end


  
=begin
  stack(margin: 10) do
    flow do
      stack(margin: 5) do
        @kg_to_lb = button "kg > lb"
        @lb_to_kg = button "lb > kg"
      end
      stack(margin: 5) do
        @km_to_mi = button("km > mi").click do
          @calc_box.text = "clicked"
        @mi_to_km = button strong("mi > km")
      end
      stack(margin: 5) do
        @m_to_ft = button "m > ft",
                          :width => BUTTON_WIDTH
        @ft_to_m = button "ft > m",
                          :width => 80
      end
    end
  end
  end
=end



=begin
background: "#EDF4FC".."#D9E4F1"
=end



=begin


KG_TO_LB = 2.20462
KM_TO_MI = 0.620137
M_TO_FT = 3.28084

M_IN_KM = 1000
FT_IN_MI = 5280

KG = "kg"
KM = "km"
M = "m"
LB = "lb"
MI = "mi"
FT = "ft"


DECIMALS = 2


def convert_to_imperial(figure, unit)
  figure*conversion_value(unit)
end
  
def convert_to_metric(figure, unit)
  figure/conversion_value(unit)
end

def convert_downwards(figure, unit)
  case unit
  return figure*M_IN_KM when KM
  return figure*FT_IN_MI when MI
  else
    puts '"{#unit}" cannot be converted downwards.'
  end
end

def convert_upwards(figure, unit)
  case unit
  return figure/M_IN_KM when M
  return figure/FT_IN_MI when FT
  else
    puts 'Error: "{#unit}" cannot be converted upwards.'
  end
end

def conversion_value(unit)
  case unit
  return KG_TO_LB when KG, LB
  return KM_TO_MI when KM, MI
  return M_TO_FT when M, FT
  else
    puts 'Error: "#{unit}" cannot be converted.'
  end
end




begin
  nantoka = convert_to_imperial(40, "km")
rescue
  nantoka = 0
end
=end



=begin
[ 00000000000000000 ] << show rounded, and copy to clipboard

Metric > Imperial
KG > LB; KM > MI; M > FT

Imperial > Metric
LB > KG; MI > KM; FT > M

Parallel
M > KM; KM > M; FT > MI; MI > FT

The big = for calculate
=end





=begin
def conversion_value(unit, parallel=false)
  unless parallel
    case unit
    when "kg", "lb"
      return KG_TO_LB
    when "km", "mi"
      return KM_TO_MI
    when "m", "ft"
      return M_TO_FT
    else
      puts "Error: "#{unit}" not recognized."
      return 0
    end
  else
    case unit
    when "m", "km"
      return M_IN_KM
    when "ft", "mi"
      return FT_IN_MI
    when "kg", "lb"
      puts 'Error: "#{unit}" not convertible.'
      return 0
    else
      puts 'Error: "#{unit}" not recognized.'
      return 0
    end
  end
end
=end



=begin
def parallel_convert(amount, unit)
  case unit
  when "lb", "ft", "mi"
    return amount * get_parallel_conversion_value(unit)
  when "kg", "m", "km"
    return amount / get_parallel_conversion_value(unit)
  else
    puts "Error: Unit #{unit} not recognized."
    return 0
  end
end

def get_conversion_value (unit)
  case unit
  when "lb", "kg"
    return 2.20462
  when "ft", "m"
    return 3.28084
  when "mi", "km"
    return 0.620137
  else
    return 0
  end
end    
    
    
    

kg to pound
--- 1kg = 2.20462lb
--- KG * 2.20462, ROUND..2
--- LB / 2.20462, ROUND..2

m to ft
--- 1m = 3.28084ft
--- M * 3.28084, ROUND..2
--- FT / 3.28084, ROUND..2

km to miles

--- 1km = .6201371mi
--- KM * .620137, ROUND..2
--- MI / .620137, ROUND..2

=end