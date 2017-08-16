function varargout = D01_GUI(varargin)
%D01_GUI M-file for D01_GUI.fig
%      D01_GUI, by itself, creates a new D01_GUI or raises the existing
%      singleton*.

% Edit the above text to modify the response to help D01_GUI

% Last Modified by GUIDE v2.5 15-Aug-2017 17:21:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @D01_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @D01_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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

% Variáveis
tf = 1;                   % Tempo de duração da nota
fc = 512;                 % Frequência da nota Dó
fs = 100*fc;              % Frequência de amostragem da nota. 
t = 0:1/fs:tf;            % Vetor tempo. Para cada elemento do vetor t, haverá um elemento em y correspondente.
A = 1;                    % Amplitude do sinal


% --- Executes just before D01_GUI is made visible.
function D01_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for D01_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes D01_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = D01_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ReButton_Callback(hObject, eventdata, handles)



function DoButton_Callback(hObject, eventdata, handles)


function DoSusButton_Callback(hObject, eventdata, handles)




function MiButton_Callback(hObject, eventdata, handles)



function ReSusButton_Callback(hObject, eventdata, handles)




function FaButton_Callback(hObject, eventdata, handles)
% hObject    handle to FaButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SolButton.
function SolButton_Callback(hObject, eventdata, handles)
% hObject    handle to SolButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in FaSusButton.
function FaSusButton_Callback(hObject, eventdata, handles)
% hObject    handle to FaSusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in LaButton.
function LaButton_Callback(hObject, eventdata, handles)
% hObject    handle to LaButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SolSusButton.
function SolSusButton_Callback(hObject, eventdata, handles)
% hObject    handle to SolSusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SiButton.
function SiButton_Callback(hObject, eventdata, handles)
% hObject    handle to SiButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in LaSusButton.
function LaSusButton_Callback(hObject, eventdata, handles)
% hObject    handle to LaSusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Do2Button.
function Do2Button_Callback(hObject, eventdata, handles)
% hObject    handle to Do2Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
