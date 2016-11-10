function [ new_img ] = filtroArea( img_in )
%UNTITLED2 Summary of this function goes here
%  Input:
%     img_in: Imagen binaria que se desea filtrar
%  Output:
%     new_img: Imagen binaria filtrada

[y,x,~] = size(img_in);
Is = img_in;
[Is2, num1] = bwlabel(Is,4);
Is2 = uint8(Is2);
% imagesc(Is2);
max_val = 0;
max_ind = 0;
for i=1:num1
    ind_etq = find(Is2==i);
    img = zeros(y,x);
    img(ind_etq)=255;
    
    val = bwarea(img);
    if (val > max_val)
        max_ind = i;
        max_val = val;
    end
end

ind_etq = find(Is2==max_ind);
img = zeros(y,x);
img(ind_etq)=255;
new_img = img;
end

