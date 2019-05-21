load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  

  f = addfile("lai.nc","r")

  LAI_SPRUCE_1025_50_control = f->laicontrol
  LAI_SPRUCE_1025_50_vers1 = f->laivers1
  LAI_SPRUCE_1025_50_vers4 = f->laivers4 
  LAI_SPRUCE_1025_50_vers5 = f->laivers5
  LAI_SPRUCE_1025_50_vers6 = f->laivers6
  LAI_SPRUCE_1025_50_vers7 = f->laivers7

  data_lai = new((/6,dimsizes(LAI_SPRUCE_1025_50_control)/),float)

  data_lai(0,:) = LAI_SPRUCE_1025_50_control
  data_lai(1,:) = LAI_SPRUCE_1025_50_vers1
  data_lai(2,:) = LAI_SPRUCE_1025_50_vers4
  data_lai(3,:) = LAI_SPRUCE_1025_50_vers5
  data_lai(4,:) = LAI_SPRUCE_1025_50_vers6
  data_lai(5,:) = LAI_SPRUCE_1025_50_vers7

;************************************************
; create plots
;************************************************
  
  time                    = ispan(1900,2100,1)

  wks                     = gsn_open_wks("pdf","PicAbi_LAI_1900-2100")
  plot                    = new(1,graphic)
  axislabelstyle          = "panel"

  res                     = True
; res@gsnPanelCenter      = True
; res@gsnPanelTop         = 1.0
  res@xyLineColors        = (/"gray","blue","orange","black","purple","green"/)
  res@lgItemOrder         = (/5,4,3,2,1,0/)   ; Reorder the legends 
  res@trYMinF             = -1.00
  res@trYMaxF             = 4.50 
  res@trXMinF             = 1924
  res@trXMaxF             = 2100
  res@xyDashPattern       = 0                     
  res@gsnDraw             = False
  res@gsnFrame            = False   
  res@gsnMaximize         = True

  res@pmLegendDisplayMode    = "Always"
  res@xyExplicitLegendLabels = (/"Control","ifdisturb 1","ifstochmort 0","iffire 0","ifstochmort 0 + iffire 0","ifstochmort 0 + iffire 0 + ifdisturb 1"/)
  res@lgPerimOn              = False      ; No legend perimeter
  res@pmLegendWidthF         = 0.47        ; Make legend skinnier  
  res@pmLegendHeightF        = 0.13        ; Make legend shorter
  res@pmLegendOrthogonalPosF = -0.315
  res@pmLegendParallelPosF   = 0.605

  plot(0)  = gsn_csm_xy(wks,time,data_lai,res)

  resp                                  = True
  resp@txString                         = "Spruce LAI at 10.25E,50N"

  resp@gsnPanelFigureStrings            = (/""/)  

  resp@gsnPanelFigureStringsFontHeightF = 0.017
  resp@amJust                           = "BottomRight"
;  resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True
  resp@gsnPaperOrientation              = "portrait"

  gsn_panel(wks,plot,(/1/),resp)
end


