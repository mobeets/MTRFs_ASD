function fits = fitExpCells(exname, stimdir, neurdir, fitopts)
% 
% exname = 'n20150304a';
% 
    if nargin < 2 || isempty(stimdir)
        stimdir = '';
    end
    if nargin < 3 || isempty(neurdir)
        neurdir = '';
    end
    if nargin < 4
        fitopts = struct();
    end

    stim = io.loadStim(exname, stimdir);
    neurfns = io.loadNeuronFilenames(exname, neurdir);

    % for each neuron, load and fit
    fits  = struct([]);
    for ii = 1:numel(neurfns)
        neurfn = neurfns{ii};
        neur = load(neurfn);

        if ~strcmpi(neur.brainArea, 'MT')
            continue;
        end
        obj = rf.fitCell(stim, neur, fitopts);

        ft.neurfn = neurfn;
        ft.exname = neur.exname;
        ft.cellid = neur.id;
        ft.fit = obj;
        fits = [fits ft];
    end

end
