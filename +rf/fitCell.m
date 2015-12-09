function obj = fitCell(stim, neur, fitType)
% 
% stim = load('data/stim/n20150304a_stim.mat');
% neur = load('data/neurons/n20150304a_01.mat');
% 
    if nargin < 3
        fitType = 'asd';
    end

    % load trials
    ix = stim.goodtrial;
    ix2 = false(size(ix));
    ix2(neur.trialIndex) = true;
    ix = ix & ix2;
    assert(isequal(numel(neur.spikeCount), sum(ix)));

    % create X and Y, Xxy and D    
    X = stim.pulses(ix,:,:);
    Y = neur.spikeCount;
    Xxy = stim.gaborXY;        
    
    if numel(fitType) < 3 || ~strcmpi(fitType(1:3), 'asd')
        % Non-ASD fit
        obj = rf.fitLinearModel(X(1:end,:), Y, nan, fitType);
    elseif numel(fitType) > 3 && strcmpi(fitType(5:end), 'space')
        % spatial fit only - sum across time
        Xs = squeeze(sum(X,2));
        Ds = asd.sqdist.space(Xxy);
        obj = rf.fitLinearModel(Xs, Y, Ds, 'asd');
    else
        % full spacetime fit
        Dst = asd.sqdist.spaceTime(Xxy, size(X,2));
        obj = rf.fitLinearModel(X(1:end,:), Y, Dst, 'asd');
    end

end

