function stim = loadStim(exname, stimdir)

    if nargin < 2 || isempty(stimdir)
        stimdir = fullfile('data', 'stim');
    end
    stim = load(fullfile(stimdir, [exname '_stim.mat']));

end
