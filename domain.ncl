import("yag_utils")
begin
  a = set_inputfile()
  wks = gsn_open_wks("png","domain")
  hgt = hgt_contour(a,wks,True)

  draw(wks)
  frame(wks)

end
