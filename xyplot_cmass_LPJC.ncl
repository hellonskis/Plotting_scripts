load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  

  f = addfile("cmass.nc","r")

  CMASS_SPRUCE_1025_50_control = f->cmasscontrol
  CMASS_SPRUCE_1025_50_vers1 = f->cmassvers1
  CMASS_SPRUCE_1025_50_vers4 = f->cmassvers4 
  CMASS_SPRUCE_1025_50_vers5 = f->cmassvers5
  CMASS_SPRUCE_1025_50_vers6 = f->cmassvers6
  CMASS_SPRUCE_1025_50_vers7 = f->cmassvers7
  CMASS_SPRUCE_1025_50_vers9 = f->cmassvers9

  data_cmass = new((/7,dimsizes(CMASS_SPRUCE_1025_50_control)/),float)

  data_cmass(0,:) = CMASS_SPRUCE_1025_50_control
  data_cmass(1,:) = CMASS_SPRUCE_1025_50_vers1
  data_cmass(2,:) = CMASS_SPRUCE_1025_50_vers4
  data_cmass(3,:) = CMASS_SPRUCE_1025_50_vers5
  data_cmass(4,:) = CMASS_SPRUCE_1025_50_vers6
  data_cmass(5,:) = CMASS_SPRUCE_1025_50_vers7
  data_cmass(6,:) = CMASS_SPRUCE_1025_50_vers9

;************************************************
; create plots
;************************************************
  
  time                    = ispan(1900,2100,1)

  wks                     = gsn_open_wks("pdf","PicAbi_CMASS_1900-2100")
  plot                    = new(1,graphic)
  axislabelstyle          = "panel"

  res                     = True
; res@gsnPanelCenter      = True
; res@gsnPanelTop         = 1.0
  res@xyLineColors        = (/"gray","blue","orange","black","purple","green","brown"/)
  res@lgItemOrder         = (/6,5,4,3,2,1,0/)   ; Reorder the legends 
  res@trYMinF             = -4.00
  res@trYMaxF             = 22.50 
  res@trXMinF             = 1924
  res@trXMaxF             = 2100
  res@xyDashPattern       = 0                     
  res@gsnDraw             = False
  res@gsnFrame            = False   
  res@gsnMaximize         = True

  res@pmLegendDisplayMode    = "Always"
  res@xyExplicitLegendLabels = (/"Control","ifdisturb 1","ifstochmort 0","iffire 0","ifstochmort 0 + iffire 0","ifstochmort 0 + iffire 0 + ifdisturb 1","iffire 0 + ifdisturb 1 + relaxed_establishment"/)
  res@lgPerimOn              = False      ; No legend perimeter
  res@pmLegendWidthF         = 0.44        ; Make legend skinnier  
  res@pmLegendHeightF        = 0.13        ; Make legend shorter
  res@pmLegendOrthogonalPosF = -0.315
  res@pmLegendParallelPosF   = 0.625

  plot(0)  = gsn_csm_xy(wks,time,data_cmass,res)

  resp                                  = True
  resp@txString                         = "Spruce CMASS at 10.25E,50N"

  resp@gsnPanelFigureStrings            = (/""/)  

  resp@gsnPanelFigureStringsFontHeightF = 0.017
  resp@amJust                           = "BottomRight"
; resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True
  resp@gsnPaperOrientation              = "portrait"

  gsn_panel(wks,plot,(/1/),resp)
  
end


