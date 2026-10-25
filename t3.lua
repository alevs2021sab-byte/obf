local a=string.byte;local d=string.char;local o=string.sub;local G=table.concat;local e=table.insert;local r=math.ldexp;local B=getfenv or function()return _ENV end;local e=setmetatable;local s=select;local f=unpack or table.unpack;local h=tonumber;local function A(f)local l,n,i="","",{}local t=256;local c={}for e=0,t-1 do c[e]=d(e)end;local e=1;local function a()local l=h(o(f,e,e),36)e=e+1;local n=h(o(f,e,e+l-1),36)e=e+l;return n end;l=d(a())i[1]=l;while e<#f do local e=a()if c[e]then n=c[e]else n=l..o(l,1,1)end;c[t]=l..o(n,1,1)i[#i+1],l,t=n,n,t+1 end;return table.concat(i)end;local h=A('21K21G27521H21D27521G21W21Y22L22I21S21H21Q27925N22V22C24K25D1C25623E23N25721H27921G21H21E27921Z21S27C22I22B21H21J27Y21T22E21H21C27922F22K22D21Y21I27U27U28G27U25W22J23828J27U25G1B21H27427524J1821K25H26922P25R1K26F25W23J25028O2791S28N28H27523828H22E2792121H27927T27521227528G29727528A28O28J28A28A28H29U29B29X27T29M21G27X28529L27521F21G29V21G1K2A621G2A72782A121O2A82791K21521G2AH2AH27X21G27821P28H2A127H2A72A521G21R2AM29G2752742AS29Q27527H1Y27V2B521M2B027928A21N21G21L27U1T21G2BB29O2751521G2AS2BH2BB21G2BO2AS2BB2BH21C1L21G27H2102B92122192C02C629L2C52AZ2B42AC2742A92C42BG2BP2BD1R2AY21G22W2B91K1621G2BF2BB2AS1K29M2BF2BF2AZ2AB2CQ2D02CB21G2C22AP27U2112AQ29B29M2AW27U2132AI28H1W2BK29B1X2DH2AT21G2DJ29729M2AS2A128A2DD2DB2B02DG27H28H2DJ2BF28H2B82E02DC21G2B82972DD2AS2DD2792DJ2A127U2B82EA21G28J2DJ2DJ2DY2DM2DI2EM2A02C51Z2CH2C821G2182AD27921M1V2EW122B92DJ21C1I2792F127T2F42792352B921M112EW2FB27T2B82F92752FG2AA2BB2C52DJ2741K2BB21A2E521G27421E1321G2C5192B92FT2FJ21G2G129K1G2EU2G92ER21G1M21G21B2EM2C51K2BF2GF2GF28T2752142FU2FT2CZ2GO2GO2FQ2752ER2ER2GM2FU2GO2EL2GF2B5279172B921E2GO2DJ23G2B92FI2F52752HA2F82HD21G23H2B92AI2DJ2B82752FD2EW22P2F22A82HH2HR27T2FR2FZ2EM2742EY2EW23F2B92C52G42I32HG27922S2HK2G82EV2EV2GB2GD2FT2DJ2GH2742FT2FT2FQ21621G2GW2FV2B52DJ2FT29Q2HH2HJ29K28A2D72EV2BD21G29M2C52791J2DK2BD2HH2312HK1821G2D72AS2D72IP2A22D32JE2A82BZ2AZ2GF2IY2H627U29R2EW2J62EH29W2HH22C2HK2EK2JW29K1P29J279');local t=bit and bit.bxor or function(e,n)local l,t=1,0
while e>0 and n>0 do
local o,i=e%2,n%2
if o~=i then t=t+l end
e,n,l=(e-o)/2,(n-i)/2,l*2
end
if e<n then e=n end
while e>0 do
local n=e%2
if n>0 then t=t+l end
e,l=(e-n)/2,l*2
end
return t
end
local function n(n,e,l)if l then
local e=(n/2^(e-1))%2^((l-1)-(e-1)+1);return e-e%1;else
local e=2^(e-1);return(n%(e+e)>=e)and 1 or 0;end;end;local e=1;local function l()local l,i,o,n=a(h,e,e+3);l=t(l,52)i=t(i,52)o=t(o,52)n=t(n,52)e=e+4;return(n*16777216)+(o*65536)+(i*256)+l;end;local function c()local l=t(a(h,e,e),52);e=e+1;return l;end;local function i()local l,n=a(h,e,e+2);l=t(l,52)n=t(n,52)e=e+2;return(n*256)+l;end;local function A()local e=l();local l=l();local o=1;local t=(n(l,1,20)*(2^32))+e;local e=n(l,21,31);local l=((-1)^n(l,32));if(e==0)then
if(t==0)then
return l*0;else
e=1;o=0;end;elseif(e==2047)then
return(t==0)and(l*(1/0))or(l*(0/0));end;return r(l,e-1023)*(o+(t/(2^52)));end;local r=l;local function H(l)local n;if(not l)then
l=r();if(l==0)then
return'';end;end;n=o(h,e,e+l-1);e=e+l;local l={}for e=1,#n do
l[e]=d(t(a(o(n,e,e)),52))end
return G(l);end;local e=l;local function h(...)return{...},s('#',...)end
local function d()local f={};local t={};local e={};local a={f,t,nil,e};local e=l()local o={}for n=1,e do
local l=c();local e;if(l==0)then e=(c()~=0);elseif(l==2)then e=A();elseif(l==1)then e=H();end;o[n]=e;end;for e=1,l()do t[e-1]=d();end;a[3]=c();for a=1,l()do
local e=c();if(n(e,1,1)==0)then
local t=n(e,2,3);local c=n(e,4,6);local e={i(),i(),nil,nil};if(t==0)then
e[3]=i();e[4]=i();elseif(t==1)then
e[3]=l();elseif(t==2)then
e[3]=l()-(2^16)elseif(t==3)then
e[3]=l()-(2^16)e[4]=i();end;if(n(c,1,1)==1)then e[2]=o[e[2]]end
if(n(c,2,2)==1)then e[3]=o[e[3]]end
if(n(c,3,3)==1)then e[4]=o[e[4]]end
f[a]=e;end
end;return a;end;local function r(e,l,c)local l=e[1];local n=e[2];local e=e[3];return function(...)local o=l;local l=n;local t=e;local e=h
local n=1;local a=-1;local d={};local i={...};local h=s('#',...)-1;local e={};local l={};for e=0,h do
if(e>=t)then
d[e-t]=i[e+1];else
l[e]=i[e+1];end;end;local e=h-t+1
local e;local t;while true do
e=o[n];t=e[1];if t<=29 then if t<=14 then if t<=6 then if t<=2 then if t<=0 then l[e[2]]=l[e[3]];elseif t>1 then a=e[2];else l[e[2]]=e[3];end;elseif t<=4 then if t==3 then if(e[2]<l[e[4]])then n=n+1;else n=e[3];end;else l[e[2]]=l[e[3]];end;elseif t==5 then local c;local i;local t;l[e[2]]={};n=n+1;e=o[n];l[e[2]]=e[3];n=n+1;e=o[n];l[e[2]]=e[3];n=n+1;e=o[n];l[e[2]]=e[3];n=n+1;e=o[n];t=e[2];i=l[t]c=l[t+2];if(c>0)then
if(i>l[t+1])then
n=e[3];else
l[t+3]=i;end
elseif(i<l[t+1])then
n=e[3];else
l[t+3]=i;end
else
local n=e[2]l[n]=l[n](f(l,n+1,e[3]))end;elseif t<=10 then if t<=8 then if t>7 then local t;l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];t=e[2]l[t]=l[t](f(l,t+1,e[3]))n=n+1;e=o[n];l[e[2]]=l[e[3]][l[e[4]]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];else l[e[2]]=#l[e[3]];end;elseif t==9 then
local e=e[2]l[e]=l[e](l[e+1])else l[e[2]]={};end;elseif t<=12 then if t==11 then l[e[2]]=l[e[3]][l[e[4]]];else l[e[2]]=l[e[3]]/e[4];end;elseif t==13 then l[e[2]]=c[e[3]];else l[e[2]]=l[e[3]]%e[4];end;elseif t<=21 then if t<=17 then if t<=15 then l[e[2]]=l[e[3]]/e[4];n=n+1;e=o[n];l[e[2]]=l[e[3]]-l[e[4]];n=n+1;e=o[n];l[e[2]]=l[e[3]]/e[4];n=n+1;e=o[n];l[e[2]]=l[e[3]]*e[4];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];n=e[3];elseif t>16 then if(l[e[2]]~=l[e[4]])then n=n+1;else n=e[3];end;else if(l[e[2]]<l[e[4]])then n=e[3];else n=n+1;end;end;elseif t<=19 then if t>18 then l[e[2]]=l[e[3]]%e[4];else local t;l[e[2]]=l[e[3]]%e[4];n=n+1;e=o[n];l[e[2]]=l[e[3]]+e[4];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];t=e[2]l[t]=l[t](f(l,t+1,e[3]))n=n+1;e=o[n];l[e[2]]=l[e[3]][l[e[4]]];end;elseif t>20 then
local e=e[2]l[e](l[e+1])else
local e=e[2]l[e](l[e+1])end;elseif t<=25 then if t<=23 then if t==22 then l[e[2]][l[e[3]]]=l[e[4]];else local t=e[3];local n=l[t]for e=t+1,e[4]do n=n..l[e];end;l[e[2]]=n;end;elseif t==24 then l[e[2]]=l[e[3]]*e[4];else l[e[2]]=e[3];end;elseif t<=27 then if t==26 then n=e[3];else l[e[2]]=l[e[3]]+e[4];end;elseif t>28 then l[e[2]]=l[e[3]][e[4]];else if(l[e[2]]<l[e[4]])then n=e[3];else n=n+1;end;end;elseif t<=44 then if t<=36 then if t<=32 then if t<=30 then l[e[2]]=l[e[3]]*e[4];elseif t>31 then l[e[2]]=l[e[3]]+l[e[4]];else l[e[2]]={};end;elseif t<=34 then if t>33 then l[e[2]]=l[e[3]]-l[e[4]];else
local t=e[2];local i=l[t+2];local o=l[t]+i;l[t]=o;if(i>0)then
if(o<=l[t+1])then
n=e[3];l[t+3]=o;end
elseif(o>=l[t+1])then
n=e[3];l[t+3]=o;end
end;elseif t==35 then
local t=e[2];local i=l[t+2];local o=l[t]+i;l[t]=o;if(i>0)then
if(o<=l[t+1])then
n=e[3];l[t+3]=o;end
elseif(o>=l[t+1])then
n=e[3];l[t+3]=o;end
else l[e[2]]=l[e[3]]+l[e[4]];end;elseif t<=40 then if t<=38 then if t==37 then l[e[2]]=c[e[3]];n=n+1;e=o[n];l[e[2]]=e[3];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]];n=n+1;e=o[n];l[e[2]]=e[3];n=n+1;e=o[n];l[e[2]]=c[e[3]];n=n+1;e=o[n];l[e[2]]=l[e[3]][e[4]];n=n+1;e=o[n];l[e[2]]=c[e[3]];else n=e[3];end;elseif t==39 then a=e[2];else do return end;end;elseif t<=42 then if t==41 then
local e=e[2]l[e]=l[e](l[e+1])else
local n=e[2]l[n]=l[n](f(l,n+1,e[3]))end;elseif t==43 then if(e[2]<l[e[4]])then n=e[3];else n=n+1;end;else
local t=e[2];local o=l[t]local i=l[t+2];if(i>0)then
if(o>l[t+1])then
n=e[3];else
l[t+3]=o;end
elseif(o<l[t+1])then
n=e[3];else
l[t+3]=o;end
end;elseif t<=52 then if t<=48 then if t<=46 then if t==45 then do return end;else if(e[2]<l[e[4]])then n=e[3];else n=n+1;end;end;elseif t==47 then
local t=e[2];local o=l[t]local i=l[t+2];if(i>0)then
if(o>l[t+1])then
n=e[3];else
l[t+3]=o;end
elseif(o<l[t+1])then
n=e[3];else
l[t+3]=o;end
else l[e[2]]=l[e[3]]+e[4];end;elseif t<=50 then if t>49 then l[e[2]]=l[e[3]]-e[4];else l[e[2]][l[e[3]]]=l[e[4]];end;elseif t>51 then l[e[2]]=l[e[3]][e[4]];else local t=e[3];local n=l[t]for e=t+1,e[4]do n=n..l[e];end;l[e[2]]=n;end;elseif t<=56 then if t<=54 then if t>53 then l[e[2]]=l[e[3]]/e[4];else if(e[2]<l[e[4]])then n=n+1;else n=e[3];end;end;elseif t==55 then if(l[e[2]]~=l[e[4]])then n=n+1;else n=e[3];end;else l[e[2]]=l[e[3]]-l[e[4]];end;elseif t<=58 then if t==57 then l[e[2]]=c[e[3]];else l[e[2]]=#l[e[3]];end;elseif t>59 then l[e[2]]=l[e[3]][l[e[4]]];else l[e[2]]=l[e[3]]-e[4];end;n=n+1;end;end;end;return r(d(),{},B())();