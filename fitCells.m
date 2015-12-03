function fits = fitCells(exname, stimdir, neurdir)
% 
% exname = 'n20150304a';
% 
if nargin < 2
    stimdir = fullfile('data', 'stim');
end
if nargin < 3
    neurdir = fullfile('data', 'neurons');
end

stim = load(fullfile(stimdir, [exname '_stim.mat']));
neurfns = dir(fullfile(neurdir, [exname '*']));
neurfns = {neurfns.name};

fits  = struct([]);
for ii = 1:numel(neurfns)
    neurfn = neurfns{ii};
    neur = load(fullfile(neurdir, neurfn));
    
    if ~strcmpi(neur.brainArea, 'MT')
        continue;
    end
    obj = oneCell(stim, neur);

    ft.neurfn = neurfn;
    ft.fit = obj;
    fits = [fits ft];
end

end
