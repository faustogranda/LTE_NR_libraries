function y = DemodulatorHard(u, Mode)
% The function takes as inputs the received modulated symbols (u) 
% and the modulation mode (Mode)
% Mode 4 - QPSK LTE based modulation
% Mode 16 - QAM16 LTE based modulation
% Mode 64 - QAM64 LTE based modulation
% Mode 256 - QAM256 LTE based modulation
%% Initialization
persistent qpsk qam16 qam64 qam256

if isempty(qpsk)
  qpsk = comm.PSKDemodulator('ModulationOrder', 4, 'BitOutput', true, ... 
    'PhaseOffset', pi/4, 'SymbolMapping', 'Custom', ...
    'CustomSymbolMapping', [0 2 3 1]);

  qam16 = comm.RectangularQAMDemodulator('ModulationOrder',16, ...
    'BitOutput',true,'NormalizationMethod','Average power', ...
    'SymbolMapping', 'Custom', ... 
    'CustomSymbolMapping',[11 10 14 15 9 8 12 13 1 0 4 5 3 2 6 7]);

  qam64 = comm.RectangularQAMDemodulator('ModulationOrder',64, ...
    'BitOutput',true,'NormalizationMethod','Average power', ...
    'SymbolMapping','Custom','CustomSymbolMapping', [47 46 42 43 59 58 ...
    62 63 45 44 40 41 57 56 60 61 37 36 32 33 49 48 52 53 39 38 34 35 ...
    51 50 54 55 7 6 2 3 19 18 22 23 5 4 0 1 17 16 20 21 13 12 8 9 25 ...
    24 28 29 15 14 10 11 27 26 30 31]);

  qam256 = comm.RectangularQAMDemodulator('ModulationOrder',256, ...
    'BitOutput',true,'NormalizationMethod','Average power', ...
    'SymbolMapping','Custom',...
    'CustomSymbolMapping', [191 190 186 187 171 170 174 175 239 238 234 ...
    235 251 250 254 255 189 188 184 185 169 168 172 173 237 236 232 233 ...
    249 248 252 253 181 180 176 177 161 160 164 165 229 228 224 225 241 ...
    240 244 245 183 182 178 179 163 162 166 167 231 230 226 227 243 242 ...
    246 247 151 150 146 147 131 130 134 135 199 198 194 195 211 210 214 ...
    215 149 148 144 145 129 128 132 133 197 196 192 193 209 208 212 213 ...
    157 156 152 153 137 136 140 141 205 204 200 201 217 216 220 221 159 ...
    158 154 155 139 138 142 143 207 206 202 203 219 218 222 223 31 30 ...
    26 27 11 10 14 15 79 78 74 75 91 90 94 95 29 28 24 25 9 8 12 13 77 ...
    76 72 73 89 88 92 93 21 20 16 17 1 0 4 5 69 68 64 65 81 80 84 85 23 ...
    22 18 19 3 2 6 7 71 70 66 67 83 82 86 87 55 54 50 51 35 34 38 39 ...
    103 102 98 99 115 114 118 119 53 52 48 49 33 32 36 37 101 100 96 97 ...
    113 112 116 117 61 60 56 57 41 40 44 45 109 108 104 105 121 120 124 ...
    125 63 62 58 59 43 42 46 47 111 110 106 107 123 122 126 127]);
end
%% processing
switch Mode 
    case 4
        y = qpsk.step(u);
    case 16
        y = qam16.step(u);
    case 64
        y = qam64.step(u);
    case 256
        y = qam256.step(u);   
    otherwise
        error('Invalid Modulation Mode. Use {4,16,64, or 256}')
end

