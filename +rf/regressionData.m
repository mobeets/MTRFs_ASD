function obj = regressionData(stim, neur, fitopts)
    if nargin < 3
        fitopts = struct();
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
    
    if isfield(fitopts, 'fitInfo')
        X = makeBaselineStim(X, fitopts);
    else
        fitopts.fitInfo = '';
    end
    
    if ~strcmpi(fitopts.fitType, 'asd')
        % Non-ASD fit
        X = X(1:end,:);
        D = nan;
    elseif isfield(fitopts, 'asdType') && ...
            strcmpi(fitopts.asdType, 'space')
        % spatial fit only - sum across time
        X = squeeze(sum(X,2));
        D = asd.sqdist.space(Xxy);
    else
        % full spacetime fit        
        D = asd.sqdist.spaceTime(Xxy, size(X,2));
        X = X(1:end,:);
    end
    
    obj.X = X;
    obj.Y = Y;
    obj.Xxy = Xxy;
    obj.D = D;
    obj.fitopts = fitopts;
end

function X = makeBaselineStim(X, opts)
    switch opts.fitInfo
        case 'baseline'
            X = sum(X(1:end,:),2);
        case 'gaborInd'
            X = X(1:end,:,opts.gaborInd);
        case 'gaborIndSum'
            X = sum(X(1:end,:,opts.gaborInd),2);
    end
end
