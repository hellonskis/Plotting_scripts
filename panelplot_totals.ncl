load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"

;*******************************************
begin
;*******************************************  
  f = addfile("","r")

  npp_71 = f->npp(:,0,22,0)
  npp_98 = f->npp(:,126,22,0) 
  cmass_71 = f->cmasstotal(:,0,22,0)
  cmass_98 = f->cmasstotal(:,126,22,0)
 
  gridcell = f->Station
  lati = f->Latitude
  loni = f->Longitude
  npixels = dimsizes(gridcell)
  gridindex = new((/dimsizes(gridcell),3/),"float",0)

  lat_array = count_unique_values(lati)
  lon_array = count_unique_values(loni) 
  nlat = lat_array
  nlon = lon_array

  lat_new = new((/lat_array/),"float",0)
  lat_new@units = "degrees_north"
  lon_new = new((/lon_array/),"float",0)
  lon_new@units = "degrees_east"
  
  do pp=0, npixels-1
     gridindex(pp,0) = loni(pp)
     gridindex(pp,1) = lati(pp)
     gridindex(pp,2) = gridcell(pp)
  end do

  print(gridindex)
 
  do lt=0, nlat-1
     lat_new(lt) = min(lati) + (((max(lati)-min(lati))/(lat_array-1))*lt)
  end do

  do ln=0, nlon-1
     lon_new(ln) = min(loni) + (((max(loni)-min(loni))/(lon_array-1))*ln)
  end do

  npp1971 = new((/nlat,nlon/),"float",0)
  npp1971!0="lat"
  npp1971!1="lon"
  npp1971&lat = lat_new
  npp1971&lon = lon_new

  npp2098 = new((/nlat,nlon/),"float",0) 
  npp2098!0="lat"
  npp2098!1="lon"
  npp2098&lat = lat_new
  npp2098&lon = lon_new

  cmass1971 = new((/nlat,nlon/),"float",0)
  cmass1971!0="lat"
  cmass1971!1="lon"
  cmass1971&lat = lat_new
  cmass1971&lon = lon_new

  cmass2098 = new((/nlat,nlon/),"float",0)
  cmass2098!0="lat"
  cmass2098!1="lon"
  cmass2098&lat = lat_new
  cmass2098&lon = lon_new

  outname = "npp_out.nc"
  system("rm -rf "+outname)
  h = addfile(outname,"c")
  h->npp1971 = npp1971
  h->npp2098 = npp2098
  h->cmass1971 = cmass1971
  h->cmass2098 = cmass2098

  lat  = h->lat
  lon  = h->lon  

  npp1971_new = h->npp1971(:,:) 
  npp2098_new = h->npp2098(:,:)
  cmass1971_new = h->cmass1971(:,:)
  cmass2098_new = h->cmass2098(:,:)  

  do lt=0, nlat-1
    do ln=0, nlon-1
      do pp=0, npixels-1
        if (gridindex(pp,0) .eq. lon(ln) .and. gridindex(pp,1) .eq. lat(lt)) 
          npp1971_new(lt,ln) = (/npp_71(pp)/)
          npp2098_new(lt,ln) = (/npp_98(pp)/)
          cmass1971_new(lt,ln) = (/cmass_71(pp)/)
          cmass2098_new(lt,ln) = (/cmass_98(pp)/)
        end if
      end do
    end do
  end do

  h->npp1971 = npp1971_new
  h->npp2098 = npp2098_new
  h->cmass1971 = cmass1971_new
  h->cmass2098 = cmass2098_new

  npp1971_plot = h->npp1971
  npp1971_plot@_FillValue = 1e20
  npp2098_plot = h->npp2098
  npp2098_plot@_FillValue = 1e20
  cmass1971_plot = h->cmass1971
  cmass1971_plot@_FillValue = 1e20
  cmass2098_plot = h->cmass2098
  cmass2098_plot@_FillValue = 1e20

;************************************************
; create plots
;************************************************
  
  wks                     = gsn_open_wks("pdf","npp_cmass_panel_1971-2098")
  plot                    = new(4,graphic)
  axislabelstyle          = "panel"

  lat_min = 44
  lat_max = 54
  lon_min = 6
  lon_max = 17

;***************************************************************
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
  res1@cnLevels                    = (/0.14,0.16,0.18,0.20,0.22,0.24,0.26,0.28,0.30,0.32,0.34,0.36,0.38,0.40,0.42,0.44,0.46,0.48,0.50,0.52,0.54,0.56,0.58,0.60,0.62,0.64/)
  res1@cnFillPalette       = "MPL_YlGn"  

  res1@mpOutlineBoundarySets       = "National"   ; turn on country boundaries

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
  res2@cnLevels                    = (/5.0,5.4,5.8,6.2,6.6,7.0,7.4,7.8,8.2,8.6,9.0,9.4,9.8,10.2,10.6,11.0,11.4,11.8,12.2,12.6/)
  res2@cnFillPalette       = "MPL_YlGn"

  res2@mpOutlineBoundarySets       = "National"   ; turn on country boundaries

  res2@gsnAddCyclic = False

;***************************************************************

  plot(0)  = gsn_csm_contour_map(wks,npp1971_plot,res1)
  plot(1)  = gsn_csm_contour_map(wks,npp2098_plot,res1)
  plot(2)  = gsn_csm_contour_map(wks,cmass1971_plot,res2)
  plot(3)  = gsn_csm_contour_map(wks,cmass2098_plot,res2)

  resp                                  = True
  resp@txString                         = "Totals - all PFTs"

  resp@gsnPanelFigureStrings            = (/"NPP (kgC/m~S~2~N~) - 1971","NPP (kgC/m~S~2~N~) - 2098","CMASS (kgC/m~S~2~N~) - 1971","CMASS (kgC/m~S~2~N~) - 2098"/)

  resp@gsnPanelFigureStringsFontHeightF = 0.012
  resp@amJust                           = "BottomRight"
; resp@amOrthogonalPosF                 = 0.5
  resp@gsnMaximize                      = True
  resp@gsnPanelRowSpec                  = True

  gsn_panel(wks,plot,(/2,2/),resp)
end


