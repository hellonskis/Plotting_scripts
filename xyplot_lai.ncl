load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  

  f = addfile("lai_multiplePFTs.nc","r")
 
  C3GPas = f->C3GPas(:,:,:)
  FagSyl = f->FagSyl(:,:,:)
  PicAbi = f->PicAbi(:,:,:)
  PinSyl = f->PinSyl(:,:,:)

  AvgLAI_C3GPas = dim_avg_n(C3GPas, (/1,2/))
  AvgLAI_FagSyl = dim_avg_n(FagSyl, (/1,2/))
  AvgLAI_PicAbi = dim_avg_n(PicAbi, (/1,2/))
  AvgLAI_PinSyl = dim_avg_n(PinSyl, (/1,2/))

  dataseries_lai = new((/4,dimsizes(AvgLAI_C3GPas)/),float)   

  dataseries_lai(0,:) = AvgLAI_C3GPas
  dataseries_lai(1,:) = AvgLAI_FagSyl
  dataseries_lai(2,:) = AvgLAI_PicAbi
  dataseries_lai(3,:) = AvgLAI_PinSyl

;************************************************
; create plots
;************************************************
  
  time                    = ispan(1901,2100,1)

  wks                     = gsn_open_wks("pdf","LAI_1901-2100")
  plot                    = new(1,graphic)
  axislabelstyle          = "panel"

  res                        = True
; res@gsnPanelCenter         = True
; res@gsnPanelTop            = 1.0
  res@xyLineColors           = (/"blue","orange","green","purple"/)
; res@trYMinF                = 0.24
; res@trYMaxF                = 0.98
  res@trXMinF                = 1901
  res@trXMaxF                = 2100 
  res@gsnDraw                = False
  res@gsnFrame               = False   
  res@gsnMaximize            = True
  res@pmLegendDisplayMode    = "Always"
  res@xyExplicitLegendLabels = (/"C3GPas","FagSyl","PicAbi","PinSyl"/)
  res@lgPerimOn              = False      ; No legend perimeter
  res@pmLegendWidthF         = 0.2        ; Make legend skinnier  
  res@pmLegendHeightF        = 0.1        ; Make legend shorter
  res@pmLegendOrthogonalPosF = -1.08
  res@pmLegendParallelPosF   =  0.19  

;***************************************************************

  plot = gsn_csm_xy(wks,time,dataseries_lai,res)

  resp                                  = True
  resp@txString                         = "LAI"

; resp@gsnPanelFigureStrings            = (//)  

  resp@gsnPanelFigureStringsFontHeightF = 0.017
  resp@amJust                           = "BottomRight"
; resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True
  resp@gsnPaperOrientation              = "portrait"

  gsn_panel(wks,plot,(/2,2/),resp)
end


