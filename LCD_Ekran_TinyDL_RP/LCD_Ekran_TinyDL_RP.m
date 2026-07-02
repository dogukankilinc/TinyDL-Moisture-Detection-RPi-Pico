classdef LCD_Ekran_TinyDL_RP < matlab.System ...
        & coder.ExternalDependency ...
        & matlabshared.sensors.simulink.internal.BlockSampleTime

    % TinyDL I2C LCD Ekran
    %#codegen
    %#ok<*EMCA>

    properties

    end

    properties(Access = protected)
        Logo = 'IO Device Builder';
    end

    properties (Nontunable)
        I2C_Address(:,:) {mustBeData(I2C_Address,'int8'),mustBeSize(I2C_Address,[1,1])} = int8(39);
    end

    properties (Access = private)


    end

    methods
        % Constructor
        function obj = LCD_Ekran_TinyDL_RP(varargin)
            setProperties(obj,nargin,varargin{:});
        end
    end

    methods (Access=protected)
        function setupImpl(obj)
            if coder.target('RtwForRapid')
                % Rapid Accelerator. In this mode, coder.target('Rtw')
                % returns true as well, so it is important to check for
                % 'RtwForRapid' before checking for 'Rtw'

                %pass
            elseif ~coder.target('MATLAB')
                coder.cinclude('LCD_Ekran_TinyDL_RP.h');
                coder.ceval('setupFunctionLCD_Ekran_TinyDL_RP', (obj.I2C_Address),1);
            end
        end

        function validateInputsImpl(obj,varargin)
            %  Check the input size
            if nargin ~=0

                validateattributes(varargin{1},{'double'},{'2d','size',[1,1]},'','AI_Tahmin');

            end
        end

        function  stepImpl(obj ,AI_Tahmin)

            if isempty(coder.target)
            elseif coder.target('RtwForRapid')
                % Rapid Accelerator. In this mode, coder.target('Rtw')
                % returns true as well, so it is important to check for
                % 'RtwForRapid' before checking for 'Rtw'

                %pass
            else
                coder.ceval('stepFunctionLCD_Ekran_TinyDL_RP', AI_Tahmin,1);
            end
        end

        function releaseImpl(obj)
            if isempty(coder.target)
            elseif coder.target('RtwForRapid')
                % Rapid Accelerator. In this mode, coder.target('Rtw')
                % returns true as well, so it is important to check for
                % 'RtwForRapid' before checking for 'Rtw'

                %pass
            else

            end
        end
    end

    methods (Access=protected)
        %% Define output properties
        function num = getNumInputsImpl(~)
            num = 1;
        end

        function num = getNumOutputsImpl(~)
            num = 0;
        end

        function varargout = getInputNamesImpl(obj)
            varargout{1} = 'AI_Tahmin';

        end

        function varargout = getOutputNamesImpl(obj)

        end

        function flag = isOutputSizeLockedImpl(~,~)
            flag = true;
        end

        function varargout = isOutputFixedSizeImpl(~,~)

        end

        function varargout = isOutputComplexImpl(~)

        end

        function varargout = getOutputSizeImpl(~)

        end

        function varargout = getOutputDataTypeImpl(~)

        end

        function maskDisplayCmds = getMaskDisplayImpl(obj)
            outport_label = [];
            num = getNumOutputsImpl(obj);
            if num > 0
                outputs = cell(1,num);
                [outputs{1:num}] = getOutputNamesImpl(obj);
                for i = 1:num
                    outport_label = [outport_label 'port_label(''output'',' num2str(i) ',''' outputs{i} ''');' ]; %#ok<AGROW>
                end
            end
            inport_label = [];
            num = getNumInputsImpl(obj);
            if num > 0
                inputs = cell(1,num);
                [inputs{1:num}] = getInputNamesImpl(obj);
                for i = 1:num
                    inport_label = [inport_label 'port_label(''input'',' num2str(i) ',''' inputs{i} ''');' ]; %#ok<AGROW>
                end
            end
            icon = 'LCD_Ekran_TinyDL_RP';
            maskDisplayCmds = [ ...
                ['color(''white'');',...
                'plot([100,100,100,100]*1,[100,100,100,100]*1);',...
                'plot([100,100,100,100]*0,[100,100,100,100]*0);',...
                'color(''blue'');', ...
                ['text(38, 92, ','''',obj.Logo,'''',',''horizontalAlignment'', ''right'');',newline],...
                'color(''black'');'], ...
                ['text(52,50,' [''' ' icon ''',''horizontalAlignment'',''center'');' newline]]   ...
                inport_label ...
                outport_label
                ];
        end

        function sts = getSampleTimeImpl(obj)
            sts = getSampleTimeImpl@matlabshared.sensors.simulink.internal.BlockSampleTime(obj);
        end
    end

    methods (Static, Access=protected)
        function simMode = getSimulateUsingImpl(~)
            simMode = 'Interpreted execution';
        end

        function isVisible = showSimulateUsingImpl
            isVisible = false;
        end
    end

    methods (Static)
        function name = getDescriptiveName(~)
            name = 'LCD_Ekran_TinyDL_RP';
        end

        function tf = isSupportedContext(~)
            tf = true;
        end

        function updateBuildInfo(buildInfo, context)
            coder.extrinsic('codertarget.targethardware.getTargetHardware');
            isRaccelBuild = strcmp(context.getConfigProp('SystemTargetFile'), 'raccel.tlc');
            if ~isRaccelBuild
                hCS = coder.const(getActiveConfigSet(bdroot));
                targetInfo = coder.const(codertarget.targethardware.getTargetHardware(hCS));

                % Added this env variable to fetch the comm libraries required only for Arduino target.
                % The env variable is cleared at the end of
                % "GenerateWrapperMakefile.m" file.
                if contains(targetInfo.TargetName,'arduinotarget')
                    setenv('Arduino_ML_Codegen_I2C', 'Y');
                end

                filename = mfilename('fullpath');
                [filepath,~,~] = fileparts(filename);

                DriverFiles = {'LCD_Ekran_TinyDL.cpp','LiquidCrystal_I2C.cpp',};
                DriverFilesFolder = 'Dependencies';
                SystemObjFiles = {'LCD_Ekran_TinyDL_RP.cpp'};




                buildInfo.addSourceFiles(SystemObjFiles,filepath);
                buildInfo.addSourceFiles(DriverFiles,fullfile(filepath,DriverFilesFolder));
                buildInfo.addIncludePaths(filepath);
                buildInfo.addIncludePaths(fullfile(filepath,DriverFilesFolder));
            end
        end
    end
end

function mustBeData(a,dataType)
% As the 'isa' function doesnot support boolean datatype, change to 'logical' %
if isequal(dataType,'boolean')
    dataType = 'logical';
end

if ~(isa(a,dataType))
    error("Value must of type %s.",dataType);
end
end

function mustBeSize(value, expectedSize)
% Get the actual size of the input
actualSize = size(value);

% Check if the actual size matches the expected size
if ~isequal(actualSize, expectedSize)
    error(message('devicedriverapp_resources:messages:ParameterSizeValidation',num2str(expectedSize), num2str(actualSize)).getString);
end
end

function value = getValueFromTypeName(typeName)
keys = {'double', 'single','uint8', 'uint16', 'uint32', 'uint64', ...
    'int8', 'int16', 'int32', 'int64'};
values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

% Find the index of the type name
index = find(strcmp(keys, typeName));

if isempty(index)
    value = -1;
else
    value = values(index);
end
end

