function varargout = final1(varargin)
% FINAL1 MATLAB code for final1.fig
%      FINAL1, by itself, creates a new FINAL1 or raises the existing
%      singleton*.
%
%      H = FINAL1 returns the handle to a new FINAL1 or the handle to
%      the existing singleton*.
%
%      FINAL1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL1.M with the given input arguments.
%
%      FINAL1('Property','Value',...) creates a new FINAL1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help final1

% Last Modified by GUIDE v2.5 19-Mar-2020 19:29:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final1_OpeningFcn, ...
                   'gui_OutputFcn',  @final1_OutputFcn, ...
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


% --- Executes just before final1 is made visible.
function final1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final1 (see VARARGIN)

% Choose default command line output for final1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes final1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final1_OutputFcn(hObject, eventdata, handles) 
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

%% Segmentation

load PO

% Color Segmentation

NM=rgb2ycbcr(NR);
NM1=NM(:,:,1);
axes(handles.axes1);
imshow(NM);
title('Color Segmentation');

% Thresholding and Morphological Operation

SE1=strel('square',2);
IC1=imclose(NM1,SE1);
IF1=imfill(IC1,'holes');
diff_img=imsubtract(IF1,IC1);
level1=graythresh(diff_img);
I2=im2bw(diff_img,level1);
axes(handles.axes2);
imshow(I2);
title('Initial Segmentation');

I2 = ExtractNLargestBlobs(I2, 2);
I2=bwareaopen(I2,300);
I2=imfill(I2,'holes');

axes(handles.axes3);
imshow(I2);
title('Final Cancer Cell Nucleus Region Detection');

b = bwboundaries(I2);
axes(handles.axes4);
imshow((F));
title('Cancer Cell Nucleus Detection Result');
hold on
for area_N = 1:numel(b)
    plot(b{area_N}(:,2), b{area_N}(:,1), 'r', 'Linewidth', 2)
end 


T1=F(:,:,1);
T2=F(:,:,2);
T3=F(:,:,3);

T1(~I2)=0;
T2(~I2)=0;
T3(~I2)=0;

NDR=cat(3,T1,T2,T3);
axes(handles.axes5);
imshow(NDR);
title('Nucleus Region Extracted Result');

save('SR.mat','NDR');

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
final2
