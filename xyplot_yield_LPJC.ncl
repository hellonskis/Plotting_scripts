load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  

;  f = addfile("CC3ann_yield_out.nc","r")
;  f = addfile("CC3nfx_yield_out.nc","r")
;  f = addfile("CC4ann_yield_out.nc","r")
  f = addfile("BEC4G_yield_out.nc","r")

  yield_rcp45 = f->yield_rcp45
  yield_rcp85 = f->yield_rcp85
  
  YIELD_avg_rcp45 = dim_avg_n(yield_rcp45, (/1,2/))
  YIELD_avg_rcp85 = dim_avg_n(yield_rcp85, (/1,2/))

  data_yield = new((/2,dimsizes(YIELD_avg_rcp45)/),float)
  
  data_yield(0,:) = YIELD_avg_rcp45
  data_yield(1,:) = YIELD_avg_rcp85

  time                       = ispan(1971,2100,1)

  wks                        = gsn_open_wks("pdf","BEC4G_YIELD_1971-2100_125")
  plot                       = new(1,graphic)
  axislabelstyle             = "panel"

  res                        = True
; res@gsnPanelCenter         = True
; res@gsnPanelTop            = 1.0
;  res@trYMinF                = 8.7
;  res@trYMaxF                = 10.0
  res@xyLineColors           = (/"purple","green"/)
  res@xyDashPattern          = 0.0
  res@pmLegendDisplayMode    = "Always"
  res@pmLegendParallelPosF   = 0.19                  ; move units right
  res@pmLegendOrthogonalPosF = -1.09                ; move units down
  res@pmLegendWidthF         = 0.22                ; Change width and
  res@pmLegendHeightF        = 0.08                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .014                 ; label font height
  res@xyExplicitLegendLabels = (/"rcp45","rcp85"/)         ; create explicit labels
  res@lgItemOrder            = (/0,1/)   ; Reorder the legends
  res@gsnDraw                = False
  res@gsnFrame               = False
  res@gsnMaximize            = True

  plot(0)  = gsn_csm_xy(wks,time,data_yield,res)

  resp                                  = True
  resp@txString                         = "~Z125~BEC4G - statewide average yield (kg dry mass/m~S~2~N~)"

  resp@gsnPanelFigureStrings            = (/""/)

  resp@gsnPanelFigureStringsFontHeightF = 0.017
  resp@amJust                           = "BottomRight"
;  resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True
  resp@gsnPaperOrientation              = "portrait"

  gsn_panel(wks,plot,(/1/),resp)

end


