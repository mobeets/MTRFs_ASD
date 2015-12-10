function Yh = predict(stim, neur, fitobj, pulses)
% if you don't want to use stim or neur, leave them empty
%   and provide pulses (the raw stim) instead
% 
    if isempty(stim) && isempty(neur)
        [stim, neur] = io.dummyObjs(size(pulses,1));
        stim.pulses = pulses;
    end    
    robj = rf.regressionData(stim, neur, fitobj.fitopts);
    Yh = robj.X*fitobj.w + fitobj.b;
    
end
