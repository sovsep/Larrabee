%--------------------------------
%	翼型読み込みと定義
%--------------------------------
%var_Re.matファイルからReを読み込む
%Cd = f(Re,Cl),alpha = f(Re,Cl)と考え、
% readXFLRで読み込んだdata_matから必要なデータを補間
load var_Re.mat;			%変数Reを前の計算から読み込み

% tic
for k = 1:length(r)
Cd(k) = Re_lookup(Re(k),Cl(k),1,data_mat);
alpha_deg(k) = Re_lookup(Re(k),Cl(k),2,data_mat);
end
% toc

alpha = alpha_deg .* pi/180;		%迎え角α[rad]
DL = Cd ./ Cl;						%D/L：揚抗比の逆数
Tc = 2*T / (rho*V^2*pi*R^2);		%推力係数Tc
