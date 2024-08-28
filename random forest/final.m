function varargout = final(varargin)
% FINAL MATLAB code for final.fig
%      FINAL, by itself, creates a new FINAL or raises the existing
%      singleton*.
%
%      H = FINAL returns the handle to a new FINAL or the handle to
%      the existing singleton*.
%
%      FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL.M with the given input arguments.
%
%      FINAL('Property','Value',...) creates a new FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help final

% Last Modified by GUIDE v2.5 19-Mar-2020 21:36:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final_OpeningFcn, ...
                   'gui_OutputFcn',  @final_OutputFcn, ...
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


% --- Executes just before final is made visible.
function final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final (see VARARGIN)

% Choose default command line output for final
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Read Test Image 

[filename,pathname] = uigetfile('*.jpg;*.tiff;*.png;*.jpeg;*.bmp;*.pgm;*.gif','pick an imgae');
file = fullfile(pathname,filename);

   F = imread(file);
F=imresize(F,[480 640]);
axes(handles.axes1);
imshow(F);
title('Test Image');

handles.F=F;

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

F=handles.F;

%% Preprocessing

% Image Normalization

% Multiscale Image decomposition - WLS Decomposition 

I=double(F)/255;

% This is our Smoothed image 

[height, width, channel] = size(I);
    
       M = [];
        for k=1:channel
            % ex, localExtrema(I, 3)
            C = I(:, :, k);
        
            M(:, :, k) = wlsFilter(C, 0.125, 0.8);
            
        end
                      
% Construct illumination (Detail layer) based on Input image and smoothed image 
 
 D = I./M;

reflectance=M;
Illumination=D;

% Illumination Adjustment

L=( Illumination);
la=(L ) .^ (1 / 2.2);

X=(reflectance).*la;

axes(handles.axes2);
imshow(X);
title('Normalized Result');

%% Contrast Enhancement 

Heq1 = adapthisteq(X(:,:,1),'clipLimit',0.0005);
Heq2 = adapthisteq(X(:,:,2),'clipLimit',0.0005);
Heq3 = adapthisteq(X(:,:,3),'clipLimit',0.0005);
Heq=cat(3,Heq1,Heq2,Heq3);

axes(handles.axes3);
imshow(Heq);
title('Contrast Enhancement Result');


%% Noise Removal

NR1=medfilt2(Heq(:,:,1));
NR2=medfilt2(Heq(:,:,2));
NR3=medfilt2(Heq(:,:,3));
NR=cat(3,NR1,NR2,NR3);

axes(handles.axes4);
imshow(NR);
title('Noise Removal Result');

save('PO.mat','NR','F');

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
final1
