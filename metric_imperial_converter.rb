CALC_WIDTH = 160
BUTTON_WIDTH = CALC_WIDTH/2
WINDOW_MARGIN = 10
APP_WIDTH = CALC_WIDTH + WINDOW_MARGIN*2
APP_HEIGHT = CALC_WIDTH*1.6
LABEL_SIZE = 10

KG_TO_LB = 2.20462
KM_TO_MI = 0.620137
M_TO_FT = 3.28084

:kg, :km, :m, ;lb, :miles, :ft


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
      flow do
        @autocopy = check
        para "auto copy result"
      end
    end
  end
  
  copy_to_clipboard = lambda { app.clipboard = @result.text.to_s }
  
  @kg_to_lb.click do
    @result.text = convert_to_imperial(@calc.text, KG, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  @lb_to_kg.click do
    @result.text = convert_to_metric(@calc.text, LB, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  
  @km_to_mi.click do
    @result.text = convert_to_imperial(@calc.text, KM, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  @mi_to_km.click do
    @result.text = convert_to_metric(@calc.text, MI, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  
  @m_to_ft.click do
    @result.text = convert_to_imperial(@calc.text, M, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  @ft_to_m.click do
    @result.text = convert_to_metric(@calc.text, FT, @decimals.text)
    copy_to_clipboard.call if @autocopy.checked?
  end
  
end