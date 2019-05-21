load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  
  f       = addfile("sfcWindmax_EUR-11_MOHC-HadGEM2-ES_historical_r1i1p1_SMHI-RCA4_v1_day_1999_regridded_masked.nc","r")
  g       = addfile("sfcWindmax_EUR-11_IPSL-IPSL-CM5A-MR_historical_r1i1p1_SMHI-RCA4_v1_day_1999_regridded_masked.nc","r")

  SFC_WIND_1_Dec26  = f->sfcWindmax(355,:,:)
  SFC_WIND_1_Dec27  = f->sfcWindmax(356,:,:)
  SFC_WIND_2_Dec26  = g->sfcWindmax(359,:,:)
  SFC_WIND_2_Dec27  = g->sfcWindmax(360,:,:)

;  printVarSummary (NEEV_ageclass01)

  lat_min = 28
  lat_max = 70
  lon_min = -10
  lon_max = 37

;************************************************
; create plots
;************************************************
  
  wks                     = gsn_open_wks("pdf","sfcWindmax_panel")
  plot                    = new(4,graphic)
  axislabelstyle          = "panel"

;*************************************************************

  res1                     = True
  res1@mpMinLatF           = lat_min
  res1@mpMaxLatF           = lat_max
  res1@mpMinLonF           = lon_min
  res1@mpMaxLonF           = lon_max
  res1@mpCenterLonF        = (res1@mpMinLonF + res1@mpMaxLonF) / 2.
  res1@gsnDraw             = False
  res1@gsnFrame            = False   
  res1@gsnMaximize         = True

  res1@gsnLeftString	  = "MOHC-HadGEM2-ES-SMHI"
  res1@gsnRightString      = ""
  res1@mpFillOn            = False              ; Turn off gray fill
  res1@cnFillOn            = True               ; color Fill 
  res1@cnFillMode          = "RasterFill"       ; Raster Mode
  res1@cnLinesOn           =  False             ; Turn off contour lines
  res1@cnMissingValFillPattern     = 0
  res1@cnMissingValFillColor       = "Transparent"
  res1@mpOutlineBoundarySets       = "National"   ; turn on country boundaries
  res1@gsnAddCyclic = False
  res1@cnLevelSelectionMode        = "ExplicitLevels"   ; set explicit contour levels
  res1@cnLevels                    = (/2,4,6,8,10,12,14,16,18,20,22,24,26,28,30/)

  res2                     = True
  res2@mpMinLatF           = lat_min
  res2@mpMaxLatF           = lat_max
  res2@mpMinLonF           = lon_min
  res2@mpMaxLonF           = lon_max
  res2@mpCenterLonF        = (res2@mpMinLonF + res2@mpMaxLonF) / 2.
  res2@gsnDraw             = False
  res2@gsnFrame            = False
  res2@gsnMaximize         = True

  res2@gsnLeftString      = "IPSL-IPSL-CM5A-MR-SMHI"
  res2@gsnRightString      = ""
  res2@mpFillOn            = False              ; Turn off gray fill
  res2@cnFillOn            = True               ; color Fill
  res2@cnFillMode          = "RasterFill"       ; Raster Mode
  res2@cnLinesOn           =  False             ; Turn off contour lines
  res2@cnMissingValFillPattern     = 0
  res2@cnMissingValFillColor       = "Transparent"
  res2@mpOutlineBoundarySets       = "National"   ; turn on country boundaries
  res2@gsnAddCyclic = False
  res2@cnLevelSelectionMode        = "ExplicitLevels"   ; set explicit contour levels
  res2@cnLevels                    = (/2,4,6,8,10,12,14,16,18,20,22,24,26,28,30/)

;*************************************************************

  plot(0)  = gsn_csm_contour_map(wks,SFC_WIND_1_Dec26,res1)
  plot(1)  = gsn_csm_contour_map(wks,SFC_WIND_1_Dec27,res1)
  plot(2)  = gsn_csm_contour_map(wks,SFC_WIND_2_Dec26,res2)
  plot(3)  = gsn_csm_contour_map(wks,SFC_WIND_2_Dec27,res2)

  resp                                  = True
  resp@txString                         = "EURO-CORDEX Daily Max. Near-Surface Windspeed (m/s)"

  resp@gsnPanelFigureStrings            = (/"Dec 26, 1999","Dec 27, 1999","Dec 26, 1999","Dec 27, 1999"/)

  resp@gsnPanelFigureStringsFontHeightF = 0.012
  resp@amJust                           = "BottomRight"
; resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True

  gsn_panel(wks,plot,(/2,2/),resp)
end


