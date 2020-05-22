### PostProcessing
Code used for post-processing and extraction of variables from pre-processed data.


#### Site differences
![Site differences](/Figures/ABCD_QC.png)


<html>
<head>
<meta charset="utf-8" />
</head>
<body>
<div class="Rtable1"><table class="Rtable1">
<thead>
<tr>
<th class="rowlabel firstrow lastrow"></th>
<th class="firstrow lastrow"><span class="varlabel">sex</span></th>
<th class="firstrow lastrow"><span class="varlabel">interview_age</span></th>
<th class="firstrow lastrow"><span class="varlabel">euler</span></th>
<th class="firstrow lastrow"><span class="varlabel">esitmated intracranial volume </span></th>
<th class="firstrow lastrow"><span class="varlabel">bmi</span></th>
</tr>
</thead>
<tbody>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site01<br><span class="stratn">(N=368)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 187 (50.8%)<br />M: 181 (49.2%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 119 (7.51)<br />Median [Min, Max]: 119 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 59.4 (35.6)<br />Median [Min, Max]: 52.0 [17.0, 349]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1440000 (128000)<br />Median [Min, Max]: 1440000 [1110000, 1860000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 20.2 (5.22)<br />Median [Min, Max]: 19.0 [2.15, 41.6]<br />Missing: 1 (0.3%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site02<br><span class="stratn">(N=526)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 246 (46.8%)<br />M: 280 (53.2%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 121 (7.52)<br />Median [Min, Max]: 121 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 60.0 (23.9)<br />Median [Min, Max]: 56.0 [15.0, 242]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1560000 (138000)<br />Median [Min, Max]: 1550000 [1180000, 2050000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 17.5 (3.19)<br />Median [Min, Max]: 16.7 [12.7, 34.6]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site03<br><span class="stratn">(N=585)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 282 (48.2%)<br />M: 303 (51.8%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 118 (7.45)<br />Median [Min, Max]: 118 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 61.3 (22.1)<br />Median [Min, Max]: 58.0 [17.0, 197]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1530000 (135000)<br />Median [Min, Max]: 1530000 [1090000, 1960000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 19.7 (4.26)<br />Median [Min, Max]: 19.0 [2.08, 35.4]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site04<br><span class="stratn">(N=638)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 305 (47.8%)<br />M: 333 (52.2%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 118 (7.90)<br />Median [Min, Max]: 118 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 93.0 (59.8)<br />Median [Min, Max]: 76.0 [18.0, 447]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1410000 (125000)<br />Median [Min, Max]: 1400000 [1100000, 1820000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 19.1 (4.56)<br />Median [Min, Max]: 17.8 [8.95, 45.1]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site05<br><span class="stratn">(N=357)</span></span></td>
<td class="firstrow lastrow">: <br />: 3 (0.8%)<br />F: 180 (50.4%)<br />M: 174 (48.7%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 119 (7.47)<br />Median [Min, Max]: 118 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 68.9 (41.1)<br />Median [Min, Max]: 60.0 [16.0, 407]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1550000 (143000)<br />Median [Min, Max]: 1540000 [1140000, 1960000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 26.8 (159)<br />Median [Min, Max]: 17.5 [5.55, 3020]<br />Missing: 2 (0.6%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site06<br><span class="stratn">(N=561)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 277 (49.4%)<br />M: 284 (50.6%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 119 (7.14)<br />Median [Min, Max]: 120 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 61.4 (24.0)<br />Median [Min, Max]: 58.0 [17.0, 212]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1570000 (139000)<br />Median [Min, Max]: 1560000 [1080000, 2070000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 18.5 (3.86)<br />Median [Min, Max]: 17.5 [8.65, 38.8]<br />Missing: 2 (0.4%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site07<br><span class="stratn">(N=300)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 136 (45.3%)<br />M: 164 (54.7%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 118 (7.59)<br />Median [Min, Max]: 117 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 66.3 (33.1)<br />Median [Min, Max]: 59.5 [17.0, 364]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1560000 (145000)<br />Median [Min, Max]: 1560000 [1210000, 2010000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 19.6 (4.92)<br />Median [Min, Max]: 18.2 [6.65, 55.0]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site08<br><span class="stratn">(N=245)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 117 (47.8%)<br />M: 128 (52.2%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 120 (7.54)<br />Median [Min, Max]: 120 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 77.6 (45.4)<br />Median [Min, Max]: 64.0 [21.0, 328]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1440000 (126000)<br />Median [Min, Max]: 1440000 [1040000, 1760000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 18.2 (3.60)<br />Median [Min, Max]: 17.2 [12.7, 38.9]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site09<br><span class="stratn">(N=414)</span></span></td>
<td class="firstrow lastrow">: <br />: 1 (0.2%)<br />F: 207 (50.0%)<br />M: 206 (49.8%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 119 (7.32)<br />Median [Min, Max]: 119 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 69.3 (49.0)<br />Median [Min, Max]: 60.0 [17.0, 503]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1560000 (134000)<br />Median [Min, Max]: 1560000 [1220000, 2090000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 19.0 (4.15)<br />Median [Min, Max]: 17.9 [10.5, 40.3]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site10<br><span class="stratn">(N=590)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 289 (49.0%)<br />M: 301 (51.0%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 118 (7.55)<br />Median [Min, Max]: 118 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 73.3 (50.3)<br />Median [Min, Max]: 59.0 [16.0, 395]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1400000 (132000)<br />Median [Min, Max]: 1390000 [1110000, 1910000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 19.5 (4.38)<br />Median [Min, Max]: 18.5 [10.8, 53.9]<br />Missing: 1 (0.2%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site11<br><span class="stratn">(N=422)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 204 (48.3%)<br />M: 218 (51.7%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 118 (7.64)<br />Median [Min, Max]: 117 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 63.0 (26.2)<br />Median [Min, Max]: 58.0 [23.0, 292]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1540000 (134000)<br />Median [Min, Max]: 1530000 [1160000, 1920000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 19.1 (4.31)<br />Median [Min, Max]: 17.8 [12.5, 42.3]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site12<br><span class="stratn">(N=546)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 269 (49.3%)<br />M: 277 (50.7%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 118 (7.46)<br />Median [Min, Max]: 118 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 67.2 (34.1)<br />Median [Min, Max]: 59.5 [16.0, 373]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1530000 (141000)<br />Median [Min, Max]: 1520000 [1100000, 2070000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 18.5 (4.29)<br />Median [Min, Max]: 17.4 [7.78, 36.5]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site13<br><span class="stratn">(N=542)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 269 (49.6%)<br />M: 273 (50.4%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 117 (7.35)<br />Median [Min, Max]: 116 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 91.2 (59.7)<br />Median [Min, Max]: 73.5 [17.0, 485]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1450000 (134000)<br />Median [Min, Max]: 1440000 [1020000, 1900000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 18.7 (4.03)<br />Median [Min, Max]: 17.4 [9.04, 40.3]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site14<br><span class="stratn">(N=576)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 266 (46.2%)<br />M: 310 (53.8%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 122 (6.82)<br />Median [Min, Max]: 123 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 65.5 (34.4)<br />Median [Min, Max]: 60.0 [19.0, 548]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1590000 (136000)<br />Median [Min, Max]: 1590000 [1250000, 2100000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 17.7 (3.18)<br />Median [Min, Max]: 16.9 [12.3, 32.4]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site15<br><span class="stratn">(N=414)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 191 (46.1%)<br />M: 223 (53.9%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 119 (7.37)<br />Median [Min, Max]: 119 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 82.1 (69.4)<br />Median [Min, Max]: 62.0 [18.0, 540]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1530000 (146000)<br />Median [Min, Max]: 1520000 [1160000, 2060000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 20.7 (5.47)<br />Median [Min, Max]: 19.2 [12.3, 52.8]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site16<br><span class="stratn">(N=977)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 434 (44.4%)<br />M: 543 (55.6%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 118 (7.88)<br />Median [Min, Max]: 118 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 54.2 (20.5)<br />Median [Min, Max]: 52.0 [17.0, 283]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1570000 (132000)<br />Median [Min, Max]: 1570000 [1180000, 2050000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 17.6 (3.47)<br />Median [Min, Max]: 16.7 [10.8, 34.6]<br />Missing: 1 (0.1%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site17<br><span class="stratn">(N=524)</span></span></td>
<td class="firstrow lastrow">: <br />: 1 (0.2%)<br />F: 246 (46.9%)<br />M: 277 (52.9%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 118 (7.59)<br />Median [Min, Max]: 117 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 73.5 (45.1)<br />Median [Min, Max]: 61.0 [15.0, 418]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1510000 (129000)<br />Median [Min, Max]: 1500000 [1170000, 1900000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 18.2 (3.48)<br />Median [Min, Max]: 17.4 [5.27, 41.1]<br />Missing: 1 (0.2%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site18<br><span class="stratn">(N=301)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 135 (44.9%)<br />M: 166 (55.1%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 119 (7.67)<br />Median [Min, Max]: 119 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 97.2 (62.9)<br />Median [Min, Max]: 81.0 [21.0, 437]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1450000 (134000)<br />Median [Min, Max]: 1450000 [1070000, 1830000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 18.2 (3.38)<br />Median [Min, Max]: 17.4 [13.2, 35.2]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site19<br><span class="stratn">(N=499)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 260 (52.1%)<br />M: 239 (47.9%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 121 (6.54)<br />Median [Min, Max]: 121 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 65.3 (46.0)<br />Median [Min, Max]: 53.0 [16.0, 405]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1450000 (131000)<br />Median [Min, Max]: 1450000 [1100000, 1840000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 18.8 (4.06)<br />Median [Min, Max]: 17.9 [11.8, 38.2]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site20<br><span class="stratn">(N=670)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 332 (49.6%)<br />M: 338 (50.4%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 121 (5.86)<br />Median [Min, Max]: 121 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 65.4 (29.2)<br />Median [Min, Max]: 59.5 [19.0, 320]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1570000 (139000)<br />Median [Min, Max]: 1560000 [1130000, 1940000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 18.9 (4.33)<br />Median [Min, Max]: 17.9 [6.16, 35.1]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site21<br><span class="stratn">(N=501)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 230 (45.9%)<br />M: 271 (54.1%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 119 (7.56)<br />Median [Min, Max]: 118 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 68.4 (37.4)<br />Median [Min, Max]: 60.0 [17.0, 341]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1560000 (140000)<br />Median [Min, Max]: 1550000 [1180000, 1950000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 19.9 (4.76)<br />Median [Min, Max]: 18.6 [12.6, 40.3]<br />Missing: 2 (0.4%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">site22<br><span class="stratn">(N=32)</span></span></td>
<td class="firstrow lastrow">: <br />: 0 (0%)<br />F: 19 (59.4%)<br />M: 13 (40.6%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 123 (6.67)<br />Median [Min, Max]: 125 [109, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 105 (61.7)<br />Median [Min, Max]: 89.0 [44.0, 321]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1420000 (108000)<br />Median [Min, Max]: 1410000 [1170000, 1720000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 19.1 (4.06)<br />Median [Min, Max]: 18.2 [13.3, 29.9]<br />Missing: 0 (0%)</td>
</tr>
<tr>
<td class="rowlabel firstrow lastrow"><span class="stratlabel">Overall<br><span class="stratn">(N=10588)</span></span></td>
<td class="firstrow lastrow">: <br />: 5 (0.0%)<br />F: 5081 (48.0%)<br />M: 5502 (52.0%)</td>
<td class="firstrow lastrow">: <br />Mean (SD): 119 (7.47)<br />Median [Min, Max]: 119 [108, 131]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 69.7 (43.0)<br />Median [Min, Max]: 59.0 [15.0, 548]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 1520000 (148000)<br />Median [Min, Max]: 1510000 [1020000, 2100000]</td>
<td class="firstrow lastrow">: <br />Mean (SD): 19.1 (29.5)<br />Median [Min, Max]: 17.6 [2.08, 3020]<br />Missing: 10 (0.1%)</td>
</tr>
</tbody>
</table>
</div>
</body>
</html>
