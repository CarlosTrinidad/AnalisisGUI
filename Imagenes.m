function varargout = Imagenes(varargin)
% IMAGENES MATLAB code for Imagenes.fig
%      IMAGENES, by itself, creates a new IMAGENES or raises the existing
%      singleton*.
%
%      H = IMAGENES returns the handle to a new IMAGENES or the handle to
%      the existing singleton*.
%
%      IMAGENES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGENES.M with the given input arguments.
%
%      IMAGENES('Property','Value',...) creates a new IMAGENES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Imagenes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Imagenes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Imagenes

% Last Modified by GUIDE v2.5 05-Nov-2016 18:06:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Imagenes_OpeningFcn, ...
                   'gui_OutputFcn',  @Imagenes_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Imagenes is made visible.
function Imagenes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Imagenes (see VARARGIN)

% Choose default command line output for Imagenes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Imagenes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Imagenes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in importBtn.
function importBtn_Callback(hObject, eventdata, handles)
% hObject    handle to importBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nombreArchivo, ubicacionArchivo] = uigetfile({'*.jpg;*.tif;*.png;*.gif;*.dcm'}, 'Seleccionar imagen');
imagenArchivo = '';
imagenGray = '';
if( nombreArchivo ~= 0)
    [~,~,ext] = fileparts(nombreArchivo);
    if(strcmp(ext,'.dcm'))
        imagenArchivo = dicomread(strcat(ubicacionArchivo, nombreArchivo));
        imshow(imagenArchivo(:,:,1,1));
        title(nombreArchivo);
        axis image
    else
        imagenArchivo = imread(strcat(ubicacionArchivo, nombreArchivo));
        if size(imagenArchivo,3) == 3 
            imagenGray = rgb2gray(imagenArchivo);
        else
            imagenGray = imagenArchivo;
        end       

    end
end
set(handles.disRES, 'String', '...');

if isfield(handles,'imagenBIN')
    handles = rmfield(handles,'imagenBIN');
end


  handles.nameFile = nombreArchivo;
  handles.imagenGray=imagenGray;
  handles.imagenGray_mod = handles.imagenGray;
  guidata(hObject,handles);
  axes(handles.histogram);
  imhist(imagenGray);
  axes(handles.imgPreGray);
  imshow(imagenGray);
  title('En escala de grises');
  axis image        
        
  axes(handles.imgPreview);
  imshow(imagenArchivo);
  title(nombreArchivo);
  axis image

% Ajustar brillo
%ajustar contrste
%ecualizar


% --- Executes on slider movement.
function sdBrillo_Callback(hObject, eventdata, handles)
% hObject    handle to sdBrillo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
imagenGray=handles.imagenGray;

valBrillo = get(handles.sdBrillo, 'Value');
 imagenGray = imagenGray + valBrillo;
 
 handles.imagenGray_mod=imagenGray;
    guidata(hObject,handles);
 
  axes(handles.histogram);
  imhist(imagenGray);
  axes(handles.imgPreGray);
  imshow(imagenGray);
  title('En escala de grises');
  axis image        
        



% --- Executes during object creation, after setting all properties.
function sdBrillo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sdBrillo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sdContrast_Callback(hObject, eventdata, handles)
% hObject    handle to sdContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
imagenGray=handles.imagenGray;

valContrast = get(handles.sdContrast, 'Value');
 imagenGray = imagenGray .* valContrast;
 
 handles.imagenGray_mod=imagenGray;
 guidata(hObject,handles);
 
  axes(handles.histogram);
  imhist(imagenGray);
  axes(handles.imgPreGray);
  imshow(imagenGray);
  title('En escala de grises');
  axis image

% --- Executes during object creation, after setting all properties.
function sdContrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sdContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in equBtn.
function equBtn_Callback(hObject, eventdata, handles)
% hObject    handle to equBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagenGray=handles.imagenGray;
 imagenGray = histeq(imagenGray);
 handles.imagenGray_mod=imagenGray;
 guidata(hObject,handles);
 
  axes(handles.histogram);
  imhist(imagenGray);
  axes(handles.imgPreGray);
  imshow(imagenGray);
  title('En escala de grises');
  axis image


% --- Executes during object creation, after setting all properties.
function histogram_CreateFcn(hObject, eventdata, handles)
% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate histogram


% --- Executes on button press in binBtn.
function binBtn_Callback(hObject, eventdata, handles)
% hObject    handle to binBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imagenGray=handles.imagenGray;

if isfield(handles,'imagenGray_mod')
    imagenGray=handles.imagenGray_mod;
end

% [y,x,~] = size(imagenGray);
isq = graythresh(imagenGray);
Is = im2bw(imagenGray,isq);
% [Is2, num1] = bwlabel(Is,4);
% Is2 = uint8(Is2);
% % imagesc(Is2);
% max_val = 0;
% max_ind = 0;
% for i=1:num1
%     ind_etq = find(Is2==i);
%     img = zeros(y,x);
%     img(ind_etq)=255;
%     
%     val = bwarea(img);
%     if (val > max_val)
%         max_ind = i;
%         max_val = val;
%     end
% end
% 
% ind_etq = find(Is2==max_ind);
% img = zeros(y,x);
% img(ind_etq)=255;
img = filtroArea(Is);
handles.imagenBIN = img;
guidata(hObject,handles);

figure
imshow(img);


% --- Executes on button press in rstBtn.
function rstBtn_Callback(hObject, eventdata, handles)
% hObject    handle to rstBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.imagenGray_mod = handles.imagenGray;
guidata(hObject,handles);
set(handles.sdBrillo, 'value', 0);
set(handles.sdContrast, 'value', 0);

  axes(handles.imgPreGray);
  imshow(handles.imagenGray_mod);
  imagenGray = handles.imagenGray_mod;
  axes(handles.histogram);
  imhist(imagenGray);


% --- Executes on button press in classifyBtn.
function classifyBtn_Callback(hObject, eventdata, handles)
% hObject    handle to classifyBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%obtiene los datos necesarios de la imagen y se almacenan en un vector
load('network.mat');
img = handles.imagenBIN;
 stats = regionprops(logical(img), 'centroid','Eccentricity','Extent','BoundingBox','MajorAxisLength','MinorAxisLength');
    centroids = cat(1, stats.Centroid);
    img_iz = img;
    img_de = img;
    img_de(:,1:centroids(:,1)) = 0;
    img_iz(:,centroids(:,1):end) = 0;
    
    %Filtrar imagenes por area
    img_iz = filtroArea(img_iz);
    img_de = filtroArea(img_de); 
    
    stats_iz = regionprops(logical(img_iz), 'centroid','Eccentricity','Extent');
    stats_de = regionprops(logical(img_de), 'centroid','Eccentricity','Extent');
 
    diference_iz_de = stats_de.Extent - stats_iz.Extent;
    data_calssify = [stats.Eccentricity; diference_iz_de];
    
    % clasify_new_value

W = net(data_calssify);
classes2 = vec2ind(W);

switch classes2
    case 1
        disp('Mero izquierdo');
        set(handles.disRES, 'String', 'Mero izquierdo');

    case 2
        disp('Mero derecho');
        set(handles.disRES, 'String', 'Mero derecho');

    case 3
        disp('Chacci derecho');
        set(handles.disRES, 'String', 'Chac chi derecho');

    case 4
        disp('Chacci izquierdo');
        set(handles.disRES, 'String', 'Chac chi izquierdo');

    otherwise
        disp('Error');
        set(handles.disRES, 'String', 'Ha ocurrido un error :(');
end


% --- Executes on selection change in drpdown1.
function drpdown1_Callback(hObject, eventdata, handles)
% hObject    handle to drpdown1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns drpdown1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from drpdown1


% --- Executes during object creation, after setting all properties.
function drpdown1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to drpdown1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in validateBtn.
function validateBtn_Callback(hObject, eventdata, handles)
% hObject    handle to validateBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(handles.drpdown1,'String');
drpdown1_value = get(handles.drpdown1,'Value');
drpdown1_string = contents{get(handles.drpdown1,'Value')};

I=handles.imagenGray;

if isfield(handles,'imagenGray_mod')
    I=handles.imagenGray_mod;
end
BW = imbinarize(I);

if isfield(handles,'imagenBIN')
    BW = handles.imagenBIN;
end


switch drpdown1_value
    case 1
%         Firma
%         BW = handles.imagenBIN;
%         BW = imbinarize(I);
        [B,L] = bwboundaries(BW,'noholes');  
        stats = regionprops(bwlabel(BW), 'centroid','Eccentricity');
        centroids = cat(1, stats.Centroid);
        for k = 1:length(B)
            boundary = B{k};
            x1 = [boundary(:,2), boundary(:,1)];
            y1 = [centroids(:,1),centroids(:,2)];
            x = pdist2(x1,y1);
        end
        figure
        plot(x)
        title({drpdown1_string; handles.nameFile});
        xlabel('Muestra')
        ylabel('Distancia')

    case 2
%         Borde/Centroide
%         BW = imbinarize(I);
%         BW = handles.imagenBIN;        
        [B,L] = bwboundaries(BW,'noholes');  
        
        stats = regionprops(bwlabel(BW), 'centroid','Eccentricity');
        centroids = cat(1, stats.Centroid);        
        figure
        title({drpdown1_string; handles.nameFile});
        imshow(I)
        hold on
        plot(centroids(:,1),centroids(:,2), 'b*')

        for k = 1:length(B)
           boundary = B{k};
           plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
        end
        hold off
    case 3
        % EJES
%          BW = imbinarize(I);
%         BW = handles.imagenBIN;
        [B,L] = bwboundaries(BW,'noholes');  
        figure
        title({drpdown1_string; handles.nameFile});
        imshow(I)
        hold on
        stats = regionprops(bwlabel(BW), 'centroid','Orientation','MajorAxisLength','MinorAxisLength');
        xMajor=stats.Centroid(1) + [-1 1]*(stats.MajorAxisLength/2)*cosd(stats.Orientation);
        yMajor=stats.Centroid(2) + [-1 1]*(stats.MajorAxisLength/2)*sind(stats.Orientation);

        xMinor=stats.Centroid(1) + [-1 1]*(stats.MinorAxisLength/2)*sind(stats.Orientation);
        yMinor=stats.Centroid(2) - [-1 1]*(stats.MinorAxisLength/2)*cosd(stats.Orientation);
        line(xMajor,yMajor);
        line(xMinor,yMinor);
        hold off
    case 4
%         BoundingBox
        img = BW;
        stats = regionprops(logical(img), 'centroid','Eccentricity','Extent','BoundingBox','MajorAxisLength','MinorAxisLength');
        centroids = cat(1, stats.Centroid);
        img_iz = img;
        img_de = img;
        img_de(:,1:centroids(:,1)) = 0;
        img_iz(:,centroids(:,1):end) = 0;

        %Filtrar imagenes por area
        img_iz = filtroArea(img_iz);
        img_de = filtroArea(img_de); 

        figure
        imshow(bwlabel(img))
        hold on
        plot(centroids(:,1),centroids(:,2), 'b*')
        rectangle('Position',stats.BoundingBox ,...
	'EdgeColor','r', 'LineWidth', 3)
        hold off

        stats_iz = regionprops(logical(img_iz), 'centroid','Eccentricity','Extent','BoundingBox','MajorAxisLength','MinorAxisLength');
        stats_de = regionprops(logical(img_de), 'centroid','Eccentricity','Extent','BoundingBox','MajorAxisLength','MinorAxisLength');
%         IZQUIERDA
        figure
        imshow(bwlabel(img_iz))
        hold on
        plot(centroids(:,1),centroids(:,2), 'b*')
        rectangle('Position',stats_iz.BoundingBox ,...
	'EdgeColor','g', 'LineWidth', 3)
        hold off
%         DERECHA 
        figure
        imshow(bwlabel(img_de))
        hold on
        plot(centroids(:,1),centroids(:,2), 'b*')
        rectangle('Position',stats_de.BoundingBox ,...
	'EdgeColor','b', 'LineWidth', 3)
        hold off
        
    case 5
        
        
    otherwise
        
end
