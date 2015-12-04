function obj = fitCell(stim, neur)
% 
% stim = load('data/stim/n20150304a_stim.mat');
% neur = load('data/neurons/n20150304a_01.mat');
% 

    % load trials
    ix = stim.goodtrial;
    ix2 = false(size(ix));
    ix2(neur.trialIndex) = true;
    ix = ix & ix2;
    assert(isequal(numel(neur.spikeCount), sum(ix)));

    % create X and Y, Xxy and D
    Xxy = stim.gaborXY;
    D = asd.sqdist.space(Xxy);
    X = stim.pulses(ix,:,:);
    Y = neur.spikeCount;

    X = squeeze(sum(X,2)); % sum across time for now
    obj = oneCell(X, Y, D, 'ml');

end

