load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  

  f = addfile("lai_multiplePFTs.nc","r")

  C3GPas_lai2010 = f->C3GPas(109,:,:)
  C3GPas_lai2010@_FillValue = 1e20

  print("===============done================")

;************************************************
; create plots
;************************************************
  
  wks                     = gsn_open_wks("pdf","lai_plot")
  plot                    = new(1,graphic)
  axislabelstyle          = "panel"

  lat_min = 44
  lat_max = 54
  lon_min = 6
  lon_max = 17

  res                     = True
; res@gsnPanelCenter      = True
; res@gsnPanelTop         = 1.0
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
;  res@cnFillMode          = "RasterFill"       ; Raster Mode
  res@cnLinesOn           =  False             ; Turn off contour lines
  res@cnMissingValFillPattern     = 0
  res@cnMissingValFillColor       = "Transparent"
;  res@cnLevelSelectionMode        = "ExplicitLevels"   ; set explicit contour levels
;  res@cnLevels                    = (//)
  res@cnFillPalette       = "MPL_YlGn"  

;  res@mpDataBaseVersion           = "MediumRes"
;  res@mpDataSetName               = "Earth..4"
;  res@mpOutlineBoundarySets       = "National"   ; turn on country boundaries

  res@gsnAddCyclic = False

  plot(0)  = gsn_csm_contour_map(wks,C3GPas_lai2010,res)

  resp                                  = True
  resp@txString                         = "Statewide LAI - 2010"

  resp@gsnPanelFigureStrings            = (/"LAI - 2010"/)
;

  resp@gsnPanelFigureStringsFontHeightF = 0.012
  resp@amJust                           = "BottomRight"
; resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True

  gsn_panel(wks,plot,(/1/),resp)
end


