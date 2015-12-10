function [stim, neur] = dummyObjs(ntrials)
    stim.gaborXY = nan(2,2);
    stim.goodtrial = true(ntrials,1);
    neur.spikeCount = nan(ntrials,1);
    neur.trialIndex = 1:ntrials;
end
