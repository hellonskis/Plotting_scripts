load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  

;  f = addfile("cmass_C3GPas_out.nc","r")
;  f = addfile("cmass_FagSyl_out.nc","r")
;  f = addfile("cmass_PicAbi_out.nc","r")
;  f = addfile("cmass_PinSyl_out.nc","r")
;  f = addfile("cmass_QueRob_out.nc","r")
  f = addfile("cmass_PopTre_out.nc","r")

  npp_rcp45 = f->npp_rcp45
  npp_rcp85 = f->npp_rcp85
  cmass_rcp45 = f->cmass_rcp45
  cmass_rcp85 = f->cmass_rcp85
  
  NPP_avg_rcp45 = dim_avg_n(npp_rcp45, (/1,2/))
  NPP_avg_rcp85 = dim_avg_n(npp_rcp85, (/1,2/))
  CMASS_avg_rcp45 = dim_avg_n(cmass_rcp45, (/1,2/))
  CMASS_avg_rcp85 = dim_avg_n(cmass_rcp85, (/1,2/))

  data_npp = new((/2,dimsizes(NPP_avg_rcp45)/),float)
  data_cmass = new((/2,dimsizes(CMASS_avg_rcp45)/),float)
  
  data_npp(0,:) = NPP_avg_rcp45
  data_npp(1,:) = NPP_avg_rcp85
  data_cmass(0,:) = CMASS_avg_rcp45
  data_cmass(1,:) = CMASS_avg_rcp85  

  time                       = ispan(1971,2100,1)

  wks                        = gsn_open_wks("pdf","PopTre_CMASS_1971-2100_125")
  plot                       = new(2,graphic)
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

  plot(0)  = gsn_csm_xy(wks,time,data_npp,res)
  plot(1)  = gsn_csm_xy(wks,time,data_cmass,res)

  resp                                  = True
  resp@txString                         = "~Z125~Poplar - statewide average 1971-2100"

  resp@gsnPanelFigureStrings            = (/"NPP (kgC/m~S~2~N~)","CMASS (kgC/m~S~2~N~)"/)

  resp@gsnPanelFigureStringsFontHeightF = 0.017
  resp@amJust                           = "BottomRight"
;  resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True
  resp@gsnPaperOrientation              = "portrait"

  gsn_panel(wks,plot,(/1,1/),resp)

end


