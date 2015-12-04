function fits = fitCells(exname, stimdir, neurdir)
% 
% exname = 'n20150304a';
% 
    if nargin < 2
        stimdir = '';
    end
    if nargin < 3
        neurdir = fullfile('data', 'neurons');
    end

    stim = io.loadStim(exname, stimdir);
    neurfns = io.loadNeuronFilenames(exname, neurdir);

    fits  = struct([]);
    for ii = 1:numel(neurfns)
        neurfn = neurfns{ii};
        neur = load(neurfn);

        if ~strcmpi(neur.brainArea, 'MT')
            continue;
        end
        obj = fitCell(stim, neur);

        ft.neurfn = neurfn;
        ft.exname = neur.exname;
        ft.cellid = neur.id;
        ft.fit = obj;
        fits = [fits ft];
    end

end
