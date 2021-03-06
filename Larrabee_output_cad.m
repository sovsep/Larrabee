%--------------------------------
%	SolidWorks用にファイル出力
%--------------------------------
%SolidWorks用にファイルを作る予定。

% 翼型datファイルの読み込み
% 翼型はairfoil/の中に入れる
% airfoil[x座標,y座標]:size(airfoil) = 2 many
fp=fopen('airfoil/dae51.dat');
airfoil=fgetl(fp);
airfoil=(fscanf(fp,'%f',[2,200]))';
fclose(fp);

%複数翼型に対応予定
fp = fopen('airfoil/geminism.dat');
airfoil_2 = fgetl(fp);
airfoil_2 = (fscanf(fp,'%f',[2,200]))';
fclose(fp);


%簡単のため行列計算からベクトル計算にするためにx,yに分ける
airfoil_x = airfoil(:,1);
airfoil_y = airfoil(:,2);
% 位置rによるairfoilのベクトル作りここを分割にしたい
airfoil_x = airfoil_x * linspace(1,1,length(r));
airfoil_y = airfoil_y * linspace(1,1,length(r));
%前縁から空力中心の位置に平行移動 airfoil_i[length(airfoil),length(r)]
airfoil_x = airfoil_x + 0.25;
%角度変化とコード長に合わせて大きさ変化 deformation_i[1,length(r)]
deformation_x = chord .* cos(beta);
deformation_y = chord .* sin(beta);
%位置rの断面の形状[length(airfoil),length(r)]
for i = 1:1:length(airfoil)
	cross_section_x(i,:) = airfoil_x(i,:) .* deformation_x;
	cross_section_y(i,:) = airfoil_y(i,:) .* deformation_y;
end

%cross_section[many,3] (x,y,r)
for i = 1:1:length(r)
	for j = 1:1:length(airfoil)
		cross_section((i-1)*length(airfoil)+j,1) = cross_section_x(j,i);
		cross_section((i-1)*length(airfoil)+j,2) = cross_section_y(j,i);
		cross_section((i-1)*length(airfoil)+j,3) = r(i);
	end
end

%フィイル書き出し----
%cad_filename = 'CADfile';
%fid = fopen(cad_filename, 'wt');
%for i = 1:1:length(airfoil)
%	fprintf(fid,'%f,%f,%f\n',cross_section(i,1),cross_section(i,2),cross_section(i,3),);
%end
%fclose(fid);


