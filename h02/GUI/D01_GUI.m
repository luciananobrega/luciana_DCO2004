function varargout = D01_GUI(varargin)
% D01_GUI M-file for D01_GUI.fig
%      D01_GUI, by itself, creates a new D01_GUI or raises the existing
%      singleton*.

% Edit the above text to modify the response to help D01_GUI

% Last Modified by GUIDE v2.5 21-Aug-2017 17:26:35

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

% --- Executes on button press in DoButton.
function DoButton_Callback(hObject, eventdata, handles)
global t
global y

[t,y] = play_and_plot(1);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);

% --- Executes on button press in DoSusButton.
function DoSusButton_Callback(hObject, eventdata, handles)

global t
global y

[t,y] = play_and_plot(1.059);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);

% --- Executes on button press in ReButton.
function ReButton_Callback(hObject, eventdata, handles)

global t
global y

[t,y] = play_and_plot(9/8);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);

% --- Executes on button press in ReSusButton.
function ReSusButton_Callback(hObject, eventdata, handles)
global t
global y

[t,y] = play_and_plot(1.189);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);

% --- Executes on button press in MiButton.
function MiButton_Callback(hObject, eventdata, handles)
global t
global y

[t,y] = play_and_plot(5/4);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);

% --- Executes on button press in FaButton.
function FaButton_Callback(hObject, eventdata, handles)

global t
global y

[t,y] = play_and_plot(4/3);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);


% --- Executes on button press in FaSusButton.
function FaSusButton_Callback(hObject, eventdata, handles)
global t
global y

[t,y] = play_and_plot(1.414);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);

% --- Executes on button press in SolButton.
function SolButton_Callback(hObject, eventdata, handles)
global t
global y

[t,y] = play_and_plot(3/2);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);


% --- Executes on button press in SolSusButton.
function SolSusButton_Callback(hObject, eventdata, handles)

global t
global y

[t,y] = play_and_plot(1.587);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);

% --- Executes on button press in LaButton.
function LaButton_Callback(hObject, eventdata, handles)
global t
global y

[t,y] = play_and_plot(5/3);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);


% --- Executes on button press in LaSusButton.
function LaSusButton_Callback(hObject, eventdata, handles)

global t
global y

[t,y] = play_and_plot(1.782);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);



% --- Executes on button press in SiButton.
function SiButton_Callback(hObject, eventdata, handles)
global t
global y

[t,y] = play_and_plot(15/8);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);


% --- Executes on button press in Do2Button.
function Do2Button_Callback(hObject, eventdata, handles)
global t
global y

[t,y] = play_and_plot(2);

axes(handles.axes1)
plot(t, y)
axis([0 0.02 -1.5 1.5 ]);
