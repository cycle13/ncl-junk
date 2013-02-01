; Created: 金曜日, 12月 28 2012

load "$nsc/yagUtils.ncl"

begin

  nofproc = (/12,24,36,48,60,72,84,96,108,120/)

  maximum = (/ 98.87 , 89.06, 67.98, 51.95, 50.45, 47.80, 43.11, 42.24, 41.95, 39.90 /)

  minimum = (/4.103440,2.588120,1.629090,1.180440,0.964260,0.834830,0.643880,0.581200,0.528330,0.491200/)
  summ = (/8536.566460,5649.382270,3682.182760,2721.770920,2249.338030,2016.434080,1521.565270,1403.325930,1283.833000,1205.437370/)
  mean = (/10.944316,7.242798,4.720747,3.489450,2.883767,2.585172,1.950725,1.799136,1.645940,1.545433/)
  mean_max = (/0.110690,0.081325,0.069442,0.067169,0.057155,0.054073,0.045245,0.042589,0.039232,0.038730/)

  wks = gsn_open_wks("png","amur-mpi")

  plot =  gsn_xy(wks,nofproc,mean,True)

end
;;; amur-mpi.ncl ends here