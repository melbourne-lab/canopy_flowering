
%  -- Niwot Ridge Subalpine Forest AmeriFlux Data (site ID:  US-NR1) -- 
% MST Time Period: 2021  01/01 00:00:00 - 2021  12/31 17:00:00, JD 1.000-365.708 (MST) 
% UTC Time Period: 2021  01/01 07:00:00 - 2022  01/01 00:00:00, JD 1.292-366.000 (UTC)
% File Name: niwot_USNR1_radiation_2021_5min.csv
% File Created by: Sean Burns (sean.burns@colorado.edu)
% File Created for: Scott Nordstrom (scott.nordstrom@colorado.edu)
% Date: 16-Sep-2022
% --------
% 
%  Current Version: Preliminary (these are 5-min averages)                                                
%                                                                                                         
%           * Rsw_out_sp610_mV is being clipped in the data processing (need to fix this!)                
%                                                                                                         
%             [Additional notes to be added here later]                                                   
%                                                                                                         
% 
% --------
% 
%  Columns are: 
% 
%  1-6. Year, Month, Day, Hour, Minute, Sec -- in MST, Time Stamp Corresponds to start of Averaging Time Period
%  07. Decimal Day of Year (MST)
%  08. Rsw_in_25m_KZ        W/m2            25.5m             Incoming Shortwave Radiation                      	  Kipp and Zonen CNR1
%  09. Rsw_out_25m_KZ       W/m2            25.5m             Outgoing Shortwave Radiation                      	  Kipp and Zonen CNR1
%  10. Rlw_in_25m_KZ        W/m2            25.5m             Incoming Longwave Radiation                       	  Kipp and Zonen CNR1
%  11. Rlw_out_25m_KZ       W/m2            25.5m             Outgoing Longwave Radiation                       	  Kipp and Zonen CNR1
%  12. Rppfd_in_25m         umol/m2/s       25.5m             Incoming Photosynthetic Active Photon Flux Density (PPFD) 	  LI-COR 190-SA
%  13. Rppfd_out_25m        umol/m2/s       25.5m             Outgoing PPFD                                     	  LI-COR 190-SA
%  14. Rnet_25m_REBS        W/m2            25.5m             Net Radiation                                     	  REBS Q*7.1 (sn ?)
%  15. Rnet_0200cm_REBS     W/m2            2m                Net Radiation                                     	  Rebs Q*7.1 (sn Q96333)
%  16. Rsw_in_sp510         W/m2            2.2m              Incoming Shortwave Radiation                      	  Apogee SP-510
%  17. Rsw_in_sn500         W/m2            2.2m              Incoming Shortwave Radiation                      	  Apogee SN-500
%  18. Rsw_out_sp610        W/m2            2.2m              Outgoing Shortwave Radiation                      	  Apogee SP-610
%  19. Rsw_out_sn500        W/m2            2.2m              Outgoing Shortwave Radiation                      	  Apogee SN-500
%  20. Rlw_in_sl510         W/m2            2.2m              Incoming Longwave Radiation                       	  Apogee SL-510
%  21. Rlw_in_sn500         W/m2            2.2m              Incoming Longwave Radiation                       	  Apogee SN-500
%  22. Rlw_out_sn500        W/m2            2.2m              Outgoing Longwave Radiation                       	  Apogee SN-500
%  23. Tir_si121            degC            ground (sensor at 2m)    Infrared Surface Temperature                      	  Apogee SI-121
%  24. T_therm_si121        degC            2.2m              Thermistor Temperature                            	  Apogee SI-121
%  25. T_therm_sl510        degC            2.2m              Thermistor Temperature                            	  Apogee SL-510
%  26. T_med_uc             degC            2.5m              Air Temperature at Mini-tower                     	  Medtherm Thermocouple
%  27. snowdepth_judd       cm              2.5m              Snow Depth                                        	  Judd Ultrasonic Depth Sensor
%  28. Rsw_in_sp510_mV      mV              2.2m              Incoming Shortwave Radiation Voltage              	  Apogee SP-510
%  29. Rsw_out_sp610_mV     mV              2.2m              Outgoing Shortwave Radiation Voltage              	  Apogee SP-610
%  30. Rpile_in_sl510_mV    mV              2.2m              Thermopile Voltage                                	  Apogee SL-510
%  31. T_therm_sl510_mV     mV              2.2m              Thermistor Voltage                                	  Apogee SL-510
%  32. Tir_pile_si121_mV    mV              2m                Thermopile Voltage                                	  Apogee SI-121
%  33. Tir_term_si121_mV    mV              2m                Thermistor Voltage                                	  Apogee SI-121
% --------
% 
% 