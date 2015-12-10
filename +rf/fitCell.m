function obj = fitCell(stim, neur, fitopts)
% 
% stim = load('data/stim/n20150304a_stim.mat');
% neur = load('data/neurons/n20150304a_01.mat');
% 
    if nargin < 3
        fitopts = struct();
    end
    fobj = rf.regressionData(stim, neur, fitopts);
    obj = rf.fitLinearModel(fobj.X, fobj.Y, fobj.D, fobj.fitopts.fitType);
    obj.fitopts = fobj.fitopts;

end
