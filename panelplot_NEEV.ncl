load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  
  f       = addfile("GFAD_V1-0.nc","r")

  NEEV_ageclass01  = f->age(0,0,:,:)
  NEEV_ageclass02  = f->age(1,0,:,:)
  NEEV_ageclass03  = f->age(2,0,:,:)
  NEEV_ageclass04  = f->age(3,0,:,:)
  NEEV_ageclass05  = f->age(4,0,:,:)
  NEEV_ageclass06  = f->age(5,0,:,:)
  NEEV_ageclass07  = f->age(6,0,:,:)
  NEEV_ageclass08  = f->age(7,0,:,:)
  NEEV_ageclass09  = f->age(8,0,:,:)
  NEEV_ageclass10  = f->age(9,0,:,:)
  NEEV_ageclass11  = f->age(10,0,:,:)
  NEEV_ageclass12  = f->age(11,0,:,:)
  NEEV_ageclass13  = f->age(12,0,:,:)
  NEEV_ageclass14  = f->age(13,0,:,:)
  NEEV_ageclass15  = f->age(14,0,:,:)
 
  NEEV_ageclass15 = where(NEEV_ageclass15.lt.0, 0, NEEV_ageclass15)

  printVarSummary (NEEV_ageclass01)

  lat_min = 34
  lat_max = 72
  lon_min = -11
  lon_max = 35
  age_sub = NEEV_ageclass01({lat_min:lat_max},{lon_min:lon_max})
  printVarSummary(age_sub)

;************************************************
; create plots
;************************************************
  
  wks                     = gsn_open_wks("pdf","NEEV_Ageclass_panel")
  plot                    = new(15,graphic)
  axislabelstyle          = "panel"

  res                     = True
; res@gsnPanelCenter      = True
; res@gsnPanelTop         = 1.0
  res@gsnDraw             = False
  res@gsnFrame            = False   
  res@gsnMaximize         = True

  res@mpMinLatF             = min(age_sub&lat)-2
  res@mpMaxLatF             = max(age_sub&lat)+2
  res@mpMinLonF             = min(age_sub&lon)-2
  res@mpMaxLonF             = max(age_sub&lon)+2
  res@mpCenterLonF          = (res@mpMinLonF + res@mpMaxLonF) / 2.

  res@mpFillOn            = False              ; Turn off gray fill
  res@cnFillOn            = True               ; color Fill 
  res@cnFillMode          = "RasterFill"       ; Raster Mode
  res@cnLinesOn           =  False             ; Turn off contour lines
  res@cnMissingValFillPattern     = 0
  res@cnMissingValFillColor       = "Transparent"
  
  res@cnFillPalette       = "WhiteGreen"  
;  res@cnFillColors        = (/-1,21,38,55,72,89,106,123,140,157,174,191,208,225,242/)

  res@mpOutlineBoundarySets       = "National"   ; turn on country boundaries

  res@tiYAxisString       = ""
;  res@vpWidthF            = 0.9

  gsnAddCyclic = False

  plot(0)  = gsn_csm_contour_map(wks,NEEV_ageclass01,res)
  plot(1)  = gsn_csm_contour_map(wks,NEEV_ageclass02,res)
  plot(2)  = gsn_csm_contour_map(wks,NEEV_ageclass03,res)
  plot(3)  = gsn_csm_contour_map(wks,NEEV_ageclass04,res)
  plot(4)  = gsn_csm_contour_map(wks,NEEV_ageclass05,res)
  plot(5)  = gsn_csm_contour_map(wks,NEEV_ageclass06,res)
  plot(6)  = gsn_csm_contour_map(wks,NEEV_ageclass07,res)
  plot(7)  = gsn_csm_contour_map(wks,NEEV_ageclass08,res)
  plot(8)  = gsn_csm_contour_map(wks,NEEV_ageclass09,res)
  plot(9)  = gsn_csm_contour_map(wks,NEEV_ageclass10,res)
  plot(10) = gsn_csm_contour_map(wks,NEEV_ageclass11,res)
  plot(11) = gsn_csm_contour_map(wks,NEEV_ageclass12,res)
  plot(12) = gsn_csm_contour_map(wks,NEEV_ageclass13,res)
  plot(13) = gsn_csm_contour_map(wks,NEEV_ageclass14,res)
  plot(14) = gsn_csm_contour_map(wks,NEEV_ageclass15,res)

  resp                                  = True
  resp@txString                         = "Needleleaf Evergreen"

  resp@gsnPanelFigureStrings            = (/"Age 1-10","Age 11-20","Age 21-30","Age 31-40","Age 41-50","Age 51-60","Age 61-70","Age 71-80","Age 81-90","Age 91-100","Age 101-110","Age 111-120","Age 121-130","Age 131-140","Age 141-150"/)

  resp@gsnPanelFigureStringsFontHeightF = 0.008
  resp@amJust                           = "BottomRight"
; resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True

  gsn_panel(wks,plot,(/3,3,3,3,3/),resp)
end


