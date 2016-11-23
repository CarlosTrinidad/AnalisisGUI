% clear all
data = xlsread('C:\Users\Carlos\Documents\Proyecto Temas\Region_data_2.xlsx');
class = {
'chacci der';
'chacci der';
'chacci der';
'chacci der';
'chacci der';
'chacci der';
'chacci der';
'chacci der';
'chacci izq';
'chacci izq';
'chacci izq';
'chacci izq';
'chacci izq';
'chacci izq';
'chacci izq';
'chacci izq';
'mero der';
'mero der';
'mero der';
'mero der';
'mero der';
'mero der';
'mero der';
'mero der';
'mero izq';
'mero izq';
'mero izq';
'mero izq';
'mero izq';
'mero izq';
'mero izq'
};
% gplotmatrix(data(:,[1 2]),data(:,5),class);
figure
gplotmatrix(data(:,1),data(:,2), class);
% gplotmatrix(data(:,6),data(:,2), class);
% gplotmatrix(data(:,10),data(:,2), class);