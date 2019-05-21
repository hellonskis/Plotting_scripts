load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  

  f = addfile("cmass_npp_out.nc","r")

  npp1971_v10_plot = f->npp1971v10(:,:)
  npp1971_v10_plot@_FillValue = 1e20
  npp2100_v10_plot = f->npp2100v10(:,:)
  npp2100_v10_plot@_FillValue = 1e20
  cmass1971_v10_plot = f->cmass1971v10(:,:)
  cmass1971_v10_plot@_FillValue = 1e20
  cmass2100_v10_plot = f->cmass2100v10(:,:)
  cmass2100_v10_plot@_FillValue = 1e20

  npp1971_v11_plot = f->npp1971v11(:,:)
  npp1971_v11_plot@_FillValue = 1e20
  npp2100_v11_plot = f->npp2100v11(:,:)
  npp2100_v11_plot@_FillValue = 1e20
  cmass1971_v11_plot = f->cmass1971v11(:,:)
  cmass1971_v11_plot@_FillValue = 1e20
  cmass2100_v11_plot = f->cmass2100v11(:,:)
  cmass2100_v11_plot@_FillValue = 1e20

  npp1971_v12_plot = f->npp1971v12(:,:)
  npp1971_v12_plot@_FillValue = 1e20
  npp2100_v12_plot = f->npp2100v12(:,:)
  npp2100_v12_plot@_FillValue = 1e20
  cmass1971_v12_plot = f->cmass1971v12(:,:)
  cmass1971_v12_plot@_FillValue = 1e20
  cmass2100_v12_plot = f->cmass2100v12(:,:)
  cmass2100_v12_plot@_FillValue = 1e20

;************************************************
; create plots
;************************************************
  
  wks                     = gsn_open_wks("pdf","PicAbi_npp_cmass_panel_1971-2100_vers12")
  plot                    = new(4,graphic)
  axislabelstyle          = "panel"

  lat_min = 44
  lat_max = 54
  lon_min = 6
  lon_max = 17

  res1                     = True
; res1@gsnPanelCenter      = True
; res1@gsnPanelTop         = 1.0
  res1@gsnDraw             = False
  res1@gsnFrame            = False   
  res1@gsnMaximize         = True

  res1@mpMinLatF             = lat_min
  res1@mpMaxLatF             = lat_max
  res1@mpMinLonF             = lon_min
  res1@mpMaxLonF             = lon_max
  res1@mpCenterLonF          = (res1@mpMinLonF + res1@mpMaxLonF) / 2.

  res1@mpFillOn            = False              ; Turn off gray fill
  res1@cnFillOn            = True               ; color Fill 
  res1@cnFillMode          = "RasterFill"       ; Raster Mode
  res1@cnLinesOn           =  False             ; Turn off contour lines
  res1@cnMissingValFillPattern     = 0
  res1@cnMissingValFillColor       = "Transparent"
  res1@cnLevelSelectionMode        = "ExplicitLevels"   ; set explicit contour levels
;  res1@cnLevels                    = (/0.00,0.04,0.08,0.12,0.16,0.20,0.24,0.28,0.32,0.36,0.40,0.44,0.48,0.52,0.56,0.60,0.64,0.68,0.72,0.76,0.80,0.84,0.88,0.92,0.96/)
;  res1@cnLevels                    = (/-0.04,0.00,0.04,0.08,0.12,0.16,0.20,0.24,0.28,0.32,0.36,0.40,0.44,0.48,0.52,0.56,0.60,0.64,0.68,0.72/) 
  res1@cnLevels                    = (/0.00,0.04,0.08,0.12,0.16,0.20,0.24,0.28,0.32,0.36,0.40,0.44,0.48,0.52,0.56,0.60,0.64,0.68,0.72,0.76,0.80,0.84,0.88,0.92,0.96,1.00/)
;  res1@cnLevels                    = (/0.44,0.48,0.52,0.56,0.60,0.64,0.68,0.72,0.76,0.80,0.84,0.88,0.92,0.96,1.00,1.04,1.08/)
;  res1@cnLevels                    = (/0.00,0.04,0.08,0.12,0.16,0.20,0.24,0.28,0.32,0.36,0.40,0.44,0.48,0.52,0.56,0.60,0.64,0.68,0.72,0.76,0.80,0.84,0.88/)
;  res1@cnLevels                    = (/0.0,0.05,0.10,0.15,0.20,0.25,0.30,0.35,0.40,0.45,0.50,0.55,0.60,0.65,0.70,0.75,0.80,0.85,0.90,0.95,1.00,1.05,1.10,1.15/)
  res1@cnFillPalette       = "MPL_YlGn"  

  res1@mpOutlineBoundarySets       = "National"   ; turn on country boundaries
  res1@mpDataBaseVersion           = "MediumRes"
  res1@mpDataSetName               = "Earth..4"

  res1@gsnAddCyclic = False

;***************************************************************

  res2                     = True
; res2@gsnPanelCenter      = True
; res2@gsnPanelTop         = 1.0
  res2@gsnDraw             = False
  res2@gsnFrame            = False
  res2@gsnMaximize         = True

  res2@mpMinLatF             = lat_min
  res2@mpMaxLatF             = lat_max
  res2@mpMinLonF             = lon_min
  res2@mpMaxLonF             = lon_max
  res2@mpCenterLonF          = (res2@mpMinLonF + res2@mpMaxLonF) / 2.

  res2@mpFillOn            = False              ; Turn off gray fill
  res2@cnFillOn            = True               ; color Fill
  res2@cnFillMode          = "RasterFill"       ; Raster Mode
  res2@cnLinesOn           =  False             ; Turn off contour lines
  res2@cnMissingValFillPattern     = 0
  res2@cnMissingValFillColor       = "Transparent"
  res2@cnLevelSelectionMode        = "ExplicitLevels"   ; set explicit contour levels
;  res2@cnLevels                    = (/0.34,0.38,0.42,0.46,0.50,0.54,0.58,0.62,0.66,0.70,0.74,0.78,0.82,0.86,0.90,0.94,0.98,1.02,1.06/)
;  res2@cnLevels                    = (/0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0/)
  res2@cnLevels                    = (/0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0/)
;  res2@cnLevels                    = (/3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0/)
;  res2@cnLevels                    = (/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0/)
;  res2@cnLevels                    = (/0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0,8.4,8.8,9.2,9.6,10.0,10.4,10.8,11.2/)
  res2@cnFillPalette       = "MPL_YlGn"

  res2@mpOutlineBoundarySets       = "National"   ; turn on country boundaries
  res2@mpDataBaseVersion           = "MediumRes"
  res2@mpDataSetName               = "Earth..4"

  res2@gsnAddCyclic = False

;***************************************************************

;  plot(0)  = gsn_csm_contour_map(wks,npp1971_v10_plot,res1)
;  plot(1)  = gsn_csm_contour_map(wks,npp2100_v10_plot,res1)
;  plot(2)  = gsn_csm_contour_map(wks,cmass1971_v10_plot,res2)
;  plot(3)  = gsn_csm_contour_map(wks,cmass2100_v10_plot,res2)
;  plot(0)  = gsn_csm_contour_map(wks,npp1971_v11_plot,res1)
;  plot(1)  = gsn_csm_contour_map(wks,npp2100_v11_plot,res1)
;  plot(2)  = gsn_csm_contour_map(wks,cmass1971_v11_plot,res2)
;  plot(3)  = gsn_csm_contour_map(wks,cmass2100_v11_plot,res2)
  plot(0)  = gsn_csm_contour_map(wks,npp1971_v12_plot,res1)
  plot(1)  = gsn_csm_contour_map(wks,npp2100_v12_plot,res1)
  plot(2)  = gsn_csm_contour_map(wks,cmass1971_v12_plot,res2)
  plot(3)  = gsn_csm_contour_map(wks,cmass2100_v12_plot,res2)

  resp                                  = True
  resp@txString                         = "iffire 0, ifdisturb 1, harvest_system continuous, relaxed_establishment 1, + added~C~code changes to management.cpp suggested by Andy on 3/1/2019, + npatch=5"    

  resp@gsnPanelFigureStrings            = (/"NPP (kgC/m~S~2~N~) - 1971","NPP (kgC/m~S~2~N~) - 2100","CMASS (kgC/m~S~2~N~) - 1971","CMASS (kgC/m~S~2~N~) - 2100"/)

  resp@gsnPanelFigureStringsFontHeightF = 0.012
  resp@amJust                           = "BottomRight"
; resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True

  gsn_panel(wks,plot,(/2,2/),resp)
end


