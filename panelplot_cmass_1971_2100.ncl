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
  
  cmass_rcp45_1971 = f->cmass_rcp45(0,:,:) 
  cmass_rcp45_1971@_FillValue = 1e20
  cmass_rcp45_2100 = f->cmass_rcp45(129,:,:)
  cmass_rcp45_2100@_FillValue = 1e20
  cmass_rcp85_1971 = f->cmass_rcp85(0,:,:)
  cmass_rcp85_1971@_FillValue = 1e20
  cmass_rcp85_2100 = f->cmass_rcp85(129,:,:)
  cmass_rcp85_2100@_FillValue = 1e20

  ;***************************************************************

  wks                     = gsn_open_wks("pdf","PopTre_cmass_panel_1971-2100")
  plot                    = new(4,graphic)
  axislabelstyle          = "panel"

  lat_min = 44
  lat_max = 54
  lon_min = 6
  lon_max = 17  

  res                     = True
  res@gsnDraw             = False
  res@gsnFrame            = False
  res@gsnMaximize         = True

  res@mpMinLatF             = lat_min
  res@mpMaxLatF             = lat_max
  res@mpMinLonF             = lon_min
  res@mpMaxLonF             = lon_max
  res@mpCenterLonF          = (res@mpMinLonF + res@mpMaxLonF) / 2.

  res@mpFillOn            = False              ; Turn off gray fill
  res@cnFillOn            = True               ; color Fill
  res@cnFillMode          = "RasterFill"       ; Raster Mode
  res@cnLinesOn           =  False             ; Turn off contour lines
  res@cnMissingValFillPattern     = 0
  res@cnMissingValFillColor       = "Transparent"
  res@cnLevelSelectionMode        = "ExplicitLevels"   ; set explicit contour levels
;  res@cnLevels                    = (/0.34,0.38,0.42,0.46,0.50,0.54,0.58,0.62,0.66,0.70,0.74,0.78,0.82,0.86,0.90,0.94,0.98,1.02,1.06/)
;  res@cnLevels                    = (/0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0/)
;  res@cnLevels                    = (/0.0,2.0,4.0,6.0,8.0,10.0,12.0,14.0,16.0,18.0,20.0,22.0/)
;  res@cnLevels                    = (/3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0/)
;  res@cnLevels                    = (/3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,21.0,22.0,23.0,24.0,25.0/)
  res@cnLevels                    = (/0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0,8.4,8.8,9.2,9.6,10.0,10.4,10.8,11.2/)
  res@cnFillPalette       = "MPL_YlGn"

  res@mpDataBaseVersion           = "MediumRes"
  res@mpDataSetName               = "Earth..4"
  res@mpOutlineBoundarySets       = "National"   ; turn on country boundaries

  res@gsnAddCyclic = False

;***************************************************************

  plot(0)  = gsn_csm_contour_map(wks,cmass_rcp45_1971,res)
  plot(1)  = gsn_csm_contour_map(wks,cmass_rcp45_2100,res)
  plot(2)  = gsn_csm_contour_map(wks,cmass_rcp85_1971,res)
  plot(3)  = gsn_csm_contour_map(wks,cmass_rcp85_2100,res)  

  resp                                  = True
  resp@txString                         = "Poplar"

  resp@gsnPanelFigureStrings            = (/"RCP4.5 - CMASS (kgC/m~S~2~N~) - 1971","RCP4.5 - CMASS (kgC/m~S~2~N~) - 2100","RCP8.5 - CMASS (kgC/m~S~2~N~) - 1971","RCP8.5 - CMASS (kgC/m~S~2~N~) - 2100"/)

  resp@gsnPanelFigureStringsFontHeightF = 0.012
  resp@amJust                           = "BottomRight"
; resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True

  gsn_panel(wks,plot,(/2,2/),resp)

end


