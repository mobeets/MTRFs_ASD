function exnames = loadExnames(stimdir)
    if nargin < 2 || isempty(stimdir)
        stimdir = fullfile('data', 'stim');
    end

    fns = dir(fullfile(stimdir, '*.mat'));
    exnames = cellfun(@(fn) strrep(fn, '_stim.mat', ''), ...
        {fns(~[fns.isdir]).name}, 'uni', 0);

end
