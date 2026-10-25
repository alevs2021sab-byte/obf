
local Byte         = string.byte;
local Char         = string.char;
local Sub          = string.sub;
local Concat       = table.concat;
local Insert       = table.insert;
local LDExp        = math.ldexp;
local GetFEnv      = getfenv or function() return _ENV end;
local Setmetatable = setmetatable;
local Select       = select;

local Unpack = unpack or table.unpack;
local ToNumber = tonumber;local function decompress(b)local c,d,e="","",{}local f=256;local g={}for h=0,f-1 do g[h]=Char(h)end;local i=1;local function k()local l=ToNumber(Sub(b, i,i),36)i=i+1;local m=ToNumber(Sub(b, i,i+l-1),36)i=i+l;return m end;c=Char(k())e[1]=c;while i<#b do local n=k()if g[n]then d=g[n]else d=c..Sub(c, 1,1)end;g[f]=c..Sub(d, 1,1)e[#e+1],c,f=d,d,f+1 end;return table.concat(e)end;local ByteString=decompress('21K21G27521H21D27521G21W21Y22L22I21S21H21Q27925N22V22C24K25D1C25623E23N25721H27921G21H21E27921Z21S27C22I22B21H21J27Y21T22E21H21C27922F22K22D21Y21I27U27U28G27U25W22J23828J27U25G1B21H27427524J1821K25H26922P25R1K26F25W23J25028O2791S28N28H27523828H22E2792121H27927T27521227528G29727528A28O28J28A28A28H29U29B29X27T29M21G27X28529L27521F21G29V21G1K2A621G2A72782A121O2A82791K21521G2AH2AH27X21G27821P28H2A127H2A72A521G21R2AM29G2752742AS29Q27527H1Y27V2B521M2B027928A21N21G21L27U1T21G2BB29O2751521G2AS2BH2BB21G2BO2AS2BB2BH21C1L21G27H2102B92122192C02C629L2C52AZ2B42AC2742A92C42BG2BP2BD1R2AY21G22W2B91K1621G2BF2BB2AS1K29M2BF2BF2AZ2AB2CQ2D02CB21G2C22AP27U2112AQ29B29M2AW27U2132AI28H1W2BK29B1X2DH2AT21G2DJ29729M2AS2A128A2DD2DB2B02DG27H28H2DJ2BF28H2B82E02DC21G2B82972DD2AS2DD2792DJ2A127U2B82EA21G28J2DJ2DJ2DY2DM2DI2EM2A02C51Z2CH2C821G2182AD27921M1V2EW122B92DJ21C1I2792F127T2F42792352B921M112EW2FB27T2B82F92752FG2AA2BB2C52DJ2741K2BB21A2E521G27421E1321G2C5192B92FT2FJ21G2G129K1G2EU2G92ER21G1M21G21B2EM2C51K2BF2GF2GF28T2752142FU2FT2CZ2GO2GO2FQ2752ER2ER2GM2FU2GO2EL2GF2B5279172B921E2GO2DJ23G2B92FI2F52752HA2F82HD21G23H2B92AI2DJ2B82752FD2EW22P2F22A82HH2HR27T2FR2FZ2EM2742EY2EW23F2B92C52G42I32HG27922S2HK2G82EV2EV2GB2GD2FT2DJ2GH2742FT2FT2FQ21621G2GW2FV2B52DJ2FT29Q2HH2HJ29K28A2D72EV2BD21G29M2C52791J2DK2BD2HH2312HK1821G2D72AS2D72IP2A22D32JE2A82BZ2AZ2GF2IY2H627U29R2EW2J62EH29W2HH22C2HK2EK2JW29K1P29J279');

local BitXOR = bit and bit.bxor or function(a,b)
    local p,c=1,0
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra~=rb then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    if a<b then a=b end
    while a>0 do
        local ra=a%2
        if ra>0 then c=c+p end
        a,p=(a-ra)/2,p*2
    end
    return c
end

local function gBit(Bit, Start, End)
	if End then
		local Res = (Bit / 2 ^ (Start - 1)) % 2 ^ ((End - 1) - (Start - 1) + 1);
		return Res - Res % 1;
	else
		local Plc = 2 ^ (Start - 1);
        return (Bit % (Plc + Plc) >= Plc) and 1 or 0;
	end;
end;

local Pos = 1;

local function gBits32()
    local W, X, Y, Z = Byte(ByteString, Pos, Pos + 3);

	W = BitXOR(W, 52)
	X = BitXOR(X, 52)
	Y = BitXOR(Y, 52)
	Z = BitXOR(Z, 52)

    Pos	= Pos + 4;
    return (Z*16777216) + (Y*65536) + (X*256) + W;
end;

local function gBits8()
    local F = BitXOR(Byte(ByteString, Pos, Pos), 52);
    Pos = Pos + 1;
    return F;
end;

local function gBits16()
    local W, X = Byte(ByteString, Pos, Pos + 2);

	W = BitXOR(W, 52)
	X = BitXOR(X, 52)

    Pos	= Pos + 2;
    return (X*256) + W;
end;

local function gFloat()
	local Left = gBits32();
	local Right = gBits32();
	local IsNormal = 1;
	local Mantissa = (gBit(Right, 1, 20) * (2 ^ 32))
					+ Left;
	local Exponent = gBit(Right, 21, 31);
	local Sign = ((-1) ^ gBit(Right, 32));
	if (Exponent == 0) then
		if (Mantissa == 0) then
			return Sign * 0; -- +-0
		else
			Exponent = 1;
			IsNormal = 0;
		end;
	elseif (Exponent == 2047) then
        return (Mantissa == 0) and (Sign * (1 / 0)) or (Sign * (0 / 0));
	end;
	return LDExp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / (2 ^ 52)));
end;

local gSizet = gBits32;
local function gString(Len)
    local Str;
    if (not Len) then
        Len = gSizet();
        if (Len == 0) then
            return '';
        end;
    end;

    Str	= Sub(ByteString, Pos, Pos + Len - 1);
    Pos = Pos + Len;

	local FStr = {}
	for Idx = 1, #Str do
		FStr[Idx] = Char(BitXOR(Byte(Sub(Str, Idx, Idx)), 52))
	end

    return Concat(FStr);
end;

local gInt = gBits32;
local function _R(...) return {...}, Select('#', ...) end

local function Deserialize()
    local Instrs = {};
    local Functions = {};
	local Lines = {};
    local Chunk = 
	{
		Instrs,
		Functions,
		nil,
		Lines
	};
	local ConstCount = gBits32()
    local Consts = {}

	for Idx=1, ConstCount do 
		local Type =gBits8();
		local Cons;
	
		if(Type==0) then Cons = (gBits8() ~= 0);
		elseif(Type==2) then Cons = gFloat();
		elseif(Type==1) then Cons = gString();
		end;
		
		Consts[Idx] = Cons;
	end;
for Idx=1,gBits32() do Functions[Idx-1]=Deserialize();end;Chunk[3] = gBits8();for Idx=1,gBits32() do 
									local Descriptor = gBits8();
									if (gBit(Descriptor, 1, 1) == 0) then
										local Type = gBit(Descriptor, 2, 3);
										local Mask = gBit(Descriptor, 4, 6);
										
										local Inst=
										{
											gBits16(),
											gBits16(),
											nil,
											nil
										};
	
										if (Type == 0) then 
											Inst[3] = gBits16(); 
											Inst[4] = gBits16();
										elseif(Type==1) then 
											Inst[3] = gBits32();
										elseif(Type==2) then 
											Inst[3] = gBits32() - (2 ^ 16)
										elseif(Type==3) then 
											Inst[3] = gBits32() - (2 ^ 16)
											Inst[4] = gBits16();
										end;
	
										if (gBit(Mask, 1, 1) == 1) then Inst[2] = Consts[Inst[2]] end
										if (gBit(Mask, 2, 2) == 1) then Inst[3] = Consts[Inst[3]] end
										if (gBit(Mask, 3, 3) == 1) then Inst[4] = Consts[Inst[4]] end
										
										Instrs[Idx] = Inst;
									end
								end;return Chunk;end;
local function Wrap(Chunk, Upvalues, Env)
	local Instr  = Chunk[1];
	local Proto  = Chunk[2];
	local Params = Chunk[3];

	return function(...)
		local Instr  = Instr; 
		local Proto  = Proto; 
		local Params = Params;

		local _R = _R
		local InstrPoint = 1;
		local Top = -1;

		local Vararg = {};
		local Args	= {...};

		local PCount = Select('#', ...) - 1;

		local Lupvals	= {};
		local Stk		= {};

		for Idx = 0, PCount do
			if (Idx >= Params) then
				Vararg[Idx - Params] = Args[Idx + 1];
			else
				Stk[Idx] = Args[Idx + 1];
			end;
		end;

		local Varargsz = PCount - Params + 1

		local Inst;
		local Enum;	

		while true do
			Inst		= Instr[InstrPoint];
			Enum		= Inst[1];if Enum <= 29 then if Enum <= 14 then if Enum <= 6 then if Enum <= 2 then if Enum <= 0 then Stk[Inst[2]]=Stk[Inst[3]]; elseif Enum > 1 then Top=Inst[2];else Stk[Inst[2]] = Inst[3];end; elseif Enum <= 4 then if Enum == 3 then if(Inst[2] < Stk[Inst[4]])then InstrPoint=InstrPoint+1;else InstrPoint=Inst[3];end;else Stk[Inst[2]]=Stk[Inst[3]];end; elseif Enum == 5 then local Step;local Index;local A;Stk[Inst[2]]={};InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]] = Inst[3];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]] = Inst[3];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]] = Inst[3];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];
A= Inst[2];
Index= Stk[A]
Step= Stk[A + 2];
if (Step > 0) then 
	if (Index > Stk[A+1]) then
		InstrPoint = Inst[3];
	else
		Stk[A+3] = Index;
	end
elseif (Index < Stk[A+1]) then
	InstrPoint = Inst[3];
else
	Stk[A+3] = Index;
end
else 
local A = Inst[2]
Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3])) 
end; elseif Enum <= 10 then if Enum <= 8 then if Enum > 7 then local A;Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];
A= Inst[2]
Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3])) 
InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]][Stk[Inst[4]]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];else Stk[Inst[2]]=#Stk[Inst[3]];end; elseif Enum == 9 then 
local A = Inst[2]
Stk[A] = Stk[A](Stk[A + 1]) 
else Stk[Inst[2]]={};end; elseif Enum <= 12 then if Enum == 11 then Stk[Inst[2]]=Stk[Inst[3]][Stk[Inst[4]]];else Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];end; elseif Enum == 13 then Stk[Inst[2]]=Env[Inst[3]];else Stk[Inst[2]] = Stk[Inst[3]] % Inst[4];end; elseif Enum <= 21 then if Enum <= 17 then if Enum <= 15 then Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]]-Stk[Inst[4]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]] = Stk[Inst[3]] * Inst[4];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];InstrPoint=Inst[3]; elseif Enum > 16 then if(Stk[Inst[2]]~=Stk[Inst[4]])then InstrPoint=InstrPoint+1;else InstrPoint=Inst[3];end;else if (Stk[Inst[2]]<Stk[Inst[4]])then InstrPoint=Inst[3]; else InstrPoint=InstrPoint+1; end;end; elseif Enum <= 19 then if Enum > 18 then Stk[Inst[2]] = Stk[Inst[3]] % Inst[4];else local A;Stk[Inst[2]] = Stk[Inst[3]] % Inst[4];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];
A= Inst[2]
Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3])) 
InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]][Stk[Inst[4]]];end; elseif Enum > 20 then 
local A = Inst[2]
Stk[A](Stk[A + 1])
else 
local A = Inst[2]
Stk[A](Stk[A + 1])
end; elseif Enum <= 25 then if Enum <= 23 then if Enum == 22 then Stk[Inst[2]][Stk[Inst[3]]]=Stk[Inst[4]];else local B=Inst[3];local K=Stk[B] for Idx=B+1,Inst[4] do K=K..Stk[Idx];end;Stk[Inst[2]]=K;end; elseif Enum == 24 then Stk[Inst[2]] = Stk[Inst[3]] * Inst[4];else Stk[Inst[2]] = Inst[3];end; elseif Enum <= 27 then if Enum == 26 then InstrPoint=Inst[3];else Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];end; elseif Enum > 28 then Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];else if (Stk[Inst[2]]<Stk[Inst[4]])then InstrPoint=Inst[3]; else InstrPoint=InstrPoint+1; end;end; elseif Enum <= 44 then if Enum <= 36 then if Enum <= 32 then if Enum <= 30 then Stk[Inst[2]] = Stk[Inst[3]] * Inst[4]; elseif Enum > 31 then Stk[Inst[2]]=Stk[Inst[3]]+Stk[Inst[4]];else Stk[Inst[2]]={};end; elseif Enum <= 34 then if Enum > 33 then Stk[Inst[2]]=Stk[Inst[3]]-Stk[Inst[4]];else 
local A = Inst[2];
local Step = Stk[A + 2];
local Index = Stk[A] + Step;
Stk[A] = Index;
if (Step > 0) then 
	if (Index <= Stk[A+1]) then
		InstrPoint = Inst[3];
		Stk[A+3] = Index;
	end
elseif (Index >= Stk[A+1]) then
	InstrPoint = Inst[3];
	Stk[A+3] = Index;
end
end; elseif Enum == 35 then 
local A = Inst[2];
local Step = Stk[A + 2];
local Index = Stk[A] + Step;
Stk[A] = Index;
if (Step > 0) then 
	if (Index <= Stk[A+1]) then
		InstrPoint = Inst[3];
		Stk[A+3] = Index;
	end
elseif (Index >= Stk[A+1]) then
	InstrPoint = Inst[3];
	Stk[A+3] = Index;
end
else Stk[Inst[2]]=Stk[Inst[3]]+Stk[Inst[4]];end; elseif Enum <= 40 then if Enum <= 38 then if Enum == 37 then Stk[Inst[2]]=Env[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]] = Inst[3];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]] = Inst[3];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Env[Inst[3]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];InstrPoint = InstrPoint + 1;Inst = Instr[InstrPoint];Stk[Inst[2]]=Env[Inst[3]];else InstrPoint=Inst[3];end; elseif Enum == 39 then Top=Inst[2];else do return end;end; elseif Enum <= 42 then if Enum == 41 then 
local A = Inst[2]
Stk[A] = Stk[A](Stk[A + 1]) 
else 
local A = Inst[2]
Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3])) 
end; elseif Enum == 43 then if (Inst[2] < Stk[Inst[4]]) then InstrPoint=Inst[3]; else InstrPoint=InstrPoint+1; end;else 
local A = Inst[2];
local Index = Stk[A]
local Step = Stk[A + 2];
if (Step > 0) then 
	if (Index > Stk[A+1]) then
		InstrPoint = Inst[3];
	else
		Stk[A+3] = Index;
	end
elseif (Index < Stk[A+1]) then
	InstrPoint = Inst[3];
else
	Stk[A+3] = Index;
end
end; elseif Enum <= 52 then if Enum <= 48 then if Enum <= 46 then if Enum == 45 then do return end;else if (Inst[2] < Stk[Inst[4]]) then InstrPoint=Inst[3]; else InstrPoint=InstrPoint+1; end;end; elseif Enum == 47 then 
local A = Inst[2];
local Index = Stk[A]
local Step = Stk[A + 2];
if (Step > 0) then 
	if (Index > Stk[A+1]) then
		InstrPoint = Inst[3];
	else
		Stk[A+3] = Index;
	end
elseif (Index < Stk[A+1]) then
	InstrPoint = Inst[3];
else
	Stk[A+3] = Index;
end
else Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];end; elseif Enum <= 50 then if Enum > 49 then Stk[Inst[2]]=Stk[Inst[3]] - Inst[4];else Stk[Inst[2]][Stk[Inst[3]]]=Stk[Inst[4]];end; elseif Enum > 51 then Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];else local B=Inst[3];local K=Stk[B] for Idx=B+1,Inst[4] do K=K..Stk[Idx];end;Stk[Inst[2]]=K;end; elseif Enum <= 56 then if Enum <= 54 then if Enum > 53 then Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];else if(Inst[2] < Stk[Inst[4]])then InstrPoint=InstrPoint+1;else InstrPoint=Inst[3];end;end; elseif Enum == 55 then if(Stk[Inst[2]]~=Stk[Inst[4]])then InstrPoint=InstrPoint+1;else InstrPoint=Inst[3];end;else Stk[Inst[2]]=Stk[Inst[3]]-Stk[Inst[4]];end; elseif Enum <= 58 then if Enum == 57 then Stk[Inst[2]]=Env[Inst[3]];else Stk[Inst[2]]=#Stk[Inst[3]];end; elseif Enum > 59 then Stk[Inst[2]]=Stk[Inst[3]][Stk[Inst[4]]];else Stk[Inst[2]]=Stk[Inst[3]] - Inst[4];end;
			InstrPoint	= InstrPoint + 1;
		end;
    end;
end;	
return Wrap(Deserialize(), {}, GetFEnv())();
