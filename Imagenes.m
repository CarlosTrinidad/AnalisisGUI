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

% Last Modified by GUIDE v2.5 27-Aug-2016 00:03:52

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
    handles.imagenGray=imagenGray;
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
