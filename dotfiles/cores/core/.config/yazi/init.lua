local title1 = os.getenv("YAZI_FP_T1")
local title2 = os.getenv("YAZI_FP_T2")
local filePickerName = os.getenv("YAZI_FP_NAME")
local fileName = os.getenv("YAZI_FP_FILENAME")

if title1 == nil then
  title1 = ""
end

if title2 == nil then
  title2 = ""
end

if fileName == nil then
  fileName = ""
end

if filePickerName then
  Header:children_add(function()
    return ui.Line({
      ui.Span(" " .. title1 .. " "):bg("green"),
      ui.Span(" "),
      ui.Span(" " .. title2 .. " "):bg("red"),
      ui.Span(" "),
      ui.Span(" " .. filePickerName):bg("yellow"):bold(),
      ui.Span(" "),
      ui.Span(" " .. fileName .. " "):bg("magenta"):bold(),
    }):align(ui.Align.CENTER)
  end, 500, Header.RIGHT)
end
