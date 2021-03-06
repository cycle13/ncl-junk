;    File: t2_w10_qs.ncl
; Created: Monday, November 14 2011
; License: GPL v3 or later.
import("yag_utils")

begin
  a = set_inputfile()
  type = "pdf"
  type = "X11"

  varname = "QSNOW"
  noflevels = 32                ; how many layers should be added

  times  = wrf_user_list_times(a)
  times_in_file = a->Times

  xlat = a->XLAT(0,:,:)
  xlon = a->XLONG(0,:,:)

  do it = 0, dim_len0(times) - 1 , 1
    vt = it
    print("working with: " + times(vt))

    out = "qs_over" + chartostring(times_in_file(it,4:12)) + "_" + \
          chartostring(times_in_file(it,14:15))
    wks = gsn_open_wks(type,out)

    wgted_var = wrf_user_getvar_weighted_sum(a,varname,vt)
    wgted_var = wgted_var * 1000. ;
    wgted_var@units = "g"

    res = True
    res@TimeLabel = times(vt)   ; Set Valid time to use on plots

    opts = res
    opts@ContourParameters = (/ 0., 1.6, .1 /)
    opts@sfXArray = xlon
    opts@sfYArray = xlat
    opts@cnLevelFlags = False
    contour = wrf_contour(a,wks,wgted_var,opts)

    optsT = res
    optsT@sfXArray = xlon
    optsT@sfYArray = xlat
    optsT@cnFillOn  = True
    optsT@cnFillColor = True
    optsT@ContourParameters = (/ 250.,285., 0.5 /)
    optsT = set_res_no_frame(optsT)

    t2 = wrf_user_getvar(a,"T2",vt)
    contour_t = wrf_contour(a,wks,t2,optsT)

    cres = res
    cres@cnFillOn         = False
    cres@cnLevelFlags = True
    cres@cnLineColor = "White"
    cres@cnLineThicknessF = 2.3
    cres@sfXArray = xlon
    cres@sfYArray = xlat

    slp = wrf_user_getvar(a,"slp",it)
    cres@ContourParameters = (/ 970., 1035., 1 /)
    contour_slp = wrf_contour(a,wks,slp,cres)

    ;;-- plot/overlay all  --
    pltres = True ; Plot resources
    pltres = set_res_wrf_no_headers(pltres)
    pltres = set_res_tm_size(res)
    pltres@LatLonOverlay = True ; Don't do an NDC overlay

    mpres  = True  ; Map resources
    mpres = set_res_highres_coast(mpres)
    mpres = set_res_mp_latlon(mpres,139.,145.5,43.,48.)
    mpres = set_res_wrf_no_headers(mpres)

    mpres = set_res_tm_size(mpres)
    mpres@lbOrientation = "vertical"

;    plot = wrf_map_overlays(a,wks,(/contour_t,vector,contour/),pltres,mpres)
    plot = wrf_map_overlays(a,wks,(/contour_t,contour_slp,contour/),pltres,mpres)

    tit = chartostring(times_in_file(it,5:15))
    anno_top_left(wks,plot,tit)

    draw(wks)
    frame(wks)

  end do

end
;;; t2_w10_qs.ncl ends here
